#include "qmlsslcertificate.h"

#include <QStringList>

QmlSslCertificate::QmlSslCertificate(QObject *parent) :
	QObject(parent)
{
}

QmlSslCertificate::QmlSslCertificate(const QSslCertificate &cert, QObject *parent) :
	QObject(parent),
	m_cert(cert)
{

}

bool QmlSslCertificate::isNull() const
{
	return m_cert.isNull();
}

QString QmlSslCertificate::commonName() const
{
	return subjectInfo(QSslCertificate::CommonName);
}

QString QmlSslCertificate::organization() const
{
	return subjectInfo(QSslCertificate::Organization);
}

QString QmlSslCertificate::organizationUnit() const
{
	return subjectInfo(QSslCertificate::OrganizationalUnitName);
}

QString QmlSslCertificate::serialNumber() const
{
	return formatDigest(m_cert.serialNumber());
}

QDateTime QmlSslCertificate::issuedOn() const
{
	return m_cert.effectiveDate();
}

QDateTime QmlSslCertificate::expiryDate() const
{
	return m_cert.expiryDate();
}

QString QmlSslCertificate::sha1Digest() const
{
	return formatDigest(m_cert.digest(QCryptographicHash::Sha1));
}

QString QmlSslCertificate::md5Digest() const
{
	return formatDigest(m_cert.digest(QCryptographicHash::Md5));
}

void QmlSslCertificate::setCertificate(const QSslCertificate &cert)
{
	m_cert = cert;

	emit nullChanged();
	emit commonNameChanged();
	emit organizationChanged();
	emit organizationUnitChanged();
	emit serialNumberChanged();
	emit issuedOnChanged();
	emit expiryDateChanged();
	emit sha1DigestChanged();
	emit md5DigestChanged();
}

QString QmlSslCertificate::formatDigest(QByteArray raw) const
{
	QString digest = QString(raw.toHex()).toUpper();

	for(int i = 2; i < digest.size(); i+=3)
		digest.insert(i, ":");

	return digest;
}

QString QmlSslCertificate::subjectInfo(QSslCertificate::SubjectInfo info) const
{
#if (QT_VERSION >= QT_VERSION_CHECK(5, 0, 0))
	return m_cert.subjectInfo(info).join(" ");
#else
	return m_cert.subjectInfo(info);
#endif
}
