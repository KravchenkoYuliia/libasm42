import os

for root, dirs, files in os.walk('.'):
    for file in files:
        if file.endswith('.o') or file == "program":
            path = os.path.join(root, file)
            os.remove(path)
            print(f"Deleted: {path}")