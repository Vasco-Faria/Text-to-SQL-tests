import os
import requests
from dotenv import load_dotenv

# === CONFIG ===
descriptions_dir = "descriptions"
outputs_dir = "generated_sql"

# Choose the free model available on OpenRouter
model_name = "nvidia/nemotron-nano-12b-v2-vl:free"

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



def generate_sql(question,instruction):
    prompt = f"""

QUESTION:
{question}
"""

    print("🧠 Sending request to OpenRouter...")
    headers = {
        "Authorization": f"Bearer {OPENROUTER_API_KEY}",
        "HTTP-Referer": "https://github.com/Tiagogr8/Text-to-SQL-tests",
        "X-Title": "SQL Generator",
        "Content-Type": "application/json",
    }

    payload = {
        "model": model_name,
        "messages": [
            {"role": "system", "content": instruction.strip()},
            {"role": "user", "content": prompt.strip()},
        ],
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

    # Clean output
    sql = sql.strip("```").strip("sql").strip()
    return sql


# === Process Q1 to Q5 descriptions ===
for q_num in range(19, 23):  # Q1 até Q5
    query_name = f"q{q_num}"
    description_path = os.path.join(descriptions_dir, f"{query_name}_description.txt")

    if not os.path.exists(description_path):
        print(f"⚠️  Description file not found for {query_name}: {description_path}")
        continue

    print(f"\n🚀 Generating SQL for: {query_name}...")

    with open(description_path, "r") as f:
        description_text = f.read()

    try:
        sql_query = generate_sql(description_text,instruction)
    except Exception as e:
        print(f"❌ Error generating SQL for {query_name}: {e}")
        continue

    output_path = os.path.join(outputs_dir, f"{query_name}_ZS.sql")
    with open(output_path, "w") as f:
        f.write(sql_query)

    print(f"✅ Saved to: {output_path}")
    print(f"---\n{sql_query}\n---")