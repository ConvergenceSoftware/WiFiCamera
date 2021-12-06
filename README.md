## WiFiCamera
---- 
>  iOS SDK and Demo for devices designed by Convergence Ltd.
## 🔨 Requirements
- iOS 10+

## Add the code to your project in the following two ways

### 1.WiFiCamera is available through [CocoaPods](https://cocoapods.org). add the following line to your Podfile:
```objc
pod 'WiFiCamera'
``` 
### 2.Clone Code 
> Add the code under the CVGC folder to the project.
```objc
#import "CameraBuffer.h"
```
## Example

- Must be connected  **WiFiBox** or **Planet**  device. 

```objc
#import "CameraBuffer.h"
```

- Image data connection.
```objc
//1.CameraBuffer delegate
[CameraBuffer shareInstance].delegate = self;
//2.Start data flow task
[[CameraBuffer shareInstance] startWiFiBox];

```
- Required to achieve
```objc
/// FPS
/// @param cameraFPS FPS
- (void)cameraFPS:(NSInteger)cameraFPS;

/// Picture per frame
/// @param image image
- (void)cameraBufferImage:(UIImage *)image;

/// disconnection
- (void)disconnection;

```
## Lens parameter setting

>  Request to set/get lens parameters through the network.
 
 ```objc

/**
Get lens parameters:
http://192.168.8.10:8080/input.json
 
{
    "controls": [
        {
            "name": "Brightness",
            "id": "9963776",
            "type": "1",
            "min": "-128",
            "max": "127",
            "step": "1",
            "default": "0",
            "value": "10",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "Contrast",
            "id": "9963777",
            "type": "1",
            "min": "0",
            "max": "127",
            "step": "1",
            "default": "38",
            "value": "38",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "Saturation",
            "id": "9963778",
            "type": "1",
            "min": "0",
            "max": "255",
            "step": "1",
            "default": "55",
            "value": "55",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "White Balance Temperature, Auto",
            "id": "9963788",
            "type": "2",
            "min": "0",
            "max": "1",
            "step": "1",
            "default": "1",
            "value": "1",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "Gamma",
            "id": "9963792",
            "type": "1",
            "min": "100",
            "max": "300",
            "step": "1",
            "default": "120",
            "value": "120",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "Gain",
            "id": "9963795",
            "type": "1",
            "min": "0",
            "max": "255",
            "step": "1",
            "default": "0",
            "value": "0",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "Power Line Frequency",
            "id": "9963800",
            "type": "3",
            "min": "0",
            "max": "2",
            "step": "1",
            "default": "1",
            "value": "1",
            "dest": "0",
            "flags": "0",
            "group": "1",
            "menu": {}
        },
        {
            "name": "White Balance Temperature",
            "id": "9963802",
            "type": "1",
            "min": "2800",
            "max": "6500",
            "step": "1",
            "default": "4600",
            "value": "4600",
            "dest": "0",
            "flags": "16",
            "group": "1"
        },
        {
            "name": "Backlight Compensation",
            "id": "9963804",
            "type": "1",
            "min": "0",
            "max": "1",
            "step": "1",
            "default": "0",
            "value": "0",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "Exposure, Auto",
            "id": "10094849",
            "type": "3",
            "min": "0",
            "max": "3",
            "step": "1",
            "default": "3",
            "value": "3",
            "dest": "0",
            "flags": "0",
            "group": "1",
            "menu": {}
        },
        {
            "name": "Exposure (Absolute)",
            "id": "10094850",
            "type": "1",
            "min": "3",
            "max": "32768",
            "step": "1",
            "default": "256",
            "value": "256",
            "dest": "0",
            "flags": "16",
            "group": "1"
        },
        {
            "name": "Focus (absolute)",
            "id": "10094858",
            "type": "1",
            "min": "0",
            "max": "255",
            "step": "1",
            "default": "0",
            "value": "0",
            "dest": "0",
            "flags": "16",
            "group": "1"
        },
        {
            "name": "Focus, Auto",
            "id": "10094860",
            "type": "2",
            "min": "0",
            "max": "1",
            "step": "1",
            "default": "0",
            "value": "1",
            "dest": "0",
            "flags": "0",
            "group": "1"
        },
        {
            "name": "JPEG quality",
            "id": "1",
            "type": "1",
            "min": "0",
            "max": "100",
            "step": "1",
            "default": "50",
            "value": "0",
            "dest": "0",
            "flags": "0",
            "group": "3"
        }
    ],
    "formats": [
        {
            "id": "0",
            "name": "MJPEG",
            "compressed": "true",
            "emulated": "false",
            "current": "true",
            "resolutions": {
                "0": "640x480",
                "1": "3840x2160",
                "2": "2592x1944",
                "3": "2688x1512",
                "4": "2048x1536",
                "5": "1920x1080",
                "6": "1600x1200",
                "7": "1280x960",
                "8": "1280x720",
                "9": "960x540",
                "10": "800x600",
                "11": "640x360"
            },
            "currentResolution": "8"
        },
        {
            "id": "1",
            "name": "YUV 4:2:2 (YUYV)",
            "compressed": "false",
            "emulated": "false",
            "current": "true",
            "resolutions": {
                "0": "640x480",
                "1": "3840x2160",
                "2": "2592x1944",
                "3": "2688x1512",
                "4": "2048x1536",
                "5": "1920x1080",
                "6": "1600x1200",
                "7": "1280x960",
                "8": "1280x720",
                "9": "960x540",
                "10": "800x600",
                "11": "640x360"
            },
            "currentResolution": "8"
        },
        {
            "id": "2",
            "name": "RGB3",
            "compressed": "false",
            "emulated": "true",
            "current": "true",
            "resolutions": {
                "0": "640x480",
                "1": "3840x2160",
                "2": "2592x1944",
                "3": "2688x1512",
                "4": "2048x1536",
                "5": "1920x1080",
                "6": "1600x1200",
                "7": "1280x960",
                "8": "1280x720",
                "9": "960x540",
                "10": "800x600",
                "11": "640x360"
            },
            "currentResolution": "8"
        },
        {
            "id": "3",
            "name": "BGR3",
            "compressed": "false",
            "emulated": "true",
            "current": "true",
            "resolutions": {
                "0": "640x480",
                "1": "3840x2160",
                "2": "2592x1944",
                "3": "2688x1512",
                "4": "2048x1536",
                "5": "1920x1080",
                "6": "1600x1200",
                "7": "1280x960",
                "8": "1280x720",
                "9": "960x540",
                "10": "800x600",
                "11": "640x360"
            },
            "currentResolution": "8"
        },
        {
            "id": "4",
            "name": "YU12",
            "compressed": "false",
            "emulated": "true",
            "current": "true",
            "resolutions": {
                "0": "640x480",
                "1": "3840x2160",
                "2": "2592x1944",
                "3": "2688x1512",
                "4": "2048x1536",
                "5": "1920x1080",
                "6": "1600x1200",
                "7": "1280x960",
                "8": "1280x720",
                "9": "960x540",
                "10": "800x600",
                "11": "640x360"
            },
            "currentResolution": "8"
        },
        {
            "id": "5",
            "name": "YV12",
            "compressed": "false",
            "emulated": "true",
            "current": "true",
            "resolutions": {
                "0": "640x480",
                "1": "3840x2160",
                "2": "2592x1944",
                "3": "2688x1512",
                "4": "2048x1536",
                "5": "1920x1080",
                "6": "1600x1200",
                "7": "1280x960",
                "8": "1280x720",
                "9": "960x540",
                "10": "800x600",
                "11": "640x360"
            },
            "currentResolution": "8"
        }
    ]
}
 
*/ 

 ```
