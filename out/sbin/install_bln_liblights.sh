# BacklightNotification
# Installs bln liblights

# commands need:
#   test [-f, -gt]
#   cp
#   mv
#   strings
#   grep [-c]

#eclair
#liblights_name = "lights.default.so"
#liblights_destdir = "/system/lib/hw/"
#liblights_sourcedir = "/res/misc/"


# froyo
liblights_name = "lights.s5pc110.so"
liblights_sourcedir = "/res/misc"
liblights_destdir = "/system/lib/hw"


if test ($(strings $liblights_dest/$liblights_name | grep -c "backlightnotification") -eq 0
    then
	#no bln liblights or liblights v0
	if test ! -f $liblights_dest/${liblights_name}.backup
	    then
		mv $liblights_dest/$liblights_name $liblights_dest/${liblights_name}.backup
#	    else
#		log "liblights already backed up"
	fi
#	log "copying bln liblights"
	cp $liblights_sourcedir/$liblights_name $liblights_dest/
	chmod 644 $liblights_dest
#    else
#	log "liblights version >= v1"
fi

exit 0;