import 'dart:async';

import 'employee.dart';

class EmployeeBloc{

  //sink to add in pipe
  //stream to get data from pipe
  //by pipe i mean data flow

  List<Employee> _employeeList=[
    Employee(1,"Employee One",10000.0),
    Employee(2,"Employee two",20000.0),
    Employee(3,"Employee three",30000.0),
    Employee(4,"Employee four",40000.0),
    Employee(5,"Employee five",50000.0)
  ];

  final _employeeListStreamController=StreamController<List<Employee>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController=StreamController<Employee>();
  final _employeeSalaryDecrementStreamController=StreamController<Employee>();

  //getters
  Stream<List<Employee>> get employeeListStream=>_employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink=>_employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement=>_employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement=>_employeeSalaryDecrementStreamController.sink;


  EmployeeBloc(){
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);

  }

  _incrementSalary(Employee employee){
    double salary=employee.salary;
    double incrementedSalary=salary * 20/100;

    _employeeList[employee.id - 1].salary=salary+incrementedSalary;

    employeeListSink.add(_employeeList);
  }
  _decrementSalary(Employee employee){
    double salary=employee.salary;
    double decrementedSalary=salary * 20/100;

    _employeeList[employee.id - 1].salary=salary-decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  //free all the streams
  void dispose(){
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }





}
