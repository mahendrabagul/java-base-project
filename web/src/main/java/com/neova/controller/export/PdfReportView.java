package com.neova.controller.export;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

@SuppressWarnings("unchecked")
public class PdfReportView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model,
			Document document, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// Set the headers
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Disposition",
				"attachment; filename=UserReport.pdf");
		List<UserReportDetails> userList = (List<UserReportDetails>) model
				.get("userList");

		PdfPTable table = new PdfPTable(4);

		table.setHorizontalAlignment(Element.ALIGN_CENTER);

		Paragraph paragraph = new Paragraph("User List");
		paragraph.setAlignment(Element.ALIGN_CENTER);
		paragraph.setSpacingAfter(4);
		document.add(paragraph);

		//

		Phrase phrase = new Phrase("UserName");
		PdfPCell c1 = new PdfPCell(phrase);
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
		phrase.getFont().setStyle(Font.BOLD);

		phrase = new Phrase("FirstName");
		c1 = new PdfPCell(phrase);
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
		phrase.getFont().setStyle(Font.BOLD);

		phrase = new Phrase("LastName");
		c1 = new PdfPCell(phrase);
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
		phrase.getFont().setStyle(Font.BOLD);

		phrase = new Phrase("Email");
		c1 = new PdfPCell(phrase);
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
		phrase.getFont().setStyle(Font.BOLD);

		table.setHeaderRows(1);

		// create data rows
		for (UserReportDetails user : userList) {

			table.addCell(user.getUserName());
			table.addCell(user.getFirstName());
			table.addCell(user.getLastName());
			table.addCell(user.getEmail());

		}
		document.add(table);
		document.addTitle("User List");

		// try (OutputStream outStream = response.getOutputStream()) {
		// workbook.write(outStream);
		// outStream.flush();
		// } catch (Exception e) {
		// System.out.println("Exception Occurred...");
		// }

	}
}