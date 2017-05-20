class Shipyard
{
    private int planetSize;
    public int nShips;
    private Faction owner;
    private int ticksForShip;
    private int currTicks;
    private final int PLANET_SIZE_TICK_SCALE = 1000;
    private final float PLANET_SIZE_START_SCALE = 0.50;

    public Shipyard(int planetSize, Faction owner)
    {
        this.planetSize = planetSize;
        this.nShips = int(planetSize*PLANET_SIZE_START_SCALE);
        this.owner = owner;
        ticksForShip = int(1.0/planetSize*PLANET_SIZE_TICK_SCALE);
        currTicks = ticksForShip;
    }

    public Fleet getFleet()
    {
        int ships = nShips/2;
        nShips = nShips/2 + nShips%2;
        return ships == 0? null: new Fleet(ships, owner);
    }

    public Fleet getFleet(int nShips)
    {
        this.nShips -= nShips;
        return new Fleet(nShips, owner);
    }

    public Fleet getFullFleet()
    {
        int ships = nShips;
        nShips = 0;
        return ships == 0? null: new Fleet(ships, owner);
    }

    public int getNShips()
    {
        return nShips;
    }

    public void setOwner(Faction o)
    {
        owner = o;
    }

    public void addShips(int n)
    {
        nShips += n;
    }

    public void tick()
    {
        currTicks --;
        if (currTicks == 0)
        {
            nShips ++;
            owner.builtShips(1);
            currTicks = ticksForShip;
        }
    }
}
