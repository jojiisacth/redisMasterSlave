#!/bin/bash

# Copyright 2014 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function launchmaster() {
  if [[ ! -e /redis-master-data ]]; then
    echo "Redis master data doesn't exist, data won't be persistent!"
    mkdir /redis-master-data
  fi
  redis-server /redisconf/master.conf --protected-mode no
}


function launchslave() {
  while true; do
    redis-cli -h ${REDIS_MASTER_SERVICE_HOST} INFO
    if [[ "$?" == "0" ]]; then
      break
    fi
    echo "Connecting to master failed.  Waiting..."
    sleep 10
  done
  sed -i "s/%master-ip%/${REDIS_MASTER_SERVICE_HOST}/" redisconf/slave.conf
  #sed -i "s/%master-port%/${REDIS_MASTER_SERVICE_PORT}/" redisconf/slave.conf
  redis-server /redisconf/slave.conf --protected-mode no
}

if [[ "${MASTER}" == "true" ]]; then
  launchmaster
  exit 0
fi

launchslave

