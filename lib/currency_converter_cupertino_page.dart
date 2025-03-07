import 'package:flutter/cupertino.dart';

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() => _CurrencyConverterCupertinoPageState();
}

class _CurrencyConverterCupertinoPageState extends State<CurrencyConverterCupertinoPage> {

  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey3,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey3,
        middle: Text('Currency Converter', style: TextStyle(color: CupertinoColors.white)),
        // leading: Icon(Icons.menu, size: 36, color: Colors.white),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'INR ${result != result.round() ? result.toStringAsFixed(3) : result.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: CupertinoTextField(
                controller: textEditingController,
                style: TextStyle(
                  color: CupertinoColors.black,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(color: CupertinoColors.black,),
                  borderRadius: BorderRadius.circular(5),
                ),
                placeholder: 'Please entrer the amount in USD',
                prefix: Icon(CupertinoIcons.money_dollar),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: CupertinoButton(
                onPressed: () {
                  setState(() {
                    result = double.parse(textEditingController.text) * 81;
                  });
                },
                color: CupertinoColors.black,
                child: Text('Convert'),
              ),
            ),
          ],
        ),
      )
    );
  }
}