#include "nodemodel.h"
#include "../haveclip-core/src/Settings.h"

NodeModel::NodeModel(QObject *parent) :
	QAbstractListModel(parent)
{
    m_nodes = Settings::get()->nodes();
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

    const Node &node = m_nodes[index.row()];

	switch(role)
	{
	case Qt::DisplayRole:
        return QString("%1:%2").arg(node.host()).arg(node.port());

	case HostRole:
        return node.host();

	case PortRole:
        return node.port();

	case PointerRole:
        return node.id();

	default:
		break;
	}

	return QVariant();
}

void NodeModel::remove(QVariant v)
{
    int cnt = m_nodes.size();
    int index = -1;
    int id = v.toInt();

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

void NodeModel::add(QString host, quint16 port)
{
    Node node;
    node.setHost(host);
    node.setPort(port);
    node.setId();

	const int cnt = m_nodes.count();

	beginInsertRows(QModelIndex(), cnt, cnt);

	m_nodes << node;
    Settings::get()->addOrUpdateNode(node);

	endInsertRows();
}

void NodeModel::updateAt(int i, QString host, quint16 port)
{
    m_nodes[i].setHost(host);
    m_nodes[i].setPort(port);

	emit dataChanged(index(i, 0), index(i, 0));
}
