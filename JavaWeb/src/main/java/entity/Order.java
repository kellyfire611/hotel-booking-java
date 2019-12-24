package entity;

import java.sql.Date;

public class Order {
    
    private String orderNumber;

    private String orderStatus;

    private String customerIDCard;

    private String roomNumber;

    private Date checkInTime;

    private Date checkOutTime;

    private Date orderTime;

    private String waiterID;

    private int totalMoney;

    private String remarks;
    
    private String hotelID;
    private int serviceID_1;
    private float price_1;
    private int serviceID_2;
    private float price_2;
    private int serviceID_3;
    private float price_3;

    public Order() {

    }

    public Order(String orderNumber,
                 String orderStatus,
                 String customerIDCard,
                 String roomNumber,
                 Date checkInTime,
                 Date checkOutTime,
                 int totalMoney,String waiterID
            ,String remarks,Date orderTime,
            String hotelID, int serviceID_1, float price_1,
            int serviceID_2, float price_2,
            int serviceID_3, float price_3) {
        this.orderNumber = orderNumber;
        this.orderStatus = orderStatus;
        this.customerIDCard = customerIDCard;
        this.roomNumber = roomNumber;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
        this.totalMoney = totalMoney;
        this.waiterID =waiterID ;
        this.remarks = remarks;
        this.orderTime =orderTime ;
        this.hotelID=hotelID;
        this.serviceID_1=serviceID_1;
        this.price_1=price_1;
        this.serviceID_2=serviceID_2;
        this.price_2=price_2;
        this.serviceID_3=serviceID_3;
        this.price_3=price_3;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public void setWaiterID(String waiterID) {
        this.waiterID = waiterID;
    }

    public String getWaiterID() {
        return waiterID;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCustomerIDCard() {
        return customerIDCard;
    }

    public void setCustomerIDCard(String customerIDCard) {
        this.customerIDCard = customerIDCard;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public Date getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(Date checkInTime) {
        this.checkInTime = checkInTime;
    }

    public Date getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(Date checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public int getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(int totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
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

    /**
     * @return the serviceID_1
     */
    public int getServiceID_1() {
        return serviceID_1;
    }

    /**
     * @param serviceID_1 the serviceID_1 to set
     */
    public void setServiceID_1(int serviceID_1) {
        this.serviceID_1 = serviceID_1;
    }

    /**
     * @return the price_1
     */
    public float getPrice_1() {
        return price_1;
    }

    /**
     * @param price_1 the price_1 to set
     */
    public void setPrice_1(float price_1) {
        this.price_1 = price_1;
    }

    /**
     * @return the serviceID_2
     */
    public int getServiceID_2() {
        return serviceID_2;
    }

    /**
     * @param serviceID_2 the serviceID_2 to set
     */
    public void setServiceID_2(int serviceID_2) {
        this.serviceID_2 = serviceID_2;
    }

    /**
     * @return the price_2
     */
    public float getPrice_2() {
        return price_2;
    }

    /**
     * @param price_2 the price_2 to set
     */
    public void setPrice_2(float price_2) {
        this.price_2 = price_2;
    }

    /**
     * @return the serviceID_3
     */
    public int getServiceID_3() {
        return serviceID_3;
    }

    /**
     * @param serviceID_3 the serviceID_3 to set
     */
    public void setServiceID_3(int serviceID_3) {
        this.serviceID_3 = serviceID_3;
    }

    /**
     * @return the price_3
     */
    public float getPrice_3() {
        return price_3;
    }

    /**
     * @param price_3 the price_3 to set
     */
    public void setPrice_3(float price_3) {
        this.price_3 = price_3;
    }
}