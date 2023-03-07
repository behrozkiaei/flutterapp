
class AppStateState {
    AppStateState({
        this.tabIndex,
        this.themeMode,
        this.isAuthenticated,
    });

    final int? tabIndex ;
    final String? themeMode;
    final bool? isAuthenticated;

    AppStateState copyWith({
        int? tabIndex,
        String? themeMode,
        bool? isAuthenticated,
    }) => 
        AppStateState(
            tabIndex: tabIndex ?? this.tabIndex,
            themeMode: themeMode ?? this.themeMode,
            isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        );

    factory AppStateState.fromJson(Map<String, dynamic> json) => AppStateState(
        tabIndex: json["tabIndex"],
        themeMode: json["themeMode"],
        isAuthenticated: json["isAuthenticated"],
    );

    Map<String, dynamic> toJson() => {
        "tabIndex": tabIndex,
        "themeMode": themeMode,
        "isAuthenticated": isAuthenticated,
    };
}
