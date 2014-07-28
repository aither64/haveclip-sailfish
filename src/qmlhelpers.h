#ifndef QMLHELPERS_H
#define QMLHELPERS_H

#include <QObject>

#include "Network/Communicator.h"

class QmlNode;

class QmlHelpers : public QObject
{
	Q_OBJECT
public:
	explicit QmlHelpers(QObject *parent = 0);

	Q_INVOKABLE QmlNode* verifiedNode();
	Q_INVOKABLE QString communicationStatusToString(Communicator::CommunicationStatus status) const;

private:
	QmlNode *m_verifiedNode;

};

#endif // QMLHELPERS_H
