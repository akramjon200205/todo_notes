import 'dart:io';

void main(List<String> args) {
  print("Oylikni kiriting");
  double summa = 0;
  double oylikoldingi = 0;
  double oylik = double.parse(stdin.readLineSync()!);
  double kpi = 0;

  for (var i = 0; i < 12; i++) {
    double a;
    if (i == 0) {
      oylikoldingi = oylik;
      a = oylikoldingi / 100;      
    } else {
      a = oylikoldingi / 100;      
    } 
    oylikoldingi = a + oylikoldingi; 

    print("$i - oydagi oylik qo'shimchasi: $oylikoldingi");  
    kpi = oylikoldingi * 0.2;

    print("$i - oydagi KPI oylik $kpi");

    print("oylik va kpi jamisi oydagi: ${kpi + oylikoldingi}");
    summa += oylikoldingi;
  }
  print("oylik holati bir yildan keyingi jami: $summa");
  print("oylik holati bir yildan keyingi bir oylik ish haqqi: $oylikoldingi");
}
