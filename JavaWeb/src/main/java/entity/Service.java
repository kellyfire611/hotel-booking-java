package entity;

import java.sql.Date;

public class Service {
    
    private int serviceID;

    private String name;

    private float price;

    private String hotelID;

    public Service() {

    }

    public Service(int serviceID,
                  String name,
                  float price,
                  String hotelID) {
        this.serviceID = serviceID;
        this.name = name;
        this.price = price;
        this.hotelID = hotelID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public String getServiceName() {
        return name;
    }

    public void setServiceName(String name) {
        this.name = name;
    }

    public float getServicePrice() {
        return price;
    }

    public void setServicePrice(Float price) {
        this.price = price;
    }

    /**
     * @return the hotelID
     */
    public String getHotelID() {
        return hotelID;
    }

    /**
     * @param hotelID the hotelID to set
     */
    public void setHotelID(String hotelID) {
        this.hotelID = hotelID;
    }
}