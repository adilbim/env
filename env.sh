#!/bin/bash

echo "Type your password:"
read -s password
echo "password: $pass"

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

data=$(curl "http://localhost:5500/sawebliaConfig/$password" --progress-bar)

# data="$data" | ./jq-win64.exe '.data[0].zone'
# echo "$data" > .env

keys=$data | ./jq-win64.exe '.data[0] | keys | .[]';
#keys=(prakhar ankit 1 rishabh manish abhinav)

#echo "keys (${keys[@]})";

# for i in {1..50..2}
# do
#    echo "Looping ... number $i"
# done

echo $data | ./jq-win64.exe '.data' > ../env.json
echo "done."
#echo "this is datatest $data";
#printf "GET /getuser/Default.aspx?username=b772643 HTTP/1.0\r\n\r\n" >&5

#########################################################################

# 1. Create ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:                           
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"

}

# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=100

# Proof of concept
# for number in $(seq ${_start} ${_end})
# do
#     sleep 0.1
#     ProgressBar ${number} ${_end}
# done
printf '\nFinished!\n'