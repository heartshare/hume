#!/bin/sh

traffic_line -s proxy.config.cache.ram_cache.size -v 51539607552
traffic_line -s proxy.config.cache.min_average_object_size -v 64000

traffic_line -s proxy.config.http.send_http11_requests -v 3
traffic_line -s proxy.config.http.cache.enable_default_vary_headers -v 1

traffic_line -s proxy.config.hostdb.ttl_mode -v 2
traffic_line -s proxy.config.hostdb.timeout -v 90

traffic_line -s proxy.config.http.transaction_active_timeout_in -v 0
traffic_line -s proxy.config.http.transaction_active_timeout_out -v 0

# we'd like to use remap.config even in forarding mode.
traffic_line -s proxy.config.reverse_proxy.enabled -v 1
traffic_line -s proxy.config.url_remap.pristine_host_hdr -v 0
traffic_line -s proxy.config.url_remap.remap_required -v 0

traffic_line -s proxy.config.http.connect_attempts_max_retries -v 10
traffic_line -s proxy.config.http.connect_attempts_max_retries_dead_server -v 6
traffic_line -s proxy.config.http.connect_attempts_rr_retries -v 6
traffic_line -s proxy.config.http.down_server.cache_time -v 10
traffic_line -s proxy.config.hostdb.size -v 1000000
traffic_line -s proxy.config.hostdb.storage_size -v 335544320
traffic_line -s proxy.config.http.cache.required_headers -v 0
traffic_line -s proxy.config.http.cache.heuristic_min_lifetime -v 10800
traffic_line -s proxy.config.http.cache.heuristic_max_lifetime -v 5184000
traffic_line -s proxy.config.http.cache.cache_responses_to_cookies -v 3
traffic_line -s proxy.config.http.background_fill_active_timeout -v 1200
traffic_line -s proxy.config.http.background_fill_completed_threshold -v 0
traffic_line -s proxy.config.log.max_space_mb_for_logs -v 400000

traffic_line -s proxy.config.stack_dump_enabled -v 1
traffic_line -s proxy.config.mem_alloc_type.iobuf -v 1
traffic_line -s proxy.config.mem_alloc_type.cachebuf -v 1
traffic_line -s proxy.config.cache.enable_empty_http_doc -v 1
traffic_line -s proxy.config.http.cache.ignore_accept_mismatch -v 1

# record mem hit ratio
traffic_line -s proxy.config.http.record_tcp_mem_hit -v 1

# we need cache video file by default
traffic_line -s proxy.config.http.cache.required_headers -v 0

# enable read_while_writer, the connection collapsing
traffic_line -s proxy.config.cache.enable_read_while_writer -v 1
traffic_line -s proxy.config.http.background_fill_completed_threshold -v 0


traffic_line -x
