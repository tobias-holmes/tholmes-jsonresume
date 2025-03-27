#!/bin/bash

# Define the paths to the JSON resume files
RESUME_EN="resume-en.json"
RESUME_DE="resume-de.json"

# Create directories for the HTML files
mkdir -p en
mkdir -p de

# Define the output paths for the HTML files
OUTPUT_EN="en/index.html"
OUTPUT_DE="de/index.html"

# Define the themes
THEME_EN="kendall"
THEME_DE="kendall-german"

# Export the resumes to HTML using resume-cli
resume export -r "$RESUME_EN" -t $THEME_EN "$OUTPUT_EN"
resume export -r "$RESUME_DE" -t $THEME_DE "$OUTPUT_DE"
# # Export the resumes to HTML using resume-cli
# resumed export "$RESUME_EN" --output "$OUTPUT_EN"
# resumed export "$RESUME_DE" --output "$OUTPUT_DE"

# Function to adapt the HTML files
adapt_html() {
    local input_file=$1
    local output_file=$2

    # Define temporary files for the injected content
    LANG_SWITCHER_FILE=$(mktemp)
    STYLES_FILE=$(mktemp)

    # Write the language switcher to a temp file
    cat <<EOF > "$LANG_SWITCHER_FILE"
    <header>
        <div class="header-content">
            <div class="lang-switcher">
                <select id="languageSwitcher" onchange="switchLanguage()">
                    <option value="en">🇬🇧 English</option>
                    <option value="de">🇩🇪 Deutsch</option>
                </select>
            </div>
        </div>
    </header>       
    <script>
    // Detect current language from URL
    function getCurrentLang() {
        return window.location.pathname.includes("/de") ? "de" : "en";
    }
    
    // Set correct dropdown option on load
    document.getElementById("languageSwitcher").value = getCurrentLang();
    
    // Switch language when user selects an option
    function switchLanguage() {
        let selectedLang = document.getElementById("languageSwitcher").value;
        let targetUrl = selectedLang === "en" ? "/en/" : "/de/";
        window.location.href = targetUrl;
    }
    </script>   
EOF

    # Write the styles to a temp file
    cat <<EOF > "$STYLES_FILE"
    <style>
        /* Style for the language switcher container */
        .lang-switcher {
            position: fixed;
            top: 15px;
            right: 15px;
            background: #ffffff;
            border: 2px solid #ddd;
            padding: 5px 10px;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            font-family: Arial, sans-serif;
            font-size: 14px;
            cursor: pointer;
        }
    
        /* Style the dropdown */
        .lang-switcher select {
            border: none;
            background: transparent;
            font-size: 14px;
            padding: 5px;
            cursor: pointer;
        }
    
        /* Remove default dropdown arrow for Webkit browsers */
        .lang-switcher select::-webkit-inner-spin-button,
        .lang-switcher select::-webkit-outer-spin-button {
            appearance: none;
            margin: 0;
        }
    
        /* Hide default dropdown arrow and use a custom one */
        .lang-switcher select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            padding-right: 20px; /* Space for custom arrow */
            background: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%23000' d='M2 0L0 2h4z'/></svg>") no-repeat right 5px center;
            background-size: 10px;
        }
    </style>
EOF

    # Insert the language switcher after <body>
    sed -i "/<body[^>]*>/r $LANG_SWITCHER_FILE" "$output_file"

    # Insert styles into <head>
    sed -i "/<head[^>]*>/r $STYLES_FILE" "$output_file"

    # Clean up temporary files
    rm "$LANG_SWITCHER_FILE" "$STYLES_FILE"
}

# Adapt the generated HTML files
adapt_html "$OUTPUT_EN" "$OUTPUT_EN"
adapt_html "$OUTPUT_DE" "$OUTPUT_DE"

echo "Resumes have been exported to HTML with language switchers."