import 'dart:convert';

import 'package:gsheets/gsheets.dart';

class UsersSheetApi {
  static final spreadSheetId = '1xBwCuMJq2YcXm2VB_R8VK68wcMfUNIZ1H-QzmEJJjds';
  static final credentials = r'''
  {
  "type": "service_account",
  "project_id": "blnktask",
  "private_key_id": "3b1e8716f65b3b39980eca90ad08f96da6c613c1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpI3DTxRYDnTqy\n/qUhTIJtRog4NeXHdkqZVA5yyuQrVGCsC478N4CnklRFF0XVpZvUnDZ85LZjubsB\n7Z7oVSHlzijUGDX7ImpwQ4eP/lAn+aIqzT1cGrd0XkdvTaC2zpY0SFDELxCMws/3\nVSVNJtVzs/ZAAsvc7Uax3YMkGbjOMvKfqBY7hcFbf6JYTxlbEjEzCMnNeXiJdx7t\nXOZ47dVEcogd8xcDogegJ2AmG+eBYdxDZzP+T3fSRkh23i1cMCCsObWen/u+k1vc\n1Ee+ouyLgExyrKpjSk0v4ZJL7cyD6tTcyfPlOw/9pWtIoSRXSExYVs1wQuAOXG/s\nc0rMnAXJAgMBAAECggEAAuUbc8VawCkyYtckY6KSqgh8EyuOxakpKO8ENkrjf+MG\njh7a+GOelfFx9CLIrCgUxgDhz95v16Igr+ZDAxVW1SK5CEmkPf/h97li1qrS1IKN\nXxNlc2j1bscu/mE07ka/CqFErmfU7hL1GKB7Lj213MzWsDet0CYPwMJhyqGOve6E\nDPdfU0+zIZQrh+0VaTncWWaE2QwWFC0slhzQ7w98iEOkswINwvVuuLzjHj9w1ZF2\nGrJoO8nHxuXWL8Mk0mLmFD89sOg9gGoi4I4EWeDcdjOC5fGG4Y1hlO5J9DUyWyuQ\nwBL5XoA8uH099A+i+BCxl30hG01yAw/0NRaQ5DS4uQKBgQDhR4HwKAxrN+9GraHC\n1i4akSTnaw2rXb0t3vd5PAraQbsxlx3+VJcwO9qYEg9GNdnW/BF9jInl9OUiNif4\n4QgFMcyGxERnyK6iot+lsFYxmAbsMlCCf84kP4Q8VEjsYWNuAo91tucA7umD9Y2N\nsg+qJdPOPsVojk1oFSmMscPaXQKBgQDANA6ZzipPKlQ/ZWlQkL9Dq/MEWU6ssNxR\nTMK7omZJnQd6IfByW+AFhFCRP82y0/PQwHdxGMz1m2+VidTrZJas5cGtQNgrTHv+\nFHz6bSpoKzq+qz9m7Dyr3cTPNDPD1y7vCvp6MVwVsAsvb7kXmDnqlx6B4LaqasDU\nM+vVo2VaXQKBgEckJcyJWSKiz1Uqj+LPcE/Ddjv+epqbR5qsxsnqRCMYjtziM/6V\nCAmbXTSYv2oUp25Uu9FCCGouJA3hvE3EApxhVY1ZfaCopz2E4cuZHB8dO1JrsTEE\n2zxnMoM6uqyrNJMRC+zIjbqlt+iMKt+MU5YPzAtdl0mlZpxv0mcz2/2hAoGBALul\nVyfj9ryJV+z45iPI3WKFCmIRitTgaohZB7lGaNSvoTAk2Gndts3MCxhzkTBo652/\neh0JmHilAwCcqyoRb2VnfnnWV/WV22wItqeLUp6Wreieqeyi8OzeO5oLngoyGFk6\nf6YycHOgBpuOWMdnUAvu89La/5tLU+0Yr8NIndflAoGBAIMrELBEqYovco0xZryX\nvbrwSX3psDQYwah1r61zWnkDWS54KvqIeyS58k3ywa/kx7KE6Q0G2LmaOCLpvw5R\ngITr3aP8nLEUwUw86qAC9Z1yNOLUGr1oxDkWTCmDIJunD0KK9JUgVGKzzLBRCoZS\n5hO2cyeK4tf5mdiZ5hcIpkwW\n-----END PRIVATE KEY-----\n",
  "client_email": "blnk-task@blnktask.iam.gserviceaccount.com",
  "client_id": "100253411170471170911",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/blnk-task%40blnktask.iam.gserviceaccount.com"
}

  ''';
  static final gsheets = GSheets(credentials);
  static Worksheet userSheet;

  static Future init() async {
    final spreadShhet = await gsheets.spreadsheet(spreadSheetId);
    await getWorkSheet(spreadShhet, 'users');
  }

  static getWorkSheet(Spreadsheet spreadsheet, String title) async {
    try {
      userSheet = await spreadsheet.addWorksheet(title);
      await userSheet.values?.insertRow(
          1, ['Id', 'First Name', 'Last Name', 'Address', 'Mobile']);
      return userSheet;
    } catch (e) {
      userSheet = spreadsheet.worksheetByTitle(title);
    }
  }
}
