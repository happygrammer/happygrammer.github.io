---
title: "Rest 컨트롤러"
date: 2020-03-01T20:51:40+03:00
draft: true
---

Rest 컨트롤러





- @SpringBootApplication : 





```
@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/rest").allowedOrigins("http://localhost:4200");
				registry.addMapping("/get/intent").allowedOrigins("http://localhost:4200");
			}
		};
	}
```

