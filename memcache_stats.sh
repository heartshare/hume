#!/bin/bash

declare -a cache_ips=( "10.11.65.30" "10.11.65.31" "10.11.65.32" "10.11.65.35" "10.11.65.37" "10.11.65.38" "10.11.65.45" "10.11.65.46" "10.11.65.51" "10.11.65.57" "10.11.65.61" "10.11.65.70" "10.11.65.74" "10.11.65.75")

declare -a cache_ports=("11210" "11211" "11212" "11213" "11214" "11215")

case "$1" in
  allcache)
    if [ -f "./memcache_stats.log" ]
    then
        rm -rf ./memcache_stats.log
    fi
    cache_ips_len=${#cache_ips[*]}
    cache_ports_len=${#cache_ports[*]}
    echo "ip.length = $cache_ips_len, port.length = $cache_ports_len"
    declare -i i=0
    memcache_stats_log=./memcache_stats.log.`date +%Y%m%d%H%M%S`
    while  [ $i -lt $cache_ips_len ]
    do
      ip_name="${cache_ips[$i]}"
      declare j=0 
      while  [ $j -lt $cache_ports_len ]
      do
        port_name="${cache_ports[$j]}"
        node_name=$ip_name:$port_name
        perl memcache_stats.pl $node_name stats >> $memcache_stats_log
        echo "" >> $memcache_stats_log
        let j++
      done
      let i++
    done
    ;;

  *) 
    echo "parameter error"
    ;;
esac	

