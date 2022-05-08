library Constants;

const navPersonalArea = 'Área Pessoal';
const navSchedule = 'Horário';
const navExams = 'Mapa de Exames';
const navStops = 'Autocarros';
const navAbout = 'Sobre';
const navBugReport = 'Bugs e Sugestões';
const navLogOut = 'Terminar sessão';
const navFoodFeup = 'Food FEUP';

const faculties = ['faup', 'fbaup', 'fcup', 'fcnaup', 'fadeup',
                  'fdup', 'fep', 'feup', 'ffup', 'flup', 'fmup',
                  'fmdup', 'fpceup', 'icbas'];


//google sheets related
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "foodfeup123",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": ""
}
''';

// your spreadsheet id
const _spreadsheetId = '1DKzseOcDlRFbqeitILN_ygX6zxvPXkwXI6Zi8Llc3mM';