package com.mycompany.fft_plott;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;


public class Plot  {

    public static void main(final String[] args) throws Exception {
        final Plot plot = new Plot();
    }
    
    public Plot() throws Exception {
        final BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(new File("/tmp/xilinx.out"))));
        
        String line;
        final List<Double> data = new ArrayList<Double>();
//        final double[] data = new double[2048];
        while((line = in.readLine()) != null){
            int pos = Short.parseShort(line.split(" ")[2], 2) & 0x0000ffff;
            byte real = (byte)(Short.parseShort(line.split(" ")[0], 2));
            byte im = (byte)(Short.parseShort(line.split(" ")[1], 2));
            
            System.out.println("data: "+pos+", real: "+real+", im: "+im);
            data.add(pos, Math.sqrt(((double)im * (double)im) + ((double)real * (double)real)));
        }
        in.close();
        
        plot(data.toArray(new Double[]{}));
    }
    
    void plot(final Double[] data){
        final JFrame frame = new JFrame();
        final BufferedImage image = new BufferedImage(data.length/2, 256, BufferedImage.TYPE_INT_ARGB);
        final Graphics2D gr = image.createGraphics();
//        gr.setColor(Color.black);
//        gr.fillRect(0, 0, 500, 500);
        gr.setColor(Color.black);
        
        for(int a = 0; a < data.length/2; a++){
            gr.drawLine(a, 256-(int)(data[a] * 2), a, 0);
        }
        
        final JLabel l = new JLabel(new ImageIcon(image));
        l.setSize(image.getWidth(), image.getHeight());
        frame.add(l);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(image.getWidth(), image.getHeight());
        frame.pack();
        frame.setVisible(true);
    }
}
