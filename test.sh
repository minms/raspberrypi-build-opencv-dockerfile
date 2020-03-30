#!/bin/bash

docker run -it \
	-v "$(pwd):/root/sources" \
	cross-compler /bin/bash