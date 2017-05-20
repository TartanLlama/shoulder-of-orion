//Represents the path a fleet is on
class ShipPath implements Drawable
{
    private PVector lastPopped;
    ArrayList<PVector> points;
    Planet sourcePlanet;
    Planet targetPlanet;
    float length;
    private color c;

    public ShipPath(float x, float y, Planet sourcePlanet)
    {
        init(sourcePlanet);
        addPoint(x, y);
    }

    public ShipPath(PVector start, Planet sourcePlanet)
    {
        init(sourcePlanet);
        addPoint(start);
    }

    private void init(Planet sourcePlanet)
    {
        points = new ArrayList();
        this.sourcePlanet = sourcePlanet;
        c = sourcePlanet.getOwner().getColour() & (128 << 8*3)-1;
    }

    public void addPoint(float x, float y)
    {
        addPoint(new PVector(x, y));
    }

    public void addPoint(PVector point)
    {
        if (points.size() > 1)
        {
            //keep track of length
            length += point.dist(points.get(points.size()-1));
        }
        points.add(point);
    }

    public PVector getStartPoint()
    {
        return points.get(0);
    }

    public PVector nextPoint()
    {
        if (points.size() > 0)
        {
            PVector next = points.get(0);
            return next;
        }

        return null;
    }

    private void popPoint()
    {
        if (points.size() > 1)
        {
            length -= points.get(0).dist(points.get(1));
        }

        //keep track so it can still be drawn
        lastPopped = points.get(0);
        points.remove(0);
    }

    public boolean atTarget()
    {
        return points.size() == 0;
    }

    public void close()
    {
        boolean remove = false;
        int size = points.size();
        int max;

        //strips off the points after the first point which enters the target planet
        for (int i=0; i<size; i++)
        {
            if (remove)
            {
                max = points.size()-1;
                length -= points.get(max-1).dist(points.get(max));
                points.remove(max);
            }

            else if (targetPlanet.intersects(points.get(i)))
            {
                remove = true;
            }
        }
    }

    public void draw()
    {
        if (points.size() > 1)
        {
            stroke(c);
            fill(0,0,0,0);
            beginShape();

            if (lastPopped != null)
            {
                vertex(lastPopped.x, lastPopped.y);
            }
            for (PVector p : points)
            {
                vertex(p.x, p.y);
            }

            endShape();
        }
    }
}
