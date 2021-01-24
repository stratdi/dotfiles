#!/bin/bash
## IMPORTANT: Uses colors defined in /etc/environment!!

SPRING_APP_PATH=$SPRING_APPS_PATH/$2
JAVA_FILE=$SPRING_APP_PATH/$2.war
PROPERTIES_FILE=$SPRING_APP_PATH/application.properties

jprocess_pid() {
        echo $(jps -l | awk -v app="$1" '$2 ~ app {print $1}');
}

jprocess_isrunning() {
	if [ -z $(jprocess_pid $1) ]; then false; else true; fi

}

case $1 in
	start)
		if jprocess_isrunning $2; then
			printf "\n${RED}[$2]${NC} App already running...\n\n"
		else
			printf "\n${BLUE}[$2]${NC} Starting app..."
			nohup java \
			-Xms256m -Xmx4g \
			-jar $JAVA_FILE \
			--spring.config.location=file:$PROPERTIES_FILE /tmp 2>> /dev/null >> /dev/null &
			printf "\n${GREEN}[$2]${NC} App successfully started!\n\n"
		fi
	;;
	stop)
		if jprocess_isrunning $2; then
			printf "\n${BLUE}[$2]${NC} Stopping app..."
			kill $(jprocess_pid $2);
			printf "\n${GREEN}[$2]${NC} App successfully stopped!\n\n"
		else
			printf "\n${RED}[$2]${NC} App is not running...\n\n"
		fi
	;;
	status)
		if jprocess_isrunning $2; then
			printf "\n${GREEN}[$2]${NC} App currently running\n\n"
		else
			printf "\n${RED}[$2]${NC} App currently stopped\n\n"
		fi
	;;
	stats)
		echo "TODO!"
	;;
esac
