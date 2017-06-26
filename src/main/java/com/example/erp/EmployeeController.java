package com.example.erp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeDao employeeDao;
	
	@Autowired
	MappingJackson2JsonView jsonView;
	
	@RequestMapping("/search.json")
	public @ResponseBody Result<Employee> search(SearchForm searchForm) {
		int rows = employeeDao.getRowCount(searchForm);
		
		Pagination pagination = null;
		if (searchForm.getDisplay() != 0) {
			pagination = new Pagination(searchForm.getDisplay(), searchForm.getPageNo(), rows);
		} else {
			pagination = new Pagination(5, searchForm.getPageNo(), rows);
		}
		searchForm.setBginIndex(pagination.getBeginIndex());
		searchForm.setEndIndex(pagination.getEndIndex());
		
		List<Employee> employeeList = employeeDao.getEmployees(searchForm);
		
		Result<Employee> result = new Result<Employee>();
		result.setData(employeeList);
		result.setRows(rows);
		result.setCode(1);
		
		return result;
	}
	
	@RequestMapping("/search.do")
	public String search(SearchForm searchForm, Model model) {
		int rows = employeeDao.getRowCount(searchForm);
		
		Pagination pagination = null;
		if (searchForm.getDisplay() != 0) {
			pagination = new Pagination(searchForm.getDisplay(), searchForm.getPageNo(), rows);
		} else {
			pagination = new Pagination(5, searchForm.getPageNo(), rows);
		}
		searchForm.setBginIndex(pagination.getBeginIndex());
		searchForm.setEndIndex(pagination.getEndIndex());
		
		List<Employee> employees = employeeDao.getEmployees(searchForm);
		
		model.addAttribute("employees", employees);
		model.addAttribute("pagination", pagination);
		model.addAttribute("search", searchForm);
		
		return "search";
	}
}
