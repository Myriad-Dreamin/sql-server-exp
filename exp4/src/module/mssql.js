

import odbc from 'odbc';

class Mssql {
    constructor() {
        this.db = null;
    }

    async connect(uid, pwd) {
        if (!((uid instanceof String) && (pwd instanceof String))) {
            window.console.log('bad uid, pwd arg');
            return;
        }

        if (this.db != null) {
            await this.close();
        }
        this.db = await odbc.pool('DSN=stmssql; UID=' + uid + ';PWD=' + pwd);
    }

    async close() {
        if (this.db != null) {
            await this.db.close();
            this.db = null;
        }
    }

}

let db = Mssql();

let dbs = [db];

function closeHandler() {
    for (let d of dbs) {
        if (d != null) {
            d.close();
        }
    }
}




export default db;
export { db, Mssql, closeHandler };

