
import 'dart:convert';
AppState AppStateFromJson(String str) => AppState.fromJson(json.decode(str));

String AppStateToJson(AppState data) => json.encode(data.toJson());

class AppState  {
    AppState({
        this.authenticated,
        this.pageIndex,
        this.themeMode,
    });


    bool? authenticated;

   
    int? pageIndex;


    String? themeMode;

    AppState copyWith({
        bool? authenticated,
        int? pageIndex,
        String? themeMode,
    }) => 
        AppState(
            authenticated: authenticated ?? this.authenticated,
            pageIndex: pageIndex ?? this.pageIndex,
            themeMode: themeMode ?? this.themeMode,
        );

    factory AppState.fromJson(Map<String, dynamic> json) => AppState(
        authenticated: json["authenticated"],
        pageIndex: json["pageIndex"],
        themeMode: json["themeMode"],
    );

    Map<String, dynamic> toJson() => {
        "authenticated": authenticated,
        "pageIndex": pageIndex,
        "themeMode": themeMode,
    };


}
