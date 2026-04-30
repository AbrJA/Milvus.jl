#!/usr/bin/env python3
"""
Download Milvus RESTful API v2 documentation pages as Markdown files.
Extracts content from the __NEXT_DATA__ JSON embedded in the HTML pages.
"""

import json
import os
import re
import sys
import urllib.request
import urllib.error
from urllib.parse import quote

BASE_URL = "https://milvus.io"
API_REF_PATH = "/api-reference/restful/v2.6.x"
OUTPUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "docs", "api", "v2")


def fetch_page(url):
    """Fetch a page and return the HTML content."""
    req = urllib.request.Request(url, headers={
        "User-Agent": "Mozilla/5.0 (compatible; MilvusDocsBot/1.0)"
    })
    with urllib.request.urlopen(req, timeout=30) as resp:
        return resp.read().decode("utf-8")


def extract_next_data(html):
    """Extract the __NEXT_DATA__ JSON from the HTML."""
    match = re.search(
        r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>',
        html, re.DOTALL
    )
    if not match:
        raise ValueError("Could not find __NEXT_DATA__ in page")
    return json.loads(match.group(1))


def extract_about_content(compiled_source):
    """Extract markdown content from the About page's compiled source."""
    lines = []

    # Extract code blocks first (they're nested inside pre > CodeBlock)
    code_blocks = []
    code_pattern = r'_jsx\(CodeBlock,\s*\{[^}]*children:\s*"((?:[^"\\]|\\.)*)"'
    for match in re.finditer(code_pattern, compiled_source):
        code = match.group(1)
        code = code.replace('\\n', '\n').replace('\\"', '"').replace("\\'", "'")
        code = code.replace('\\\\', '\\')
        code_blocks.append(code)

    # Find the Fragment children array using bracket matching
    idx_start = compiled_source.find('_jsxs(_Fragment')
    if idx_start == -1:
        return "# Get Started\n\n(Content could not be parsed)"

    # Find the opening [ of the children array
    bracket_start = compiled_source.find('[', idx_start)
    if bracket_start == -1:
        return "# Get Started\n\n(Content could not be parsed)"

    # Find the matching closing ] using bracket depth counting
    depth = 0
    bracket_end = -1
    for i in range(bracket_start, len(compiled_source)):
        c = compiled_source[i]
        if c == '[':
            depth += 1
        elif c == ']':
            depth -= 1
            if depth == 0:
                bracket_end = i
                break

    if bracket_end == -1:
        return "# Get Started\n\n(Content could not be parsed)"

    children_content = compiled_source[bracket_start + 1:bracket_end]

    # Split into individual elements by finding top-level commas
    # Elements are separated by "),\n" patterns at the top level
    elements = []
    depth = 0
    in_string = False
    current = []
    for c in children_content:
        if c == '"' and (not current or current[-1] != '\\'):
            in_string = not in_string
        if not in_string:
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            elif c == ',' and depth == 0:
                elements.append(''.join(current).strip())
                current = []
                continue
        current.append(c)
    if current:
        elements.append(''.join(current).strip())

    code_idx = 0
    for elem in elements:
        elem = elem.strip()

        # Check for heading
        h1_match = re.search(r'_jsx\(_components\.h1,\s*\{[^}]*children:\s*"((?:[^"\\]|\\.)*)"', elem)
        if h1_match:
            text = h1_match.group(1).replace('\\n', '\n').replace('\\"', '"').replace("\\'", "'")
            lines.append(f"# {text}")
            lines.append("")
            continue

        h2_match = re.search(r'_jsx\(_components\.h2,\s*\{[^}]*children:\s*"((?:[^"\\]|\\.)*)"', elem)
        if h2_match:
            text = h2_match.group(1).replace('\\n', '\n').replace('\\"', '"').replace("\\'", "'")
            lines.append(f"## {text}")
            lines.append("")
            continue

        # Check for paragraph (may contain inline code)
        p_match = re.search(r'_jsx[s]?\(_components\.p,\s*\{[^}]*children:\s*', elem)
        if p_match:
            # Extract text - could be a simple string or an array with inline elements
            text_match = re.search(r'children:\s*"((?:[^"\\]|\\.)*)"', elem)
            if text_match:
                text = text_match.group(1).replace('\\n', '\n').replace('\\"', '"').replace("\\'", "'")
                lines.append(text)
                lines.append("")
            else:
                # Complex paragraph with inline elements - extract all string children
                strings = re.findall(r'children:\s*"((?:[^"\\]|\\.)*)"', elem)
                para_text = ""
                for s in strings:
                    s = s.replace('\\n', '\n').replace('\\"', '"').replace("\\'", "'")
                    para_text += s
                if para_text:
                    lines.append(para_text)
                    lines.append("")
            continue

        # Check for code block (pre element)
        if '_components.pre' in elem or 'CodeBlock' in elem:
            if code_idx < len(code_blocks):
                lines.append("```bash")
                lines.append(code_blocks[code_idx])
                lines.append("```")
                lines.append("")
                code_idx += 1
            continue

    return "\n".join(lines)


