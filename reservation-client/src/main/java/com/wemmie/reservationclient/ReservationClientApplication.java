package com.wemmie.reservationclient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.hateoas.Resources;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.Collection;
import java.util.stream.Collectors;

@SpringBootApplication
public class ReservationClientApplication {

	public static void main(String[] args) {
		SpringApplication.run(ReservationClientApplication.class, args);
	}

    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        return builder.build();
    }
}

@RestController
@RequestMapping("/reservations")
class ReservationApiGatewayRestController {

    @RequestMapping(method = RequestMethod.GET, value = "/names")
    public Collection<String> getReservationNames() {

        ParameterizedTypeReference<Resources<Reservation>> ptr =
                new ParameterizedTypeReference<Resources<Reservation>>() {};

        ResponseEntity<Resources<Reservation>> exchange = this.restTemplate.exchange("http://reservation-service/reservations",
                HttpMethod.GET,
                null,
                ptr);

        return exchange.getBody()
                .getContent()
                .stream()
                .map(Reservation::getReservationName)
                .collect(Collectors.toList());
    }



    @Autowired
    private RestTemplate restTemplate;
}



class Reservation {

    private Long id;
    private String reservationName;

    public Long getId() {
        return id;
    }

    public String getReservationName() {
        return reservationName;
    }
}