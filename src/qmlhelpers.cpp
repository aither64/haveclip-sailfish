#include "qmlhelpers.h"

#include "ClipboardManager.h"
#include "qmlnode.h"

QmlHelpers::QmlHelpers(QObject *parent) :
	QObject(parent),
	m_verifiedNode(0)
{
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
