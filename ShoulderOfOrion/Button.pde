public class Button
{
    PVector pos;
    PVector size;
    String text;
    PImage img;

    public Button(String text, PVector pos, PVector size)
    {
        this.img = buttonImage;
        this.text = text;
        this.pos = pos;
        this.size = size;
    }

    protected Button() {}

    protected void setPos (PVector pos)
    {
        this.pos = pos;
    }

    protected void setSize (PVector size)
    {
        this.size = size;
    }

    protected void setImage (PImage img)
    {
        this.img = img;
    }

    public void setText (String text)
    {
        this.text = text;
    }

    //for mouse click detection
    public boolean contains(float x, float y)
    {
        return x>=pos.x && x<=pos.x+size.x &&
            y>=pos.y && y<=pos.y+size.y;
    }

    public void draw()
    {
        image(img, pos.x, pos.y);
        textSize(22);
        textAlign(CENTER);
        fill(0,0,255);
        text(this.text, pos.x, pos.y+(size.y/2-10), size.x, 40);
    }
}
