#ifndef QMLHELPERS_H
#define QMLHELPERS_H

#include <QObject>

#include "Network/Communicator.h"

class QmlNode;
class QmlSslCertificate;

class QmlHelpers : public QObject
{
	Q_OBJECT
public:
	explicit QmlHelpers(QObject *parent = 0);

	Q_PROPERTY(QmlSslCertificate* selfSslCertificate READ selfSslCertificate NOTIFY selfSslCertificateChanged)
	QmlSslCertificate* selfSslCertificate() const;

	Q_INVOKABLE QmlNode* verifiedNode();
	Q_INVOKABLE QString communicationStatusToString(Communicator::CommunicationStatus status) const;

signals:
	void selfSslCertificateChanged();

private slots:
	void updateSelfSslCertificate(const QSslCertificate &certificate);

private:
	QmlNode *m_verifiedNode;
	QmlSslCertificate *m_selfCert;

};

#endif // QMLHELPERS_H
