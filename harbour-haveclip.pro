TEMPLATE = subdirs
SUBDIRS = haveclip-core \
        harbour-haveclip

harbour-haveclip.depends = haveclip-core

DEFINES += MER_SAILFISH
