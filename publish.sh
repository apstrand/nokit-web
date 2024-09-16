#!/bin/bash

set -e

rm -rf public

hugo

rsync -avP public/ peter@wonko.nena.se:web/nokit/

