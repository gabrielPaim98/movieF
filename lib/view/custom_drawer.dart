import 'package:flutter/material.dart';
import 'package:movief/consts/colors.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool showMovies = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: KDark,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: KDarker,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: size.height*0.08,
                              child: Icon(Icons.account_circle, size: size.height*0.08,),
                            ),
                            Text('Nome'),
                            Text('@Usuario'),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('3M Seguidores'),
                                Text('17 Seguindo'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(),
                          OptionsItem(icon: Icons.account_circle, text: 'Perfil',),
                          OptionsItem(icon: Icons.star, text: 'Favoritos',),
                          OptionsItem(icon: Icons.rate_review, text: 'Avaliações',),
                          OptionsItem(icon: Icons.settings, text: 'Configurações',),
                          Spacer(flex: 6),
                          Row(
                            children: [
                              Image.asset('assets/launcher/movieF.png', height: 64,),
                              SizedBox(width: 16),
                              Text('MovLib', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                            ],
                          ),
                          Spacer()
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsItem extends StatelessWidget {
  OptionsItem({this.onTap, this.text, this.icon});

  final Function onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 8),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
