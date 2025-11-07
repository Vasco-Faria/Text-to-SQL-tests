import os
import requests
from dotenv import load_dotenv

# === CONFIG ===
schema_file = "schema.txt"
descriptions_dir = "descriptions"
outputs_dir = "generated_sql"

# Choose the free model available on OpenRouter
model_name = "meta-llama/llama-3.3-70b-instruct:free"

# Put your OpenRouter API key here or as an environment variable
load_dotenv()
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY", "YOUR_API_KEY_HERE")

os.makedirs(outputs_dir, exist_ok=True)

# === System instruction ===
instruction = """
Generate a valid PostgreSQL query that answers the question.
Do NOT include explanations or comments.
Return ONLY the SQL code.
"""

# === Read schema ===
with open(schema_file, "r") as f:
    schema_text = f.read()
    
    
refinement_prompts = [
    "Revise the SQL query to ensure it uses the most efficient JOINs and filters.",
    "Optimize the query by removing unnecessary subqueries and simplifying expressions.",
    "Ensure the final SQL follows PostgreSQL syntax strictly and runs without errors.",
]



def generate_sql(question, refinements):
    """
    Executa um ciclo iterativo de refinamento:
    1. Gera SQL base.
    2. Aplica refinamentos em sequência.
    """
    print("🧠 Sending initial request to OpenRouter...")

    headers = {
        "Authorization": f"Bearer {OPENROUTER_API_KEY}",
        "HTTP-Referer": "https://github.com/Tiagogr8/Text-to-SQL-tests",
        "X-Title": "SQL Generator",
        "Content-Type": "application/json",
    }

    # Mensagem inicial com o schema e a pergunta
    messages = [
        {"role": "system", "content": instruction.strip()},
        {
            "role": "user",
            "content": f"\nQUESTION:\n{question}\n",
        },
    ]

    for step, refinement in enumerate(refinements, start=1):
        print(f"🔁 Refinement step {step}: {refinement[:50]}...")

        # Adiciona refinamento como nova mensagem
        messages.append({"role": "user", "content": refinement})

        payload = {
            "model": model_name,
            "messages": messages,
            "temperature": 0.0,
        }

        response = requests.post(
            "https://openrouter.ai/api/v1/chat/completions",
            headers=headers,
            json=payload,
            timeout=120,
        )

        if response.status_code != 200:
            raise Exception(f"API Error {response.status_code}: {response.text}")

        data = response.json()
        sql = data["choices"][0]["message"]["content"].strip()
        sql = sql.strip("```").strip("sql").strip()

        # Atualiza o contexto para o próximo refinamento
        messages.append({"role": "assistant", "content": sql})

    return sql

# === Process all descriptions ===
for filename in os.listdir(descriptions_dir):
    if filename.endswith("_description.txt"):
        query_name = filename.replace("_description.txt", "")
        description_path = os.path.join(descriptions_dir, filename)

        with open(description_path, "r") as f:
            description_text = f.read()

        print(f"\n🚀 Generating SQL for: {query_name}...")

        try:
            sql_query = generate_sql(description_text,refinement_prompts)
        except Exception as e:
            print(f"❌ Error generating SQL for {query_name}: {e}")
            continue

        output_path = os.path.join(outputs_dir, f"{query_name}_ZS.sql")
        with open(output_path, "w") as f:
            f.write(sql_query)

        print(f"✅ Saved to: {output_path}")
        print(f"---\n{sql_query}\n---")
