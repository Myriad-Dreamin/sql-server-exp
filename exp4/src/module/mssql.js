

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

    async query(pageCount, pageNumber=1, whereStmt='') {
        if (typeof whereStmt != 'string') {
            whereStmt = '';
        }
        const connection = await this.db.connect();
        let all_count_stmt = 'select count(1) from book ' + whereStmt;
        console.log(all_count_stmt);
        let bookCount = (await connection.query(all_count_stmt))[0][''];
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

