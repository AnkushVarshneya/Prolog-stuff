capital(bern).
capital(london).
capital(prague).
capital(bonn).
capital(belgrade).
city-in(prague, czechoslovakia).
city-in(bratislava, czechoslovakia).
city-in(berlin, germany).
city-in(leipzig, germany).
city-in(bonn, germany).
city-in(hamberg, germany).
city-in(belgrade, yugoslavia).
city-in(zagreb, yugoslavia).
city-in(bern, switzerland).
city-in(zurich, switzerland).
city-in(london, united_kingdom).
city-in(edinburgh, united_kingdom).
belongs-to(czechoslovakia, 'COMECON').
belongs-to(germany, 'EC').
belongs-to(switzerland, 'EFTA').
belongs-to(united_kingdom, 'EC').

% City is the capital of Country %
capital_of(City, Country) :- capital(City),
                             city-in(City, Country).

% Capitals is the list of cities in the given Community, such as 'EC' %
capital_of_community(Community, [Capital]) :- capital_of(Capital, Country),
                                              belongs-to(Country, Community).

capital_of_community(Community, [Capital|List]) :- capital_of(Capital, Country),
                                                   belongs-to(Country, Community),
                                                   capital_of_community(Community, List),!.