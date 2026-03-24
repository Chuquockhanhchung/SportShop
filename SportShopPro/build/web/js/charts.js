// Dashboard Charts Initialization
function initCharts() {
  // Check if Chart.js is loaded
  if (typeof Chart === "undefined") {
    console.error("Chart.js is not loaded yet");
    setTimeout(initCharts, 100);
    return;
  }

  const ordersCanvas = document.getElementById("ordersChart");
  const salesCanvas = document.getElementById("salesChart");

  if (!ordersCanvas || !salesCanvas) {
    console.warn("Chart canvases not found");
    return;
  }

  // Get data from backend (passed via window.dashboardData in JSP)
  const chartData = window.dashboardData;

  const ordersCtx = ordersCanvas.getContext("2d");
  const salesCtx = salesCanvas.getContext("2d");

  // Orders Line Chart
  new Chart(ordersCtx, {
    type: "line",
    data: {
      labels: chartData.ordersChart.labels,
      datasets: [
        {
          label: "Đơn hàng",
          data: chartData.ordersChart.data,
          borderColor: "#fff",
          backgroundColor: "rgba(255, 255, 255, 0.1)",
          tension: 0.4,
          fill: true,
          borderWidth: 3,
          pointRadius: 6,
          pointBackgroundColor: "#fff",
          pointBorderColor: "#1a1a1a",
          pointBorderWidth: 2,
          pointHoverRadius: 8,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: "#fff",
          padding: 12,
          titleColor: "#000",
          bodyColor: "#000",
          borderColor: "#ddd",
          borderWidth: 1,
          displayColors: false,
          callbacks: {
            label: function (context) {
              return "Đơn hàng: " + context.parsed.y;
            },
          },
        },
      },
      scales: {
        x: {
          ticks: {
            color: "#9CA3AF",
            font: { size: 11, weight: "500" },
          },
          grid: { display: false },
          border: { display: false },
        },
        y: {
          ticks: {
            color: "#9CA3AF",
            font: { size: 11, weight: "500" },
          },
          grid: {
            color: "rgba(255, 255, 255, 0.05)",
            drawBorder: false,
          },
          border: { display: false },
        },
      },
    },
  });

  // Sales Bar Chart
  new Chart(salesCtx, {
    type: "bar",
    data: {
      labels: chartData.salesChart.labels,
      datasets: [
        {
          label: "Sản phẩm đã bán",
          data: chartData.salesChart.data,
          backgroundColor: [
            "rgba(255, 255, 255, 0.9)",
            "rgba(255, 255, 255, 0.7)",
            "rgba(255, 255, 255, 0.5)",
            "rgba(255, 255, 255, 0.3)",
          ],
          borderRadius: 8,
          borderSkipped: false,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: "#fff",
          padding: 12,
          titleColor: "#000",
          bodyColor: "#000",
          borderColor: "#ddd",
          borderWidth: 1,
          displayColors: false,
          callbacks: {
            label: function (context) {
              return "Đã bán: " + context.parsed.y + " sản phẩm";
            },
          },
        },
      },
      scales: {
        x: {
          ticks: {
            color: "#9CA3AF",
            font: { size: 11, weight: "500" },
          },
          grid: { display: false },
          border: { display: false },
        },
        y: {
          ticks: {
            color: "#9CA3AF",
            font: { size: 11, weight: "500" },
          },
          grid: {
            color: "rgba(255, 255, 255, 0.05)",
            drawBorder: false,
          },
          border: { display: false },
        },
      },
    },
  });
}

// Initialize charts when document is ready
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initCharts);
} else {
  initCharts();
}