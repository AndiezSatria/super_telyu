part of 'widgets.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler,
      {Color iconColor = Colors.black}) {
    return Container(
      color: Colors.white54,
      child: ListTile(
        leading: Icon(
          icon,
          size: 26,
          color: iconColor,
        ),
        title: Text(
          title,
          style: blackTextFont.copyWith(
            fontSize: 20,
          ),
        ),
        onTap: tapHandler,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            alignment: Alignment.centerLeft,
            color: accentColor1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: <Widget>[
                            SpinKitFadingCircle(
                              color: accentColor1,
                              size: 50,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: (state.user.profilePicture == ""
                                          ? AssetImage(
                                              "assets/images/user_pic.png")
                                          : NetworkImage(
                                              state.user.profilePicture)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${state.user.name}',
                                        maxLines: 1,
                                        style: blackTextFont.copyWith(
                                          fontSize: 18,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        state.user.role.toString().substring(5),
                                        style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(
                          size: 50,
                          color: primaryColor,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Super Telyu',
                  style: blackTextFont.copyWith(
                    fontSize: 30,
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    repeat: ImageRepeat.repeat,
                    image: AssetImage(
                      'assets/images/pattern.jpg',
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  buildListTile(
                    'Home',
                    Icons.home,
                    () {
                      context.bloc<PageBloc>().add(GoToMainPage());
                    },
                    iconColor: primaryColor,
                  ),
                  buildListTile(
                    'Bantuan',
                    Icons.help,
                    () {
                      context.bloc<PageBloc>().add(GoToHelpPage());
                    },
                    iconColor: primaryColor,
                  ),
                  buildListTile(
                    'Keluar',
                    MdiIcons.logout,
                    () {
                      context.bloc<UserBloc>().add(SignOut());
                      AuthServices.signOut();
                    },
                    iconColor: primaryColor,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
