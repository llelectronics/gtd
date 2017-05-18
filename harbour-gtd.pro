# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-gtd

CONFIG += sailfishapp

SOURCES += src/harbour-gtd.cpp

OTHER_FILES += qml/harbour-gtd.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-gtd.changes.in \
    rpm/harbour-gtd.spec \
    rpm/harbour-gtd.yaml \
    translations/*.ts \
    harbour-gtd.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-gtd-de.ts

DISTFILES += \
    qml/pages/AboutPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/MainPageCom/ListsViewComponent.qml \
    qml/pages/MainPageCom/qmldir \
    qml/pages/MainPageCom/DoingListView.qml \
    qml/pages/MainPageCom/DoneListView.qml \
    qml/pages/MainPageCom/TodoListView.qml \
    qml/pages/MainPageCom/TodoItem.qml \
    qml/pages/LListModel.qml

include(src/sortFilterProxyModel/SortFilterProxyModel.pri)
