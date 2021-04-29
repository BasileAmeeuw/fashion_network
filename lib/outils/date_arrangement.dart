
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateArrangement {

  String maDate (int timestamp){

    initializeDateFormatting();
    String ajout = "";
    DateTime mtn = new DateTime.now();
    DateTime momentPubli = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;
    if (mtn.difference(momentPubli).inDays > 0) {
      ajout="Le ";
      format = new DateFormat.yMMMd("fr_FR");
    } else {
      format = new DateFormat.d("fr_FR");
      if (format.format(mtn) != format.format(momentPubli)){
        ajout = "Hier, à ";
      }
      format = new DateFormat.Hm("fr_FR");
    }

    return ajout + format.format(momentPubli).toString();
  }

}