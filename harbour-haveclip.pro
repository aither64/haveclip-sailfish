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

SOURCES += \
    haveclip-core/src/History.cpp \
    haveclip-core/src/ClipboardSerialBatch.cpp \
    haveclip-core/src/ClipboardManager.cpp \
    haveclip-core/src/ClipboardItem.cpp \
    haveclip-core/src/ClipboardContainer.cpp \
    haveclip-core/src/Network/Sender.cpp \
    haveclip-core/src/Network/Receiver.cpp \
    haveclip-core/src/Network/Conversation.cpp \
    haveclip-core/src/Network/Communicator.cpp \
    haveclip-core/src/Network/Command.cpp \
    haveclip-core/src/Network/Commands/SerialModeToggle.cpp \
    haveclip-core/src/Network/Commands/SerialModeInfo.cpp \
    haveclip-core/src/Network/Commands/SerialModeAppendReady.cpp \
    haveclip-core/src/Network/Commands/Confirm.cpp \
    haveclip-core/src/Network/Commands/Cmd_SerialModeBase.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateSend.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateReady.cpp \
    haveclip-core/src/Network/Commands/ClipboardUpdateConfirm.cpp \
    haveclip-core/src/Network/Conversations/SerialModeRestart.cpp \
    haveclip-core/src/Network/Conversations/SerialModeNext.cpp \
    haveclip-core/src/Network/Conversations/SerialModeEnd.cpp \
    haveclip-core/src/Network/Conversations/SerialModeCopy.cpp \
    haveclip-core/src/Network/Conversations/SerialModeBegin.cpp \
    haveclip-core/src/Network/Conversations/SerialModeBase.cpp \
    haveclip-core/src/Network/Conversations/SerialModeAppend.cpp \
    haveclip-core/src/Network/Conversations/HistoryMixin.cpp \
    haveclip-core/src/Network/Conversations/ClipboardUpdate.cpp \
    haveclip-core/src/PasteServices/BasePasteService.cpp \
    haveclip-core/src/PasteServices/HaveSnippet/HaveSnippet.cpp \
    haveclip-core/src/PasteServices/Pastebin/Pastebin.cpp \
    haveclip-core/src/PasteServices/Stikked/Stikked.cpp \
    src/qmlclipboardmanager.cpp \
    src/qmlsettings.cpp \
    src/harbour-haveclip.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/Settings.qml \
    qml/pages/settings/Connection.qml \
    qml/pages/settings/Pool.qml \
    qml/pages/settings/NodeDialog.qml \
    qml/pages/settings/Clipboard.qml \
    qml/harbour-haveclip.qml \
    rpm/harbour-haveclip.spec \
    rpm/harbour-haveclip.yaml \
    harbour-haveclip.desktop \
    harbour-haveclip.png \
    qml/pages/About.qml \
    qml/pages/History.qml

HEADERS += \
    haveclip-core/src/History.h \
    haveclip-core/src/ClipboardSerialBatch.h \
    haveclip-core/src/ClipboardManager.h \
    haveclip-core/src/ClipboardItem.h \
    haveclip-core/src/ClipboardContainer.h \
    haveclip-core/src/Network/Sender.h \
    haveclip-core/src/Network/Receiver.h \
    haveclip-core/src/Network/Conversation.h \
    haveclip-core/src/Network/Communicator.h \
    haveclip-core/src/Network/Command.h \
    haveclip-core/src/Network/Commands/SerialModeToggle.h \
    haveclip-core/src/Network/Commands/SerialModeInfo.h \
    haveclip-core/src/Network/Commands/SerialModeAppendReady.h \
    haveclip-core/src/Network/Commands/Confirm.h \
    haveclip-core/src/Network/Commands/Cmd_SerialModeBase.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateSend.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateReady.h \
    haveclip-core/src/Network/Commands/ClipboardUpdateConfirm.h \
    haveclip-core/src/Network/Conversations/SerialModeRestart.h \
    haveclip-core/src/Network/Conversations/SerialModeNext.h \
    haveclip-core/src/Network/Conversations/SerialModeEnd.h \
    haveclip-core/src/Network/Conversations/SerialModeCopy.h \
    haveclip-core/src/Network/Conversations/SerialModeBegin.h \
    haveclip-core/src/Network/Conversations/SerialModeBase.h \
    haveclip-core/src/Network/Conversations/SerialModeAppend.h \
    haveclip-core/src/Network/Conversations/HistoryMixin.h \
    haveclip-core/src/Network/Conversations/ClipboardUpdate.h \
    haveclip-core/src/PasteServices/BasePasteService.h \
    haveclip-core/src/PasteServices/HaveSnippet/HaveSnippet.h \
    haveclip-core/src/PasteServices/Pastebin/Pastebin.h \
    haveclip-core/src/PasteServices/Stikked/Stikked.h \
    src/qmlclipboardmanager.h \
    src/qmlsettings.h
