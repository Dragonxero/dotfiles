#!/bin/bash

echo `mpstat | grep all | awk '{print $7 +$6 +$5 + $4}'`