def format_schema(schema, indent=0):
    """Format a JSON schema into readable text."""
    prefix = "  " * indent
    lines = []

    schema_type = schema.get("type", "object")
    lines.append(f"{prefix}- **Type:** `{schema_type}`")

    if "description" in schema:
        desc = schema["description"]
        # Remove i18n tags
        desc = re.sub(r'<include[^>]*>', '', desc)
        desc = re.sub(r'</include>', '', desc)
        lines.append(f"{prefix}- **Description:** {desc}")

    if "properties" in schema:
        lines.append(f"{prefix}- **Properties:**")
        for prop_name, prop_schema in schema["properties"].items():
            prop_type = prop_schema.get("type", "any")
            prop_desc = prop_schema.get("description", "")
            prop_desc = re.sub(r'<include[^>]*>', '', prop_desc)
            prop_desc = re.sub(r'</include>', '', prop_desc)
            required = ""
            if "required" in schema and prop_name in schema["required"]:
                required = " **(required)**"
            lines.append(f"{prefix}  - `{prop_name}` ({prop_type}){required}: {prop_desc}")

            # Handle nested properties
            if "properties" in prop_schema:
                for sub_name, sub_schema in prop_schema["properties"].items():
                    sub_type = sub_schema.get("type", "any")
                    sub_desc = sub_schema.get("description", "")
                    sub_desc = re.sub(r'<include[^>]*>', '', sub_desc)
                    sub_desc = re.sub(r'</include>', '', sub_desc)
                    lines.append(f"{prefix}    - `{sub_name}` ({sub_type}): {sub_desc}")

    if "items" in schema:
        items = schema["items"]
        if isinstance(items, dict):
            items_type = items.get("type", "any")
            lines.append(f"{prefix}- **Items type:** `{items_type}`")
            if "properties" in items:
                lines.append(f"{prefix}- **Item properties:**")
                for prop_name, prop_schema in items["properties"].items():
                    prop_type = prop_schema.get("type", "any")
                    prop_desc = prop_schema.get("description", "")
                    prop_desc = re.sub(r'<include[^>]*>', '', prop_desc)
                    prop_desc = re.sub(r'</include>', '', prop_desc)
                    lines.append(f"{prefix}  - `{prop_name}` ({prop_type}): {prop_desc}")

    if "enum" in schema:
        lines.append(f"{prefix}- **Enum values:** {', '.join(schema['enum'])}")

    if "example" in schema:
        example = json.dumps(schema["example"], indent=2)
        lines.append(f"{prefix}- **Example:**")
        for line in example.split("\n"):
            lines.append(f"{prefix}  {line}")

    return "\n".join(lines)


def format_parameters(params):
    """Format API parameters into markdown."""
    if not params:
        return ""

    lines = ["### Parameters", ""]

    for param in params:
        name = param.get("name", "")
        location = param.get("in", "")
        required = param.get("required", False)
        description = param.get("description", "")
        # Clean up i18n tags
        description = re.sub(r'<include[^>]*>', '', description)
        description = re.sub(r'</include>', '', description)

        schema = param.get("schema", {})
        param_type = schema.get("type", "string")

        req_str = " **(required)**" if required else ""
        lines.append(f"- **`{name}`** ({location}, `{param_type}`){req_str}")
        if description:
            lines.append(f"  - {description}")
        lines.append("")

    return "\n".join(lines)


def format_request_body(request_body):
    """Format request body into markdown."""
    if not request_body:
        return ""

    lines = ["### Request Body", ""]

    required = request_body.get("required", False)
    if required:
        lines.append("**Required**")
        lines.append("")

    content = request_body.get("content", {})
    for content_type, content_spec in content.items():
        lines.append(f"**Content-Type:** `{content_type}`")
        lines.append("")

        schema = content_spec.get("schema", {})
        lines.append(format_schema(schema))
        lines.append("")

    return "\n".join(lines)


def format_responses(responses):
    """Format API responses into markdown."""
    if not responses:
        return ""

    lines = ["### Responses", ""]

    for status_code, response in responses.items():
        description = response.get("description", "")
        description = re.sub(r'<include[^>]*>', '', description)
        description = re.sub(r'</include>', '', description)

        lines.append(f"**{status_code}:** {description}")
        lines.append("")

        content = response.get("content", {})
        if content:
            for content_type, content_spec in content.items():
                schema = content_spec.get("schema", {})

                # Handle anyOf
                if "anyOf" in schema:
                    for i, option in enumerate(schema["anyOf"]):
                        tab_label = option.get("x-tab-label", f"Option {i+1}")
                        lines.append(f"**{tab_label}:**")
                        lines.append("")
                        lines.append(format_schema(option))
                        lines.append("")
                else:
                    lines.append(format_schema(schema))
                    lines.append("")

    return "\n".join(lines)


