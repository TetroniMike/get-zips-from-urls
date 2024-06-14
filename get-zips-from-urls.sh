#!/bin/bash

# Define files and output directory

input_file="urls.txt"
zip_links_file="zip_links.txt"
old_file="old_zips.txt"

download_dir="downloaded_zips"
log_file="download_log.txt"

# Part 1: Find .zip links

# Ensure necessary files exist
touch $zip_links_file
touch $old_file
touch $log_file

> $zip_links_file  # Clear the output file

while IFS= read -r url; do
    echo "Fetching: $url"
    # Fetch the page content
    page_content=$(curl -s "$url")
    # Extract .zip links
    zip_links=$(echo "$page_content" | grep -oP 'href="\K[^"]+\.zip')
    for link in $zip_links; do
        # Handle relative URLs
        if [[ $link != http* ]]; then
            base_url=$(echo $url | grep -oP '^(https?://[^/]+)')
            link="${base_url}${link}"
        fi
        # Check for duplicates in old_file and zip_links_file
        if ! grep -q "$link" "$old_file" && ! grep -q "$link" "$zip_links_file"; then
            echo "$link" >> $zip_links_file 
        else
            echo "Duplicate zip link found, will not download: $link"
        fi
    done
done < "$input_file"

# Remove duplicates from old_file
sort -u -o $old_file $old_file

echo "Found zip links saved to $zip_links_file"

# Part 2: Download .zip files

mkdir -p $download_dir
rm -f $log_file  # Clear the log file

while IFS= read -r url; do
    echo "Starting download for: $url"
    if wget -P $download_dir "$url"; then
        echo "Successfully downloaded: $url" >> $log_file
        echo "$url" >> $old_file
    else
        echo "Failed to download: $url" >> $log_file
    fi
done < "$zip_links_file"
