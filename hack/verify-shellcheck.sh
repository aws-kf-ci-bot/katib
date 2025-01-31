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
set -o pipefail

cd "$(dirname "$0")/.."

if ! which shellcheck >/dev/null; then
	echo 'Can not find shellcheck, install with: make shellcheck'
	exit 1
fi

shell_scripts=()
while IFS='' read -r script;
  do git check-ignore -q "$script" || shell_scripts+=("$script");
done < <(find . -name "*.sh" \
  ! -path "./_*" \
  ! -path "./.git/*"
)

echo 'Running shellcheck'
shellcheck "${shell_scripts[@]}"
