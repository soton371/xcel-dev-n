import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? btnText;
  final Color? btnColor;
  final Function? onTap;
  const CustomButton({super.key, 
    @required this.btnColor,
    @required this.btnText,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                btnColor!.withOpacity(1.0),
                btnColor!.withOpacity(0.6),
              ],
            ),
          ),
          child: Center(
            child: Text(
              btnText??'',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final IconData? iconData;
  final Color btnColor;
  final Color? btnBackgroundColor;
  final double btnSize;
  final VoidCallback? onBtnTap;
  const CustomIconButton({
    Key? key,
    @required this.iconData,
    this.btnColor = Colors.white,
    @required this.btnBackgroundColor,
    this.btnSize = 32,
    @required this.onBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: btnBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: IconButton(
        icon: Icon(
          iconData,
          color: btnColor,
          size: btnSize,
        ),
        onPressed: () => onBtnTap!(),
      ),
    );
  }
}
