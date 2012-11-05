#!/bin/sh

ss -4 | grep $1 | awk '{print $5}' | awk -F":" '{print $1}'
