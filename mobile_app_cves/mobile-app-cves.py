#!/usr/bin/env python3
# Script: mobile-app-cves.py
# Author: Corey Garst
# Description: This script downloads the NIST NVD feed and extracts a list of Android & iOS app CVEs into an HTML report.

import datetime
import io
import json
import sys
import urllib.request
import zipfile

# Establish empty tracking lists
matching_cves = []
cves_already_listed = []

# Define some date variables
now = datetime.datetime.now()
current_year = now.year
# Data is available from 2002, but no CVEs are labeled for Android or iOS apps until 2012
years_to_search = list(range(2020, current_year + 1))

print("Downloading the yearly NVD CVE feeds to search for mobile apps.")

# Iterate through each yearly JSON feed
for year in years_to_search:
    print("Downloading NVD feed for " + str(year) + "...")
    url = "https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-" + str(year) + ".json.zip"
    try:
        with urllib.request.urlopen(url) as f:
            nvd_feed_file = f.read()
    except:
        print("Error downloading the NVD feed from the Internet. Are you connected?")
        sys.exit(0)

    zip = zipfile.ZipFile(io.BytesIO(nvd_feed_file))
    file_data = zip.open('nvdcve-1.1-' + str(year) + '.json')
    json_data = json.load(file_data)

    # Iterate through each CVE in the feed
    for cve in json_data['CVE_Items']:
        cve_id = cve['cve']['CVE_data_meta']['ID']
        cve_pub_date = cve['publishedDate'].split('T')[0]
        # Parse out the CVE description
        for cve_desc_item in cve['cve']['description']['description_data']:
            if cve_desc_item['lang'] == 'en':
                cve_desc = cve_desc_item['value']
                break
        # Iterate over each CVE's affected software configurations
        for node in cve['configurations']['nodes']:
            cpe_to_parse = []
            # Look at CPEs listed both at a parent level and child level
            if 'cpe_match' in node:
                for cpe in node['cpe_match']:
                    cpe_to_parse.append(cpe)
            elif 'children' in node:
                for child in node['children']:
                    for cpe in child['cpe_match']:
                        cpe_to_parse.append(cpe)
            # Some CVE's may have invalid CPE data.
            else:
                print('Invalid software configuration found in', cve_id)

            # Parse the CPE 2.3 URI
            for cpe in cpe_to_parse:
                cpe_uri = cpe['cpe23Uri']
                cpe_fields = cpe_uri.split(':')
                host_platform = cpe_fields[10]
                # Append Android and iOS matches to a match list
                if host_platform == "iphone_os" or host_platform == "android":
                    if cve_id not in cves_already_listed:
                        cves_already_listed.append(cve_id)
                        matching_cve = { 
                            'id': cve_id, 
                            'desc': cve_desc,
                            'pub_date': cve_pub_date}
                        matching_cves.append(matching_cve)

# Sort the match list by date
date_sorted_matching_cves = sorted(matching_cves, key=lambda k: k['pub_date'])

# Count the number of CVEs and format it like "1,000"
total_with_comma = f'{len(date_sorted_matching_cves):,}'
print(str(total_with_comma), 'mobile app CVEs found')

# Building the HTML output report as a string
report = '<h2>' + str(total_with_comma) + ' mobile app CVEs found today:</h2>\n'
# Append each matched CVE as HTML
for cve in reversed(date_sorted_matching_cves):
    report += '[' + cve['pub_date'] + '] <a href="https://nvd.nist.gov/vuln/detail/' + cve['id'] + '">' + cve['id'] + '</a>: ' + cve['desc'] + '<br>\n<br>\n'

# Write the output HTML report
try:
    output_file = 'mobile-app-cves.html'
    with open(output_file, 'w') as file:
        file.write(report)
    print("All mobile app CVEs saved to", output_file)
except OSError:
    print("Couldn't save a report file, please verify permissions.")