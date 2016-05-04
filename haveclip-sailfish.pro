TEMPLATE = subdirs
SUBDIRS = haveclip-core \
        haveclip-sailfish

haveclip-sailfish.depends = haveclip-core

DEFINES += MER_SAILFISH
