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
