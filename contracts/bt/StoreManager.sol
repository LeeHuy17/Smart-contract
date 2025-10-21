// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductManager{

    struct Product {
        string name;
        uint amount;
        uint price;
    }

    mapping(string => Product) public products;

    function addProduct(string memory _name, uint _amount, uint _price) public {
        products[_name] = Product(_name, _amount, _price);
    }

    function getProduct(string memory _name) public view returns (string memory, uint, uint) {
        return (products[_name].name, products[_name].amount, products[_name].price);
    }

    function isProductExist(string memory _name) public view returns (bool) {
        return bytes(products[_name].name).length > 0;
    }

    function updateProductPrice(string memory _name, uint _price) public {
        require(isProductExist(_name), "Product does not exist");
        require(products[_name].amount > 0, "Product is out of stock");
        products[_name].price = _price;
    }    

    

}