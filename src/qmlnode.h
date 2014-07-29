#ifndef QMLNODE_H
#define QMLNODE_H

#include <QObject>

#include "Node.h"

class QmlSslCertificate;

class QmlNode : public QObject
{
	Q_OBJECT
public:
	explicit QmlNode(QObject *parent = 0);
	QmlNode(const Node& n, QObject *parent = 0);

	Q_PROPERTY(unsigned int id READ id)
	unsigned int id() const;

	Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
	QString name() const;
	void setName(QString name);

	Q_PROPERTY(QString host READ host WRITE setHost NOTIFY hostChanged)
	QString host() const;
	void setHost(QString host);

	Q_PROPERTY(quint16 port READ port WRITE setPort NOTIFY portChanged)
	quint16 port() const;
	void setPort(quint16 port);

	Q_PROPERTY(bool sendEnabled READ isSendEnabled WRITE setSendEnabled NOTIFY sendEnabledChanged)
	bool isSendEnabled() const;
	void setSendEnabled(bool enabled);

	Q_PROPERTY(bool receiveEnabled READ isReceiveEnabled WRITE setReceiveEnabled NOTIFY receiveEnabledChanged)
	bool isReceiveEnabled() const;
	void setReceiveEnabled(bool enabled);

	Q_PROPERTY(QmlSslCertificate* sslCertificate READ sslCertificate NOTIFY sslCertificateChanged)
	QmlSslCertificate* sslCertificate();

	Node node() const;
	void setNode(const Node &n);

signals:
	void nameChanged();
	void hostChanged();
	void portChanged(quint16 port);
	void sendEnabledChanged();
	void receiveEnabledChanged();
	void sslCertificateChanged();

private:
	Node m_node;

	QmlSslCertificate* m_sslCertificate;
};

#endif // QMLNODE_H
