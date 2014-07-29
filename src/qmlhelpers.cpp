#include "qmlhelpers.h"

#include "Settings.h"
#include "ClipboardManager.h"
#include "qmlnode.h"
#include "qmlsslcertificate.h"

QmlHelpers::QmlHelpers(QObject *parent) :
	QObject(parent),
	m_verifiedNode(0),
	m_selfCert(0)
{
	m_selfCert = new QmlSslCertificate(Settings::get()->certificate(), this);

	connect(Settings::get(), SIGNAL(certificateChanged(QSslCertificate)), this, SLOT(updateSelfSslCertificate(QSslCertificate)));
}

QmlSslCertificate* QmlHelpers::selfSslCertificate() const
{
	return m_selfCert;
}

QmlNode* QmlHelpers::verifiedNode()
{
	const Node &n = ClipboardManager::instance()->connectionManager()->verifiedNode();

	if(!m_verifiedNode)
		m_verifiedNode = new QmlNode(n, this);

	else if(m_verifiedNode->node().id() != n.id())
		m_verifiedNode->setNode(n);

	return m_verifiedNode;
}

QString QmlHelpers::communicationStatusToString(Communicator::CommunicationStatus status) const
{
	return Communicator::statusToString(status);
}

void QmlHelpers::updateSelfSslCertificate(const QSslCertificate &certificate)
{
	m_selfCert->setCertificate(certificate);
}
