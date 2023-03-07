import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.event.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.state.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/timeUtil.dart';
import 'package:paytel/widgets/utils/toPersianDate.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class TransactionsPanel extends StatefulWidget {
  const TransactionsPanel({super.key ,
   required this.scrollController ,
   required this.panelController});

  final PanelController panelController;
  final ScrollController scrollController;

  @override
  State<TransactionsPanel> createState() => _TransactionsPanelState();
}

class _TransactionsPanelState extends State<TransactionsPanel> {
  // ScrollController _scrollController = ScrollController();
  List<MyTransactions> _dataList = [];

  bool _isLoading =false;
  final int _page = 1;

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyTransactionsBloc>(context).add(const MyTransactionsButtonPressed(page:0));
    widget.scrollController.addListener(_onScroll);
  }

  Widget draggableButton() => GestureDetector(
          onTap: togglePanel,
          child : Center(
                      child:SizedBox(width:30 , height : 5 ,
                      child:Container(decoration:const BoxDecoration(color:Style.Colors.primary,borderRadius:  BorderRadius.all(Radius.circular(10))) )  ,)
                      ),
      ); 

     void togglePanel()=> widget.panelController.isPanelOpen ? widget.panelController.close() : widget.panelController.open();

  Future<void> _loadData() async {
    // Simulate loading data from network or other source
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    for (int i = 0; i < 10; i++) {
      // _dataList.add("Item ${_dataList.length + 1}");
    }
    if(!mounted){
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _onScroll() {
      if (widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadData();
      }
    }

  Widget _buildProgressIndicator() {
    return
    
     Padding(
      padding:const EdgeInsets.all(8.0),
      child: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('Load More'),
                onPressed: () {
                  _loadData();
                },
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final double height = MediaQuery.of(context).size.height;
    return BlocListener<MyTransactionsBloc,MyTransactionsState>(listener: (context,state){
      if(state is MyTransactionsSuccess){
        // print(staste.myTransactions[0].title);
        setState(() {
          _isLoading =false;
        _dataList = state.myTransactions;
        });
      }
      if(state is MyTransactionsLoading){
        setState(() {
          _isLoading =true;
        });
      }
      if(state is MyTransactionsFailure){
        setState(() {
          _isLoading =false;
        });
      }
    },
    child :Scaffold(
      body: Column(
      children: [
      const  SizedBox(height: 10),
      draggableButton(),
      const  SizedBox(height: 10),
      Expanded(
        child:
         _dataList.isNotEmpty ?
         ListView.builder(
          controller: widget.scrollController,
          itemCount: _dataList.length + 1,
          itemBuilder: (context, index) {
            if (index == _dataList.length) {
              return _buildProgressIndicator();
            } else {
              return  MyTransactionRow(title :_dataList[index].title , date :_dataList[index].date , amount : _dataList[index].amount , index :index);
            }
          }
        )
        :
        const Center(child:  Text("هیچ تراکنشی نیست") )
         ),
      // ),
    ]),
    ),
    );
  }
}

 class MyTransactionRow extends StatelessWidget {
  final String title;
  final int amount;
  final String date ;
  final int index ;
  const  MyTransactionRow({super.key,required this.title,required this.amount,required this.date, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:const  EdgeInsets.symmetric(horizontal : 10),
                child: Container(
                    height: 80,
                    decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.primary,
                        width: 1.0,
                         )
                       )   
                      ),
                    child: 
                    InkWell(
                      
                      onTap:(){
                       BlocProvider.of<MyTransactionsBloc>(context).add(ViewTransactionDetail(index: index));
                      } ,
                      child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.only(right: 3),
                                      decoration:  const BoxDecoration(shape: BoxShape.circle , color: Style.Colors.gray2),
                                      child:const   Icon( CupertinoIcons.shopping_cart,color: Style.Colors.gray1 , size:20 ,),
                                    ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(title,style:  const TextStyle(fontSize: 12)),
                             Row(children: [
                                ToPersianDate(y: DateUtil.getYear(date),m:DateUtil.getMonth(date),d:DateUtil.getDay(date),style:  const TextStyle(color: Style.Colors.gray1,fontSize: 10),),
                                Text( DateUtil.getTime(date),style:  const TextStyle(color: Style.Colors.gray1,fontSize: 10),),
                             ],) ],
                          ),
                          Expanded(child: 
                          Container(alignment:Alignment.centerLeft ,
                               child:  AddComma(value:amount.toString() ,textStyle: const TextStyle(fontSize: 12))) 
                          )
                      ],
                    ),
                    ),
                  ),
              );
  }
}

