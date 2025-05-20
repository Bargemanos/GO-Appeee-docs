# GO Appeee Documentation - HTML Section

This directory contains the HTML documentation for the GO Appeee platform. The documentation follows specific standards to ensure consistency and proper functionality across different systems and browsers.

## Directory Structure Standards

- All HTML files should be named `content.html`
- Each topic should have its own directory
- Directory and file names must follow URL encoding standards for special characters
- Documentation is organized in a hierarchical structure with main sections and subsections

## URL Encoding Standards

### Directory Names
- Keep original readable names in the filesystem (e.g., `FAQ & Troubleshooting`)
- Use URL encoded characters in href attributes:
  - Spaces → `%20`
  - Ampersand (&) → `%26`
  - Single quotes (') → `%27`
  - Double quotes (") → Wrap in single quotes in href
  - Parentheses → `%28` for ( and `%29` for )
  - Forward slash (/) → Keep as is in display text, encode as `%2F` in URLs
  - Question mark (?) → Keep as is in display text, encode as `%3F` in URLs
  - Plus sign (+) → `%2B`
  - Equals sign (=) → `%3D`
  - Comma (,) → `%2C`

Example:
```html
<a href="FAQ%20%26%20Troubleshooting/content.html">FAQ & Troubleshooting</a>
```

### List Sorting Standards

Lists of links (such as in navigation or index pages) should be:
1. Sorted alphabetically by the display text
2. Case-insensitive sorting
3. Special characters (like &, /) should not affect the sorting order
4. Articles (a, an, the) at the start of titles should not affect sorting

Example of proper sorting:
```html
<ul>
    <li><a href="App%20Features/content.html">App Features</a></li>
    <li><a href="Basic%20Setup/content.html">Basic Setup</a></li>
    <li><a href="FAQ%20%26%20Troubleshooting/content.html">FAQ & Troubleshooting</a></li>
    <li><a href="How%20To%20Guides/content.html">How To Guides</a></li>
</ul>
```

## File Naming Convention

1. Content files:
   - Always named: `content.html`
   - Located in their respective topic directories

2. Asset files:
   - Images: Use descriptive names with hyphens
   - Supporting files: Use lowercase with hyphens
   - Example: `system-architecture-diagram.png`

## HTML Content Standards

1. Page Structure:
   ```html
   <ul class="childpages-macro conf-macro output-block" data-hasbody="false" data-macro-name="children">
       <li><a href="...">Display Text</a></li>
   </ul>
   ```

2. Attributes:
   - Use proper HTML5 attributes
   - Maintain consistent class names
   - Keep data attributes for functionality

## Best Practices

1. Link Management:
   - Always use relative paths
   - Double-check URL encoding
   - Verify links work in both filesystem and web browser

2. Content Organization:
   - Keep related content in the same directory
   - Use clear, descriptive directory names
   - Maintain consistent depth levels

3. Maintenance:
   - Regularly verify URL encoding
   - Check for broken links
   - Update sorting when adding new content

## Common Issues and Solutions

1. Special Characters:
   - Always URL encode in href attributes
   - Keep readable format in display text
   - Test in multiple browsers

2. Sorting:
   - Remove leading/trailing spaces before sorting
   - Ignore case and special characters
   - Sort by visible text, not href values

3. Navigation:
   - Ensure proper parent-child relationships
   - Maintain breadcrumb compatibility
   - Keep navigation depth consistent 