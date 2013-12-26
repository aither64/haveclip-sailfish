#ifndef QMLCLIPBOARDMANAGER_H
#define QMLCLIPBOARDMANAGER_H

#include <QObject>
#include "../haveclip-core/src/ClipboardManager.h"

class QmlClipboardManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString content READ content NOTIFY contentChanged)

public:
    explicit QmlClipboardManager(QObject *parent = 0);
    QString content();

signals:
    void contentChanged(QString content);

public slots:
	void jumpToItemAt(int index);

private:
    ClipboardManager *m_manager;
    History *m_history;
    QString m_content;

private slots:
    void historyChange();

};

#endif // QMLCLIPBOARDMANAGER_H
