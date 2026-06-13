//
/* You may copy+paste this file and use it as it is.
 *
 * If you make changes to your about:config while the program is running, the
 * changes will be overwritten by the user.js when the application restarts.
 *
 * To make lasting changes to preferences, you will have to edit the user.js.
 */

/****************************************************************************
 * Betterfox                                                                *
 * "Ad meliora"                                                             *
 * version: 150                                                             *
 * url: https://github.com/yokoffing/Betterfox                              *
****************************************************************************/


/** DISK AVOIDANCE ***/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", true)
user_pref("browser.sessionstore.interval", 600000);

/** UNLOAD INACTIVE TABS ***/
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("browser.low_commit_space_threshold_percent", 100);
user_pref("browser.tabs.min_inactive_duration_before_unload", 300000);

/** MOZILLA UI ***/
user_pref("browser.aboutConfig.showWarning", false);

/** THEME ADJUSTMENTS ***/
user_pref("browser.compactmode.show", true);


/****************************************************************************
 * SECTION: SMOOTHFOX                                                       *
****************************************************************************/
// visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
// Enter your scrolling overrides below this line:


/****************************************************************************
 * START: MY OVERRIDES                                                      *
****************************************************************************/
// visit https://github.com/yokoffing/Betterfox/wiki/Common-Overrides
// visit https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening
// Enter your personal overrides below this line:


/****************************************************************************
 * END: BETTERFOX                                                           *
****************************************************************************/
