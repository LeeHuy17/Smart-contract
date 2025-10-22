// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IClassManager {
    function isClassExist(string memory _name) external view returns (bool);
    function getClassLevel(string memory _name) external view returns (string memory);
    function getStudentLimit(string memory _name) external view returns (uint, uint);
    function incrementStudent(string memory _name) external;
    function decrementStudent(string memory _name) external;
}

contract StudentManager {
    struct Student {
        uint id;
        string name;
        string className;
        string level;
        uint age;
    }
    IClassManager public classContract;
    mapping(uint => Student) public students;
    uint public studentCount;

    constructor(address _classContractAddress) {
        classContract = IClassManager(_classContractAddress);
    }

    function addStudent(string memory _name, string memory _className, uint _age) public {
        require(classContract.isClassExist(_className), "Class does not exist");

        (uint current, uint limit) = classContract.getStudentLimit(_className);
        require(current < limit, "Class is full");

        string memory level = classContract.getClassLevel(_className);

        students[studentCount] = Student(studentCount, _name, _className, level, _age);
        classContract.incrementStudent(_className);
        studentCount++;
    }
    function getStudent(uint _id) public view returns (Student memory) {
        return students[_id];
    }

    function countCurLimit(string memory _className) public view returns (uint,uint){
        return classContract.getStudentLimit(_className);
    }

    

    function deleteStudent(uint _id, string memory _className) public {
        
        delete students[_id];
        classContract.decrementStudent(_className);
    }

}