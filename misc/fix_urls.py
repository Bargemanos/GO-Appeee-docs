import os
import re

def fix_urls_in_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Fix URLs with unencoded parentheses
        pattern = r'(/wiki/spaces/GSD/pages/[^"\'>\s]*?)\(([^)]+?)\)'
        fixed_content = re.sub(pattern, lambda m: f'{m.group(1)}%28{m.group(2)}%29', content)
        
        if content != fixed_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(fixed_content)
            print(f"Fixed URLs in: {file_path}")
    except Exception as e:
        print(f"Error processing {file_path}: {str(e)}")

def process_directory(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(('.html', '.json', '.md')):
                file_path = os.path.join(root, file)
                fix_urls_in_file(file_path)

if __name__ == "__main__":
    base_dir = "."
    process_directory(base_dir)