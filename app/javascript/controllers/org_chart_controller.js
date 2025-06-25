import { Controller } from "@hotwired/stimulus";
import $ from "jquery"; // Импортируйте jQuery
import "orgchart/dist/js/jquery.orgchart.min.js"; // Импортируйте OrgChart

export default class extends Controller {
  constructor() {
    super(); // Вызов конструктора родительского класса
    this.orgChartData = []; // Инициализация свойства для данных организационной диаграммы
  }

  connect() {
    console.log("🚀 OrgChart controller connected!");
    this.fetchOrgChartData();
  }

  async fetchOrgChartData() {
    try {
      const response = await fetch("/org_chart/get_org_chart");

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const text = await response.text();
      const orgChartData = this.parseResponseData(text); // Сохранение данных в свойство
      this.initializeOrgChart(orgChartData);
    } catch (error) {
      console.error("Error fetching org chart data:", error);
    }
  }

  parseResponseData(text) {
    const parsedData = JSON.parse(text);
    const header =
      typeof parsedData[0] === "string"
        ? parsedData[0].split(",")
        : parsedData[0];
    const data = parsedData.slice(1).map((row) => {
      const rowValues = typeof row === "string" ? row.split(",") : row;
      return header.reduce((obj, key, index) => {
        obj[key] = rowValues[index];
        return obj;
      }, {});
    });

    return data;
  }

  initializeOrgChart(orgChartData) {
    const orgChartConfig = {
      data: orgChartData,
      nodeContent: "title",
      nodeBinding: {
        field_0: "name",
        field_1: "title",
      },
    };

    console.log(orgChartConfig);
    console.log(this.element);

    $(this.element).orgchart(orgChartConfig, {
      createNode: (node, data) => ({
        id: data.id,
        name: data.name,
        title: data.title,
        pid: data.pid,
      }),
    });
  }
}
