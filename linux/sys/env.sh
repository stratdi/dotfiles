# Colors
echo $(cat colors.txt | grep "^[^#;]")  >> /etc/environment
