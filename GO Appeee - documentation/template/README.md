# Documentation Template

A clean, standalone HTML template for documentation websites with built-in navigation, search functionality, and dynamic content loading.

## Template Structure

```
template/
├── template.html    # Main template file with all HTML, CSS, and JavaScript
└── README.md        # This documentation file
```

## Features

- **Self-contained Design**
  - All CSS and JavaScript included in a single file
  - No external dependencies
  - Uses system fonts for optimal performance
  - Responsive design with mobile support

- **Modern UI Elements**
  - Clean and modern interface
  - Smooth animations and transitions
  - Collapsible navigation menus
  - Search functionality
  - Active link highlighting

- **Content Management**
  - Dynamic content loading in iframe
  - Automatic styling injection for loaded content
  - Support for various content types (text, code, tables, images)
  - Proper typography and spacing

## URL Conversion Guide

### Converting Confluence URLs to Relative Paths

When scraping content from Confluence, follow these steps to convert URLs to relative paths:

1. **Identify URL Patterns**
   - Confluence URLs typically follow this pattern:
     ```
     https://confluence.example.com/display/PROJECT/Page+Title
     ```
   - Convert to relative path:
     ```
     Project/Page Title/content.html
     ```

2. **Conversion Rules**
   - Remove domain and base path
   - Replace spaces with underscores
   - Convert special characters to URL-safe format
   - Add `/content.html` suffix
   - Maintain directory structure

3. **Example Conversions**
   ```
   Original: https://confluence.example.com/display/GO/Getting+Started
   Converted: GO/Getting Started/content.html

   Original: https://confluence.example.com/display/GO/Advanced+Features/API+Documentation
   Converted: GO/Advanced Features/API Documentation/content.html
   ```

4. **Directory Structure**
   - Create directories matching the URL path
   - Place content.html files in appropriate directories
   - Maintain consistent naming conventions

### Scraping Process

1. **Initial Setup**
   ```python
   # Example scraping configuration
   config = {
       'base_url': 'https://confluence.example.com',
       'project': 'GO',
       'output_dir': 'documentation',
       'exclude_patterns': ['_sidebar', '_footer']
   }
   ```

2. **URL Processing**
   ```python
   def convert_url(confluence_url):
       # Remove domain and base path
       path = confluence_url.replace(config['base_url'], '')
       path = path.replace('/display/', '')
       
       # Split into components
       parts = path.split('/')
       project = parts[0]
       page = '/'.join(parts[1:])
       
       # Convert to relative path
       relative_path = f"{project}/{page}/content.html"
       return relative_path
   ```

3. **Content Processing**
   - Extract content from Confluence pages
   - Convert internal links to relative paths
   - Preserve images and attachments
   - Maintain formatting and structure

4. **File Organization**
   ```
   documentation/
   ├── GO/
   │   ├── Getting Started/
   │   │   └── content.html
   │   ├── Advanced Features/
   │   │   ├── API Documentation/
   │   │   │   └── content.html
   │   │   └── content.html
   │   └── content.html
   └── template/
       ├── template.html
       └── README.md
   ```

## Usage

1. **Basic Setup**
   - Copy the entire `template` folder to your desired location
   - Rename `template.html` to `index.html` if needed
   - Update the navigation structure in the `<div class="nav-section">` section

2. **Navigation Structure**
   ```html
   <div class="nav-section">
       <h2>Section Title</h2>
       <ul class="nav-list">
           <li class="has-children">
               <a href="#" data-content="path/to/content.html">Parent Item</a>
               <ul class="sub-list">
                   <li><a href="#" data-content="path/to/subcontent.html">Child Item</a></li>
               </ul>
           </li>
       </ul>
   </div>
   ```

3. **Customization**
   - Modify CSS variables in the `:root` section to change colors and fonts:
     ```css
     :root {
         --primary-color: #2c3e50;
         --secondary-color: #3498db;
         --text-color: #333;
         --background-color: #f5f6fa;
         --font-main: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
         --font-code: monospace;
     }
     ```

4. **Content Files**
   - Create content files in HTML format
   - Place them in the appropriate directory structure
   - Update the `data-content` attributes in the navigation to point to your content files

## Content Styling

The template automatically applies styles to loaded content, including:

- Headings (h1-h6)
- Paragraphs
- Links
- Code blocks
- Tables
- Images
- Blockquotes
- Lists (ordered and unordered)

## Browser Support

The template is compatible with modern browsers including:
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Notes

- The template uses CSS variables for easy customization
- All JavaScript is included in the file for simplicity
- The search functionality works with the navigation structure
- Mobile responsiveness is built-in
- Content is loaded dynamically in an iframe
- Styles are injected automatically into loaded content

## Deployment

1. **Local Development**
   - Simply open `template.html` in a web browser
   - Use a local web server for best results (prevents iframe loading issues)

2. **Production Deployment**
   - Copy the template folder to your web server
   - Ensure all content paths are correctly set
   - Test all navigation and search functionality

## License

This template is free to use and modify for any purpose. 