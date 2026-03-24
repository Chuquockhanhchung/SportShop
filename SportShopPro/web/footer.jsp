<footer class="bg-gradient-to-b from-gray-900 to-black text-white">
  <div class="max-w-7xl mx-auto px-8 py-12">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">

      <div>
        <a href="#" class="font-bebas text-4xl font-black uppercase tracking-wider mb-6 inline-block">
          SPORT ZONE
        </a>
        <p class="text-gray-400 font-inter text-sm mb-6 leading-relaxed">
          ${footerSettings.description}
        </p>
        <div class="flex gap-4">
          <c:forEach var="l" items="${footerSocialLinks}">
            <a href="${l.url}" class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-white hover:text-black transition-all duration-300">
              <i class="${l.icon}"></i>
            </a>
          </c:forEach>
        </div>
      </div>

      <div>
        <h3 class="font-bebas text-2xl uppercase tracking-wide mb-6 text-white">Quick Links</h3>
        <ul class="space-y-3">
          <c:forEach var="l" items="${footerQuickLinks}">
            <li><a href="${l.url}" class="text-gray-400 text-sm hover:text-white">${l.label}</a></li>
          </c:forEach>
        </ul>
      </div>

      <div>
        <h3 class="font-bebas text-2xl uppercase tracking-wide mb-6 text-white">Customer Service</h3>
        <ul class="space-y-3">
          <c:forEach var="l" items="${footerServiceLinks}">
            <li><a href="${l.url}" class="text-gray-400 text-sm hover:text-white">${l.label}</a></li>
          </c:forEach>
        </ul>
      </div>

      <div>
        <h3 class="font-bebas text-2xl uppercase tracking-wide mb-6 text-white">Get In Touch</h3>
        <ul class="space-y-4">
          <li class="flex items-start gap-3"><i class="fas fa-map-marker-alt text-white mt-1"></i><span class="text-gray-400 text-sm">${footerSettings.address}</span></li>
          <li class="flex items-center gap-3"><i class="fas fa-phone text-white"></i><span class="text-gray-400 text-sm">${footerSettings.phone}</span></li>
          <li class="flex items-center gap-3"><i class="fas fa-envelope text-white"></i><span class="text-gray-400 text-sm">${footerSettings.email}</span></li>
          <li class="flex items-center gap-3"><i class="fas fa-clock text-white"></i><span class="text-gray-400 text-sm">${footerSettings.hours}</span></li>
        </ul>
      </div>
    </div>

    <div class="h-[1px] bg-gradient-to-r from-transparent via-white/20 to-transparent mb-8"></div>

    <div class="flex flex-col md:flex-row justify-between items-center gap-4">
      <p class="text-gray-500 text-sm text-center md:text-left">${footerSettings.copyright}</p>
      <div class="flex gap-6">
        <a href="#" class="text-gray-500 text-sm hover:text-white">Privacy Policy</a>
        <a href="#" class="text-gray-500 text-sm hover:text-white">Terms of Service</a>
        <a href="#" class="text-gray-500 text-sm hover:text-white">Cookie Policy</a>
      </div>
    </div>
  </div>
</footer>