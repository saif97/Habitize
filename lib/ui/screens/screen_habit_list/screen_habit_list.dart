import 'package:flutter/material.dart';
import 'package:habitize3/core/view_models/base_model.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/text_styles.dart';
import 'package:habitize3/ui/shared/widgets.dart';
import 'package:provider/provider.dart';

import 'bottom_time_line.dart';

class HomeWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModelHabitList>(
      create: (context) => ModelHabitList(),
      child: Scaffold(
        backgroundColor: Color(0xFF393e46),
        body: SafeArea(
          child: Consumer<ModelHabitList>(
            builder: (_, model, child) {
              model.initModel();
              switch (model.currentState) {
                case Model2State.busy:
                  return CProgressIndecator();
                  break;
                case Model2State.idle:
                  return child;
                  break;
                default:
                  return Container(child: Text("Eroor"));
              }
            },
            child: Column(
              children: <Widget>[
                CAppbar(),
                Expanded(child: SliverScrollView()),
                BottomTimeLine(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModelHabitList model = Provider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.getTitle(), style: CTextStyle.title),
        ),
        IconButton(
          icon: Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => ScreenCreateHabit()));
          },
        )
      ],
    );
  }
}

class SliverScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
//        HabitStream(habitMode: 0),
        Saperator(color: Colors.red),
        Saperator(color: Colors.amber),
//        HabitStream(habitMode: 1),
        Saperator(color: Colors.green),
//        HabitStream(
//          showCheckedHabits: true,
//        ),
      ],
    );
  }
}

class Saperator extends StatelessWidget {
  MaterialColor color;

  Saperator({this.color});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Container(
              width: double.infinity,
              height: 5,
              color: color,
            ),
          ),
        )
      ]),
    );
  }
}
