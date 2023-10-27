import 'package:propertify_for_agents/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  
  ApiResponse(this.status, this.message);

  ApiResponse.loading() : status = Status.LOADING ;
  ApiResponse.completed(this.data) : status = Status.COMPLETED ;
  ApiResponse.error(this.message) : status = Status.ERROR ;

  @override
  String toString(){
    return 'Status : $Status \n Message : $message \n data : $data';
  }
}