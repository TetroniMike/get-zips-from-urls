# get-zips-from-urls
Get a list of zip files from a list of urls, then download the urls

1. Create "urls.txt", fill it with newline separated URLs - each URL should link to a webpage with a .zip download somewhere on the page
1. Download and put the get-zips-from-urls.sh file somewhere (I put it in ~/download-zips/)
2. Open get-zips-from-urls.sh, update the `download_dir` if necessary - this is where the zip files will be downloaded to
3. Terminal command: `chmod +x get-zips-from-urls.sh`
4. Terminal command: `./get-zips-from-urls.sh`
5. Watch as .zip files are added to "zip_links.txt", then downloaded to your download directory
6. Successfully downloaded .zip links will be added to "old_zips.txt"

Enjoy your downloaded .zip files.

# Do it again later
Let's say your list of URLs has grown, cool let's do it again

1. Clear "urls.txt" and add your new list of newline separated URLs to it
2. Follow the above - during step 5, the script will look for duplicate .zip links (in "old_zips.txt") and will skip them, nice!
