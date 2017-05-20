public class Faction
{
    private color c;
    private ArrayList<Planet> ownedPlanets;
    private AI ai;
    private PImage shipImage;
    private PImage emblemImage;
    private int shipsBuilt = 0;
    private int shipsDestroyed = 0;
    private int planetScore = 0;

    public Faction (color c, PImage shipImage, PImage emblemImage)
    {
        this.c = c;
        this.shipImage = shipImage;
        this.emblemImage = emblemImage;
        ownedPlanets = new ArrayList<Planet>();
        ai = new AI(this);
    }

    public void resetCounters()
    {
        shipsDestroyed = 0;
        shipsBuilt = 0;
        ownedPlanets = new ArrayList<Planet>();
    }

    public int getPlanetScore()
    {
        return planetScore;
    }

    public int getShipsBuilt()
    {
        return shipsBuilt;
    }

    public int getShipsDestroyed()
    {
        return shipsDestroyed;
    }

    public void builtShips(int n)
    {
        shipsBuilt += n;
    }

    public void destroyedShips(int n)
    {
        shipsDestroyed += n;
    }

    public PImage getShipImage()
    {
        return shipImage;
    }

    public PImage getEmblemImage()
    {
        return emblemImage;
    }

    public void takeTurn()
    {
        ai.tick();
    }

    public void addPlanet(Planet p)
    {
        ownedPlanets.add(p);
        planetScore += p.r;
    }

    public void removePlanet(Planet p)
    {
        ownedPlanets.remove(p);
        planetScore -= p.r;
    }

    public color getColour()
    {
        return c;
    }
}
