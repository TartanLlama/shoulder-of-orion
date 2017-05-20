class ShipPlaque
{
    final int WIDTH = 50;
    final int HEIGHT = 25;
    PVector topLeft;

    public ShipPlaque(PVector origin)
    {
        topLeft = new PVector(origin.x-WIDTH/2,origin.y-HEIGHT/2);
    }

    void draw(int numberOfShips)
    {
        fill(color(255,255,255,100));
        stroke(color(255,255,255,100));
        rect (topLeft.x, topLeft.y, WIDTH, HEIGHT, 10);
        textAlign(CENTER);
        fill(0);
        textSize(21);
        text(str(numberOfShips),topLeft.x, topLeft.y, WIDTH, HEIGHT);
    }
}
