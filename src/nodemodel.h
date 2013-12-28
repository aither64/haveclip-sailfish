#ifndef NODEMODEL_H
#define NODEMODEL_H

#include <QAbstractListModel>
#include "../haveclip-core/src/ClipboardManager.h"

class NodeModel : public QAbstractListModel
{
	Q_OBJECT
public:
	enum NodeModelRoles {
		HostRole = Qt::UserRole + 1,
		PortRole,
		PointerRole
	};

	explicit NodeModel(QObject *parent = 0);
	QHash<int, QByteArray> roleNames() const;
	int rowCount(const QModelIndex &parent) const;
	QVariant data(const QModelIndex &index, int role) const;
	Q_INVOKABLE void remove(QVariant v);
	bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex());
	Q_INVOKABLE void deleteAll();
	Q_INVOKABLE void add(QString host, quint16 port);
	Q_INVOKABLE void updateAt(int i, QString host, quint16 port);

private:
	ClipboardManager *m_manager;
	QList<ClipboardManager::Node*> m_nodes;

};

#endif // NODEMODEL_H
