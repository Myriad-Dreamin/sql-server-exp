import { app, BrowserWindow } from 'electron';

/**
 * Set `__static` path to static files in production
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-static-assets.html
 */
// eslint-disable-next-line no-undef
if (process.env.NODE_ENV !== 'development') {
// eslint-disable-next-line no-undef
    global.__static = require('path').join(__dirname, '/static').replace(/\\/g, '\\\\');
}

let mainWindow;
// eslint-disable-next-line no-undef
const winURL = process.env.NODE_ENV === 'development'
    ? 'http://localhost:9080'
    // eslint-disable-next-line no-undef
    : `file://${__dirname}/index.html`;

import { closeHandler } from 'module/mssql';


function createWindow () {
    /**
   * Initial window options
   */
    mainWindow = new BrowserWindow({
        height: 563,
        useContentSize: true,
        width: 1000
    });

    mainWindow.loadURL(winURL);

    mainWindow.on('closed', () => {
        mainWindow = null;
        closeHandler();
        //
        // require('dialog').showMessageBox({
        //     message: 'Close button has been pressed!',
        //     buttons: ['OK']
        // });
    });
}

app.on('ready', createWindow);

app.on('window-all-closed', () => {
// eslint-disable-next-line no-undef
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', () => {
    if (mainWindow === null) {
        createWindow();
    }
});

/**
 * Auto Updater
 *
 * Uncomment the following code below and install `electron-updater` to
 * support auto updating. Code Signing with a valid certificate is required.
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-electron-builder.html#auto-updating
 */

/*
import { autoUpdater } from 'electron-updater'

autoUpdater.on('update-downloaded', () => {
  autoUpdater.quitAndInstall()
})

app.on('ready', () => {
  if (process.env.NODE_ENV === 'production') autoUpdater.checkForUpdates()
})
 */
