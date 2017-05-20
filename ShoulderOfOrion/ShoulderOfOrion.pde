
//The different factions
Faction SCAVENGER = null;
Faction ZHAGHAKK = null;
Faction AENUNE = null;
Faction KALIDAN = null;
Faction FALGAR = null;
//To facilitate looping over factions
Faction[] factions = new Faction[4];

//Buttons for the faction selection screen
Button[] factionSelectButtons = new Button[4];

PImage logo = null;
PImage buttonImage = null;
PImage factionSelectionImage = null;

//Buttons for different screens
Button playButton = null;
Button saveButton = null;
Button savedButton = null;
Button loadButton = null;
Button changeFactionButton = null;
Button playAgainButton = null;
Button nextLevelButton = null;
Button selectLevelButton = null;

List<LevelButton> levelSelectButtons;

Starfield starfield;
ArrayList<ShipPath> shipPaths;
ShipPath currentPath;
ArrayList<Fleet> fleets;
boolean drawingPath = false;

//Possible states
final int MAIN_MENU = 0;
final int PLAYING = 1;
final int LEVEL_SELECT = 2;
final int FACTION_SELECT = 3;
final int LEVEL_COMPLETE = 4;
final int LEVEL_FAILED = 5;
final int GAME_COMPLETE = 6;
final int OPTIONS_MENU = 7;
int state = MAIN_MENU;

boolean paused = false;

Level level;

void setup ()
{
    frameRate(25);
    size (854, 480, P2D);
    //for the background
    starfield = new Starfield(100);

    shipPaths = new ArrayList<ShipPath>();
    fleets = new ArrayList<Fleet>();
    initialiseGame();
}

