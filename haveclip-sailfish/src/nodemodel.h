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

#ifndef NODEMODEL_H
#define NODEMODEL_H

#include <QAbstractListModel>
#include "../haveclip-core/src/Node.h"

class QmlNode;

class NodeModel : public QAbstractListModel
{
	Q_OBJECT
public:
	enum NodeModelRoles {
		NameRole = Qt::UserRole + 1,
		IdRole,
		HostRole,
		PortRole
	};

	explicit NodeModel(QObject *parent = 0);
	QHash<int, QByteArray> roleNames() const;
	int rowCount(const QModelIndex &parent) const;
	QVariant data(const QModelIndex &index, int role) const;
	Q_INVOKABLE void remove(QmlNode *n);
	Q_INVOKABLE void removeId(unsigned int id);
	bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex());
	Q_INVOKABLE void deleteAll();
	Q_INVOKABLE void update(QmlNode *n);
	Q_INVOKABLE QmlNode* nodeAt(int i);

private slots:
	void addNode(const Node &n);
	void updateNode(const Node &n);

private:
	QList<Node> m_nodes;
	QmlNode *m_qmlNode;

};

#endif // NODEMODEL_H
