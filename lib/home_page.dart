

import 'package:bloc_architecture/employee.dart';
import 'package:bloc_architecture/employee_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc=EmployeeBloc();

  @override
  void dispose(){

    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: StreamBuilder<List<Employee>>(
            stream: _employeeBloc.employeeListStream,
            builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Card(

                      color: Colors.white,
                      elevation: 2.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text("${snapshot.data![index].id}",style: TextStyle(fontSize: 20.0),),
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${snapshot.data![index].name}",style: TextStyle(fontSize: 18.0),),
                                Text("₹ ${snapshot.data![index].salary}",style: TextStyle(fontSize: 16.0),),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                },

              );
            },

          ),
        ),
      ),
    );
  }
}
