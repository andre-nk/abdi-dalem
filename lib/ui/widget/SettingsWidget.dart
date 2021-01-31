part of "widgets.dart";

class SettingsWidget extends StatelessWidget {
  final String name;
  final dynamic value;
  final dynamic method;
  final User currentUser;
  final DocumentReference users;

  SettingsWidget(
      {this.name, this.value, this.method, this.currentUser, this.users});

  @override
  Widget build(BuildContext context) {
    Widget nickNameDisplayer() {
      if (currentUser.isAnonymous == true) {
        return Text(currentUser.uid.substring(1, 15),
            style: GoogleFonts.montserrat().copyWith(
              color: buildDarkTheme('a').accentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ));
      } else {
        return StreamBuilder<DocumentSnapshot>(
            stream: users.snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.get("name") == null) {
                  return Text(
                      currentUser.displayName.length >= 15
                          ? currentUser.displayName.substring(0, 15) + "..."
                          : currentUser.displayName,
                      style: GoogleFonts.montserrat().copyWith(
                          color: Theme.of(context).accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700));
                } else {
                  return Text(
                      snapshot.data.get("name").length >= 15
                          ? snapshot.data.get("name").substring(0, 15) + "..."
                          : snapshot.data.get("name") ?? "",
                      style: GoogleFonts.montserrat().copyWith(
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ));
                }
              } else {
                SpinKitRotatingCircle(
                  color: Theme.of(context).accentColor,
                  size: 50.0,
                );
              }
            });
      }
    }

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
            : nickNameDisplayer()
      ],
    );
  }
}
