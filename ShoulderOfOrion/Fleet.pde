class Fleet implements Drawable
{
    //for displaying the number of ships plaque
    private final int PLAQUE_WIDTH = 40;
    private final int PLAQUE_HEIGHT = 20;
    private final int PLAQUE_OFFSET = 10;

    private int nShips;
    PVector pos;
    ShipPath shipPath;
    float speed;
    float direction;
    final float ACCELERATION = 0.05;
    final int MAX_SPEED = 10;
    private Faction owner;

    public Fleet (int nShips, Faction owner)
    {
        this.nShips = nShips;
        this.owner = owner;
    }

    public Faction getOwner()
    {
        return owner;
    }

    public int getNShips()
    {
        return nShips;
    }

    public void init(ShipPath shipPath)
    {
        this.shipPath = shipPath;
        pos = shipPath.getStartPoint();
        speed = 0;
    }

    private void drawPlaque()
    {
        PVector plaquePos = new PVector(pos.x+PLAQUE_OFFSET, pos.y+PLAQUE_OFFSET);
        fill(color(255,255,255,100));
        stroke(color(255,255,255,100));
        rect (plaquePos.x, plaquePos.y, PLAQUE_WIDTH, PLAQUE_HEIGHT, 10);
        textAlign(CENTER);
        fill(0);
        textSize(16);
        text(str(nShips),plaquePos.x, plaquePos.y, PLAQUE_WIDTH, PLAQUE_HEIGHT);
    }

    public void draw()
    {
        drawPlaque();

        PImage shipImage = owner.getShipImage();

        //set up the rotation of the ship image
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(direction);
        translate(-pos.x, -pos.y);

        image (shipImage, pos.x-shipImage.width/2, pos.y-shipImage.height/2);
        popMatrix();
    }

    private void modifySpeed()
    {
        //starts slowing down so that speed is minimal when arriving
        if (shipPath.length <= speed*speed/ACCELERATION)
        {
            slowDown();
        }
        else
        {
            speedUp();
        }
    }

    private void speedUp()
     {
        if (speed >= MAX_SPEED)
        {
            return;
        }

        speed += ACCELERATION;

        if (speed >= MAX_SPEED)
        {
            speed = MAX_SPEED;
        }
    }

    private void slowDown()
    {
        if (speed <= 1)
        {
            return;
        }

        speed -= ACCELERATION;

        if (speed <= 1)
        {
            speed = 1;
        }
    }

    private void arrived() throws LevelFinished
    {
        if (shipPath.targetPlanet.getOwner() == owner)
        {
            shipPath.targetPlanet.addShips(nShips);
        }
        else
        {
            attack(shipPath.targetPlanet);
        }
    }

    private void attack(Planet p) throws LevelFinished
    {
        p.defendAgainst(this);
    }

    //simulates a risk-like battle between the two fleets
    public int battle (Fleet defendingFleet) throws LevelFinished
    {
        //work out how many dice each team has
        int attackNDice = min(3,this.nShips);
        int defendNDice = min(2,defendingFleet.nShips);

        int[] attackDice = new int[attackNDice];
        int[] defendDice = new int[defendNDice];

        //until one fleet is dead
        while (this.nShips > 0 && defendingFleet.nShips > 0)
        {
            //roll all the attacker's dice
            for (int i=0; i<attackNDice; i++)
            {
                attackDice[i] = int(random(6));
            }

            //roll all the defender's dice
            for (int i=0; i<defendNDice; i++)
            {
                defendDice[i] = int(random(6));
            }

            //sort the dice rolls
            attackDice = sort(attackDice);
            defendDice = sort(defendDice);

            //Check the highest-scoring dice against each other
            if (attackDice[attackNDice-1] > defendDice[defendNDice-1])
            {
                this.owner.destroyedShips(1);
                defendingFleet.nShips --;
            }
            else
            {
                defendingFleet.owner.destroyedShips(1);
                this.nShips --;
            }

            //if there are other dice to compare, compare them
            if (defendNDice>1 && attackNDice>1
                && attackDice[attackNDice-2] > defendDice[defendNDice-2])
            {
                this.owner.destroyedShips(1);
                defendingFleet.nShips --;
            }
            else
            {
                defendingFleet.owner.destroyedShips(1);
                this.nShips --;
            }
        }

        fleetDestroyed(this);
        //return how many ships are left for the winning fleet
        //negative if the defending fleet won
        return this.nShips>0 ? this.nShips : -defendingFleet.nShips;
    }

    public boolean move() throws LevelFinished
    {
        if(shipPath.atTarget())
        {
            arrived();
            return true;
        }

        modifySpeed();

        //skip over points which the ship is moving too fast to visit
        //still take into account the distance so that movement is smooth
        float toMove = speed;
        PVector next = shipPath.nextPoint();
        float diff = pos.dist(next);
        while (diff <= toMove)
        {
            toMove -= diff;
            pos = next.get();
            next = shipPath.nextPoint();

            if (next == null)
            {
                arrived();
                return true;
            }

            diff = pos.dist(next);
            shipPath.popPoint();
        }

        //work out the direction which the ship should be pointing
        PVector directionVector = pos.get();
        directionVector.sub(next);
        directionVector.normalize();
        direction = atan2(directionVector.y, directionVector.x) - atan2(1,0);

        //carry out the move
        PVector moveVector = pos.get();
        moveVector.sub(next);
        moveVector.normalize();
        moveVector.mult(-toMove);
        pos.add(moveVector);

        return false;
    }
}
