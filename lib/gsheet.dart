import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-dictation-app",
  "private_key_id": "54d1763ce428801145d27bb28250db62ccbe05e3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC3eVZce3JlZzO6\nZav02Z4d6RArI8zg7FdPx2r9jifC1Fz1s6TJZhdQ6ZjO+hM6syY1s6GUF1ft7dC1\nSiaf8sYC1c7WEWpwhoO3SxnLYqQc75QiqwptvQ/cP6wQx+oaXBodsfrmeHQ3w7Xt\nI2EL13BA/1r/nWFbsNKYWqmyvVMZ8c+RwLvvlhSSCUHel3HYWDYrKfk8eRZuOGOl\n3gWsSPxQzMxj9DVL+agqNPkw6zkdMGbR8CYBFJBp1964QkW82ViiJjpP4k8CrVPr\nIWwBiNLOHogrbIDvzkLboH8LnvRi7W91U46iAYr9L6P13uWxg/mWIiydurqzrk84\nxzRU7ymjAgMBAAECggEAKOZmH5ivUDaY2/EFS8BlVJKbdZp19iAJeLHiQmK5r19q\n16Tz06esA/AHDgDGX5wHJQqFtv8bLWGJ2JgOkzJp/MDP6n2YZjw+SZJ2zhWPsxmf\nQrkxSnROgFE7WMRQBg9JDRyba1wnwDSjLhlobVzZ28tw7DGXvfplf+waD0vQJiSV\nt4CRyqMxpxvNkN+Qq8BlYaTRBkY6lLEL7d334mKs12S3l9/71O3Tdhu2xF6H1pgS\nFpDDaUom/24QjGBT5T1aS4in0dWKhUhf1h8myFyo+LlDL8UrkvlNpPiy11F7huXB\n+zRoFBw5leoxkbYZgXAXkNSf14hnCHNvrmg14N91cQKBgQD1sHIJzLCviZptdXsU\nwamIoz1vCbJ6qUIH6Ra98d7yDnZk2CTBPMyGlVumHS9G588xe6Lnb+LHf+o0s7Gn\nk33UiZgpInrOSChfORtlNoWWXo/YRz89Z+Tsbnfz5qe9Dq5J8Ee4/XDBgehbO511\nLJ3tNddn+iUdpCt3h+k47W8wUQKBgQC/LHvxhYYOeTpu8QQDzd1va6f6j97IpZOh\n7TscTOU4wTppdpj9HaE/i/G6LheRxzKaaBBRYIPQH3xhGzch9VzkFEw6QoWTGHqL\nkTHYFex+jS806Bq8cdxyjfSDQkIaS7v9fUtZknEO+YaRcLWTv4dCKfNMwPLMgZpW\nns/NEosRswKBgBT/VG+z97G43+LU9ITsnDGaSejQellzV7pXWGM5ZaVoSQQLWPDO\n4mfqIeALhHvZ2eJPv7dp34bPTtPcO6WnvExKyh9R3A7/KbwhpE69HyOfx0ljpWr5\nEx6Fvmiw4MsOkySsjWSo/Fb9ZD9P1AAspP6d6F/xh/SFkFVx3yPHXwZRAoGBAIsq\net+K79fBcEQqt119k2D04ceIzAkMX7hU1d74KzVxlHAJob1AwI1d9o4t14KLm87D\nSn2y4MG06fpWsX/K+eAe1o7ithIqk6rd+4buDsbhSCgffrcHvA64P/L9XNl/oE4b\n06pU7HCWPNvLTKNNnc0QdMi+/QDap9u+qE8E3K/5AoGBANPNI8gRuqyoSwU0Ins1\nLIegtiR0j4yCbAx+P+rkNFhAvsEciHtIJn7lnAHY+QaSMI7Ucs3DQ+MWtVn+u/cL\np/HCHYUsojTPJEL5ZTRPA84/I0WocYTxBdwX+kR4sNcbMKh3cCQXnaMQla9QhxEA\nkNUIRrUT9KFCgoVWSOe3AufE\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-dictation-app@flutter-dictation-app.iam.gserviceaccount.com",
  "client_id": "107704168521148626583",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-dictation-app%40flutter-dictation-app.iam.gserviceaccount.com"
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1y7HE2qk_pnm7aLc_KemhtvxDM7UCRdpXDmDUK1KFNiY';

void insertPreDefinedData() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Users');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Users');

  // insert list in row #1
  final firstRow = ['id', 'name', 'email'];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  final secondRow = {
    'name': 'Shubham Goel',
    'id': '2',
    'email': 'shubhamg@ads.com',
  };
  await sheet.values.map.appendRow(secondRow);
  // prints {index: 5, letter: f, number: 6, label: f6}
  print(await sheet.values.map.lastRow());
}
