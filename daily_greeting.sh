#!/bin/bash

cows=("dragon" "tux") # list of "cows" to choose from (see cowsay -l)

#mesages for days of the week
function weekday_message() {
    case "$(date '+%u')" in
        1) weekday_mess_arr=("Monday 1") ;;
        2) weekday_mess_arr=("Tuesday 1"
                          "Tuesday 2") ;;
	3) weekday_mess_arr=("Wednesday 1"
	                  "Wednesday 2"
	                  "Wednesday 3") ;;
        4) weekday_mess_arr=("Thursday") ;;
        5) weekday_mess_arr=("Friday") ;;
        6|7) weekday_mess_arr=("Weekend") ;;
        *) weekday_mess_arr=("Have a good day.") ;;
    esac
    echo ${weekday_mess_arr[ $RANDOM % ${#weekday_mess_arr[@]} ]} # select random message out of array
}

# yearly special dates
function yearly_message() {
    case "$(date '+%m-%d')" in
        "09-17") : "Happy $(( $(date '+%Y') - 1991 ))th birthday Linux" ;;
        "12-24") : "Marry X-Mas." ;;
        "01-01" | "12-31") : "Happy new Year!" ;;
        *) : "$(weekday_message)" ;;
    esac
    echo $_
}

# special dates
function onetime_message() {
    case "$(date '+%Y-%m-%d')" in
        "1970-01-01") : "The Beginning" ;;
        "2038-01-19") : "The End" ;;
        *) : "$(yearly_message)" ;;
    esac
    echo $_
}

daily_mes="$(onetime_message)" 

# dependent on time of day
cur_time=$(date "+%_H")
if [ "$cur_time" -ge "22" ] || [ "$cur_time" -le "5" ] ; then
    daily_mes="$daily_mes
	
Its getting late. Remember sleep is important!"
elif [[ $cur_time -le "9" ]]; then
    daily_mes="Good morning. 
$daily_mes"
fi 

cow=${cows[ $RANDOM % ${#cows[@]} ]} # select random "cow" out of list

echo "$daily_mes" | cowsay -f $cow -n

