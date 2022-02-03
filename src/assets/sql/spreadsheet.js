import ExcelJS from 'exceljs'

import { SQLStatement } from './objects'

SQLStatement.prototype.spreadsheet = function (name, wb = new ExcelJS.Workbook()) {
  const sheet = wb.addWorksheet(name);
  const colHeaders = this.cols.map(h => { return { header: h } })

  sheet.columns = colHeaders
  sheet.addRows(this.rows)
  return sheet;
}
