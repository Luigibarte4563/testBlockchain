// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title A simple contract to store and update a value.
 * @author Gemini
 * @dev This contract demonstrates basic access control using the 'onlyOwner' modifier.
 * The value can only be set by the contract's deployer.
 */
contract UpdatableValue {
    // A state variable to store the uint value.
    // The 'public' visibility automatically creates a getter function.
    uint256 public value;

    // A state variable to store the address of the contract's owner.
    address private owner;

    // An event that will be emitted whenever the value is updated.
    // Events are important for frontend applications to listen for changes
    // and update their UI in real-time.
    event ValueUpdated(uint256 oldValue, uint256 newValue, address updater);

    /**
     * @dev The constructor is a special function that is executed only once,
     * upon contract deployment. It sets the 'owner' to the address that
     * deployed the contract. 'msg.sender' is a global variable containing the
     * address of the account that called the function.
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev A custom modifier to restrict function calls to only the contract owner.
     * The '_' symbol in a modifier is a special syntax that tells Solidity to
     * execute the rest of the function's code at that point.
     * Reverts if the caller is not the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    /**
     * @notice Updates the stored value.
     * @param _newValue The new value to be set.
     * @dev This function can only be called by the owner of the contract due to the
     * 'onlyOwner' modifier. It emits the 'ValueUpdated' event.
     */
    function updateValue(uint256 _newValue) public onlyOwner {
        // Emit an event with the old value, new value, and the address that
        // made the update.
        emit ValueUpdated(value, _newValue, msg.sender);
        value = _newValue;
    }

    /**
     * @notice Returns the address of the contract owner.
     * @dev This function is a public view function, meaning it doesn't modify
     * the state and can be called for free.
     */
    function getOwner() public view returns (address) {
        return owner;
    }
}
