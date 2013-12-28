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

#ifndef QMLSETTINGS_H
#define QMLSETTINGS_H

#include <QObject>
#include "../haveclip-core/src/ClipboardManager.h"

class QmlSettings : public QObject
{
    Q_OBJECT

public:
    explicit QmlSettings(QObject *parent = 0);

	Q_PROPERTY(QString host READ host WRITE setHost)
	QString host();
	void setHost(QString host);

	Q_PROPERTY(quint16 port READ port WRITE setPort)
	quint16 port();
	void setPort(quint16 port);

	Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    QString password();
	void setPassword(QString password);

	Q_PROPERTY(bool historyEnabled READ isHistoryEnabled WRITE setHistoryEnabled NOTIFY historyEnabledChanged)
	bool isHistoryEnabled() const;
	void setHistoryEnabled(bool enabled);

	Q_PROPERTY(int historySize READ historySize WRITE setHistorySize)
	int historySize() const;
	void setHistorySize(int size);

	Q_PROPERTY(bool saveHistory READ saveHistory WRITE setSaveHistory NOTIFY saveHistoryChanged)
	bool saveHistory() const;
	void setSaveHistory(bool save);

	Q_PROPERTY(bool syncEnabled READ isSyncEnabled WRITE setSyncEnabled NOTIFY syncEnabledChanged)
	bool isSyncEnabled() const;
	void setSyncEnabled(bool enabled);

	Q_INVOKABLE void save();

signals:
    void passwordChanged(QString password);
	void historyEnabledChanged(bool enabled);
	void saveHistoryChanged(bool save);
	void syncEnabledChanged(bool enabled);

public slots:


private:
    ClipboardManager *m_manager;
};

#endif // QMLSETTINGS_H
