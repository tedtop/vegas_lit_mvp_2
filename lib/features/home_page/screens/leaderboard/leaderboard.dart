import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/data/models/player.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Player> employees = <Player>[];

  EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  List<Player> getEmployeeData() {
    return [
      Player(1, 'James', '\$144', '\$20000'),
      Player(2, 'Kathryn', '\$144', '\$30000'),
      Player(3, 'Lara', '\$144', '\$15000'),
      Player(4, 'Michael', '\$144', '\$15000'),
      Player(5, 'Martin', '\$144', '\$15000'),
      Player(6, 'Newberry', '\$144', '\$15000'),
      Player(7, 'Balnc', '\$144', '\$15000'),
      Player(8, 'Perry', '\$144', '\$15000'),
      Player(9, 'Gable', '\$144', '\$15000'),
      Player(10, 'Grimes', '\$144', '\$15000'),
      Player(11, 'Grimes', '\$144', '\$15000'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightGrey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'LEADERBOARD',
                  style: Styles.headingLeaderboard,
                ),
              ),
            ],
          ),
          const TextBar(
            text: 'Current Week',
          ),
          const TextBar(
            text: 'All Leagues',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Expanded(
                child: SfDataGrid(
                  gridLinesVisibility: GridLinesVisibility.none,
                  source: _employeeDataSource,
                  columns: [
                    GridNumericColumn(
                      columnWidthMode: ColumnWidthMode.lastColumnFill,
                      mappingName: 'id',
                      headerText: '#',
                      textAlignment: Alignment.center,
                      headerTextAlignment: Alignment.center,
                    ),
                    GridTextColumn(
                      mappingName: 'name',
                      headerText: 'Player',
                    ),
                    GridTextColumn(
                      mappingName: 'designation',
                      headerText: 'Profit',
                    ),
                    GridTextColumn(
                      mappingName: 'salary',
                      headerText: 'Balance',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 8.0,
        child: Container(
          color: Palette.darkGrey,
          padding: const EdgeInsets.all(8.0),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Styles.h3,
              ),
              const Icon(
                Icons.download_rounded,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource<Player> {
  EmployeeDataSource({List<Player> employeeData}) {
    _employeeData = employeeData;
  }

  List<Player> _employeeData;

  @override
  List<Player> get dataSource => _employeeData;

  @override
  Object getValue(Player player, String columnName) {
    switch (columnName) {
      case 'id':
        return player.id;
        break;
      case 'name':
        return player.name;
        break;
      case 'salary':
        return player.profit;
        break;
      case 'designation':
        return player.balance;
        break;
      default:
        return ' ';
        break;
    }
  }
}
