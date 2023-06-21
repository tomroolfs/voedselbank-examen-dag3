<?php

use App\Models\Supplier;
use PHPUnit\Framework\TestCase;
use App\Libraries\Core\Database;

class SupplierTest extends TestCase
{
    /**

@test*/
  public function testExamUnit(){$supplier = new Supplier();

        // Test getSuppliers
        $suppliers = $supplier->getSuppliers();
        $this->assertIsArray($suppliers, "getSuppliers returned an array");

        echo "All unit tests passed successfully!\n";
    }
}
