


import odbc from 'odbc';

import jschardet from 'jschardet';
import iconv from 'iconv-lite';
let dbs = [];

class Mssql {
    constructor() {
        this.db = null;
        this._isLogin = false;
        dbs.push(this);
    }

    get isLogin() {
        return this._isLogin;
    }

    set isLogin(value) {
        window.vue_instance.$set(this, '_isLogin', value);
    }

    async connect(uid, pwd, dsn = 'stmssql') {
        if (!((typeof(uid).toString() === 'string') && (typeof(pwd).toString() === 'string') && (typeof(dsn).toString() === 'string'))) {
            window.console.log('bad uid, pwd, dsn arg');
            return;
        }

        if (this.db != null) {
            await this.close();
            this.isLogin = false;
        }
        this.db = await odbc.pool('DSN=' + dsn +  '; UID=' + uid + ';PWD=' + pwd + ';Client_CSet=CP936');
        this.isLogin = true;
    }

    async close() {
        if (this.db != null) {
            await this.db.close();
            this.db = null;
            this.isLogin = false;
        }
    }

    async query(pageCount, pageNumber=1, whereStmt='') {
        window.jjj = jschardet;
        window.ic = iconv;
        if (typeof whereStmt != 'string') {
            whereStmt = '';
        }
        const connection = await this.db.connect();
        let all_count_stmt = 'select count(1) from book ' + whereStmt;
        //地质出版社
        window.console.log(all_count_stmt, jschardet.detect(all_count_stmt), iconv.decode(iconv.encode(all_count_stmt, 'utf-8'), 'utf-8'));
        let bookCount = (await connection.query(iconv.decode(iconv.encode(all_count_stmt, 'utf-8'), 'utf-8')))[0][''];
        window.console.log('select * from (select top '+ Math.min(pageCount, pageCount + bookCount - pageNumber * pageCount).toString() +' * from (select top ' + (pageNumber * pageCount).toString() + ' * from book ' + whereStmt + ' order by id) as xx order by id desc) as xy order by id');
        let all_stmt = 'select * from (select top '+ Math.min(pageCount, pageCount + bookCount - pageNumber * pageCount).toString() +' * from (select top ' + (pageNumber * pageCount).toString() + ' * from book ' + whereStmt + ' order by id) as xx order by id desc) as xy order by id';
        let bookInfos = await connection.query(all_stmt);
        await connection.close();
        return {bookCount, bookInfos};
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

