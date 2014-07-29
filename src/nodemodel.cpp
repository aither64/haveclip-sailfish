#include "nodemodel.h"
#include "../haveclip-core/src/Settings.h"
#include "qmlnode.h"

NodeModel::NodeModel(QObject *parent) :
	QAbstractListModel(parent),
	m_qmlNode(0)
{
	m_nodes = Settings::get()->nodes();
}

QHash<int, QByteArray> NodeModel::roleNames() const
{
	QHash<int, QByteArray> roles;
	roles[NameRole] = "name";
	roles[IdRole] = "id";
	roles[HostRole] = "host";
	roles[PortRole] = "port";

	return roles;
}

int NodeModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent);

	return m_nodes.count();
}

QVariant NodeModel::data(const QModelIndex &index, int role) const
{
	if(!index.isValid())
		return QVariant();

	const Node &node = m_nodes[index.row()];

	switch(role)
	{
	case Qt::DisplayRole:
		return QString("%1:%2").arg(node.host()).arg(node.port());

	case NameRole:
		return node.name();

	case IdRole:
		return node.id();

	case HostRole:
		return node.host();

	case PortRole:
		return node.port();

	default:
		break;
	}

	return QVariant();
}

void NodeModel::remove(QmlNode *n)
{
	int cnt = m_nodes.size();
	int index = -1;

	for(int i = 0; i < cnt; i++)
	{
		if(m_nodes[i].id() == n->id())
		{
			index = i;
			break;
		}
	}

	if(index == -1)
		return;

	removeRows(index, 1);
}

void NodeModel::removeId(unsigned int id)
{
	int cnt = m_nodes.size();
	int index = -1;

	for(int i = 0; i < cnt; i++)
	{
		if(m_nodes[i].id() == id)
		{
			index = i;
			break;
		}
	}

	if(index == -1)
		return;

	removeRows(index, 1);
}

bool NodeModel::removeRows(int row, int count, const QModelIndex &parent)
{
	beginRemoveRows(parent, row, row+count-1);

	for(int i = row, j = row; i < row+count; i++)
		m_nodes.removeAt(j);

	endRemoveRows();

	Settings::get()->setNodes(m_nodes);

	return true;
}

void NodeModel::deleteAll()
{
	removeRows(0, m_nodes.count());
}

void NodeModel::update(QmlNode *n)
{
	int cnt = m_nodes.count();
	int i;

	for(i = 0; i < cnt; i++)
	{
		if(m_nodes[i].id() == n->id())
		{
			qDebug() << "Updating node" << n->name() << n->host() << n->port();

			m_nodes[i].update(n->node());
			Settings::get()->addOrUpdateNode(m_nodes[i]);
			break;
		}
	}

	emit dataChanged(index(i, 0), index(i, 0));
}

QmlNode* NodeModel::nodeAt(int i)
{
	if(m_qmlNode)
		m_qmlNode->setNode(m_nodes[i]);

	else
		m_qmlNode = new QmlNode(m_nodes[i], this);

	return m_qmlNode;
}
