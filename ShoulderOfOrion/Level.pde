public class Level
{
    final int PLAYER = 0;
    final int A_SCAVENGER = 1;
    final int ENEMY_1 = 2;
    final int ENEMY_2 = 3;
    final int ENEMY_3 = 4;

    List<Planet> planets;
    final int[][][] levelPlanetData =
    {{{200,200,50,PLAYER},
      {600,300,50,ENEMY_1},
      {300,300,50,A_SCAVENGER}},

     {{300,250,75,PLAYER},
      {200,300,50,ENEMY_1},
      {100,280,25,ENEMY_1},
      {700,234,30,A_SCAVENGER}},

     {{150,150,100,PLAYER},
      {500,321,50,A_SCAVENGER},
      {700,400,25,ENEMY_1},
      {683,326,25,ENEMY_1},
      {732,423,25,ENEMY_1},
      {753,382,25,ENEMY_1}},

     {{586,196,60,PLAYER},
      {265,105,50,A_SCAVENGER},
      {341,261,40,A_SCAVENGER},
      {710,82,70,A_SCAVENGER},
      {281,227,60,A_SCAVENGER},
      {130,114,60,ENEMY_1}},

     {{427,240,200,ENEMY_1},
      {127,240,70,A_SCAVENGER},
      {727,240,70,A_SCAVENGER},
      {227,40,30,PLAYER},
      {627,40,30,PLAYER},
      {227,240,30,PLAYER},
      {627,240,30,PLAYER},
      {427,440,30,PLAYER},
      {427,40,30,PLAYER},
      {227,440,30,PLAYER},
      {627,440,30,PLAYER}},

     {{315,104,70,ENEMY_1},
      {509,80,40,A_SCAVENGER},
      {710,310,40,A_SCAVENGER},
      {231,101,40,A_SCAVENGER},
      {227,391,40,A_SCAVENGER},
      {281,432,40,A_SCAVENGER},
      {51,240,40,A_SCAVENGER},
      {104,320,40,A_SCAVENGER},
      {612,40,40,A_SCAVENGER},
      {529,410,40,A_SCAVENGER},
      {427,200,70,PLAYER}},

     {{427,240,100,A_SCAVENGER},
      {286,381,50,PLAYER},
      {427,40,50,ENEMY_1},
      {427,381,50,A_SCAVENGER},
      {327,240,50,A_SCAVENGER},
      {527,240,50,A_SCAVENGER},
      {568,381,50,ENEMY_2}},

     {{401,140,80,A_SCAVENGER},
      {186,301,50,PLAYER},
      {116,331,30,A_SCAVENGER},
      {616,231,70,A_SCAVENGER},
      {251,180,50,ENEMY_1},
      {568,381,50,ENEMY_2}},

     {{140,140,200,A_SCAVENGER},
      {30,30,40,A_SCAVENGER},
      {56,201,100,ENEMY_1},
      {201,56,100,ENEMY_2},
      {616,231,70,A_SCAVENGER},
      {520,281,50,PLAYER}},

     {{427,100,200,ENEMY_1},
      {90,200,50,ENEMY_2},
      {190,220,50,ENEMY_2},
      {290,240,50,ENEMY_2},
      {390,260,50,ENEMY_2},
      {490,260,50,PLAYER},
      {590,240,50,PLAYER},
      {690,220,50,PLAYER},
      {790,200,50,PLAYER}},

     {{215,204,50,ENEMY_1},
      {509,180,50,ENEMY_2},
      {708,110,50,A_SCAVENGER},
      {201,81,50,A_SCAVENGER},
      {127,291,50,A_SCAVENGER},
      {381,70,50,A_SCAVENGER},
      {251,440,50,A_SCAVENGER},
      {151,234,50,A_SCAVENGER},
      {51,140,50,A_SCAVENGER},
      {54,220,50,A_SCAVENGER},
      {312,340,50,A_SCAVENGER},
      {729,80,50,A_SCAVENGER},
      {327,100,50,PLAYER}},

     {{640,240,200,A_SCAVENGER},
      {120,100,40,A_SCAVENGER},
      {430,320,40,A_SCAVENGER},
      {710,50,40,A_SCAVENGER},
      {30,30,40,A_SCAVENGER},
      {56,201,50,ENEMY_1},
      {301,56,50,ENEMY_2},
      {716,131,50,ENEMY_3},
      {520,351,50,PLAYER}},

     {{412,210,100,ENEMY_3},
      {129,61,70,ENEMY_1},
      {613,301,40,PLAYER},
      {56,170,30,ENEMY_1},
      {301,270,50,ENEMY_2},
      {208,80,50,ENEMY_3},
      {90,341,20,PLAYER},
      {712,128,80,PLAYER}},

     {{648,414,40,A_SCAVENGER},
      {767,215,40,A_SCAVENGER},
      {594,195,40,A_SCAVENGER},
      {676,101,40,A_SCAVENGER},
      {398,381,40,A_SCAVENGER},
      {712,214,40,A_SCAVENGER},
      {481,178,40,A_SCAVENGER},
      {579,28,40,A_SCAVENGER},
      {119,217,60,ENEMY_1},
      {482,381,60,ENEMY_2},
      {485,433,60,ENEMY_3},
      {203,76,60,PLAYER}},

     {{290,314,150,ENEMY_2},
      {90,271,50,ENEMY_3},
      {815,279,50,PLAYER},
      {156,216,50,PLAYER},
      {799,95,50,ENEMY_3},
      {100,100,150,ENEMY_1},
      {456,105,50,ENEMY_3},
      {417,187,50,PLAYER}},

     {{335,21,40,A_SCAVENGER},
      {495,129,40,A_SCAVENGER},
      {295,161,40,A_SCAVENGER},
      {798,389,40,A_SCAVENGER},
      {217,174,40,A_SCAVENGER},
      {286,297,40,A_SCAVENGER},
      {663,330,40,A_SCAVENGER},
      {723,307,40,A_SCAVENGER},
      {665,81,40,A_SCAVENGER},
      {477,81,40,A_SCAVENGER},
      {158,81,40,A_SCAVENGER},
      {665,81,40,A_SCAVENGER},
      {759,173,40,A_SCAVENGER},
      {762,102,100,ENEMY_1},
      {535,176,70,PLAYER}},
    };


    List<Faction> possibleEnemies;
    List<Faction> aiFactions;
    Faction player;

    //the highest level the player can access thus far
    private int maxLevel = 1;

    private int currentLevel = 0;

    public void setPlayer(Faction player)
    {
        possibleEnemies = new ArrayList<Faction>();
        aiFactions = new ArrayList<Faction>();
        this.player = player;

        for (Faction f : factions)
        {
            if (f != player)
            {
                possibleEnemies.add(f);
            }
        }
    }

    public int getNLevels()
    {
        return levelPlanetData.length;
    }

    public boolean selectLevel(int n)
    {
        if (n > maxLevel)
        {
            return false;
        }
        currentLevel = n;
        planets = initLevel(currentLevel);
        return true;
    }

    public void nextLevel()
    {
        currentLevel ++;
        planets = initLevel(currentLevel);
    }

    public void levelComplete()
    {
        maxLevel = max(currentLevel+1, maxLevel);
        updateLevelSelectButtons();
    }

    public int getMaxLevel()
    {
        return maxLevel;
    }

    public void restartLevel()
    {
        planets = initLevel(currentLevel);
    }

    public boolean isLastLevel()
    {
        return currentLevel == levelPlanetData.length;
    }

    //creates all the planets from the level data
    private List<Planet> initLevel (int level)
    {
        for (Faction f : factions)
        {
            f.resetCounters();
        }

        ArrayList<Planet> planets = new ArrayList<Planet>();
        Faction owner;
        boolean[] factionPlaying = {false,false,false};

        for (int[] data : levelPlanetData[level-1])
        {
            //work out which faction should own this planet
            //keep track of which factions are playing as well
            switch (data[3])
            {
            case PLAYER: owner = player; break;
            case A_SCAVENGER: owner = SCAVENGER; break;
            case ENEMY_1:
                owner = possibleEnemies.get(0);
                factionPlaying[0] = true;
                break;
            case ENEMY_2:
                owner = possibleEnemies.get(1);
                factionPlaying[1] = true;
                break;
            case ENEMY_3:
                owner = possibleEnemies.get(2);
                factionPlaying[2] = true;
                break;
            default: owner = null;
            }

            //create a planet from the data
            planets.add(new Planet(data[2], new PVector(data[0],data[1]), owner));
        }

        //set up which factions should be played by the AI
        for (int i=0; i<factionPlaying.length; i++)
        {
            if (factionPlaying[i])
            {
                aiFactions.add(possibleEnemies.get(i));
            }
        }

        return planets;
    }

    //save which levels the player can access
    //uses serialization for quick-and-easy obfuscation
    public void save()
    {
        try
        {
            FileOutputStream f = new FileOutputStream(dataPath("data.ser"));
            ObjectOutputStream o = new ObjectOutputStream(f);
            o.writeObject(maxLevel);
            o.close();
        }
        catch (Exception e) {e.printStackTrace();}
    }

    //load the data back
    public void load()
    {
        try
        {
            FileInputStream f = new FileInputStream(dataPath("data.ser"));
            ObjectInputStream o = new ObjectInputStream(f);
            maxLevel = (Integer) o.readObject();
            o.close();
        }
        catch (Exception e) {e.printStackTrace();}
    }
}
