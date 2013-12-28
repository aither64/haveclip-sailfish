#include "nodemodel.h"

NodeModel::NodeModel(QObject *parent) :
	QAbstractListModel(parent)
{
	m_manager = ClipboardManager::instance();
	m_nodes = m_manager->nodes();
}

QHash<int, QByteArray> NodeModel::roleNames() const
{
	QHash<int, QByteArray> roles;
	roles[HostRole] = "host";
	roles[PortRole] = "port";
	roles[PointerRole] = "pointer";

	return roles;
}

int NodeModel::rowCount(const QModelIndex &parent) const
{
	return m_nodes.count();
}

QVariant NodeModel::data(const QModelIndex &index, int role) const
{
	if(!index.isValid())
		return QVariant();

	ClipboardManager::Node *node = m_nodes[index.row()];

	switch(role)
	{
	case Qt::DisplayRole:
		return QString("%1:%2").arg(node->host).arg(node->port);

	case HostRole:
		return node->host;

	case PortRole:
		return node->port;

	case PointerRole:
		return QVariant::fromValue<ClipboardManager::Node*>(node);

	default:
		break;
	}

	return QVariant();
}

void NodeModel::remove(QVariant v)
{
	int index = m_nodes.indexOf(v.value<ClipboardManager::Node*>());

	if(index == -1)
		return;

	removeRows(index, 1);
}

bool NodeModel::removeRows(int row, int count, const QModelIndex &parent)
{
	beginRemoveRows(parent, row, row+count-1);

	for(int i = row, j = row; i < row+count; i++)
		m_nodes.removeAt(j); // FIXME: memory leak

	// I cannot delete the node currently, because Sender might still be using it

	endRemoveRows();

	m_manager->setNodes(m_nodes);

	return true;
}

void NodeModel::deleteAll()
{
	removeRows(0, m_nodes.count());
}

void NodeModel::add(QString host, quint16 port)
{
	ClipboardManager::Node *node = new ClipboardManager::Node;
	node->host = host;
	node->port = port;

	const int cnt = m_nodes.count();

	beginInsertRows(QModelIndex(), cnt, cnt);

	m_nodes << node;
	m_manager->setNodes(m_nodes);

	endInsertRows();
}

void NodeModel::updateAt(int i, QString host, quint16 port)
{
	ClipboardManager::Node *node = m_nodes[i];
	node->host = host;
	node->port = port;

	emit dataChanged(index(i, 0), index(i, 0));
}
