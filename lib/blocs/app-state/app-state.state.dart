
class AppStateState {
    AppStateState({
        this.tabIndex,
        this.themeMode,
        this.isAuthenticated,
        this.transactionPanelStateIsOpen,
        this.scannerPanelStateIsOpen,
    });

    final int? tabIndex ;
    final String? themeMode;
    final bool? isAuthenticated;
    final bool? transactionPanelStateIsOpen;
    final bool? scannerPanelStateIsOpen;

    AppStateState copyWith({
        int? tabIndex,
        String? themeMode,
        bool? isAuthenticated,
        bool? transactionPanelStateIsOpen,
        bool? scannerPanelStateIsOpen,
    }) => 
        AppStateState(
            tabIndex: tabIndex ?? this.tabIndex,
            themeMode: themeMode ?? this.themeMode,
            isAuthenticated: isAuthenticated ?? this.isAuthenticated,
            transactionPanelStateIsOpen: transactionPanelStateIsOpen ?? this.transactionPanelStateIsOpen,
            scannerPanelStateIsOpen: scannerPanelStateIsOpen ?? this.scannerPanelStateIsOpen,
        );

    factory AppStateState.fromJson(Map<String, dynamic> json) => AppStateState(
        tabIndex: json["tabIndex"],
        themeMode: json["themeMode"],
        isAuthenticated: json["isAuthenticated"],
        transactionPanelStateIsOpen: json["transactionPanelStateIsOpen"],
        scannerPanelStateIsOpen: json["scannerPanelStateIsOpen"],
    );

    Map<String, dynamic> toJson() => {
        "tabIndex": tabIndex,
        "themeMode": themeMode,
        "isAuthenticated": isAuthenticated,
        "transactionPanelStateIsOpen": transactionPanelStateIsOpen,
        "scannerPanelStateIsOpen": scannerPanelStateIsOpen,
    };
}
