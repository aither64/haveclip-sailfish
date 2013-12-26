#include "qmlsettings.h"

QmlSettings::QmlSettings(QObject *parent) :
    QObject(parent)
{
    m_manager = ClipboardManager::instance();
    m_nodeModel = new QStringListModel(this);
    m_nodeModel->setStringList(m_manager->settings()->value("Pool/Nodes").toStringList());
}

QString QmlSettings::password()
{
    return m_manager->password();
}

void QmlSettings::setPassword(QString password)
{
	m_manager->setPassword(password);
}

QStringListModel* QmlSettings::nodeModel()
{
    return m_nodeModel;
}

bool QmlSettings::isHistoryEnabled() const
{
	return m_manager->history()->isEnabled();
}

void QmlSettings::setHistoryEnabled(bool enabled)
{
	m_manager->history()->setEnabled(enabled);
}

int QmlSettings::historySize() const
{
	return m_manager->history()->stackSize();
}

void QmlSettings::setHistorySize(int size)
{
	m_manager->history()->setStackSize(size);
}

bool QmlSettings::saveHistory() const
{
	return m_manager->history()->isSaving();
}

void QmlSettings::setSaveHistory(bool save)
{
	m_manager->history()->setSave(save);
}

bool QmlSettings::isSyncEnabled() const
{
	return m_manager->isSyncEnabled();
}

void QmlSettings::setSyncEnabled(bool enabled)
{
	m_manager->toggleSharedClipboard(enabled);

	emit syncEnabledChanged(enabled);
}

void QmlSettings::addNode(QString addr, QString port)
{
    QStringList tmp = m_manager->settings()->value("Pool/Nodes").toStringList();
    tmp << QString("%1:%2").arg(addr).arg(port);

    m_manager->setNodes(tmp);
    m_nodeModel->setStringList(m_manager->settings()->value("Pool/Nodes").toStringList());
}

void QmlSettings::updateNodeAt(int index, QString addr, QString port)
{
    QStringList tmp = m_manager->settings()->value("Pool/Nodes").toStringList();
    tmp[index] = addr + ":" + port;

    m_manager->setNodes(tmp);
    m_nodeModel->setStringList(m_manager->settings()->value("Pool/Nodes").toStringList());
}

void QmlSettings::deleteNodeAt(int index)
{
    QStringList tmp = m_manager->settings()->value("Pool/Nodes").toStringList();
    tmp.removeAt(index);

    m_manager->setNodes(tmp);
    m_nodeModel->setStringList(m_manager->settings()->value("Pool/Nodes").toStringList());
}

void QmlSettings::deleteAllNodes()
{
    m_manager->setNodes(QStringList());
    m_nodeModel->setStringList(m_manager->settings()->value("Pool/Nodes").toStringList());
}

void QmlSettings::save()
{
    m_manager->saveSettings();
}
