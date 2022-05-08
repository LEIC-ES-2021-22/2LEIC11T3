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

// your spreadsheet id
const spreadsheetId = '1DKzseOcDlRFbqeitILN_ygX6zxvPXkwXI6Zi8Llc3mM';

//google sheets related
const credentials = r'''
{
  "type": "service_account",
  "project_id": "foodfeup123",
  "private_key_id": "6cebfb9815e8f56d38d1205b5fb16ef725a26c0c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDD9/bFt9x5pd1k\nURnjGGPtF5kKSYUjZTPkH3bWBvuHgcfkhY0D10X6O9a+Kh2qYRUpkdrE/RB3dixu\n2eS+OesrPVLUof/3VtoDFc+/mvBJYZC2UNP7izGiB/htBCzfGMJEPvQgBtXQX3ii\nnSe0L5rjHZzX0y22oTfU/6qpw3LLNIv2gV37cbsWQmmONOGa9vn18CUi0PzO8Bwk\nmiKkuZVAFZqC5cOnS2J3wDqlbJyYLU2CB5BPsaM+z0861msuex0FcfUA9HxKZfwR\n43OjfUlW3nN0M6mXeh493Bpjvmy482cmLu+I1THlpUZ8FAAjqk8T0DWAkcYUYEnz\n5dCA8uvPAgMBAAECggEADGjJUZ/g8DsWl+Gi2ASVX1AdOs+JBMLF1G5Boi/zAZOw\nSsJCOboKDlx3rrcQBdf79RPtXIgB4O60xZg6qekVATny4tAXW1w+le9tpl5zVNI+\nzay0n7siu3Xxv0WCaeYxdwzdfKGyLG2/P9zfxMM29abMZcZToLr4xB4keneL714a\nFk8jna3dY8TYz1c1xSX7CAMwoG9n8+BRQiY47YMZT/NzzJMXqmKGRtEC1tzMp1Dr\nNw50YXJ/T89D7aBrn80IQw6BXx3n692dUKaO8WGCg0ZxnpIEGCGDc26zv2hY3YF1\nfQGErl6+KNdz1WQIg9ITNJ58T3oUSnAeamiKMzzl4QKBgQDmDpy89yiYt6vg7HGy\nFlndqVO7sUdLtpDtMgVEzW5XiC9QJ5btTyZQd9DxD/hsvgx9R0+/4hCgyoy8mNiN\nP0dzuVONI2HPU3UDfIwQ9Cio9D/4K97m2NUw4eXH/VCAqaJUw4dzL0XjauM/qgK0\nCKyYTTVKZsMxLuA2aCP9ySOoBwKBgQDaEUVbwPSuTDDWl6UDky/p9psjg4xhz3EA\np1sPs0Rnmb/QNxrCREUbSxz09RcxcuQUtAO5PXWJCSLhyJYIXHhgYMxV/+pUhRif\n3IkhTPlWMHhtZvNBMYd3eqw5mGPJ5PrFveN27aS9qihC+Y4oNneLLqDIb2d0qgJO\nXND15KZb+QKBgHdgR7bKbbdpP3gUWR72+CTMU5XGdN912ZgrZ45/Ju2mzh5CnM+B\nTbldov8jsV4D9Akh8uD31ncJA6Rtj5kjp9kF5rQLExr5DHQFscyuVVbufy8w3JZf\nF6ko3wo6iQZqf8CKQYPkmNhcQ5Vqi8KN6bmR/sAfuNORpmi0+1AaijULAoGAUF3X\nGvak9mucACpJJWUkXmyFRnRf01hZRC1pcQLXbfsK5xi34uq4MVPgayK8lnvKNRsW\n2DkfTQ6x7VY4fQJfVt210OgNG3Ml3Ryw6TXuGmaoq2Equ1centj2Cg/wjuK1zRSr\ndRQmB8RjLDO+wXE5Y3Eezl/IWAWj7e9lD4piCTkCgYB6dzwwN1LoPw6F6Nex9E/E\nko04qtAf6utbg2cjVTVdW9+xtNZUy1wwevRjr0jtUBlR3AY19KlxlCblI7pbCn8b\nv5i10IiJK/PsVz3c8Ep/vy+MkcSkL1iAzDW2KMnBr5WWvWgRYgPQ2B0nZG6uYqyU\nBG/O0oUzEiZ+d0JQH1u0vA==\n-----END PRIVATE KEY-----\n",
  "client_email": "foodfeup@foodfeup123.iam.gserviceaccount.com",
  "client_id": "100250046916152264881",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/foodfeup%40foodfeup123.iam.gserviceaccount.com"
}
''';

