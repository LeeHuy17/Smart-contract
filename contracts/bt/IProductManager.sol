// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface cho các phương thức
interface IProductManager {
    function addProduct(string memory _nameProduct, uint _price, uint _quantity) external;
    function getProductInfo(string memory _nameProduct) external view returns (uint price, uint quantity);
}


// ---------------------------
// Contract quản lý sản phẩm
// ---------------------------
contract ProductManager {
    
    IProductManager public storeContract;

    // Địa chỉ store
    constructor(address _storeAddress) {
        storeContract = IProductManager(_storeAddress);
    }

    // Thêm sản phẩm vào store
    function addProduct(string memory _nameProduct, uint _price, uint _quantity) public {
        storeContract.addProduct(_nameProduct, _price, _quantity);
    }

    // Lấy thông tin sản phẩm
    function getProductInfo(string memory _nameProduct) public view returns (uint price, uint quantity) {
        return storeContract.getProductInfo(_nameProduct);
    }

}
