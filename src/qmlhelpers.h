#ifndef QMLHELPERS_H
#define QMLHELPERS_H

#include <QObject>

#include "Network/Communicator.h"

class QmlNode;
class CertificateInfo;

class QmlHelpers : public QObject
{
	Q_OBJECT
public:
	explicit QmlHelpers(QObject *parent = 0);

	Q_PROPERTY(CertificateInfo* selfSslCertificate READ selfSslCertificate NOTIFY selfSslCertificateChanged)
	CertificateInfo* selfSslCertificate() const;

	Q_INVOKABLE QmlNode* verifiedNode();
	Q_INVOKABLE QString communicationStatusToString(Communicator::CommunicationStatus status) const;

signals:
	void selfSslCertificateChanged();
	void verificationRequested(QmlNode *node);

private slots:
	void updateSelfSslCertificate(const QSslCertificate &certificate);

private:
	QmlNode *m_verifiedNode;
	CertificateInfo *m_selfCert;

};

#endif // QMLHELPERS_H
