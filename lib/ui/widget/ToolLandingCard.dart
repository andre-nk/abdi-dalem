part of "widgets.dart";

class ToolLandingCard extends StatelessWidget {
  final String title;
  final String photoURL;
  final Icon icon;
  final Function method;

  ToolLandingCard({this.title, this.photoURL, this.icon, this.method});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.method,
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 10, 30, 10),
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(0, 0),
              )
            ],
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AutoSizeText(
                this.title,
                  style: GoogleFonts.montserrat().copyWith(
                    letterSpacing: 1.5,
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center),
              this.icon
            ],
          ),
          Positioned(
              bottom: -5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.125,
                child: Image(image: AssetImage(this.photoURL), fit: BoxFit.cover)
              )
          ),
        ]),
      ),
    );
  }
}
