//Not used anymore, but left in for sake of interest
//It was originally used to randomly generate planets and their positions
//  until it was decided that set levels worked better
class PlanetGenerator
{
    int MIN_PLANET_SIZE = 50;
    int MAX_PLANET_SIZE = 100;

    public ArrayList<Planet> generatePlanets(int n)
    {
        ArrayList<Planet> planets = new ArrayList<Planet>();
        while (n>0)
        {
            Planet newPlanet;
            do
            {
                newPlanet = generatePlanet();
            }
            while (!checkPlanet(newPlanet, planets));

            planets.add(newPlanet);
            n--;
        }

        return planets;
    }

    private boolean checkPlanet(Planet planet, ArrayList<Planet> planets)
    {
        for (int i=0; i<planets.size(); i++)
        {
            if (planet.intersects(planets.get(i)))
            {
                return false;
            }
        }

        return true;
    }

    private Planet generatePlanet()
    {
        int r = int(random(MIN_PLANET_SIZE, MAX_PLANET_SIZE+1));
        PVector pos = new PVector (random(r, width-r), random(r, height-r));
        return new Planet(r, pos, SCAVENGER);
    }
}
