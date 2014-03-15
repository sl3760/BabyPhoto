 package model;

public class Asset {
    public String name;
    public String image;
    public String time;
    public int com_num;
    public String comment;
    public String description;
    
    public Asset(String name, String image, String time, int com_num, String comment, String description) {
        this.name = name;
        this.image = image;
        this.time = time;
        this.com_num = com_num;
        this.comment = comment;
        this.description=description;
    }
}