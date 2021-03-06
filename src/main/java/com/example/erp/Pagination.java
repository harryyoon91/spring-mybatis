package com.example.erp;

public class Pagination {
	private int pagesPerBlock = 5;	
	private int rowsPerPage = 10;	
	private int totalRows;			
	private int currentPage;		
	
	public Pagination(int currentPage, int totalRows) {
		this.currentPage = currentPage;
		this.totalRows = totalRows;
	}
	
	public Pagination(int rowsPerPage, int currentPage, int totalRows) {
		this.rowsPerPage = rowsPerPage;
		this.currentPage = currentPage;
		this.totalRows = totalRows;
	}
	
	public int getTotalPages() {
		return (int)Math.ceil((double)totalRows/rowsPerPage);
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	
	public int getBeginIndex() {
		return ((currentPage - 1) * rowsPerPage) + 1;
	}
	
	public int getEndIndex() {
		return currentPage * rowsPerPage;
	}
	
	public int getTotalBlocks() {
		return (int) Math.ceil((double)getTotalPages()/pagesPerBlock);
	}
	
	public int getCurrentBlock() {
		return (int) Math.ceil((double)currentPage/pagesPerBlock);
	}
	
	public int getBeginPage() {
		return (getCurrentBlock() - 1) * pagesPerBlock + 1;
	}
	
	public int getEndPage() {
		int endPage = getCurrentBlock() * pagesPerBlock;
		if (getCurrentBlock() == getTotalBlocks()) {
			endPage = getTotalPages();
		}
		return endPage;
	}
	public int getPrevBlock() {
		return (getCurrentBlock()-1) * pagesPerBlock;
	}
	
	public int getNextBlock() {
		return getCurrentBlock() * pagesPerBlock + 1;
	}
}
