import 'package:flutter/material.dart';
import '../widget/GHButton.dart';
import '../services/httptool.dart';
import '../widget/GHRichTextPriceWidget.dart';

/// 在线支付
class GHOnlinePayments extends StatefulWidget {
  Map arguments;

  @override
  GHOnlinePayments({Key key, this.arguments}) : super(key: key);

  _GHOnlinePaymentsState createState() => _GHOnlinePaymentsState();
}

class _GHOnlinePaymentsState extends State<GHOnlinePayments> {
  bool _seletecd = true;
  String _orderId = "";
  double _total = 0;

  /// 获取订单详情
  void _getOrderDetails(String id) async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopOrderList/${id}";
    await HttpRequest.request(url, method: 'GET').then((res) {
      List _tempgoodList = res["goodList"];
      double _temptotal = res["total"];

      setState(() {
        this._total = _temptotal;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this._orderId = widget.arguments["id"];
    this._getOrderDetails(this._orderId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("在线支付"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "订单号: ${this._orderId}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 10,
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  this._seletecd = !this._seletecd;
                });
              },
              child: Container(
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            child: Image.asset(
                              'images/pay_wechat.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "微信",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]),
                        Container(
                            width: 20,
                            height: 20,
                            child: this._seletecd == true
                                ? Image.asset('images/checkSelected.png')
                                : Image.asset('images/checkNormal.png'))
                      ])),
            ),
            Divider(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  this._seletecd = !this._seletecd;
                });
              },
              child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            'images/pay_alipay.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            "支付宝",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                      Container(
                          width: 20,
                          height: 20,
                          child: this._seletecd != true
                              ? Image.asset('images/checkSelected.png')
                              : Image.asset('images/checkNormal.png'))
                    ],
                  )),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Text("支付"),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: GHRichTextPriceWidget(this._total + 10),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GHButton(
                "支付",
                tapAction: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}