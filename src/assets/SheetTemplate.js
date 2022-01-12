import { get } from 'axios';
import ExcelJS from 'exceljs'


export const downloadFile = url =>
get(url, {
  responseType: 'blob',
  timeout: 30000,
});

export const downloadWorkBook = url => {
  const workbook = new ExcelJS.Workbook()
  return downloadFile(url).then(
    e => e.data.arrayBuffer()).then(
      b => workbook.xlsx.load(b))
}

export async function saveWorkBook (fileName, workbook) {
  const xls64 = await workbook.xlsx.writeBuffer({ base64: true })
  saveAs(
    new Blob([xls64], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }),
    fileName
  )
}

export function mutateRow(row, mutation) {

  mutation.forEach((m, i) => {
    const cell = row.getCell(i)
    if (typeof m === "object") {
      Object.assign(cell, m)
    } else {
      cell.value = m
    }
  })
}

const all = { downloadFile,
              downloadWorkBook,
              saveWorkBook,
              ExcelJS,
              mutateRow
            }

window.ST = all

export default all
