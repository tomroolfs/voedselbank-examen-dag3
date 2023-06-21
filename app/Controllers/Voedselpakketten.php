<?php

namespace App\Controllers;

use App\Libraries\Core\Controller;
use App\Models\Voedselpakket;

class Voedselpakketten extends Controller
{
    
    private Voedselpakket $voedselpakket;
//maakt een nieuwe instantie van de klasse Voedselpakket
    public function __construct()
    {
        $this->voedselpakket = new Voedselpakket();
    }
//haalt alle voedselpakketten op
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
   //haalt alle voedselpakketten op met de gekozen eetwens 
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
//haalt het gekozen voedselpakket op
    public function show(int $id): void
    {
        $this->setData([
            'title' => 'Specefiek Voedselpakket',
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
                //laat een bericht zien dat het voedselpakket is bewerkt
                $this->view('messages/index');
                //redirect naar de voedselpakketten pagina
                $this->redirect('/voedselpakketten', 3);

                case 'GET':
                    $this->setData([
                        'title' => 'Wijzig Voedselpakket',
                        'voedselpakket' => $this->voedselpakket->findVoedselpakket($id)
                    ]);

                    $this->view('voedselpakketten/edit');
                    break;
        }
    }
    
}
