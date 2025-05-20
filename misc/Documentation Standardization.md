# Documentation Standardization Process

This document outlines the standardization process for HTML documentation files in the GO Appeee documentation system.

## Process Overview

### 1. File Structure Check
- Verify each topic has its own directory
- Confirm each directory contains a `content.html` file
- List directories to identify existing vs missing content

### 2. URL Standardization
- Convert absolute paths to relative paths
- Apply proper URL encoding:
  - Spaces → `%20`
  - Ampersands (&) → `%26`
  - Single quotes (') → `%27`
  - Parentheses → `%28` and `%29`
  - Plus signs (+) → `%2B`
  - Question marks (?) → `%3F`
  - Forward slashes (/) → `%2F` in URLs (keep as-is in display text)
  - Equals signs (=) → `%3D`
  - Commas (,) → `%2C`
- Ensure all links end with `/content.html`

### 3. Content Organization
- Sort links alphabetically by display text
- Separate into "Active Links" and "Broken Links" sections
- Add HTML comments to mark sections
- Remove unnecessary data attributes from wiki conversion
- Maintain consistent HTML structure:
```html
<ul class="childpages-macro conf-macro output-block" data-hasbody="false" data-macro-name="children">
    <!-- Active Links -->
    <li><a href="Directory%20Name/content.html">Display Text</a></li>
    ...
    <!-- Broken Links (if any) -->
    <li><a href="Missing%20Directory/content.html">Display Text</a></li>
</ul>
```

### 4. Validation Steps
- Check if each linked directory exists
- Verify URL encoding is correct
- Ensure display text matches directory name (accounting for special characters)
- Confirm all links use relative paths
- Test links work in both filesystem and browser

### 5. Clean-up
- Remove wiki-specific attributes
- Standardize indentation
- Maintain consistent line breaks
- Keep original display text readable while encoding URLs

## Application Process

To apply these standards to new documentation:

1. **Initial Assessment**
   ```bash
   # List directory contents to see existing structure
   list_dir "path/to/directory"
   ```

2. **Content Analysis**
   ```bash
   # Read current content.html
   read_file "path/to/content.html"
   ```

3. **Update Process**
   - Convert URLs to relative paths
   - Apply URL encoding
   - Sort links alphabetically
   - Separate working/broken links
   - Update HTML structure

4. **Verification**
   - Check all directory paths exist
   - Verify URL encoding
   - Test links
   - Document missing content

## Common Issues and Solutions

### 1. Special Characters
- Always URL encode in href attributes
- Keep readable format in display text
- Test in multiple browsers

### 2. Sorting
- Remove leading/trailing spaces before sorting
- Ignore case and special characters
- Sort by visible text, not href values

### 3. Directory Structure
- Maintain consistent naming conventions
- Use descriptive directory names
- Keep related content together

## Best Practices

1. **Link Management**
   - Always use relative paths
   - Double-check URL encoding
   - Verify links work in both filesystem and web browser

2. **Content Organization**
   - Keep related content in the same directory
   - Use clear, descriptive directory names
   - Maintain consistent depth levels

3. **Maintenance**
   - Regularly verify URL encoding
   - Check for broken links
   - Update sorting when adding new content

## Example Implementation

Before:
```html
<ul>
    <li><a href="/wiki/spaces/GSD/pages/123/My+Page">My Page</a></li>
    <li><a href="/absolute/path/to/Another+Page">Another Page</a></li>
</ul>
```

After:
```html
<ul class="childpages-macro conf-macro output-block" data-hasbody="false" data-macro-name="children">
    <!-- Active Links -->
    <li><a href="Another%20Page/content.html">Another Page</a></li>
    <li><a href="My%20Page/content.html">My Page</a></li>
</ul>
```

## Automation Tips

Consider creating scripts for:
- URL encoding verification
- Directory existence checking
- Link sorting
- HTML structure validation

## Quality Checklist

- [ ] All links are relative
- [ ] URLs properly encoded
- [ ] Links alphabetically sorted
- [ ] Directories exist
- [ ] HTML structure is consistent
- [ ] No wiki-specific attributes
- [ ] All links end with /content.html
- [ ] Broken links documented 