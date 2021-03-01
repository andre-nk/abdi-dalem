part of 'widgets.dart';

class AssistantTopBar extends StatelessWidget {
  final Widget content;
  final Widget topBarControl;
  final String photoURL;
  final bool fabActive;
  final Function fabMethod;

  AssistantTopBar(
      {this.content, this.topBarControl, this.photoURL, this.fabActive, this.fabMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: fabActive != null
          ? FloatingActionButton(
              child: Icon(FlutterIcons.plus_ant),
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).backgroundColor,
              mini: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: fabMethod ?? (){}
            )
          : SizedBox(),
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(photoURL), fit: BoxFit.cover))),
            SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    fit: FlexFit.loose,
                    child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.04,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: this.topBarControl),
                  ),
                  Flexible(
                    flex: 40,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(0))),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08,
                        ),
                        // bottom: MediaQuery.of(context).size.height * 0.04),
                        child: content,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
