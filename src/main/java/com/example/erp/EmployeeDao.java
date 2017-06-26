package com.example.erp;

import java.util.List;

public interface EmployeeDao {
	int getRowCount(SearchForm searchForm);
	
	List<Employee> getEmployees(SearchForm searchForm);
}
