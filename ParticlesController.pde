
class ParticlesController {

    ArrayList<Particle> particles;
    Calculator calc;
    int rect_margin = 100;
    int ellipse_radius = 350;
    boolean bRectangle = true;
    float distance_thresh = 0.0;
    
    void init(int size){
        particles = new ArrayList<Particle>();
        calc = new Calculator();
    
        for(int i=0; i<size; i++){
            particles.add(new Particle());
        }
    }
    
    void setPos(){
        for(Particle p : particles) {
            int counter = 0;
            while( true ) {
                PVector rp;
                if(bRectangle) rp = calc.getRandomInRect(rect_margin);
                else rp = calc.getRandomInEllipse(ellipse_radius);
                if(calc.judgePosition(rp, particles, distance_thresh)) {
                    p.setPos(rp);
                    break;
                }
                if(counter > 10) {
                    rp.x = -20;
                    rp.y = -20;
                    p.setPos(rp);   
                    break;
                }
                counter += 1;
            }
        }
    }
    
    void setParticleRadius(int r) {
        print("Set Particle Radius ");
        println(r);
        for(Particle p : particles) {
            p.setR(r);
        }
    }    
    void setParticleGray(int gray) {
        print("Set Particle Gray ");
        println(gray);
        for(Particle p : particles) {
            p.setGray(gray);
        }
    }
    void setParticleAlpha(int alpha) {
        print("Set Particle Alpha ");
        println(alpha);
        for(Particle p : particles) {
            p.setAlpha(alpha);
        }
    }

    void setRectMargin(int m) { rect_margin = m; }
    void setEllipseRadius(int r) { 
        ellipse_radius = r; 
        print("Set Ellipse Radius ");
        println(r);
    }
    void setDistanceThresh(float t){ distance_thresh = t; }
    void setMode(int m) { bRectangle = boolean(m); }
    
    void draw(){
        for(Particle p : particles){
            p.draw();
        }
    }

    void drawScope() {
        push();
        noFill();
        stroke(130, 130);
        if(bRectangle){
            int rectangle_size = width - rect_margin*2;
            rect(rect_margin, rect_margin, rectangle_size, rectangle_size);
        } else {
            ellipse(width/2, height/2, ellipse_radius*2, ellipse_radius*2);
        }
        pop();
    }
}
