# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'main.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets
from threading import Thread
from os.path import realpath, join

class Ui_Frame(object):
    def setupUi2(self, Frame):
        icon_folder = join("\\".join(realpath(__file__).split("\\")[:-1]), "icons")
        Frame.setObjectName("Frame")
        Frame.resize(50, 50)
        Frame.setWindowFlags(
                             QtCore.Qt.WindowStaysOnTopHint
                             | QtCore.Qt.FramelessWindowHint
                             | QtCore.Qt.Tool)
        Frame.setAttribute(QtCore.Qt.WA_TranslucentBackground)
        self.frame = Frame
#        self.frame.closeEvent = self.CLOSEEVENT
        self.tray_icon = QtWidgets.QSystemTrayIcon()
        self.tray_icon.setIcon(QtGui.QIcon(join(icon_folder, "toolbox_icon.ico")))
        self.tray_icon.show()
        self.menu = QtWidgets.QMenu()
        self.settings_menu = self.menu.addAction('Settings')
        self.close_menu = self.menu.addAction('Close')
        self.settings_menu.triggered.connect(self.SETTINGS)
        self.close_menu.triggered.connect(self.CLOSEEVENT)
        self.tray_icon.setContextMenu(self.menu)
        self.gridLayout_2 = QtWidgets.QGridLayout(Frame)
        self.gridLayout_2.setObjectName("gridLayout_2")
        self.gridLayout = QtWidgets.QGridLayout()
        self.gridLayout.setObjectName("gridLayout")
        self.pushButton = QtWidgets.QPushButton(Frame)
        self.pushButton.setObjectName("pushButton")
        self.gridLayout.addWidget(self.pushButton, 0, 0, 1, 1)
        self.gridLayout_2.addLayout(self.gridLayout, 1, 1, 1, 1)
        self.exit_button = QtWidgets.QPushButton(Frame)
        self.exit_button.setObjectName("exit")
        self.gridLayout.addWidget(self.exit_button, 2, 0, 1, 1)
        self.gridLayout_2.addLayout(self.gridLayout, 1, 1, 1, 1)
        spacerItem1 = QtWidgets.QSpacerItem(20, 40, QtWidgets.QSizePolicy.Minimum, QtWidgets.QSizePolicy.Expanding)
        self.gridLayout.addItem(spacerItem1, 1, 1, 1, 1)
        self.gridLayout_2.addLayout(self.gridLayout, 1, 1, 1, 1)

        self.retranslateUi(Frame)
        QtCore.QMetaObject.connectSlotsByName(Frame)

        global end_thread
        end_thread = False

        self.pushButton.clicked.connect(self.Resize)
        self.exit_button.clicked.connect(self.CLOSEEVENT)

        moving_thread = Thread(name="Moving", target=self.KEEPMOVING)
        moving_thread.setDaemon(True)
        moving_thread.start()

    def retranslateUi(self, Frame):
        _translate = QtCore.QCoreApplication.translate
        Frame.setWindowTitle(_translate("Frame", "Frame"))
        self.pushButton.setText(_translate("Frame", "PushButton"))
        self.exit_button.setText(_translate("Frame", "exit"))

    def Resize(self):
        if self.frame.size().height() <= 200:
            sgoal = 50
            egoal = 200
        else:
            sgoal = 200
            egoal = 50

        self.size_anim = QtCore.QPropertyAnimation(self.frame, b'size')
        self.size_anim.setDuration(500)
        self.size_anim.setStartValue(QtCore.QSize(50, sgoal))
        self.size_anim.setEndValue(QtCore.QSize(50, egoal))
        self.size_anim.start()

    def CLOSEEVENT(self, event):
        global end_thread
        end_thread = True
        self.frame.close()
        self.tray_icon.hide()
        QtCore.QCoreApplication.instance().quit()

    def SETTINGS(self):
        print("SETTINGS")

    # %% Is created by a thread that forces the form to snap to one side of screen
    """Handles constantly moving the screen to the desired position"""
    def KEEPMOVING(self):
        global end_thread
        while True:
            if end_thread is True:
                break
            else:
                x = 0
                y = 0
                self.frame.move(x, y)


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Form = QtWidgets.QFrame()
    ui = Ui_Frame()
    ui.setupUi2(Form)
    Form.show()
    app.exec_()
