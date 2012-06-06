count=0
while read -r line
do
    echo $line
    unbound-control local_data $line
    let "count+=1"
    echo "=============     $count     ============="
done <tes.z
