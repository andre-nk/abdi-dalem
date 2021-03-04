part of "widgets.dart";

class DefaultButton extends StatelessWidget {
  final dynamic method;
  final String title;
  final Color color;

  DefaultButton({this.method, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        ),
        onPressed: method ?? () {},
        child: Center(
          child: Text("$title" ?? "",
              style: GoogleFonts.montserrat().copyWith(
                color: buildDarkTheme('a').accentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
