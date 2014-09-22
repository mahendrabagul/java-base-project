package com.neova.controller.export;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Footer;
import org.apache.poi.ss.usermodel.Header;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelReportView extends AbstractExcelView {

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// Set the headers
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Disposition",
				"attachment; filename=UserReport.xls");

		// get data model which is passed by the Spring container
		List<UserReportDetails> userList = (List<UserReportDetails>) model
				.get("userList");

		// create a new Excel sheet
		HSSFSheet sheet = workbook.createSheet("User List");
		sheet.setDefaultColumnWidth(20);

		Footer footer = sheet.getFooter();
		footer.setRight("Neova Solutions");
		Header header1 = sheet.getHeader();
		header1.setCenter("User Report");

		// Style to Make Titles Bold
		HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		HSSFCellStyle style1 = workbook.createCellStyle();
		style1.setFont(font);

		// create header row
		HSSFRow header = sheet.createRow(0);

		header.createCell(0).setCellValue("User Name");
		header.getCell(0).setCellStyle(style1);

		header.createCell(1).setCellValue("First Name");
		header.getCell(1).setCellStyle(style1);

		header.createCell(2).setCellValue("Last Name");
		header.getCell(2).setCellStyle(style1);

		header.createCell(3).setCellValue("Email");
		header.getCell(3).setCellStyle(style1);

		// create data rows
		int rowCount = 1;
		for (UserReportDetails user : userList) {
			HSSFRow aRow = sheet.createRow(rowCount++);
			aRow.createCell(0).setCellValue(user.getUserName());
			aRow.createCell(1).setCellValue(user.getFirstName());
			aRow.createCell(2).setCellValue(user.getLastName());
			aRow.createCell(3).setCellValue(user.getEmail());
		}

		// try (OutputStream outStream = response.getOutputStream()) {
		// workbook.write(outStream);
		// outStream.flush();
		// } catch (Exception e) {
		// System.out.println("Exception Occurred...");
		// }

	}

}