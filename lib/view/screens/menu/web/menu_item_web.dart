
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/auth_provider.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/routes.dart';
import '../../../../utill/styles.dart';
import '../widget/sign_out_confirmation_dialog.dart';

class MenuItemWeb extends StatelessWidget {
  final String image;
  final String title;
  final String routeName;
  const MenuItemWeb({Key key, @required this.image, @required this.title, @required this.routeName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    bool _isLogin = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () {
        if(routeName == 'version') {

        }else if(routeName == 'auth'){
          _isLogin ? showDialog(
            context: context, barrierDismissible: false, builder: (context) => SignOutConfirmationDialog(),
          ) : Navigator.pushNamed(context, Routes.getLoginRoute());
        }else{
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.04), borderRadius: BorderRadius.circular(32.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 50, height: 50, color: Theme.of(context).textTheme.bodyText1.color),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            Text(title, style: robotoRegular),
          ],
        ),
      ),
    );
  }
}
