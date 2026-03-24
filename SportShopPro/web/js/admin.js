function showModal(id) {
  const modal = document.getElementById(id);
  if (modal) {
    modal.classList.remove("hidden");
    modal.classList.add("flex");
  }
}

function closeModal(id) {
  const modal = document.getElementById(id);
  if (modal) {
    modal.classList.add("hidden");
    modal.classList.remove("flex");
  }
}

function setupModalBackdropClose(modalIds) {
  window.addEventListener("click", function (e) {
    modalIds.forEach((modalId) => {
      if (e.target.id === modalId) {
        closeModal(modalId);
      }
    });
  });
}

function openDeleteModal(id, name) {
  const nameEl = document.getElementById("deleteProductName");
  const idEl = document.getElementById("deleteProductId");

  if (nameEl) nameEl.textContent = name;
  if (idEl) idEl.value = id;

  showModal("deleteModal");
}

function openDeleteOrderModal(id, name) {
  const nameEl = document.getElementById("deleteOrderName");
  const idEl = document.getElementById("deleteOrderId");

  if (nameEl) nameEl.textContent = name;
  if (idEl) idEl.value = id;

  showModal("deleteModal");
}

function openAddCustomerModal() {
  const form = document.getElementById("customerForm");
  if (form) {
    form.reset();
    const actionInput = form.querySelector('input[name="action"]');
    if (actionInput) actionInput.value = "create";

    const idInput = form.querySelector('input[name="id"]');
    if (idInput) idInput.value = "";
  }
  showModal("customerModal");
}

function openEditCustomer(id) {
  // For now, just redirect to edit page with servlet
  window.location.href = "customer?action=edit&id=" + id;
}

function openDeleteCustomerModal(id, name) {
  const nameEl = document.getElementById("deleteCustomerName");
  const idEl = document.getElementById("deleteCustomerId");

  if (nameEl) nameEl.textContent = name;
  if (idEl) idEl.value = id;

  showModal("deleteCustomerModal");
}

function confirmDeleteCustomer() {
  const form = document.getElementById("deleteCustomerForm");
  if (form) {
    form.submit();
  }
}

function setupAutoSubmitForms() {
  const autoSubmitElements = document.querySelectorAll('[onchange*="submit"]');
  autoSubmitElements.forEach((element) => {
    element.addEventListener("change", function () {
      this.form.submit();
    });
  });
}

// Toggle Sidebar Function
function toggleSidebar() {
  const sidebar = document.getElementById('sidebar');
  const toggleBtn = document.getElementById('toggleSidebar');
  const icon = toggleBtn.querySelector('i');
  
  if (sidebar && toggleBtn && icon) {
    if (sidebar.style.marginLeft === '-288px') {
      // Show sidebar
      sidebar.style.marginLeft = '0';
      toggleBtn.style.left = '288px';
      icon.classList.remove('fa-chevron-right');
      icon.classList.add('fa-chevron-left');
    } else {
      // Hide sidebar
      sidebar.style.marginLeft = '-288px';
      toggleBtn.style.left = '0';
      icon.classList.remove('fa-chevron-left');
      icon.classList.add('fa-chevron-right');
    }
  }
}

// Initialize sidebar position
function initializeSidebar() {
  const sidebar = document.getElementById('sidebar');
  const toggleBtn = document.getElementById('toggleSidebar');
  
  if (sidebar && toggleBtn) {
    sidebar.style.marginLeft = '0';
    toggleBtn.style.left = '288px';
  }
}

document.addEventListener("DOMContentLoaded", function () {
  const commonModals = [
    "productModal",
    "viewProductModal",
    "deleteModal",
    "orderDetailModal",
    "customerModal",
    "customerDetailModal",
    "deleteCustomerModal",
  ];

  setupModalBackdropClose(commonModals);
  
  // Initialize sidebar
  initializeSidebar();
});
