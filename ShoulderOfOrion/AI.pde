public class AI
{
    private Faction master;

    private final int ATTACK_SCORE_THRESHOLD = 0;
    private final int ATTACK_CONFIDENCE = 5;

    private final int TICKS = 25; //one run per second
    private int tickCounter = TICKS;


    public AI (Faction master)
    {
        this.master = master;
    }

    public void tick()
    {
        tickCounter --;
        //do an AI run if it is time
        if (tickCounter == 0)
        {
            tickCounter = TICKS;

            int planetScore = master.getPlanetScore();
            int nShips = calculateNShips();

            Planet target = getPlanetToAttack(planetScore, nShips);
            if (target == null)
            {
                return;
            }

            List<Planet> sourcePlanets = getAttackingPlanets(target);

            if (sourcePlanets == null)
            {
                return;
            }

            sendShips(sourcePlanets, target);
        }
    }

    //send ships from the source planets to the target
    private void sendShips (List<Planet> sources, Planet target)
    {
        ShipPath path;
        PVector pc;
        PVector tc;
        Fleet f;

        for (Planet p : sources)
        {
            pc = p.getCentre();
            tc = target.getCentre();

            path = new ShipPath(pc, p);
            path.targetPlanet = target;

            //put points down along the line
            for (int i=0; i<=20; i++)
            {
                path.addPoint(lerp(pc.x,tc.x, i/20.0), lerp(pc.y,tc.y, i/20.0));
            }

            f = p.getFleet();
            if (f == null)
            {
                return;
            }

            f.init(path);
            fleets.add(f);

            shipPaths.add(path);
        }
    }

    //work out whith planets should be used to attack
    private List<Planet> getAttackingPlanets (Planet target)
    {
        //sort by number of ships
        Collections.sort(master.ownedPlanets, new PlanetShipsComparator());
        int ships = 0;
        int toAdd;
        Planet p;
        for (int i=0; i<master.ownedPlanets.size(); i++)
        {
            p = master.ownedPlanets.get(i);

            toAdd = p.getNShips() / 2; //use half the ships on the planet

            //only send 3 or more ships
            //less than three is fairly ineffective due to the dice-rolling mechanics
            //this also prevents the game from descending into a chaos of 1-ship fleets
            ships += (toAdd>=3)? toAdd: 0;

            //do we have enough ships?
            if (ships > (target.getNShips() + ATTACK_CONFIDENCE))
            {
                //leave the rest of the planets alone, return the ones up till now
                return master.ownedPlanets.subList(0,i+1);
            }
        }

        return null;
    }

    private class PlanetShipsComparator implements Comparator<Planet> {
        public int compare(Planet o1, Planet o2) {
            return Double.compare(o2.getNShips(),o1.getNShips());
        }
    }

    //works out a good planet to attack if there is one
    private Planet getPlanetToAttack(int planetScore, int nShips)
    {
        Planet bestPlanet = null;
        int bestScore = 0;

        List<Planet> notOwnedPlanets = new ArrayList<Planet>(level.planets);
        //filter out the planets which are owned by this faction
        for (Planet p : master.ownedPlanets)
        {
            notOwnedPlanets.remove(p);
        }

        for (Planet p : notOwnedPlanets)
        {
            //assume that the number of defending ships to ships lost ratio is 1:1
            //this means that the AI is fairly aggressive
            int shipsLost = p.getNShips();

            //score based on the size of the target planet
            //(i.e., how fast it will generate ships)
            //and the projected loss of ships
            int score = p.r + (nShips-shipsLost) - ATTACK_SCORE_THRESHOLD;
            if (nShips-shipsLost>0)
            {
                if (score > bestScore ||
                    (score == bestScore && random(1) >= 0.5))//random element
                {
                    bestScore = score;
                    bestPlanet = p;
                }
            }
        }

        return bestPlanet;
    }

    private int calculateNShips()
    {
        int ships = 0;

        for (Planet p : master.ownedPlanets)
        {
            ships += p.getNShips()/2; //only use half the ships in each planet
        }

        //Leave at least one ship on each planet
        return ships - master.ownedPlanets.size();
    }
}
