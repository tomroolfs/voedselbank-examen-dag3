<?php

namespace App\Models;

use App\Libraries\Core\Database;

Class Voedselpakket
{
//haalt alle voedselpakketten op
    public static function getVoedselpakketten(): array
    {
        $db = Database::getInstance();
        $db->query("SELECT gezin.id, gezin.naam, gezin.omschrijving, gezin.aantalvolwassenen, gezin.aantalkinderen, gezin.aantalbabys, persoon.voornaam FROM gezin INNER JOIN persoon ON persoon.gezin_id = gezin.id WHERE persoon.isvertegenwoordiger = 1;");        
        return $db->many();
    }

    public static function getEetwensen(): array
{
    $db = Database::getInstance();
    $db->query("SELECT DISTINCT naam FROM eetwens"); 
    return $db->many();
}

public static function getFilteredVoedselpakketten($eetwens): array
{
    $db = Database::getInstance();
    $db->query("SELECT gezin.id, gezin.naam, gezin.omschrijving, gezin.aantalvolwassenen, gezin.aantalkinderen, gezin.aantalbabys, persoon.voornaam 
                FROM gezin
                INNER JOIN persoon ON persoon.gezin_id = gezin.id
                WHERE persoon.isvertegenwoordiger = 1");

    $db->bind(':eetwens', $eetwens);
    return $db->many();
}

public static function findVoedselpakket(int $id)
{
    $db = Database::getInstance();
    $db->query("SELECT gezin.id, gezin.naam, gezin.omschrijving, gezin.totaalaantalpersonen, voedselpakket.pakketnummer, voedselpakket.datumsamengesteld, voedselpakket.datumuitgifte, voedselpakket.status
                FROM gezin
                INNER JOIN voedselpakket ON voedselpakket.gezin_id = gezin.id
                INNER JOIN persoon ON persoon.gezin_id = gezin.id
                WHERE persoon.isvertegenwoordiger = 1 AND gezin.id = :id");
    $db->bind(':id', $id);
    return $db->first();
}



}