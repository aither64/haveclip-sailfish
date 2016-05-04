# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-haveclip

CONFIG += sailfishapp
DEFINES += MER_SAILFISH

INCLUDEPATH += ../haveclip-core/src

SOURCES += \
    src/harbour-haveclip.cpp \
    src/nodemodel.cpp \
    src/nodediscoverymodel.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/Settings.qml \
    qml/pages/settings/Pool.qml \
    qml/pages/settings/NodeDialog.qml \
    qml/pages/settings/Clipboard.qml \
    qml/harbour-haveclip.qml \
    rpm/harbour-haveclip.spec \
    rpm/harbour-haveclip.yaml \
    harbour-haveclip.desktop \
    harbour-haveclip.png \
    qml/pages/About.qml \
    qml/pages/History.qml \
    qml/pages/settings/Network.qml \
    qml/pages/settings/Security.qml \
    qml/pages/settings/verificationwizard/Search.qml \
    qml/pages/settings/verificationwizard/Verify.qml \
    qml/pages/settings/verificationwizard/Prompt.qml \
    qml/pages/settings/security/CertificateGenerator.qml

HEADERS += \
    src/nodemodel.h \
    src/nodediscoverymodel.h

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../haveclip-core/release/ -lhaveclipcore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../haveclip-core/debug/ -lhaveclipcore
else:unix: LIBS += -L$$OUT_PWD/../haveclip-core/ -lhaveclipcore

INCLUDEPATH += $$PWD/../haveclip-core/src
DEPENDPATH += $$PWD/../haveclip-core/src

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../haveclip-core/release/libhaveclipcore.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../haveclip-core/debug/libhaveclipcore.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../haveclip-core/release/haveclipcore.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../haveclip-core/debug/haveclipcore.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../haveclip-core/libhaveclipcore.a

unix {
	PKGCONFIG += openssl
}