def format_specs_to_markdown(specs, endpoint, method):
    """Convert OpenAPI-like specs to markdown."""
    lines = []

    # Title
    summary = specs.get("summary", "API Reference")
    lines.append(f"# {summary}")
    lines.append("")

    # Endpoint
    method_upper = method.upper() if method else "GET"
    lines.append(f"**{method_upper}** `{endpoint}`")
    lines.append("")

    # Description
    description = specs.get("description", "")
    if description:
        description = re.sub(r'<include[^>]*>', '', description)
        description = re.sub(r'</include>', '', description)
        lines.append(description)
        lines.append("")

    # Tags
    tags = specs.get("tags", [])
    if tags:
        lines.append(f"**Tags:** {', '.join(tags)}")
        lines.append("")

    # Deprecated
    if specs.get("deprecated"):
        lines.append("> **⚠️ Deprecated**")
        lines.append("")

    # Parameters
    params = specs.get("parameters", [])
    if params:
        lines.append(format_parameters(params))

    # Request Body
    request_body = specs.get("requestBody")
    if request_body:
        lines.append(format_request_body(request_body))

    # Responses
    responses = specs.get("responses", {})
    if responses:
        lines.append(format_responses(responses))

    return "\n".join(lines)


def extract_markdown_from_page(html):
    """Extract markdown content from the HTML page."""
    data = extract_next_data(html)
    page_props = data.get("props", {}).get("pageProps", {})
    mdx_source = page_props.get("mdxSource", {})
    compiled_source = mdx_source.get("compiledSource", "")
    scope = mdx_source.get("scope", {})

    # Check if this is an About page or an API spec page
    specs = scope.get("specs")
    endpoint = scope.get("endpoint", "")
    method = scope.get("method", "")

    if specs:
        # This is an API spec page
        return format_specs_to_markdown(specs, endpoint, method)
    else:
        # This is the About page
        content = extract_about_content(compiled_source)
        return content


def get_v2_pages():
    """Get the list of v2 pages from the About page."""
    url = f"{BASE_URL}{API_REF_PATH}/About.md"
    html = fetch_page(url)
    data = extract_next_data(html)

    # The About page has pageProps at the top level (not nested under props)
    page_props = data.get("pageProps", data.get("props", {}).get("pageProps", {}))
    menus = page_props["menus"]
    pages = []

    for menu in menus:
        if menu["id"] == "milvus-restful":
            for child in menu["children"]:
                if child["id"] == "v2":
                    def extract_pages(items, category=""):
                        for item in items:
                            if item.get("isMenu"):
                                label = item["label"].split("::")[-1] if "::" in item["label"] else item["label"]
                                extract_pages(item.get("children", []), label)
                            else:
                                href = item.get("href", "")
                                if href and href.endswith(".md"):
                                    pages.append({
                                        "label": item["label"],
                                        "href": href,
                                        "category": category,
                                    })
                    extract_pages(child["children"])

    return pages


def download_page(href):
    """Download a single page and return its markdown content."""
    # Properly encode the URL path
    parts = href.split("/")
    encoded_parts = [quote(p, safe="") for p in parts]
    encoded_href = "/".join(encoded_parts)
    url = f"{BASE_URL}{API_REF_PATH}/{encoded_href}"

    print(f"  Fetching: {url}")
    html = fetch_page(url)
    return extract_markdown_from_page(html)


def sanitize_filename(name):
    """Sanitize a string for use as a filename."""
    name = name.replace(" ", "_").replace("(", "").replace(")", "")
    name = re.sub(r'[<>:"/\\|?*]', "", name)
    return name


def main():
    print("Getting list of v2 API pages...")
    pages = get_v2_pages()
    print(f"Found {len(pages)} pages\n")

    # Create output directory
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # Download About.md first
    print("Downloading About.md...")
    about_url = f"{BASE_URL}{API_REF_PATH}/About.md"
    about_html = fetch_page(about_url)
    about_md = extract_markdown_from_page(about_html)

    about_path = os.path.join(OUTPUT_DIR, "About.md")
    with open(about_path, "w", encoding="utf-8") as f:
        f.write(about_md)
    print(f"  Saved: {about_path}")

    # Download each v2 page
    for page in pages:
        category = page["category"]
        label = page["label"]
        href = page["href"]

        # Create category subdirectory
        cat_dir = os.path.join(OUTPUT_DIR, sanitize_filename(category))
        os.makedirs(cat_dir, exist_ok=True)

        # Download and save
        try:
            md_content = download_page(href)

            filename = f"{sanitize_filename(label)}.md"
            filepath = os.path.join(cat_dir, filename)

            with open(filepath, "w", encoding="utf-8") as f:
                f.write(md_content)

            print(f"  Saved: {filepath}")
        except Exception as e:
            print(f"  ERROR downloading {href}: {e}", file=sys.stderr)

    print(f"\nDone! Pages saved to {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
