package com.web.webSample.Controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 영화 좌석 예매 좌석 관련 Controller
 */

@Controller
@RequestMapping("/seat")
public class SeatController {
	
	private static final Logger logger = LoggerFactory.getLogger(SeatController.class);
	
	/**
	 * 
	 */
	@RequestMapping(value = "/seat", method = RequestMethod.GET)
	public String seat(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "seat/seat";
	}
	
	/**
	 * 
	 */
	@RequestMapping(value = "/seatList", method = RequestMethod.GET)
	public String seatList(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "seat/seatList";
	}
	
	/**
	 * 
	 */
	@RequestMapping(value = "/seatView", method = RequestMethod.GET)
	public String seatView(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "seat/seatView";
	}
	
}
