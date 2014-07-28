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

INCLUDEPATH += ./haveclip-core/src

SOURCES += \
    src/qmlclipboardmanager.cpp \
    src/harbour-haveclip.cpp \
    src/nodemodel.cpp \
    haveclip-core/src/Settings.cpp \
    haveclip-core/src/Node.cpp \
    haveclip-core/src/History.cpp \
    haveclip-core/src/ConfigMigration.cpp \
    haveclip-core/src/ClipboardManager.cpp \
    haveclip-core/src/ClipboardItem.cpp \
    haveclip-core/src/ClipboardContainer.cpp \
    haveclip-core/src/Network/Sender.cpp \
    haveclip-core/src/Network/Receiver.cpp \
    haveclip-core/src/Network/Conversation.cpp \
    haveclip-core/src/Network/ConnectionManager.cpp \
    haveclip-core/src/Network/Communicator.cpp \
    haveclip-core/src/Network/Command.cpp \
    haveclip-core/src/Network/AutoDiscovery.cpp \
    haveclip-core/src/Network/Commands/SecurityCode.cpp \
    haveclip-core/src/Network/Commands/Ping.cpp \
    haveclip-core/src/Network/Commands/Introduce.cpp \
    haveclip-core/src/Network/Commands/Confirm.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateSend.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateReady.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateConfirm.cpp \
    haveclip-core/src/Network/Conversations/Verification.cpp \
    haveclip-core/src/Network/Conversations/Introduction.cpp \
    haveclip-core/src/Network/Conversations/ClipboardUpdate.cpp \
    haveclip-core/src/ConfigMigrations/V2Migration.cpp \
    src/nodediscoverymodel.cpp \
    src/qmlnode.cpp \
    src/qmlhelpers.cpp

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
    qml/pages/settings/verificationwizard/Verify.qml

HEADERS += \
    src/qmlclipboardmanager.h \
    src/nodemodel.h \
    haveclip-core/src/Version.h \
    haveclip-core/src/Settings.h \
    haveclip-core/src/Node.h \
    haveclip-core/src/History.h \
    haveclip-core/src/ConfigMigration.h \
    haveclip-core/src/ClipboardManager.h \
    haveclip-core/src/ClipboardItem.h \
    haveclip-core/src/ClipboardContainer.h \
    haveclip-core/src/Network/Sender.h \
    haveclip-core/src/Network/Receiver.h \
    haveclip-core/src/Network/Conversation.h \
    haveclip-core/src/Network/ConnectionManager.h \
    haveclip-core/src/Network/Communicator.h \
    haveclip-core/src/Network/Command.h \
    haveclip-core/src/Network/AutoDiscovery.h \
    haveclip-core/src/Network/Commands/SecurityCode.h \
    haveclip-core/src/Network/Commands/Ping.h \
    haveclip-core/src/Network/Commands/Introduce.h \
    haveclip-core/src/Network/Commands/Confirm.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateSend.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateReady.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateConfirm.h \
    haveclip-core/src/Network/Conversations/Verification.h \
    haveclip-core/src/Network/Conversations/Introduction.h \
    haveclip-core/src/Network/Conversations/ClipboardUpdate.h \
    haveclip-core/src/ConfigMigrations/V2Migration.h \
    src/nodediscoverymodel.h \
    src/qmlnode.h \
    src/qmlhelpers.h
