

import odbc from 'odbc';


let dbs = [];

class Mssql {
    constructor() {
        this.db = null;
        dbs.push(this);
    }

    async connect(uid, pwd) {
        if (!((typeof(uid).toString() === 'string') && (typeof(pwd).toString() === 'string'))) {
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

let db = new Mssql();

function closeHandler() {
    for (let d of dbs) {
        if (d != null) {
            d.close();
        }
    }
}




export default db;
export { db, Mssql, closeHandler };

