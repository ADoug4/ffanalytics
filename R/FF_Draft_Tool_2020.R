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

##### MAIN SCRAPE #####
my_scrape <- scrape_data(src = c("FFToday", "FantasyPros", "FantasySharks"),
                              pos = c("QB", "RB", "WR", "TE"),
                              season = 2020, week = 0)
my_scrape

##### SCORING RULES #####
scoring_rules_Lol <- custom_scoring(pass_yds = 0.05, pass_tds = 5, rush_yds = 0.1, rush_tds = 6, rec = 0.5, rec_yds = 0.1, rec_tds = 6)


##### LoL PROJECTIONS #####
my_projections <- projections_table(my_scrape, scoring_rules = scoring_rules_Lol)
my_projections <- my_projections %>% add_player_info %>% filter(avg_type == "average") %>%
  filter(rank < 301)
my_projections <- select(my_projections, first_name, last_name, team, position, pos_rank,
                         points, rank, points_vor, drop_off, everything()) %>%
  mutate(match = str_sub(my_projections$first_name, 1, 4)) %>%
  arrange(rank)
my_projections <- mutate(my_projections, last_match = str_sub(my_projections$last_name, 1, 4))
my_projections

#Filter by position
qb <- filter(my_projections, position == "QB")
qb <- arrange(qb, pos_rank)

rb <- filter(my_projections, position == "RB")
rb <- arrange(rb, pos_rank)

wr <- filter(my_projections, position == "WR")
wr <- arrange(wr, pos_rank)

te <- filter(my_projections, position == "TE")
te <- arrange(te, pos_rank)

View(my_projections) + View(qb) + View(rb) + View(wr) + View(te)

################ VOR MODELS #######################
short_list <- select(my_projections, position, first_name, last_name, rank, drop_off,
                     pos_rank, points_vor, ceiling_vor) %>% arrange(rank)
View(short_list)
#Plot overall top 50 value over replacement w/ shape by position
top_50 <- filter(my_projections, rank < 51)
top_25 <- filter(my_projections, rank < 26)
mid_50 <- filter(my_projections, rank < 101 & rank > 50)



vor_50 <- ggplot(data = top_50) +
  geom_point(mapping = aes(x = rank, y = points_vor, color = position, shape = position,
                           size = drop_off)) +
  geom_text_repel(aes(x = rank, y = points_vor, label = last_name), hjust=0, vjust=0)
vor_50 <- vor_50 + labs(title = "Value Over Replacement")
vor_50

vor_mid_50 <- ggplot(data = mid_50) +
  geom_point(mapping = aes(x = rank, y = points_vor, color = position, shape = position,
                           size = drop_off)) +
  geom_text_repel(aes(x = rank, y = points_vor, label = last_name), hjust=0, vjust=0)
vor_mid_50 <- vor_mid_50 + labs(title = "Value Over Replacement")
vor_mid_50
