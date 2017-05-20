public class LevelButton extends Button
{
    final int BUTTON_WIDTH = 100;
    final int BUTTON_HEIGHT = 50;
    private int levelNumber;
    private boolean accessible;
    private PImage accessibleImage;
    private PImage inaccessibleImage;

    public LevelButton (int levelNumber)
    {
        this.levelNumber = levelNumber;
        this.accessible = levelNumber<=level.getMaxLevel();

        setSize(new PVector(BUTTON_WIDTH, BUTTON_HEIGHT));
        setPos(new PVector(30+BUTTON_WIDTH*((levelNumber-1)%8),
                           100+(BUTTON_HEIGHT+20)*int((levelNumber-1)/8)));
        accessibleImage = createButtonImage(levelNumber, true);
        inaccessibleImage = createButtonImage(levelNumber, false);
        setText("");
    }

    public void draw()
    {
        PImage img;
        if(accessible)
        {
            img = accessibleImage;
        }
        else
        {
            img = inaccessibleImage;
        }

        image(img, pos.x, pos.y);
    }

    public void update()
    {
        accessible = levelNumber<=level.getMaxLevel();
    }

    public int getLevel()
    {
        return levelNumber;
    }

    private PImage createButtonImage(int n, boolean accessible)
    {
        PGraphics pg = createGraphics(BUTTON_WIDTH, BUTTON_WIDTH, P2D);
        pg.beginDraw();
        if (accessible)
        {
            pg.fill(225, 225, 225, 225);
        }
        else
        {
            pg.fill(125, 125, 125, 125);
        }
        pg.stroke(125);
        pg.rect(0,0,BUTTON_WIDTH, BUTTON_HEIGHT, 20);
        pg.fill(255);
        pg.textAlign(CENTER,CENTER);
        pg.textSize(20);
        pg.text(str(n), 0, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        pg.endDraw();
        return pg;
    }
}
