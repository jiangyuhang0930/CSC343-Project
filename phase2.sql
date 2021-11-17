DROP SCHEMA IF EXISTS Steam CASCADE;
CREATE SCHEMA Steam;
SET SEARCH_PATH TO Steam;

-- A tuple in this relation represents a Game that is selling on Steam. 
-- Gid is the game id, name is the title of the game, DLCCount is the 
-- number of extra content packages added to the game after the release data, 
-- required_age is the minimum age for player to play the game and 
-- controller_support indicates whether or not the game is controller supported
CREATE TABLE Game (
    gid INT,
    name TEXT NOT NULL,
    release_date TIMESTAMP NOT NULL,
    DLC_count INT NOT NULL DEFAULT 0,
    required_age INT NOT NULL DEFAULT 0,
    controller_support BOOLEAN NOT NULL,
    PRIMARY KEY(gid)
);

-- A tuple in this relation represents the popularity of a game. 
-- Gid is the corresponding game, onwer_count is the number of owners who have 
-- this game via purchasing or gift or weekend free trial, owner_variance 
-- is the range which is used to provide estimation error of count of owners, 
-- player_count is the number of players who have played this game after 
-- March 2009, player_varaicne is the range which is used to provide estimation 
-- error of count of players and recommendation_count is the number of player 
-- who want to recommend this game to other users on steam. 
CREATE TABLE Popularity (
    gid INT,
    owner_count INT NOT NULL,
    owner_variance INT NOT NULL,
    player_count INT NOT NULL,
    player_varaicne INT NOT NULL,
    recommendation_count INT NOT NULL,
    PRIMARY KEY(gid),
    FOREIGN KEY(gid) REFERENCES Game(gid)
);

-- A tuple in this relation represents the review of a game.
-- gid is the game id and the metacritic score of a score out of 100.
CREATE TABLE Review (
    gid INT,
    metacritic INT NOT NULL,
    PRIMARY KEY(gid),
    FOREIGN KEY(gid) REFERENCES Game(gid),
    FOREIGN KEY(gid) REFERENCES Popularity(gid)
);

-- A tuple in this relation represents a category of the game, such as 
-- single-player, multi-player, co-op, etc. Gid represents the corresponding 
-- game, cid is the id that is used to indicate different categories.
CREATE TABLE GameCategory (
    gid INT,
    cid INT NOT NULL,
    PRIMARY KEY(gid, cid),
    FOREIGN KEY(gid) REFERENCES Game(gid)
);

-- A tuple in this relation represents the available categories
-- cid is the id that is used to indicate different categories, and 
-- category name is the text description.
CREATE TABLE Category (
    cid INT,
    category_name TEXT NOT NULL,
    PRIMARY KEY(cid)
);

-- A tuple in this relation represents a genre of the game, such as 
-- action, adventure, sports, etc. Gid represents the corresponding game, 
-- geid is the id that is used to indicate different genres.
CREATE TABLE GameGenre (
    gid INT,
    geid INT NOT NULL,
    PRIMARY KEY(gid, geid),
    FOREIGN KEY(gid) REFERENCES Game(gid)
);

-- A tuple in this relation represents the available genres
-- geid is the id that is used to indicate different genres, and 
-- genre name is the text description.
CREATE TABLE Genre (
    geid INT,
    genre_name TEXT NOT NULL,
    PRIMARY KEY(geid)
);

-- A tuple in this relation represents the price of the game. Gid represents 
-- the corresponding game, price_cur is the currency that is used to price 
-- the game and price is the numerical number that represents the cost of 
-- the game.
CREATE TABLE Sales (
    gid INT,
    price_cur VARCHAR(3) NOT NULL,
    price FLOAT NOT NULL,
    FOREIGN KEY(gid) REFERENCES Game(gid)
);


