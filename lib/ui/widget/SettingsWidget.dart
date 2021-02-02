part of "widgets.dart";

class SettingsWidget extends StatelessWidget {
  final String name;
  final dynamic value;
  final dynamic method;

  SettingsWidget({this.name, this.value, this.method});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context) ?? UserData(name: "");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: GoogleFonts.karla().copyWith(
                color: Theme.of(context).accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        value != null
            ? Text(value,
                style: GoogleFonts.montserrat().copyWith(
                  color: buildDarkTheme('a').accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))
            : Text(
                userData.name.length >= 15
                    ? userData.name.substring(0, 15) + "..."
                    : userData.name ?? "",
                style: GoogleFonts.montserrat().copyWith(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
            ))
      ],
    );
  }
}
