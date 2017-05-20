class Planet implements Drawable
{
    final int PLANET_RESOLUTION = 3;
    private color c;
    int r;
    PVector o;
    color[][] ps;
    PImage planetImg;
    ShipPlaque shipPlaque;
    Shipyard shipyard;
    private Faction owner;

    Planet (int r, PVector o, Faction owner)
    {
        this.r = r/PLANET_RESOLUTION;
        this.owner = owner;
        this.c = owner.getColour();
        this.o = o;

        initPixels();
        this.planetImg = createPlanetImage();
        this.shipPlaque = new ShipPlaque(new PVector(o.x, o.y));
        this.shipyard = new Shipyard(this.r, this.owner);

        //double ship count for faction-owned planets
        if (owner != SCAVENGER)
        {
            shipyard.addShips(this.r);
        }
        owner.addPlanet(this);
    }

    public int getNShips()
    {
        return shipyard.getNShips();
    }

    public PVector getCentre()
    {
        return new PVector(o.x, o.y);
    }

    public void defendAgainst(Fleet theirFleet) throws LevelFinished
    {
        Fleet myFleet = this.shipyard.getFullFleet();
        //no ships, give up the planet
        if (myFleet == null)
        {
            this.setOwner(theirFleet.getOwner());
            this.shipyard.addShips(theirFleet.getNShips());
        }
        //battle!
        else
        {
            int theirShipsLeft = theirFleet.battle(myFleet);
            //they win
            if (theirShipsLeft > 0)
            {
                this.setOwner(theirFleet.getOwner());
            }

            //defence complete
            this.shipyard.addShips(abs(theirShipsLeft));
        }
    }

    public void setOwner (Faction o) throws LevelFinished
    {
        owner.removePlanet(this);
        owner = o;
        setColour(o.getColour());
        shipyard.setOwner(o);
        o.addPlanet(this);
        planetTaken();
    }

    public Faction getOwner()
    {
        return owner;
    }

    private void setColour (int c)
    {
        color pixel;
        for (int i=0; i<planetImg.pixels.length; i++)
        {
            pixel = planetImg.pixels[i];
            //if pixel is transparent, leave it
            //otherwise maintain the pixel difference, but change the hue
            planetImg.pixels[i] = pixel==0x00000000? pixel: c - (this.c - pixel);
        }
        this.c = c;
        planetImg.updatePixels();
    }

    public void draw()
    {
        image(planetImg, o.x-r, o.y-r);
        shipPlaque.draw(shipyard.nShips);
    }

    public void tick()
    {
        if (owner != SCAVENGER)
        {
            shipyard.tick();
        }
    }

    public boolean intersects (Planet p)
    {
        return distanceTo(p) <= 0;
    }

    public float distanceTo (Planet p)
    {
        PVector dist = o.get();
        dist.sub(p.o);
        return abs(dist.mag()) - r*PLANET_RESOLUTION - p.r*PLANET_RESOLUTION;
    }

    public boolean intersects (PVector p)
    {
        return distanceTo(p) <= 0;
    }

    public float distanceTo (PVector p)
    {
        PVector dist = new PVector (o.x, o.y);
        dist.sub(p);
        return abs(dist.mag()) - r;
    }


    //uses specialised version of the midpoint circle algorithm
    private void initPixels()
    {
        this.ps = new color[r*2+1][r*2];

        int x0 = r;
        int y0 = r;

        int f = 1 - r;
        int x = 0;
        int y = r;


        //draw lines to orthogonal points
        //texturedLine(x0, y0 + r, x0, y0 - r);
        ps[y0] = texturedLine(x0 + r, y0, x0 - r, y0);

        while(x < y-1)
        {
            if(f >= 0)
            {
                y--;
            }

            x++;

            f = x*x + y*y - r*r + 2*x - y + 1;

            sparseFill(ps[y0+y], x0-x, texturedLine
                       (x0 + x, y0 + y, x0 - x, y0 + y));
            sparseFill(ps[y0-y], x0-x, texturedLine
                       (x0 + x, y0 - y, x0 - x, y0 - y));
            sparseFill(ps[y0+x], x0-y, texturedLine
                       (x0 + y, y0 + x, x0 - y, y0 + x));
            sparseFill(ps[y0-x], x0-y, texturedLine
                       (x0 + y, y0 - x, x0 - y, y0 - x));
        }
    }

    //fill a line segment with colours
    private void sparseFill(color[] line, int start, color[] tofill)
    {
        for(int i=start; i-start < tofill.length; i++){
            line[i] = tofill[i-start];
        }
    }

    private PImage createPlanetImage()
    {
        int s = PLANET_RESOLUTION;
        PImage img = createImage(r*2+1, r*2, ARGB);
        img.loadPixels();

        for (int i=0; i<ps.length; i+=1)
        {
            for (int j=0; j<ps[1].length; j+=1)
            {
                //k and l for dealing with resolution
                for (int k=0; k<s; k++)
                {
                    for (int l=0; l<s; l++)
                    {
                        if (ps[i][j] == 0)
                        {
                            img.set(i+k,j+l, color(0,0,0,0));
                        }
                        else
                        {
                            img.set(i+k,j+l, c+ps[i][j]);
                        }
                    }
                }
            }
        }
        img.updatePixels();
        return img;
    }

    private color[] texturedLine(float x1, float y1, float x2, float y2)
    {
        color[] line = new color[int(x1-x2)];

        for (float i=x2; i<x1; i++)
        {
            //use mixture of static noise and a random modifier
            // for a fairly attractive distribution
            line[int(i-x2)] = color(noise(i, i*y1)*100*random(1));
        }

        return line;
    }

    public Fleet getFleet()
    {
        return shipyard.getFleet();
    }

    public Fleet getFullFleet()
    {
        return shipyard.getFullFleet();
    }

    public Fleet getFleet(int nShips)
    {
        return shipyard.getFleet(nShips);
    }

    public void addShips(int n)
    {
        shipyard.addShips(n);
    }
}
