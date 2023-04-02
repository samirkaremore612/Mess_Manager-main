library globals.dart;
List<String?> Notifications=['Sameer today is your last day'];
var scheduledate='1';
void ReturnNotification(){
  if(DateTime.now().day==2){
    Notifications.add("Today is first  day of mess");
    Notifications=Notifications;
  }
}