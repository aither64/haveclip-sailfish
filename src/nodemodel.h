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
