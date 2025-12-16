#!/usr/bin/env bash

# Define the primary logo directory
confDir="${XDG_CONFIG_HOME:-$HOME/.config}"
logoDir="${confDir}/fastfetch/logo"

# Function to find a random logo file and determine its type
# Outputs: --logo-type <type> --logo "<path_to_file>" or an empty string
get_random_logo_options() {
  local chosen_logo_path=""
  local search_dirs=("$logoDir")

  # Create the directory if it doesn't exist to prevent find errors
  mkdir -p "$logoDir"

  # Find a random file that looks like a logo in the specified directory
  # Includes common image and text file extensions
  chosen_logo_path=$(find -L "${search_dirs[@]}" -maxdepth 1 -type f \
    \( -name "*.icon" -o -name "*logo*" -o -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.webp" -o -name "*.bmp" -o -name "*.txt" \) \
    2>/dev/null | shuf -n 1)

  if [ -z "$chosen_logo_path" ]; then
    # No custom logo found, return empty string so fastfetch uses its default logo
    echo ""
    return
  fi

  local extension="${chosen_logo_path##*.}" # Get file extension
  local logo_type=""

  # Determine the appropriate --logo-type based on file extension
  case "$extension" in
    png|jpg|jpeg|gif|webp|bmp|ico|icon)
      # Assuming kitty protocol for image files
      logo_type="kitty"
      ;;
    txt)
      # For plain text files (ASCII art)
      logo_type="file"
      ;;
    *)
      # Default to 'file' for anything else (e.g., custom formats or unknown images)
      # If it's an image, kitty might still try to render it if it's not a common extension for 'file'
      logo_type="file"
      ;;
  esac

  # Output the fastfetch arguments
  echo "--logo-type $logo_type --logo \"$chosen_logo_path\""
}

# The script's main purpose is to print these options to stdout.
get_random_logo_options
