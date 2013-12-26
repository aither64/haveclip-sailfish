#include "qmlclipboardmanager.h"

QmlClipboardManager::QmlClipboardManager(QObject *parent) :
    QObject(parent)
{
    m_manager = ClipboardManager::instance();
    m_history = m_manager->history();

    connect(m_history, SIGNAL(historyChanged()), this, SLOT(historyChange()));
}

QString QmlClipboardManager::version()
{
	return VERSION;
}

QString QmlClipboardManager::content()
{
    return m_content;
}

void QmlClipboardManager::jumpToItemAt(int index)
{
	m_manager->jumpToItemAt(m_history->count() - index - 1);
}

void QmlClipboardManager::historyChange()
{
    QList<ClipboardContainer*> items = m_history->items();

    if(!items.size())
        m_content = "<empty>";
    else
        m_content = items.last()->item()->toPlainText();

    emit contentChanged(m_content);
}
