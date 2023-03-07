#!/bin/bash
# Copyright (c) 2022-2023, AllWorldIT.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.


# commitlint disable=SC2164
cd "$CI_PROJECT_DIR"


fdc_test_start "commitlint" "Testing valid commit message"
if ! run-commitlint --from "${CI_MERGE_REQUEST_DIFF_BASE_SHA}" --to HEAD --verbose; then
    fdc_test_fail "commitlint" "Valid commit message test failed"
    false
fi
fdc_test_pass "commitlint" "Valid commit message passed"


fdc_test_start "commitlint" "Testing invalid commit message"
git commit --amend -m "invalid commit"
if run-commitlint --from "${CI_MERGE_REQUEST_DIFF_BASE_SHA}" --to HEAD --verbose; then
    fdc_test_fail "commitlint" "Invalid commit message failed"
    false
fi
fdc_test_pass "commitlint" "Invalid commit message passed"
