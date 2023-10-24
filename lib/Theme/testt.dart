import 'package:flutter/material.dart';


class Myaaa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabbedPage(),
    );
  }
}

class TabbedPage extends StatefulWidget {
  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Change the length as needed
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white, // Customize the indicator color
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Tab 1 Content',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Tab 2 Content',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Tab 3 Content',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
