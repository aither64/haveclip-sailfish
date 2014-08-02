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

#ifndef QMLCLIPBOARDMANAGER_H
#define QMLCLIPBOARDMANAGER_H

#include <QObject>
#include "../haveclip-core/src/ClipboardManager.h"

class QmlClipboardManager : public QObject
{
	Q_OBJECT

public:
	explicit QmlClipboardManager(QObject *parent = 0);

	Q_PROPERTY(QString version READ version)
	QString version();

	Q_PROPERTY(QString content READ content NOTIFY contentChanged)
	QString content();

	Q_INVOKABLE void doSync();

signals:
	void contentChanged(QString content);

public slots:
	void jumpToItemAt(int index);

private:
	ClipboardManager *m_manager;
	History *m_history;
	QString m_content;

private slots:
	void historyChange();

};

#endif // QMLCLIPBOARDMANAGER_H
