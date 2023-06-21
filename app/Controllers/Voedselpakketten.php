<?php

namespace App\Controllers;

use App\Libraries\Core\Controller;
use App\Models\Voedselpakket;

class Voedselpakketten extends Controller
{
    private Voedselpakket $voedselpakket;

    public function __construct()
    {
        $this->voedselpakket = new Voedselpakket();
    }

    public function index(): void
    {
        try {
            $this->setData([
                'title' => 'Voedselpakketten',
                'voedselpakketten' => Voedselpakket::getVoedselpakketten(),
                'eetwensen' => Voedselpakket::getEetwensen(),
            ]);

            $this->view('voedselpakketten/index');
        } catch (\Throwable $th) {
            throw $th;
        }
    }
    
    public function filterByEetwens($eetwens): void
    {
        try {
            $this->setData([
                'title' => 'Voedselpakketten - Filtered',
                'voedselpakketten' => Voedselpakket::getFilteredVoedselpakketten($eetwens),
                'eetwensen' => Voedselpakket::getEetwensen(),
            ]);

            $this->view('voedselpakketten/index');
        } catch (\Throwable $th) {
            throw $th;
        }
    }
}
