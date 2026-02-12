import pandas as pd

CSV_FILE = "datasets/ravenstack_support_tickets.csv"
TABLE_NAME = "accounts"
OUTPUT_FILE = "sql/02_data_insertion/support_tickets.sql"

df = pd.read_csv(CSV_FILE)

with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
    for _, row in df.iterrows():
        values = []
        for value in row:
            if pd.isna(value):
                values.append("NULL")
            elif isinstance(value, str):
                escaped = value.replace("'", "''")  # escape single quotes
                values.append(f"'{escaped}'")
            else:
                values.append(str(value))

        columns = ", ".join(df.columns)
        values_str = ", ".join(values)

        insert_statement = f"INSERT INTO {TABLE_NAME} ({columns}) VALUES ({values_str});\n"
        f.write(insert_statement)

print(f"SQL file generated: {OUTPUT_FILE}")