void initialiseFactions()
{
    //with dummy images
    SCAVENGER = new Faction(#7d7d7d, new PImage(), new PImage());

    ZHAGHAKK = new Faction(#7d0000,
                           loadImage("ship_red.png"),
                           loadImage("emblem_red.png"));
    AENUNE = new Faction(#00007d,
                         loadImage("ship_blue.png"),
                         loadImage("emblem_blue.png"));
    KALIDAN = new Faction(#007d00,
                          loadImage("ship_green.png"),
                          loadImage("emblem_green.png"));
    FALGAR = new Faction(#7d1e00,
                         loadImage("ship_brown.png"),
                         loadImage("emblem_brown.png"));
    factions[0] = AENUNE;
    factions[1] = KALIDAN;
    factions[2] = ZHAGHAKK;
    factions[3] = FALGAR;
}

void initialiseButtons()
{
    for (int i=0; i<4; i++)
    {
        factionSelectButtons[i] = new Button("Select",
                                             new PVector(40+200*i, 380),
                                             new PVector(170, 85));
    }


    playButton = new Button("Play",
                            new PVector(550, 180),
                            new PVector(170, 85));

    nextLevelButton = new Button("Next Level",
                                 new PVector(340, 255),
                                 new PVector(170, 85));

    playAgainButton = new Button("Play Again",
                                 new PVector(140, 255),
                                 new PVector(170, 85));

    selectLevelButton = new Button("Select Level",
                                   new PVector(540, 255),
                                   new PVector(170, 85));

    saveButton = new Button("Save Progress",
                            new PVector(150, 300),
                            new PVector(170, 85));

    loadButton = new Button("Load Progress",
                            new PVector(350, 300),
                            new PVector(170, 85));

    changeFactionButton = new Button("Change Faction",
                                     new PVector(550, 300),
                                     new PVector(170, 85));
}

void initialiseFactionSelectionImage()
{
    factionSelectionImage = createFactionSelectionImage();
}

void initialiseLevel()
{
    level = new Level();
    levelSelectButtons = createLevelSelectButtons();
}

void initialiseGame()
{
    buttonImage = loadImage("button.png");
    logo = loadImage("newlogo.png");

    initialiseFactions();
    initialiseButtons();
    initialiseFactionSelectionImage();
    initialiseLevel();
}

List<LevelButton> createLevelSelectButtons()
{
    List<LevelButton> buttons = new ArrayList<LevelButton>();

    for (int i=0; i<level.getNLevels(); i++)
    {
        buttons.add(new LevelButton(i+1));
    }

    return buttons;
}

class LevelFinished extends Exception {}

void drawMainMenu()
{
    image(logo, 60, 132);
    playButton.draw();
}

//This would mean a lot of static drawing of text and suchlike
//so just buffer everything
PImage createFactionSelectionImage()
{
    PGraphics pg = createGraphics (width, height, P2D);
    pg.beginDraw();

    pg.fill(color(150,150,150,200));
    pg.stroke(color(150));

    pg.rect (30,10,190,460,20);
    pg.rect (230,10,190,460,20);
    pg.rect (430,10,190,460,20);
    pg.rect (630,10,190,460,20);

    pg.fill(color(0));
    pg.textAlign(CENTER);
    pg.textSize(20);
    pg.text("Aenune", 60, 20, 130, 20);
    pg.text("Kalidan", 260, 20, 130, 20);
    pg.text("Zhaghakk", 460, 20, 130, 20);
    pg.text("Falgar", 660, 20, 130, 20);

    pg.image (AENUNE.getEmblemImage(), 70, 45);
    pg.image (KALIDAN.getEmblemImage(), 270, 45);
    pg.image (ZHAGHAKK.getEmblemImage(), 470, 45);
    pg.image (FALGAR.getEmblemImage(), 670, 45);

    pg.image (AENUNE.getShipImage(), 130, 45);
    pg.image (KALIDAN.getShipImage(), 330, 45);
    pg.image (ZHAGHAKK.getShipImage(), 530, 45);
    pg.image (FALGAR.getShipImage(), 730, 45);

    pg.textSize(12);
    pg.textAlign(LEFT);
    pg.text ("An elegant faction who live in a serendipitous sector of the Swan Nebula. Their skill in the arts is rivalled only by their love for fine food and drink. They are slim, light on their feet and are recognizable by their hair, which is fashioned into beautiful patterns to attract the opposite sex. They wish to use the rare materials found in Polyorionis to make a drink called Uisce Beatha, which they believe will grant eternal life.",
             40, 100, 170, 320);

    pg.text ("The Kalidan are a nomadic faction who move throughout the Supercluster and looting planets for their goods. Greed has turned their eyes the deepest shade of black imaginable. Only the strongest of the faction survive because the rest are killed for their wealth by other members. They want the resources of Polyorionis to add to their horde of treasure.",
             240, 100, 170, 320);

    pg.text ("The hostile lands in which the Zhaghakk faction live has turned them callous and warlike. Their skin is leathery from the harsh climate and they uphold a custom of using face piercings to indicate class and wealth. They simply wish to wipe out the other factions, so the battle for Polyorionis is an excellent opportunity.",
             440, 100, 170, 320);

    pg.text ("Members of the Falgar faction are master craftsmen with a penchant for huge underground caverns and complex machines. They are partly blind from the darkness which they inhabit, but have developed a kind of telepathy with machines which they use to navigate and do their bidding. They are characterised by the thick hair which covers their body to protect them from cold. The Falgar want Polyorionis so they can use its resources for building machines which can think.",
             640, 100, 170, 320);
    pg.endDraw();
    return pg;
}

void drawFactionSelection()
{
    image (factionSelectionImage, 0, 0);
    for (Button b : factionSelectButtons)
    {
        b.draw();
    }
}

void drawLevelComplete()
{
    fill(color(125, 125, 125, 125));
    stroke(125);
    rect (120, 120, width-240, height-240, 20);

    fill(color(255));
    textSize(25);
    textAlign(CENTER);
    text("Level Complete!", 130, 130, width-260, 30);
    text(level.player.getShipsBuilt()+" ships built", 130, 180, width-260, 30);
    text(level.player.getShipsDestroyed()+" ships destroyed", 130, 220, width-260, 30);
    playAgainButton.draw();
    nextLevelButton.draw();
    selectLevelButton.draw();
}

void drawLevelFailed()
{
    fill(color(125, 125, 125, 125));
    stroke(125);
    rect (120, 120, width-240, height-240, 20);

    fill(color(255));
    textSize(25);
    textAlign(CENTER);
    text("Level Failed!", 130, 130, width-260, 30);
    text(level.player.getShipsBuilt()+" ships built", 130, 180, width-260, 30);
    text(level.player.getShipsDestroyed()+" ships destroyed", 130, 220, width-260, 30);
    playAgainButton.draw();
    selectLevelButton.draw();
}

void drawGameComplete()
{
    fill(color(125, 125, 125, 125));
    stroke(125);
    rect (120, 120, width-240, height-240, 20);

    fill(color(255));
    textSize(25);
    textAlign(CENTER);
    text("Congratualations! You beat the game!", 130, 130, width-260, 30);
    text(level.player.getShipsBuilt()+" ships built", 130, 180, width-260, 30);
    text(level.player.getShipsDestroyed()+" ships destroyed", 130, 220, width-260, 30);
    playAgainButton.draw();
    selectLevelButton.draw();
}

void drawSelectLevel()
{
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("Select a Level", 0, 20, width, 30);
    for (Button b : levelSelectButtons)
    {
        b.draw();
    }
    saveButton.draw();
    loadButton.draw();
    changeFactionButton.draw();
}

void drawPlaying()
{
    fill(255);
    textAlign(LEFT);
    textSize(12);
    text("Press 'p' to pause", 0,10);
    text("Press 'q' to go back", 0,20);
    text("Press <Esc> to quit", 0,30);

    try
    {
        if (!paused)
        {
            for (Faction f : level.aiFactions)
            {
                f.takeTurn();
            }

            ArrayList<Fleet> finished = new ArrayList<Fleet>();
            for (Fleet f : fleets)
            {
                if (f.move())
                {
                    finished.add(f);
                }
            }

            for (Fleet f : finished)
            {
                shipPaths.remove(f.shipPath);
                fleets.remove(f);
            }

            for (Planet p : level.planets)
            {
                p.tick();
            }
        }

        drawMany(level.planets);
        drawMany(shipPaths);
        drawMany(fleets);
    }
    catch(LevelFinished e)
    {}
}

/*What I really want to do is have this as a static method in Drawable:
  static void drawMany(List<Drawable>)
  Processing doesn't seem to like that, nor does it like this function having the signature
  void drawMany(List<Drawable>)
  As such, I'm stuck with this horrible hack*/
void drawMany(List l)
{
    for (int i=0; i<l.size(); i++)
    {
        ((Drawable)(l.get(i))).draw();
    }
}

void draw()
{
    //clear screen every tick
    background(0);
    //draw background
    starfield.draw();

    if (state==MAIN_MENU)
    {
        drawMainMenu();
    }

    else if (state == FACTION_SELECT)
    {
        drawFactionSelection();
    }

    else if (state == LEVEL_COMPLETE)
    {
        drawLevelComplete();
    }

    else if (state == LEVEL_FAILED)
    {
        drawLevelFailed();
    }

    else if (state == GAME_COMPLETE)
    {
        drawGameComplete();
    }

    else if (state == LEVEL_SELECT)
    {
        drawSelectLevel();
    }

    else if (state == PLAYING)
    {
        drawPlaying();
    }
}

void planetTaken() throws LevelFinished
{
    checkFinished(null);
}

void fleetDestroyed(Fleet f) throws LevelFinished
{
    checkFinished(f);
}

void checkFinished(Fleet lastDestroyed) throws LevelFinished
{
    boolean havePlayer = false;
    boolean haveEnemy = false;

    for (Planet p : level.planets)
    {
        if (p.getOwner() == level.player)
        {
            havePlayer = true;
        }
        if (p.getOwner() != level.player && p.getOwner() != SCAVENGER)
        {
            haveEnemy = true;
        }
    }


    for (Fleet f : fleets)
    {
        if (lastDestroyed != f)
        {
            if (f.getOwner() == level.player)
            {
                havePlayer = true;
            }
            if (f.getOwner() != level.player && f.getOwner() != SCAVENGER)
            {
                haveEnemy = true;
            }
        }
    }

    if (havePlayer && !haveEnemy)
    {
        win();
    }
    else if (haveEnemy && !havePlayer)
    {
        lose();
    }
}


void win() throws LevelFinished
{
    level.levelComplete();
    if (level.isLastLevel())
    {
        state = GAME_COMPLETE;
    }
    else
    {
        state = LEVEL_COMPLETE;
    }
}

void lose() throws LevelFinished
{
    state = LEVEL_FAILED;
}

void resetState()
{
    fleets = new ArrayList<Fleet>();
    shipPaths = new ArrayList<ShipPath>();
}

void nextLevel() throws LevelFinished
{
    resetState();
    level.nextLevel();
    throw(new LevelFinished());
}

void restartLevel() throws LevelFinished
{
    resetState();
    level.restartLevel();
    throw(new LevelFinished());
}

void updateLevelSelectButtons()
{
    for (LevelButton b : levelSelectButtons)
    {
        b.update();
    }
}

void mousePressed()
{
    if (state == MAIN_MENU)
    {
        if (playButton.contains(mouseX, mouseY))
        {
            state = FACTION_SELECT;
        }
    }

    else if (state == LEVEL_SELECT)
    {
        if (saveButton.contains(mouseX, mouseY))
        {
            level.save();
            saveButton.setText("Saved!");
        }
        else if (loadButton.contains(mouseX, mouseY))
        {
            level.load();
            updateLevelSelectButtons();
            saveButton.setText("Save Progress");
        }
        else if (changeFactionButton.contains(mouseX, mouseY))
        {
            state = FACTION_SELECT;
            saveButton.setText("Save Progress");
        }
        else
        {
            for (LevelButton b : levelSelectButtons)
            {
                if (b.contains(mouseX, mouseY))
                {
                    if (level.selectLevel(b.getLevel()))
                    {
                        state = PLAYING;
                        saveButton.setText("Save Progress");
                    }
                }
            }
        }
    }

    else if (state == FACTION_SELECT)
    {
        for (int i=0; i<factionSelectButtons.length; i++)
        {
            if (factionSelectButtons[i].contains(mouseX, mouseY))
            {
                level.setPlayer(factions[i]);
                state = LEVEL_SELECT;
            }
        }
    }

    else if (state == LEVEL_COMPLETE)
    {
        try
        {
            if (nextLevelButton.contains(mouseX, mouseY))
            {
                state = PLAYING;
                nextLevel();
            }
            else if (playAgainButton.contains(mouseX, mouseY))
            {
                state = PLAYING;
                restartLevel();
            }
            else if (selectLevelButton.contains(mouseX, mouseY))
            {
                resetState();
                state = LEVEL_SELECT;
            }
        }
        catch (LevelFinished e) {}
    }

    else if (state == LEVEL_FAILED || state == GAME_COMPLETE)
    {
        try
        {
            if (playAgainButton.contains(mouseX, mouseY))
            {
                state = PLAYING;
                restartLevel();
            }
            else if (selectLevelButton.contains(mouseX, mouseY))
            {
                resetState();
                state = LEVEL_SELECT;
            }
        }
        catch (LevelFinished e) {}
    }

    else if (state == PLAYING)
    {
        ShipPath path;
        Planet p;
        for (int i=0; i<level.planets.size(); i++)
        {
            p = level.planets.get(i);
            if (p.intersects(new PVector(mouseX, mouseY))
                && p.owner == level.player)
            {
                path = new ShipPath(mouseX, mouseY, p);
                shipPaths.add(path);
                currentPath = path;
                drawingPath = true;
                return;
            }
        }
    }
}

void mouseDragged()
{
    if (state == PLAYING)
    {
        if (drawingPath)
        {
            currentPath.addPoint(mouseX, mouseY);
        }
    }
}

//for handling when the path is finished
void mouseReleased()
{
    if (state == PLAYING)
    {
        if (drawingPath)
        {
            for (int i=0; i<level.planets.size(); i++)
            {
                //if the path was drawn to a planet
                if (level.planets.get(i).intersects(new PVector(mouseX, mouseY)))
                {
                    ShipPath path = currentPath;
                    path.targetPlanet = level.planets.get(i);
                    Fleet f = path.sourcePlanet.getFleet();

                    if (f == null)
                    {
                        shipPaths.remove(path);
                        return;
                    }

                    f.init(path);
                    fleets.add(f);
                    path.close();
                    drawingPath = false;
                    currentPath = null;
                    return;
                }
            }

            drawingPath = false;
            shipPaths.remove(currentPath);
            currentPath = null;
        }
    }
}

void keyPressed ()
{
    if (key == 'p' && state==PLAYING)
    {
        paused = !paused;
    }
    if (key == 'q' && state==PLAYING)
    {
        resetState();
        state = LEVEL_SELECT;
    }
}
