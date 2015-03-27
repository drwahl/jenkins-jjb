#!/bin/bash
#
# Make sure no unexpanded variable names show up in the output of
# jenkins-job-builder
#
# Usage: check_vars.sh output_directory_name

set -x

jjb_dir="$1"
jjb_files=$(ls $jjb_dir/* | grep -v '$jjb_dir/jenkins-')

if [ -z "$jjb_files" ]
then
    echo "ERROR: Found no jjb input files"
    exit 1
fi

# Disallow {var} but ignore shell variables like ${var} and function
# definitions like "function foo () {"
if egrep '[^$]\{.*\}' $jjb_files
then
    echo "ERROR: Found potentially unexpanded jenkins-job-builder variables"
    exit 1
fi
