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

    public function show(int $id): void
    {
        $this->setData([
            'title' => 'Voedselpakketten',
            'voedselpakket' => Voedselpakket::findVoedselpakket($id),
        ]);
    
        $this->view('voedselpakketten/show');
    }

//bewerkt de gekozen status van het voedselpakket
    public function edit(int $id) :void
    {
        switch ($_SERVER ['REQUEST_METHOD']){
            case 'POST':
                
                $this->voedselpakket->updateVoedselpakket([
                    'id' => $id,
                    'status' => $_POST['status'],
                ]);

                $this->setData([
                    'title' => 'Voedselpakketten',
                    'message' => [
                        'title' => 'Voedselpakket Edited',
                        'content' => 'Voedselpakket has been added edited'
                    ]
                ]);

                $this->view('messages/index');
                $this->redirect('/voedselpakketten', 3);

                case 'GET':
                    $this->setData([
                        'title' => 'Edit Voesdelpakket',
                        'voedselpakket' => $this->voedselpakket->findVoedselpakket($id)
                    ]);

                    $this->view('voedselpakketten/edit');
                    break;
        }
    }
    
}
