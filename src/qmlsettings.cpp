/*
  HaveClip

  Copyright (C) 2013 Jakub Skokan <aither@havefun.cz>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "qmlsettings.h"

QmlSettings::QmlSettings(QObject *parent) :
    QObject(parent)
{
    m_manager = ClipboardManager::instance();
    m_nodeModel = new QStringListModel(this);
    m_nodeModel->setStringList(m_manager->settings()->value("Pool/Nodes").toStringList());
}

QString QmlSettings::host()
{
	return m_manager->host();
}

void QmlSettings::setHost(QString host)
{
	m_manager->setHost(host);
}

quint16 QmlSettings::port()
{
	return m_manager->port();
}

void QmlSettings::setPort(quint16 port)
{
	m_manager->setPort(port);
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
