class Particle {
    int x, y, radius;
    int gray, alpha;

    Particle() {
        x = width/2;
        y = height/2;
        radius = 10;
        gray = 130;
        alpha = 130;
    }

    void setPos(PVector p){
        x = int(p.x);
        y = int(p.y);
    }
    
    PVector getPos() {
        PVector p = new PVector(x, y);
        return p;
    }
    
    void setR(int r) {
        radius = r;
        print("SetR ");
        print(r);
        print(" ");
        println(radius);
    }

    void setGray(int g) {
        gray = g;
    }
    void setAlpha(int a) {
        alpha = a;
    }

    void draw() {
        push();
        fill(gray, alpha);
        noStroke();
        ellipse(x, y, radius, radius);
        // print("radius");
        // println(radius);
        pop();
    }
}

class Calculator {
    PVector getRandomInRect(int margin){
        int b_margin = 5;
        int x = int(random(b_margin+margin, width-margin-b_margin));
        int y = int(random(b_margin+margin, height-margin-b_margin));
        PVector p = new PVector(x,y);
        return p;
    }
    
    PVector getRandomInEllipse(int radius){
        int b_margin = 5;
        int d = int(random(0, radius-b_margin));
        float radian = random(0, TWO_PI);
        int x = width/2 + int(d*cos(radian));
        int y = height/2 + int(d*sin(radian));
        PVector p = new PVector(x, y);
        return p;
    }
    
    boolean judgePosition(PVector p, ArrayList<Particle> particles, float thresh){
        for(Particle particle : particles) {
            PVector pos = particle.getPos();
            float dis = dist(pos.x, pos.y, p.x, p.y);
            if (dis > thresh) {
                continue;
            } else {
                return false;
            }
        }
        return true;
    }
}
