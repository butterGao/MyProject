package com.sitemap.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class EXcelUtil {
	     //  定制日期格式
	     private   static  String DATE_FORMAT  =   " m/d/yy " ;  //  "m/d/yy h:mm"

	     //  定制浮点数格式
	     private   static  String NUMBER_FORMAT  =   " #,##0.00 " ;

	     private  String xlsFileName;

	     private  HSSFWorkbook workbook;

	     private  HSSFSheet sheet;

	     private  HSSFRow row;

	     /**
	     * 初始化Excel
	     * 
	     *  @param  fileName
	     *            导出文件名
	      */
	     public  EXcelUtil(String fileName)  {
	         this .xlsFileName  =  fileName;
	         this .workbook  =   new  HSSFWorkbook();
	    }
	     public void createSheet(String sheetName){
	    	 this .sheet  =  workbook.createSheet(sheetName);
	    	 sheet.autoSizeColumn(1,true);
	     }
	    
	     
	     /**
	     * 导出Excel文件
	     * 
	     *  @throws  XLSException
	      */
	     public   void  exportXLS()  {
	         try   {
	            FileOutputStream fOut  =   new  FileOutputStream(xlsFileName);
	            workbook.write(fOut);
	            fOut.flush();
	            fOut.close();
	        }   catch  (Exception e)  {
	        	e.printStackTrace();
	        }
	    }
	     
	     public   void  exportXLS(OutputStream o)  {
	         try   {
	            workbook.write(o);
	            o.flush();
	            o.close();
	        }   catch  (Exception e)  {
	        	e.printStackTrace();
	        }
	    }

	     /**
	     * 增加一行
	     * 
	     *  @param  index
	     *            行号
	      */
	     public   void  createRow( int  index)  {
	         this .row  =   this.sheet.createRow(index);
	    }

	     /**
	     * 设置单元格
	     * 
	     *  @param  index
	     *            列号
	     *  @param  value
	     *            单元格填充值
	      */
	     public   void  setCell( int  index, String value)  {
	        HSSFCell cell  =   this .row.createCell(( short ) index);
	        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	        cell.setCellValue(value);
	    }

	     /**
	     * 设置单元格
	     * 
	     *  @param  index
	     *            列号
	     *  @param  value
	     *            单元格填充值
	      */
	     public   void  setCell( int  index, Calendar value)  {
	        HSSFCell cell  =   this .row.createCell(( short ) index);
	        cell.setCellValue(value.getTime());
	        HSSFCellStyle cellStyle  =  workbook.createCellStyle();  //  建立新的cell样式
	        cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat(DATE_FORMAT));  //  设置cell样式为定制的日期格式
	        cell.setCellStyle(cellStyle);  //  设置该cell日期的显示格式
	    }

	     /**
	     * 设置单元格
	     * 
	     *  @param  index
	     *            列号
	     *  @param  value
	     *            单元格填充值
	      */
	     public   void  setCell( int  index,  int  value)  {
	        HSSFCell cell  =   this .row.createCell(( short ) index);
	        cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	        cell.setCellValue(value);
	    }

	     /**
	     * 设置单元格
	     * 
	     *  @param  index
	     *            列号
	     *  @param  value
	     *            单元格填充值
	      */
	     public   void  setCell( int  index,  double  value)  {
	        HSSFCell cell  =   this .row.createCell(( short ) index);
	        cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	        cell.setCellValue(value);
	        HSSFCellStyle cellStyle  =  workbook.createCellStyle();  //  建立新的cell样式
	        HSSFDataFormat format  =  workbook.createDataFormat();
	        cellStyle.setDataFormat(format.getFormat(NUMBER_FORMAT));  //  设置cell样式为定制的浮点数格式
	        cell.setCellStyle(cellStyle);  //  设置该cell浮点数的显示格式
	    }

	} 
