import {db} from './mssql';

const Store = require('electron-store');

const defaultConfig = {
    'name': '.pswd',
    'path': '/home/kamiyoru',
    'dsn': 'stmssql',
    'cwd': 'configuration',
};

let cfg = new Store({
    defaults: defaultConfig,
    cwd: defaultConfig.cwd,
});


let usrCfg = new Store({
    cwd: cfg.get('path'),
    name: cfg.get('name'),
});

let loginData = usrCfg.get('login-pair', undefined);

if (loginData !== undefined) {
    try {
        db.connect(loginData.uid, loginData.pwd).then(() => {});
        // await this.$router.push({name: 'book/insert-page'});
    } catch (e) {
        window.console.log('error', e);
        // this.logining = false;
    }
}

export default {defaultConfig, cfg, usrCfg};
export {defaultConfig, cfg, usrCfg};
