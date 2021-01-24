# Colors
for color in $(cat colors.txt | grep "^[^#;]"); do echo $color; done  >> /etc/environment

# Spring script config
echo "SPRING_APPS_PATH=~/Apps" >> /etc/environment
