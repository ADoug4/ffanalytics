# Load Libraries
library("ffanalytics")

# Scrape Data (Updated 6/13)
# Does not work: ESPN, FantasyData, FleaFlicker, NumberFire, Yahoo, NFL, RTSports, FantasyFootballNerd,
# Works for 2020: CBS, FantasyPros, FantasySharks, FFToday, Walterfootball

####### SCRAPE TESTING ########
# CBS - Missing player, position, team columns
CBS_scrape <- scrape_data(src = c("CBS"),
                          pos = c("QB", "RB", "WR", "TE"),
                          season = 2020, week = 0)
CBS_scrape

# FantasyPros - Looks good
FantasyPros_scrape <- scrape_data(src = c("FantasyPros"),
                                  pos = c("QB", "RB", "WR", "TE"),
                                  season = 2020, week = 0)
FantasyPros_scrape

# FantasySharks - Looks good
FantasySharks_scrape <- scrape_data(src = c("FantasySharks"),
                                    pos = c("QB", "RB", "WR", "TE"),
                                    season = 2020, week = 0)
FantasySharks_scrape

# FFToday - Looks good
FFToday_scrape <- scrape_data(src = c("FFToday"),
                              pos = c("QB", "RB", "WR", "TE"),
                              season = 2020, week = 0)
FFToday_scrape

# Walterfootball - limited data (only yards and TDs)
Walterfootball_scrape <- scrape_data(src = c("Walterfootball"),
                                     pos = c("QB", "RB", "WR", "TE"),
                                     season = 2020, week = 0)
Walterfootball_scrape
