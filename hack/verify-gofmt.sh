#!/usr/bin/env bash

# Copyright 2022 The Kubeflow Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

if ! which gofmt >/dev/null; then
  echo "Can not find gofmt"
  exit 1
fi

diff=$(find . -name "*.go" | grep -v "\.pb\.go$" | xargs gofmt -s -d 2>&1)
if [[ -n "${diff}" ]]; then
  echo "${diff}"
  echo
  echo "Please run hack/update-gofmt.sh"
  exit 1
fi
