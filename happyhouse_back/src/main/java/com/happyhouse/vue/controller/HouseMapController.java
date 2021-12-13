package com.happyhouse.vue.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.happyhouse.vue.model.HouseDealDto;
import com.happyhouse.vue.model.HouseInfoDto;
import com.happyhouse.vue.model.SidoGugunCodeDto;
import com.happyhouse.vue.model.service.HouseMapService;
import com.happyhouse.vue.model.service.UserService;
import io.swagger.annotations.ApiOperation;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/map")
public class HouseMapController {
    
    private static final Logger logger = LoggerFactory.getLogger(QnARestController.class);
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";

    @Autowired
    private HouseMapService houseMapService;

    @Autowired
    private UserService userService;

    @ApiOperation(value = "DB에서 시도 정보 반환", response = List.class)
    @GetMapping("/sido")
    public ResponseEntity<List<SidoGugunCodeDto>> sido() throws Exception {
        logger.debug("sido - 호출");
        return new ResponseEntity<>(houseMapService.getSido(), HttpStatus.OK);
    }

    @ApiOperation(value = "DB에서 시구군 정보 반환", response = List.class)
    @GetMapping("/gugun/{sido}")
    public ResponseEntity<List<SidoGugunCodeDto>> gugun(@PathVariable String sido) throws Exception {
        logger.debug("gugun - 호출");
        return new ResponseEntity<>(houseMapService.getGugunInSido(sido), HttpStatus.OK);
    }

    @ApiOperation(value = "DB에서 법정동 정보 반환", response = List.class)
    @GetMapping("/dong/{gugun}")
    public ResponseEntity<List<HouseInfoDto>> dong(@PathVariable String gugun) throws Exception {
        logger.debug("dong - 호출");
        return new ResponseEntity<>(houseMapService.getDongInGugun(gugun), HttpStatus.OK);
    }

    @ApiOperation(value = "DB에서 아파트 정보 반환", notes="지도에서 보이는 범위 정보를 가져와 범위 내의 아파트를 불러옴", response = List.class)
    @PostMapping("/apt")
    public ResponseEntity<List<HouseInfoDto>> apt(@RequestBody Map<String, String> bounds) throws Exception {
        logger.debug("apt - 호출");
        return new ResponseEntity<>(houseMapService.getAptInDong(bounds), HttpStatus.OK);
    }

    @ApiOperation(value = "공공데이터에서 아파트 거래 정보 불러와 반환", notes="동 이름과 아파트 이름을 필요로 합니다. 현재를 기준으로 6개월의 거래 정보를 반환합니다.", response = List.class)
    @PostMapping("/deal")
    public ResponseEntity<List<HouseDealDto>> deal(@RequestBody HouseInfoDto houseInfo) throws Exception {
        logger.debug("deal - 호출");
        return new ResponseEntity<>(houseMapService.getHouseDeal(houseInfo), HttpStatus.OK);
    }
    
    @ApiOperation(value = "법정동코드에 해당하는 위경도를 불러와 반환", response = List.class)
    @GetMapping("/latlng/{dongcode}")
    public ResponseEntity<Map<String, Double>> getBaseLatLng(@PathVariable("dongcode") String dongCode) throws Exception {
        logger.debug("getBaseLatLng - 호출");
        Map<String, String> map = houseMapService.getBaseLatLng(dongCode);
        Map<String, Double> result = new HashMap<String, Double>();
        if (map != null) {
            result.put("lat", Double.parseDouble(map.get("lat")));
            result.put("lng", Double.parseDouble(map.get("lng")));
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @ApiOperation(value = "아파트 조회 시 1씩 카운트", notes = "'success' 또는 'fail' 문자열 반환", response = String.class)
    @GetMapping("/visited/{aptCode}")
    public ResponseEntity<String> countVisited(@PathVariable("aptCode") int aptCode) throws Exception {
        logger.debug("countVisited - 호출");
        if (houseMapService.countVisited(aptCode)) {
            return new ResponseEntity<>(SUCCESS, HttpStatus.OK);            
        };
        return new ResponseEntity<>(FAIL, HttpStatus.OK);
    }
    
    @ApiOperation(value = "조회수가 높은 10개의 아파트 반환", response = List.class)
    @GetMapping("/visited")
    public ResponseEntity<List<HouseInfoDto>> getMostVisited() throws Exception {
        logger.debug("getMostVisited - 호출");
        return new ResponseEntity<>(houseMapService.getMostVisited(), HttpStatus.OK);
    }
    
}
