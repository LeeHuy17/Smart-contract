// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ---------------------------
// Structs
// ---------------------------
struct Product {
    string nameProduct;
    uint price;
    uint quantity;
}

struct Order {
    string nameProduct;
    uint price;
    uint quantity;
}

// ---------------------------
// Contract quản lý 1 store duy nhất
// ---------------------------
contract StoreManager {

    mapping(string => Product) private products;

    string[] private productNames;

    mapping(string => Order[]) private userPurchases;

    function addProduct(string memory _nameProduct, uint _price, uint _quantity) external {
        Product storage prod = products[_nameProduct];

        if (bytes(prod.nameProduct).length == 0) {
            products[_nameProduct] = Product(_nameProduct, _price, _quantity);
            productNames.push(_nameProduct);
        } else {
            prod.price = _price;
            prod.quantity += _quantity;
        }
    }

    function getProductInfo(string memory _nameProduct) external view returns (uint price, uint quantity) {
        Product storage prod = products[_nameProduct];
        require(bytes(prod.nameProduct).length != 0, "Product not found");
        return (prod.price, prod.quantity);
    }

    function getAllProducts() external view returns (Product[] memory) {
        Product[] memory result = new Product[](productNames.length);
        for (uint i = 0; i < productNames.length; i++) {
            result[i] = products[productNames[i]];
        }
        return result;
    }

    function buyProduct(string memory _username, string memory _nameProduct, uint _quantity) external {
        Product storage prod = products[_nameProduct];
        require(bytes(prod.nameProduct).length != 0, "Product not found");
        require(prod.quantity >= _quantity, "Not enough quantity");

        prod.quantity -= _quantity;

        userPurchases[_username].push(Order({
            nameProduct: _nameProduct,
            price: prod.price,
            quantity: _quantity
        }));
    }

    function getPurchaseHistory(string memory _username) external view returns (Order[] memory) {
        return userPurchases[_username];
    }
}