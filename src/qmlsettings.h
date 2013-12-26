#ifndef QMLSETTINGS_H
#define QMLSETTINGS_H

#include <QObject>
#include <QStringListModel>
#include "../haveclip-core/src/ClipboardManager.h"

class QmlSettings : public QObject
{
    Q_OBJECT

public:
    explicit QmlSettings(QObject *parent = 0);

	Q_PROPERTY(QString host READ host WRITE setHost)
	QString host();
	void setHost(QString host);

	Q_PROPERTY(quint16 port READ port WRITE setPort)
	quint16 port();
	void setPort(quint16 port);

	Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    QString password();
	void setPassword(QString password);

	Q_PROPERTY(QObject* nodeModel READ nodeModel)
    QStringListModel* nodeModel();

	Q_PROPERTY(bool historyEnabled READ isHistoryEnabled WRITE setHistoryEnabled NOTIFY historyEnabledChanged)
	bool isHistoryEnabled() const;
	void setHistoryEnabled(bool enabled);

	Q_PROPERTY(int historySize READ historySize WRITE setHistorySize)
	int historySize() const;
	void setHistorySize(int size);

	Q_PROPERTY(bool saveHistory READ saveHistory WRITE setSaveHistory NOTIFY saveHistoryChanged)
	bool saveHistory() const;
	void setSaveHistory(bool save);

	Q_PROPERTY(bool syncEnabled READ isSyncEnabled WRITE setSyncEnabled NOTIFY syncEnabledChanged)
	bool isSyncEnabled() const;
	void setSyncEnabled(bool enabled);

    Q_INVOKABLE void addNode(QString addr, QString port);
    Q_INVOKABLE void updateNodeAt(int index, QString addr, QString port);
    Q_INVOKABLE void deleteNodeAt(int index);
    Q_INVOKABLE void deleteAllNodes();
	Q_INVOKABLE void save();

signals:
    void passwordChanged(QString password);
	void historyEnabledChanged(bool enabled);
	void saveHistoryChanged(bool save);
	void syncEnabledChanged(bool enabled);

public slots:


private:
    ClipboardManager *m_manager;
    QStringListModel *m_nodeModel;
};

#endif // QMLSETTINGS_H
