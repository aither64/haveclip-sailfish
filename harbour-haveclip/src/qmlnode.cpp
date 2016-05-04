#include "qmlnode.h"

#include <QDebug>

#include "Settings.h"
#include "CertificateInfo.h"

QmlNode::QmlNode(QObject *parent) :
	QObject(parent),
	m_sslCertificate(0)
{
}

QmlNode::QmlNode(const Node &n, QObject *parent) :
	QObject(parent),
	m_node(n),
	m_sslCertificate(0)
{
}

unsigned int QmlNode::id() const
{
	return m_node.id();
}

QString QmlNode::name() const
{
	return m_node.name();
}

void QmlNode::setName(QString name){
	if(m_node.name() == name)
		return;

	m_node.setName(name);
	emit nameChanged();
}

QString QmlNode::host() const
{
	return m_node.host();
}

void QmlNode::setHost(QString host)
{
	if(m_node.host() == host)
		return;

	m_node.setHost(host);
	emit hostChanged();
}

quint16 QmlNode::port() const
{
	return m_node.port();
}

void QmlNode::setPort(quint16 port)
{
	if(m_node.port() == port)
		return;

	m_node.setPort(port);
	emit portChanged(port);
}

bool QmlNode::isSendEnabled() const
{
	return m_node.isSendEnabled();
}

void QmlNode::setSendEnabled(bool enabled)
{
	if(m_node.isSendEnabled() == enabled)
		return;

	m_node.setSendEnabled(enabled);
	emit sendEnabledChanged();
}

bool QmlNode::isReceiveEnabled() const
{
	return m_node.isReceiveEnabled();
}

void QmlNode::setReceiveEnabled(bool enabled)
{
	if(m_node.isReceiveEnabled() == enabled)
		return;

	m_node.setReceiveEnabled(enabled);
	emit receiveEnabledChanged();
}

CertificateInfo* QmlNode::sslCertificate()
{
	if(m_sslCertificate)
		return m_sslCertificate;

	m_sslCertificate = new CertificateInfo(m_node.certificate(), this);

	return m_sslCertificate;
}

Node QmlNode::node() const
{
	return m_node;
}

void QmlNode::setNode(const Node &n)
{
	m_node = n;

	emit nameChanged();
	emit hostChanged();
	emit portChanged(m_node.port());
	emit sendEnabledChanged();
	emit receiveEnabledChanged();
}

void QmlNode::update()
{
	foreach(const Node &n, Settings::get()->nodes())
	{
		if(n.id() == m_node.id())
		{
			m_node.setCertificate(n.certificate());
			m_sslCertificate->setCertificate(n.certificate());
			break;
		}
	}
}
