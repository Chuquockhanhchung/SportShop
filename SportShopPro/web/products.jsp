<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section id="products" class="tab-section hidden p-4 md:p-8 max-w-7xl mx-auto font-inter">
  <!-- Header -->
  <div class="mb-10">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
      <div>
        <h2 class="text-4xl font-black text-white mb-2 font-bebas tracking-wider">
          Product Management
        </h2>
        <p class="text-gray-400">A comprehensive list of all sports products in the inventory.</p>
      </div>
      <!-- Changed to a link to trigger the servlet's 'add' action -->
      <a href="product?action=add" class="bg-white text-black font-bold uppercase px-8 py-4 rounded-xl hover:bg-gray-200 transition-all shadow-lg hover:shadow-xl flex items-center gap-3 group">
        <i class="fas fa-plus group-hover:rotate-90 transition-transform duration-300"></i>
        <span>Add new Product</span>
      </a>
    </div>
  </div>

  <!-- Search / Sort Form -->
  <form action="product" method="GET" class="bg-gray-900 rounded-2xl p-6 mb-8 border border-white/10 shadow-lg">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div class="relative md:col-span-2">
        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"></i>
        <input
          type="text"
          name="search"
          placeholder="Search by name or category..."
          class="w-full bg-black text-white pl-12 pr-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
          value="${param.search}"
          onchange="this.form.submit()"
        />
      </div>
      <select
        name="sort"
        class="w-full bg-black text-white px-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
        onchange="this.form.submit()"
      >
        <option value="default" ${empty param.sort or param.sort == 'default' ? 'selected' : ''}>Sort by Default</option>
        <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Name A-Z</option>
        <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Name Z-A</option>
        <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Price: Low to High</option>
        <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Price: High to Low</option>
      </select>
    </div>
  </form>

  <!-- Products Table -->
  <div class="bg-gray-900 rounded-2xl border border-white/10 overflow-hidden mb-8">
    <!-- Table Header -->
    <div class="hidden md:grid grid-cols-12 gap-6 px-6 py-4 bg-black/40 border-b border-white/10">
      <div class="col-span-4"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Product</p></div>
      <div class="col-span-2"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Category</p></div>
      <div class="col-span-2"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Colors</p></div>
      <div class="col-span-1 text-right"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Price</p></div>
      <div class="col-span-1 text-center"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Stock</p></div>
      <div class="col-span-2 text-center"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Actions</p></div>
    </div>

    <!-- Table Body -->
    <div class="divide-y divide-white/5">
      <c:if test="${empty productList}">
          <div class="text-center py-20">
              <div class="w-16 h-16 bg-white/5 rounded-full flex items-center justify-center mx-auto mb-4">
                  <i class="fas fa-box-open text-3xl text-gray-700"></i>
              </div>
              <p class="text-gray-400 text-sm font-medium">No products found</p>
              <p class="text-gray-500 text-xs mt-1">Add your first product to get started</p>
          </div>
      </c:if>
      
      <c:forEach var="p" items="${productList}">
        <div class="grid grid-cols-1 md:grid-cols-12 gap-4 md:gap-6 px-6 py-5 hover:bg-white/5 transition-all duration-200 group">
          
          <!-- Product (Image + Name) -->
          <div class="md:col-span-4 flex items-center gap-4">
            <div class="w-14 h-14 flex-shrink-0 bg-white/5 rounded-xl overflow-hidden border border-white/10 group-hover:border-white/20 transition-all">
              <img src="${not empty p.imageUrl ? p.imageUrl : 'https://placehold.co/100x100/1a1a1a/666?text=No+Image'}" 
     alt="${p.productName}" 
                   class="w-full h-full object-cover" 
                   onerror="this.src='https://placehold.co/100x100/1a1a1a/666?text=No+Image'">
            </div>
            <div class="flex-1 min-w-0">
              <h4 class="text-white font-semibold text-sm truncate group-hover:text-gray-200 transition-colors">${p.productName}</h4>
              <p class="text-gray-500 text-xs mt-0.5">ID: ${p.productId}</p>
            </div>
          </div>

          <!-- Category -->
          <div class="md:col-span-2 flex items-center"><span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Category:</span><span class="text-gray-400 text-sm">${not empty p.categoryId ? p.categoryId : '-'}</span></div>
          <!-- Colors -->
          <div class="md:col-span-2 flex items-center"><span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Colors:</span><span class="text-gray-400 text-sm">${not empty p.color ? p.color : '-'}</span></div>
          <!-- Price -->
          <div class="md:col-span-1 flex items-center md:justify-end"><span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Price:</span><span class="text-white font-bold text-sm">${p.price}</span></div>
           <!-- Stock -->
          <div class="md:col-span-1 flex items-center md:justify-center">
            <span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Stock:</span>
            <c:choose>
              <c:when test="${p.quantity > 10}"><span class="px-3 py-1 text-xs font-semibold text-green-300 bg-green-500/10 rounded-full">${p.quantity}</span></c:when>
              <c:when test="${p.quantity > 0}"><span class="px-3 py-1 text-xs font-semibold text-yellow-300 bg-yellow-500/10 rounded-full">${p.quantity}</span></c:when>
              <c:otherwise><span class="px-3 py-1 text-xs font-semibold text-red-400 bg-red-500/10 rounded-full">Out</span></c:otherwise>
            </c:choose>
          </div>
          <!-- Actions -->
          <div class="md:col-span-2 flex items-center justify-end md:justify-center gap-2 pt-3 md:pt-0 border-t border-white/5 md:border-none">
            <a href="product?action=view&id=${p.productId}" class="w-9 h-9 rounded-lg bg-white/10 hover:bg-white/20 border border-white/10 text-gray-400 hover:text-white transition-all flex items-center justify-center" title="View Details"><i class="fas fa-eye text-xs"></i></a>
            <a href="product?action=edit&id=${p.productId}" class="w-9 h-9 rounded-lg bg-white/10 hover:bg-white border border-white/10 text-gray-400 hover:text-black transition-all flex items-center justify-center" title="Edit Product"><i class="fas fa-edit text-xs"></i></a>
            <button onclick="openDeleteModal('${p.productId}', '${p.productName}')" class="w-9 h-9 rounded-lg bg-red-500/10 hover:bg-red-500 border border-red-500/20 text-red-400 hover:text-white transition-all flex items-center justify-center" title="Delete Product"><i class="fas fa-trash text-xs"></i></button>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- Footer counter -->
  <div class="flex items-center justify-between p-5 bg-gray-900 rounded-xl border border-white/10">
    <div class="text-sm text-gray-400">
      Showing <span class="text-white font-bold">${productList.size()}</span> of <span class="text-white font-bold">${totalProducts}</span> products
    </div>
  </div>
  
  <!-- Add/Edit Modal -->
  <div id="productModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
    <div class="bg-gray-900 rounded-2xl shadow-2xl p-8 w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto border border-white/10">
      <div class="flex items-center justify-between mb-6">
        <h3 id="modalTitle" class="text-2xl font-black text-white font-bebas tracking-wider">
            <c:choose>
                <c:when test="${not empty productToEdit}">Edit Product</c:when>
                <c:otherwise>Add New Product</c:otherwise>
            </c:choose>
        </h3>
        <button onclick="closeModal('productModal')" class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 transition-colors flex items-center justify-center"><i class="fas fa-times text-gray-300"></i></button>
      </div>
      <form id="productForm" action="product" method="POST" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-5">
        <c:choose>
            <c:when test="${not empty productToEdit}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${productToEdit.productId}">
            </c:when>
            <c:otherwise>
                <input type="hidden" name="action" value="create">
            </c:otherwise>
        </c:choose>
        
        <div class="md:col-span-2">
            <label class="text-sm font-semibold text-gray-300 mb-2 block">Product name *</label>
            <input name="name" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" value="${productToEdit.productName}" placeholder="e.g., Nike Air Max 270"/>
        </div>
        <div>
          <label class="text-sm font-semibold text-gray-300 mb-2 block">Category *</label>
          <select name="category" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10">
              <option value="">Choose category</option>
              <option value="Footwear" ${productToEdit.categoryId == 'Footwear' ? 'selected' : ''}>Footwear</option>
              <option value="Ball Sports" ${productToEdit.categoryId == 'Ball Sports' ? 'selected' : ''}>Ball Sports</option>
              <option value="Racket Sports" ${productToEdit.categoryId == 'Racket Sports' ? 'selected' : ''}>Racket Sports</option>
              <option value="Apparel" ${productToEdit.categoryId == 'Apparel' ? 'selected' : ''}>Apparel</option>
          </select>
        </div>
         <div>
            <label class="text-sm font-semibold text-gray-300 mb-2 block">Gender *</label>
            <select name="gender" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10">
                <option value="">Choose Gender</option>
                <option value="Male" ${productToEdit.gender == 'Male' ? 'selected' : ''}>Male</option>
                <option value="Female" ${productToEdit.gender == 'Female' ? 'selected' : ''}>Female</option>
                <option value="Unisex" ${productToEdit.gender == 'Unisex' ? 'selected' : ''}>Unisex</option>
            </select>
        </div>
        <div>
          <label class="text-sm font-semibold text-gray-300 mb-2 block">Colors</label>
          <input name="colors" class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" value="${productToEdit.color}" placeholder="e.g., Black, White, Blue"/>
        </div>
         <div>
            <label class="text-sm font-semibold text-gray-300 mb-2 block">Price (VND) *</label>
            <input name="price" type="number" min="0" step="1000" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" value="${productToEdit.price}" placeholder="2990000"/>
        </div>
        <div>
            <label class="text-sm font-semibold text-gray-300 mb-2 block">Quantity *</label>
            <input name="quantity" type="number" min="0" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" value="${productToEdit.quantity}" placeholder="10"/>
        </div>
       
        <div class="md:col-span-2">
            <label class="text-sm font-semibold text-gray-300 mb-2 block">Image</label>
            <input name="image" type="file" accept="image/*" class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-white/10 file:text-white hover:file:bg-white/20"/>
            <c:if test="${not empty productToEdit.imageUrl}"><p class="text-xs text-gray-400 mt-2">Current image saved. Choose a new file to replace it.</p></c:if>
        </div>
        <div class="md:col-span-2">
            <label class="text-sm font-semibold text-gray-300 mb-2 block">Description</label>
            <textarea name="description" rows="3" class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10 resize-none" placeholder="Detailed product description...">${productToEdit.description}</textarea>
        </div>
        <div class="md:col-span-2 flex gap-3 pt-4">
          <button type="submit" class="flex-1 bg-white text-black font-bold uppercase py-4 rounded-xl hover:bg-gray-200 transition-colors">Save Product</button>
          <button type="button" onclick="closeModal('productModal')" class="flex-1 bg-white/10 text-white font-bold uppercase py-4 rounded-xl hover:bg-white/20 transition-colors">Cancel</button>
        </div>
      </form>
    </div>
  </div>
  
  <!-- View Modal -->
  <div id="viewProductModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
      <div class="bg-gray-900 rounded-2xl shadow-2xl w-full max-w-5xl mx-4 max-h-[90vh] overflow-hidden border border-white/10 flex flex-col">
        <c:if test="${not empty productToView}">
            <div class="flex items-center justify-between px-8 py-6 border-b border-white/10 bg-black/40 flex-shrink-0">
                <div class="flex items-center gap-4">
                    <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center"><i class="fas fa-box-open text-white text-xl"></i></div>
                    <div>
                        <h3 class="text-2xl font-black text-white uppercase tracking-wide font-bebas">Product Details</h3>
                        <p class="text-gray-400 text-sm">Complete product information</p>
                    </div>
                </div>
                <button onclick="closeModal('viewProductModal')" class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 transition-all flex items-center justify-center group"><i class="fas fa-times text-gray-400 group-hover:text-white transition-colors"></i></button>
            </div>

            <div class="overflow-y-auto p-8 space-y-6">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <div class="relative group">
                        <div class="aspect-square bg-black rounded-2xl overflow-hidden border border-white/20 shadow-2xl">
                            <img src="${not empty productToView.imageUrl ? productToView.imageUrl : 'https://placehold.co/600x600/000000/444?text=No+Image'}" 
                                 alt="${productToView.productName}" 
                                 class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" 
                                 onerror="this.src='https://placehold.co/600x600/000000/444?text=No+Image'">
                        </div>
                        <div class="absolute top-4 right-4">
                          <c:choose>
                              <c:when test="${productToView.quantity > 10}"><span class="px-4 py-2 rounded-lg text-xs font-bold bg-green-500/80 text-white backdrop-blur-sm shadow-lg uppercase tracking-wide"><i class="fas fa-check-circle mr-1"></i>In Stock</span></c:when>
                              <c:when test="${productToView.quantity > 0}"><span class="px-4 py-2 rounded-lg text-xs font-bold bg-yellow-500/80 text-black backdrop-blur-sm shadow-lg uppercase tracking-wide"><i class="fas fa-exclamation-triangle mr-1"></i>Low Stock</span></c:when>
                              <c:otherwise><span class="px-4 py-2 rounded-lg text-xs font-bold bg-red-500/80 text-white backdrop-blur-sm shadow-lg uppercase tracking-wide"><i class="fas fa-times-circle mr-1"></i>Out of Stock</span></c:otherwise>
                          </c:choose>
                        </div>
                    </div>
                    <div class="space-y-4 flex flex-col">
                        <div class="bg-white/5 rounded-xl p-6 border border-white/10">
                            <p class="text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">Product Name</p>
                            <h4 class="text-2xl font-black text-white mb-4 leading-tight">${productToView.productName}</h4>
                            <div class="grid grid-cols-2 gap-4 pt-4 border-t border-white/10">
                                <div>
                                    <p class="text-xs font-bold text-gray-500 uppercase tracking-wider mb-1">Price</p>
                                    <p class="text-3xl font-black text-white">${productToView.price}</p>
                                </div>
                                <div class="text-right">
                                    <p class="text-xs font-bold text-gray-500 uppercase tracking-wider mb-1">Stock</p>
                                    <p class="text-3xl font-black text-white">${productToView.quantity}</p>
                                    <p class="text-xs text-gray-600">units</p>
                                </div>
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div class="bg-white/5 rounded-xl p-4 border border-white/10"><div class="flex items-center gap-2 mb-2"><i class="fas fa-folder text-gray-400 text-sm"></i><p class="text-xs font-bold text-gray-500 uppercase tracking-wider">Category</p></div><p class="text-base font-bold text-white">${not empty productToView.categoryId ? productToView.categoryId : 'N/A'}</p></div>
                            <div class="bg-white/5 rounded-xl p-4 border border-white/10"><div class="flex items-center gap-2 mb-2"><i class="fas fa-venus-mars text-gray-400 text-sm"></i><p class="text-xs font-bold text-gray-500 uppercase tracking-wider">Gender</p></div><p class="text-base font-bold text-white">${not empty productToView.gender ? productToView.gender : 'N/A'}</p></div>
                        </div>
                        <div class="bg-white/5 rounded-xl p-4 border border-white/10"><div class="flex items-center gap-2 mb-2"><i class="fas fa-palette text-gray-400 text-sm"></i><p class="text-xs font-bold text-gray-500 uppercase tracking-wider">Available Colors</p></div><p class="text-base font-bold text-white">${not empty productToView.color ? productToView.color : 'Not specified'}</p></div>
                    </div>
                </div>

                <div class="bg-white/5 rounded-xl p-6 border border-white/10">
                    <div class="flex items-center gap-3 mb-4"><div class="w-9 h-9 bg-white/10 rounded-lg flex items-center justify-center"><i class="fas fa-align-left text-gray-300 text-sm"></i></div><h4 class="text-sm font-black text-white uppercase tracking-wide">Description</h4></div>
                    <p class="text-gray-400 leading-relaxed text-sm">${not empty productToView.description ? productToView.description : 'No description available for this product.'}</p>
                </div>
            </div>
        </c:if>
      </div>
  </div>

  <!-- Delete Modal -->
  <div id="deleteModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
    <div class="bg-gray-900 rounded-2xl shadow-2xl p-8 w-full max-w-md mx-4 border border-white/10">
      <div class="text-center">
        <div class="w-20 h-20 bg-red-500/20 rounded-full flex items-center justify-center mx-auto mb-5 border-4 border-red-500/30"><i class="fas fa-exclamation-triangle text-red-400 text-3xl"></i></div>
        <h3 class="text-white text-2xl font-black mb-3">Confirm Deletion</h3>
        <p class="text-gray-400 mb-6 leading-relaxed">Are you sure you want to delete the product<br/>"<span id="deleteProductName" class="text-white font-bold"></span>"?</p>
        <div class="flex gap-3">
          <button onclick="closeModal('deleteModal')" class="flex-1 bg-white/10 text-white font-bold py-3.5 rounded-xl hover:bg-white/20 transition-colors">Cancel</button>
          <form id="deleteForm" action="product" method="POST" class="flex-1">
             <input type="hidden" name="action" value="delete">
             <input type="hidden" id="deleteProductId" name="id">
             <button type="submit" class="w-full bg-red-500 text-white font-bold py-3.5 rounded-xl hover:bg-red-600 transition-colors"><i class="fas fa-trash mr-2"></i>Delete Product</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>

