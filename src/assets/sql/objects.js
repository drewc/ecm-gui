export function SQLCommand(cmd) {
    Object.assign(this, { complete: false }, cmd)
}

export function SQLStatement(stmt) {
    Object.assign(this, { complete: !!stmt.rows }, stmt)
}

SQLStatement.prototype = Object.create(SQLCommand.prototype);
SQLStatement.prototype.constructor = SQLStatement;

export default { SQLCommand, SQLStatement };
