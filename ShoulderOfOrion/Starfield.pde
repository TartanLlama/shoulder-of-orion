public class Star
{
    PVector pos;

    public Star(float x, float y, float z)
    {
        pos = new PVector(x,y,z);
    }
}

public class Starfield
{
    private Star stars[];
    private int count;

    public Starfield(int count)
    {
        this.count = count;
        stars = new Star[count];

        for (int i=0; i<count; i++)
        {
            stars[i] = generateStar();
        }
    }

    private Star generateStar()
    {
        return new Star(int(random(width)), int(random(height)), int(random(10))+1);
    }

    public void draw() {
        strokeCap(ROUND);
        strokeWeight(2);

        for (int i=0; i<count; i++)
        {
            //draw further away stars darker
            stroke (stars[i].pos.z * 25);

            point (stars[i].pos.x, stars[i].pos.y);

            //further away stars move slower
            stars[i].pos.x -= stars[i].pos.z;

            if (stars[i].pos.x < 0)
            {
                stars[i] = generateStar();
            }
        }
    }
}
