part of 'widgets.dart';

class AssistantTopBar extends StatelessWidget {
  final Widget content;
  final Widget topBarControl;
  final String photoURL;

  AssistantTopBar({this.content, this.topBarControl, this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(photoURL), fit: BoxFit.cover))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4375,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(0))),
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08, bottom: MediaQuery.of(context).size.height * 0.04),
                child: content,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * -0.72,
            child: Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(FlutterIcons.ios_arrow_back_ion, color: HexColor("FAFAFA")),
                    onPressed: (){
                       Get.back();
                    }
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  Text("list-view", style: GoogleFonts.montserrat().copyWith(
                            color: buildDarkTheme('a').accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.125,
                    width: MediaQuery.of(context).size.width * 0.125,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).backgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                      child: Icon(FlutterIcons.list_ent, size: 20, color: Theme.of(context).accentColor,), 
                      onPressed: (){}
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.125,
                    width: MediaQuery.of(context).size.width * 0.125,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).backgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(FlutterIcons.calendar_ant, size: 20, color: Theme.of(context).accentColor,),
                      ), 
                      onPressed: null //TBA
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
