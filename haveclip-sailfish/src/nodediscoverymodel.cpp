#include "nodediscoverymodel.h"

#include "../haveclip-core/src/ClipboardManager.h"
#include "../haveclip-core/src/Network/AutoDiscovery.h"
#include "../haveclip-core/src/Helpers/qmlnode.h"

NodeDiscoveryModel::NodeDiscoveryModel(QObject *parent) :
	QAbstractListModel(parent),
	m_qmlNode(0)
{
	m_discovery = ClipboardManager::instance()->connectionManager()->autoDiscovery();

	connect(m_discovery, SIGNAL(aboutToDiscover()), this, SLOT(resetDiscovery()));
	connect(m_discovery, SIGNAL(peerDiscovered(Node)), this, SLOT(addNode(Node)));
}

QHash<int, QByteArray> NodeDiscoveryModel::roleNames() const
{
	QHash<int, QByteArray> roles;
	roles[NameRole] = "name";
	roles[IdRole] = "id";
	roles[HostRole] = "host";
	roles[PortRole] = "port";

	return roles;
}

int NodeDiscoveryModel::columnCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent);

	return ColumnCount;
}

int NodeDiscoveryModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent);

	return m_nodes.count();
}

QVariant NodeDiscoveryModel::data(const QModelIndex &index, int role) const
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

QVariant NodeDiscoveryModel::headerData(int section, Qt::Orientation orientation, int role) const
{
	if(orientation == Qt::Vertical || role != Qt::DisplayRole)
		return QVariant();

	switch(section)
	{
	case Name:
		return tr("Name");

	case Compatible:
		return tr("Compatibility");

	case HostAddress:
		return tr("Address");

	case HostPort:
		return tr("Port");

	default:
		break;
	}

	return QVariant();
}

QmlNode* NodeDiscoveryModel::nodeAt(int i)
{
	if(m_qmlNode)
		m_qmlNode->setNode(m_nodes[i]);

	else
		m_qmlNode = new QmlNode(m_nodes[i], this);

	return m_qmlNode;
}

bool NodeDiscoveryModel::isEmpty() const
{
	return m_nodes.isEmpty();
}

void NodeDiscoveryModel::discover()
{
	m_discovery->discover();
}

bool NodeDiscoveryModel::haveSearchedYet() const
{
	return false;
}

void NodeDiscoveryModel::resetDiscovery()
{
	if(m_nodes.empty())
		return;

	beginRemoveRows(QModelIndex(), 0, m_nodes.count() - 1);

	m_nodes.clear();

	endRemoveRows();
}

void NodeDiscoveryModel::addNode(const Node &n)
{
	int cnt = m_nodes.count();

	beginInsertRows(QModelIndex(), cnt, cnt);

	m_nodes << n;

	endInsertRows();

	if(m_nodes.count() == 1)
		emit emptyChanged(false);
}
