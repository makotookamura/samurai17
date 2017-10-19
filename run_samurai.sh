#!bin/sh

function install_samurai () {
    git clone https://github.com/SamurAI-Coding/Software2017-18/ .
    make -B -k
    echo `date +%Y%m%d%H%M%S` > installed     
}

function create_make_players () {
    echo 'make -C player/ -k' > make_players.sh
    chmod 777 make_players.sh
}

function create_race_settings () {
    {
        echo 'DATETIME=`date +%Y%m%d%H%M%S`'
        echo 'COURSE=samples/sample-course.smrjky'
        echo 'AI1=player/greedy'
        echo 'AI1_NAME=ai1'
        echo 'AI2=player/greedy'
        echo 'AI2_NAME=ai2'
        echo 'LOG1=log/$DATETIME$AI1_NAME.log'
        echo 'LOG2=log/$DATETIME$AI2_NAME.log'
        echo 'RACELOG=log/$DATETIME.racelog'
    } > race_settings.txt
    chmod 777 make_players.sh
}

if ! test -e /samurai/installed ; then
    install_samurai
fi

if ! test -e make_players.sh ; then
    create_make_players
fi

if ! test -e race_settings.txt ; then
    create_race_settings
fi

mkdir -p log
./make_players.sh
. race_settings.txt
official/official $COURSE $AI1 $AI1_NAME $AI2 $AI2_NAME $LOG1 $LOG2 > $RACELOG

/bin/sh