> Example of setting lens resolution: value0~11;
> 
> http://192.168.8.10:8080/?action=command&dest=0plugin=0&id=0&group=2&value=0
> 
> The specific value corresponds to the resolution refer to input.json "resolutions"

## Planet Rotatement Control

Planet rotatement is controlled through the following interface:

Communication protocol:HTTP

Request URL:http://192.168.8.10:8092 

Request Method:GET

Request Parameter:
|Parameter|Explanation|Value Type|Value|
| :------------: | :------------ | :------------: |:------------ |
|**id**|Motor id|int|0-Spin<br>1-Pitch|
|**controlType**|Control type|int|0-Stop<br>1-Clockwise<br>2-Counterclockwise<br>3-Reset the position|
|**time**|Time|int|>=0 unit(milliseconds)|
|**mode**|Motor rotate mode|int|0-Specified speed<br>1-Specified time and speed|
|**speed**|Motor speed, not the angular velocity①|int|>=400<br><=2000|
|**subDivision**|Motor subdivision|int|2<br>4<br>8<br>16|
|**returnTrip**|Whether to eliminate the return error|int|0-Not eliminate the return error<br>1-Eliminate the return error|
|**returnTripTime**|Eliminate return error time|int|>=0 unit(milliseconds)|

①The rotate angular velocity of the motor is determined by two parameter: “speed” and “subDivision”. The theoretical angular velocity of motor 0 is equal to 3,662.109375/(speed\*subDivision), and the theoretical angular velocity of motor 1 is equal to 1,831.0546875/(speed\*subDivision).

Return Result:
|Parameter|Explanation|Value Type|Value|
| :------------: | :------------ | :------------: |:------------ |
|**id**|Motor id|int|0-Spin<br>1-Pitch|
location**|The location of the motor|double|Motor 0:0-360<br>Motor 1:30-150|
|**posLimit**|Motor position limit|int|0-Not in the positivie limit<br>1-In the positive limit|
|**negLimit**|Motor negetive limit|int|0-Not in the negetive limit<br>1-In the negetive limit|
|**resetFlag**|Is the motor in the reset position|int|0-In the reset position<br>1-Not in the reset position|
|**result**|Return result|int|1000-ok<br>1001-The motor isn't initialized<br>1002-The motor is running<br>1003-The motor has already stopped<br>1004-The motor is resetting the position|

> Example:
> 
> http://192.168.8.10:8092?id=0&controlType=3&time=0&id=0&mode=0&speed=2&subDivision=400&returnTrip=0&returnTripTime=0

### For more information, please refer to Demo

## Contact us
> **✉️ :** software@cvgc.cn 
> 
> **Official website:**
>
> [cvgc](http://www.cvgc.cn)
>
>  [tipscope](http://www.tipscope.com)
>
> [tinyscope](https://www.tinyscope.com)
 
