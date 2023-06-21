<?php

namespace App\Models;

use App\Libraries\Core\Database;

Class Supplier
{
    //haalt de gekozen supplier op
    public static function findSuppliers(int $id)
    {
        $db = Database::getInstance();
        $db->query('SELECT supplier.id, supplier.name, supplier.image, address.street, address.zipcode, address.city, contact_details.name AS contactname, contact_details.email, contact_details.phone_number FROM supplier INNER JOIN address ON address.supplier_id = supplier.id INNER JOIN contact_details ON contact_details.supplier_id = supplier.id WHERE supplier.id=:id');
        $db->bind('id', $id);
        return $db->first();
    }
//haalt alle suppliers op
    public static function getSuppliers(): array
    {
        $db = Database::getInstance();
        $db->query('SELECT supplier.id, supplier.name, supplier.image, address.street, address.zipcode, address.city, contact_details.name AS contactname, contact_details.email, contact_details.phone_number FROM supplier INNER JOIN address ON address.supplier_id = supplier.id INNER JOIN contact_details ON contact_details.supplier_id = supplier.id');
        return $db->many();
    }
//verwijdert de gekozen supplier
    public function deleteSupplier(int $id)
    {
        $db = Database::getInstance();
        $db->query("DELETE FROM address WHERE supplier_id=:id");
        $db->bind('id', $id);
        $db->execute();
        $db->query("DELETE FROM contact_details WHERE supplier_id=:id");
        $db->bind('id', $id);
        $db->execute();
        $db->query("DELETE FROM supplier WHERE id=:id");
        $db->bind('id', $id);
        $db->execute();
    }
//voegt een nieuwe supplier toe
    public function addSupplier(array $data)
    {
        $db = Database::getInstance();
        $db->query("CALL create_supplier(:name, :image, :street, :zipcode, :city, :contact_name, :email, :phone_number)");
        $db->bind('name', $data['name']);
        $db->bind('image', $data['image']);
        $db->bind('street', $data['street']);
        $db->bind('zipcode', $data['zipcode']);
        $db->bind('city', $data['city']);
        $db->bind('contact_name', $data['contactname']);
        $db->bind('email', $data['email']);
        $db->bind('phone_number', $data['phone_number']);
        $db->execute();
        return $db->Count();
    }
//update de gekozen supplier
public function updateSupplier(array $data)
{
    $db = Database::getInstance();
    $db->query("SET @supplier_id = :id");
    $db->bind('id', $data['id']);
    $db->execute();

    $db->query("CALL update_supplier(@supplier_id, :name, :image, :street, :zipcode, :city, :contact_name, :email, :phone_number, :id)");
    $db->bind('name', $data['name']);
    $db->bind('image', $data['image']);
    $db->bind('street', $data['street']);
    $db->bind('zipcode', $data['zipcode']);
    $db->bind('city', $data['city']);
    $db->bind('contact_name', $data['contactname']);
    $db->bind('email', $data['email']);
    $db->bind('phone_number', $data['phone_number']);
    $db->bind('id', $data['id']);
    $db->execute();

    return $db->Count();
}



}