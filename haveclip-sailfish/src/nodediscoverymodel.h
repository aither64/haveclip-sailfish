/*
  HaveClip

  Copyright (C) 2013-2016 Jakub Skokan <aither@havefun.cz>

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

#ifndef NODEDISCOVERYMODEL_H
#define NODEDISCOVERYMODEL_H

#include <QAbstractListModel>

#include "../haveclip-core/src/Node.h"

class AutoDiscovery;
class QmlNode;

class NodeDiscoveryModel : public QAbstractListModel
{
	Q_OBJECT
public:
	enum Columns {
		Name = 0,
		Compatible,
		HostAddress,
		HostPort,
		ColumnCount
	};

	enum NodeModelRoles {
		NameRole = Qt::UserRole + 1,
		IdRole,
		HostRole,
		PortRole
	};

	explicit NodeDiscoveryModel(QObject *parent = 0);
	QHash<int, QByteArray> roleNames() const;
	int columnCount(const QModelIndex &parent = QModelIndex()) const;
	int rowCount(const QModelIndex &parent = QModelIndex()) const;
	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
	QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
	Q_INVOKABLE QmlNode* nodeAt(int i);

	Q_PROPERTY(bool empty READ isEmpty NOTIFY emptyChanged)
	bool isEmpty() const;
	//void setEmpty();

	Q_INVOKABLE void discover();
	Q_INVOKABLE bool haveSearchedYet() const;

signals:
	void emptyChanged(bool empty);

private slots:
	void resetDiscovery();
	void addNode(const Node &n);

private:
	AutoDiscovery *m_discovery;
	QList<Node> m_nodes;
	QmlNode *m_qmlNode;
};

#endif // NODEDISCOVERYMODEL_H
