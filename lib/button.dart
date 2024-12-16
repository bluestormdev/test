import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    required this.label,
    super.key, required this.onTap});

  final String label;
  final VoidCallback onTap;
  @override
  State<AppButton> createState() {
    return _AppButtonState();
  }
}


class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _gradientAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){

    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () async {
            widget.onTap();

            if(_animationController.isCompleted){
             await  _animationController.reverse();
            }
            else{
              await _animationController.forward();
            }
            _animationController.reset();
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 240,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: const [
                    Color(0xFF70C3FF),
                    Color(0xFF4B65FF),
                  ],
                  begin: _gradientAnimation.value,
                  end: Alignment.bottomRight,
                ),
              ),

              child: Text(widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter'
                ),
              )
            ),
          ),
        );
      }
    );
  }
}