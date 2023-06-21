<?php 

namespace App\Controllers;

use App\Libraries\Core\Controller;
use App\Models\Supplier;

class Suppliers extends Controller
{

    private Supplier $supplier;

    public function __construct()
    {
        $this->supplier = new Supplier();
    }
//haalt alle suppliers op
    public function index(): void
    {
       try {
        $this->setData([
        'title' => 'Suppliers',
        'suppliers' => Supplier::getSuppliers(),
        ]);
    
        $this->view('suppliers/index');

    } catch (\Throwable $th) {
        throw $th;
    }
    }
//haalt de gekozen supplier op
    public function show(int $id): void
    {
        $this->setData([
        'title' => 'Suppliers',
        'supplier' => Supplier::findSuppliers($id),
        ]);
    
        $this->view('suppliers/show');
    }
//verwijdert de gekozen supplier
    public function delete(int $id): void
    {
        $this->supplier->deleteSupplier($id);

        $this->setData([
            'title' => 'Suppliers',
            'message' => [
                'title' => 'Supplier Deleted',
                'content' => 'Supplier has been deleted successfully'
            ]
        ]);

        $this->view('messages/index');
        $this->redirect('/suppliers', 3);
    }
//voegt een nieuwe supplier toe
    public function add() :void
    {
        switch ($_SERVER ['REQUEST_METHOD']){
            case 'POST':
                
                $this->supplier->addSupplier([
                    'name' => $_POST['name'],
                    'image' => $_POST['image'],
                    'street' => $_POST['street'],
                    'zipcode' => $_POST['zipcode'],
                    'city' => $_POST['city'],
                    'contactname' => $_POST['contact_name'],
                    'email' => $_POST['email'],
                    'phone_number' => $_POST['phone_number']

                ]);

                $this->setData([
                    'title' => 'Suppliers',
                    'message' => [
                        'title' => 'Supplier Added',
                        'content' => 'Supplier has been added successfully'
                    ]
                ]);

                $this->view('messages/index');
                $this->redirect('/suppliers', 3);

                default:
                    $this->setData([
                        'title' => 'Add Supplier'
                    ]);

                    $this->view('suppliers/add');
                    break;
        }
    }
//bewerkt de gekozen supplier
    public function edit(int $id) :void
    {
        switch ($_SERVER ['REQUEST_METHOD']){
            case 'POST':
                
                $this->supplier->updateSupplier([
                    'id' => $id,
                    'name' => $_POST['name'],
                    'image' => $_POST['image'],
                    'street' => $_POST['street'],
                    'zipcode' => $_POST['zipcode'],
                    'city' => $_POST['city'],
                    'contactname' => $_POST['contact_name'],
                    'email' => $_POST['email'],
                    'phone_number' => $_POST['phone_number']
                ]);

                $this->setData([
                    'title' => 'Suppliers',
                    'message' => [
                        'title' => 'Supplier Edited',
                        'content' => 'Supplier has been added edited'
                    ]
                ]);

                $this->view('messages/index');
                $this->redirect('/suppliers', 3);

                case 'GET':
                    $this->setData([
                        'title' => 'Edit Supplier',
                        'supplier' => $this->supplier->findSuppliers($id)
                    ]);

                    $this->view('suppliers/edit');
                    break;
        }
    }

}