 abstract class LayoutStates{

}

class LayoutInitialState extends LayoutStates{}




 class GetUserDataSuccessState extends LayoutStates{}


 class GetUserDataLoadingState extends LayoutStates{}


 class FailedToGetUserDataState extends LayoutStates{
   String error;
   FailedToGetUserDataState({required this.error});
 }

 class GetFavSuccessState extends LayoutStates{}
 class FaildToGetFavState extends LayoutStates{}






