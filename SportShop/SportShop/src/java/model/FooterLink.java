/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Win11
 */
public class FooterLink {
     private int id;
    private int settingsId;
    private String type;   // social/quick/service
    private String label;
    private String url;
    private String icon;   // chỉ social
    private int sortOrder;
    private boolean active;

    public FooterLink() {
    }

    public FooterLink(int id, int settingsId, String type, String label, String url, String icon, int sortOrder, boolean active) {
        this.id = id;
        this.settingsId = settingsId;
        this.type = type;
        this.label = label;
        this.url = url;
        this.icon = icon;
        this.sortOrder = sortOrder;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSettingsId() {
        return settingsId;
    }

    public void setSettingsId(int settingsId) {
        this.settingsId = settingsId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
    
}
