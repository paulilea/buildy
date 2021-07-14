docker build -t pauloss/buildy .

printf "\n\n"
docker run --rm pauloss/buildy rsync --version
printf "\n\n"
docker run --rm pauloss/buildy php -v
printf "\n\n"
docker run --rm pauloss/buildy composer --version
printf "\n\n"
docker run --rm pauloss/buildy composer1 --version
printf "\n\n"
docker run --rm pauloss/buildy git --version
printf "\n\n"
docker run --rm pauloss/buildy identify --version
printf "\n\nnode:"
docker run --rm pauloss/buildy node --version
printf "\n\nnpm:"
docker run --rm pauloss/buildy npm --version
