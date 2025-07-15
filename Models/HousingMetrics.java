package Models;

public class HousingMetrics {
    private String housingName;
    private String hostName;
    private String city;
    private String country;
    private double totalRevenue;
    private int totalGuests;
    private int stars;
    private double averageOccupancy;

    public HousingMetrics(){}
    public HousingMetrics(String housingName, String hostName, String city, String country, double totalRevenue, int totalGuests, int stars, double averageOccupancy) {
        this.totalRevenue = totalRevenue;
        this.averageOccupancy = averageOccupancy;
        this.totalGuests = totalGuests;
        this.stars = stars;
        this.city = city;
        this.country = country;
        this.housingName = housingName;
        this.hostName = hostName;
    }

    // Getters
    public String getHousingName() { return housingName; }
    public String getHostName() { return hostName; }
    public String getCity() { return city; }
    public String getCountry() { return country; }
    public double getTotalRevenue() { return totalRevenue; }
    public int getTotalGuests() { return totalGuests; }
    public int getStars() { return stars; }
    public double getAverageOccupancy() { return averageOccupancy; }
}

