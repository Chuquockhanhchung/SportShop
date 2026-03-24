/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dao;

import java.sql.*;
import java.util.*;
import model.DBContext;
import model.FooterSettings;
import model.FooterLink;

public class FooterDAO extends DBContext {

    public FooterSettings getSettings() {
        String sql = "SELECT * FROM footer_settings WHERE id = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                FooterSettings f = new FooterSettings();
                f.setId(rs.getInt("id"));
                f.setDescription(rs.getString("description"));
                f.setAddress(rs.getString("address"));
                f.setPhone(rs.getString("phone"));
                f.setEmail(rs.getString("email"));
                f.setHours(rs.getString("hours"));
                f.setCopyright(rs.getString("copyright"));
                return f;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<FooterLink> getLinksByType(String type) {
        List<FooterLink> list = new ArrayList<>();
        String sql = "SELECT * FROM footer_link WHERE settings_id = 1 AND type = ? AND is_active = 1 ORDER BY sort_order";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FooterLink l = new FooterLink();
                    l.setId(rs.getInt("id"));
                    l.setSettingsId(rs.getInt("settings_id"));
                    l.setType(rs.getString("type"));
                    l.setLabel(rs.getString("label"));
                    l.setUrl(rs.getString("url"));
                    l.setIcon(rs.getString("icon"));
                    l.setSortOrder(rs.getInt("sort_order"));
                    l.setActive(rs.getBoolean("is_active"));
                    list.add(l);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateSettings(FooterSettings f) {
        String sql = "UPDATE footer_settings SET description=?, address=?, phone=?, email=?, hours=?, copyright=?, updated_at=GETDATE() WHERE id=1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, f.getDescription());
            ps.setString(2, f.getAddress());
            ps.setString(3, f.getPhone());
            ps.setString(4, f.getEmail());
            ps.setString(5, f.getHours());
            ps.setString(6, f.getCopyright());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void replaceLinks(String type, List<FooterLink> links) {
        String deleteSql = "DELETE FROM footer_link WHERE settings_id=1 AND type=?";
        String insertSql = "INSERT INTO footer_link(settings_id,type,label,url,icon,sort_order,is_active) VALUES(1,?,?,?,?,?,1)";
        try (PreparedStatement del = connection.prepareStatement(deleteSql)) {
            del.setString(1, type);
            del.executeUpdate();

            try (PreparedStatement ins = connection.prepareStatement(insertSql)) {
                int order = 1;
                for (FooterLink l : links) {
                    if (l.getLabel() == null || l.getLabel().trim().isEmpty()) continue;
                    ins.setString(1, type);
                    ins.setString(2, l.getLabel());
                    ins.setString(3, l.getUrl());
                    ins.setString(4, l.getIcon());
                    ins.setInt(5, order++);
                    ins.addBatch();
                }
                ins.executeBatch();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
