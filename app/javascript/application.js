// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers"

//= require rails-ujs

//= require jquery
//= require jquery_ujs
//= require cart
// app/assets/javascripts/cart.js
document.addEventListener("DOMContentLoaded", function() {
    // Отримуємо всі кнопки для збільшення і зменшення кількості
    const decreaseButtons = document.querySelectorAll(".quantity-btn.decrease");
    const increaseButtons = document.querySelectorAll(".quantity-btn.increase");
    const quantityInputs = document.querySelectorAll(".quantity");
    const cartItems = document.querySelectorAll(".cart-item");

    // Оновлення суми кошика
    function updateCartTotal() {
        let total = 0;
        cartItems.forEach((item, index) => {
            const price = parseFloat(item.querySelector(".product-price").textContent.replace(" грн", "").replace(" ", "")); // Отримуємо ціну
            const quantity = parseInt(quantityInputs[index].value); // Кількість товару
            const totalPrice = price * quantity;
            total += totalPrice;
            item.querySelector(".product-total").textContent = totalPrice.toFixed(2) + " грн"; // Оновлюємо підсумкову ціну товару
        });
        document.querySelector(".total-price").textContent = total.toFixed(2) + " грн"; // Оновлюємо загальну суму
    }

    // Зменшити кількість
    decreaseButtons.forEach((button, index) => {
        button.addEventListener("click", function() {
            let quantity = parseInt(quantityInputs[index].value);
            if (quantity > 1) {
                quantity--;
                quantityInputs[index].value = quantity;
                updateCartTotal();
            }
        });
    });

    // Збільшити кількість
    increaseButtons.forEach((button, index) => {
        button.addEventListener("click", function() {
            let quantity = parseInt(quantityInputs[index].value);
            quantity++;
            quantityInputs[index].value = quantity;
            updateCartTotal();
        });
    });

    // Початкове оновлення суми кошика
    updateCartTotal();
});

