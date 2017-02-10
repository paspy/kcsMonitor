using System;
using System.Linq;
using System.Collections.Generic;
using System.Net.Http.Headers;

namespace Paspy.kcsMonitor {
    public class Consts {

        public static readonly List<string> WorldServerAddr = new List<string>() {
               "203.104.209.71"  , // 横須賀鎮守府   
               "203.104.209.87"  , // 呉鎮守府        
               "125.6.184.16"    , // 佐世保鎮守府    
               "125.6.187.205"   , // 舞鶴鎮守府      
               "125.6.187.229"   , // 大湊警備府      
               "125.6.187.253"   , // トラック泊地    
               "125.6.188.25"    , // リンガ泊地      
               "203.104.248.135" , // ラバウル基地    
               "125.6.189.7"     , // ショートランド泊地
               "125.6.189.39"    , // ブイン基地
               "125.6.189.71"    , // タウイタウイ泊地 
               "125.6.189.103"   , // パラオ泊地
               "125.6.189.135"   , // ブルネイ泊地    
               "125.6.189.167"   , // 単冠湾泊地      
               "125.6.189.215"   , // 幌筵泊地        
               "125.6.189.247"   , // 宿毛湾泊地      
               "203.104.209.23"  , // 鹿屋基地        
               "203.104.209.39"  , // 岩川基地        
               "203.104.209.55"  , // 佐伯湾泊地      
               "203.104.209.102" , // 柱島泊地        
        };

        public static readonly List<string> WorldServerName = new List<string>() {
               "横須賀鎮守府",
               "呉鎮守府",
               "佐世保鎮守府",
               "舞鶴鎮守府",
               "大湊警備府",
               "トラック泊地",
               "リンガ泊地",
               "ラバウル基地",
               "ショートランド泊地",
               "ブイン基地",
               "タウイタウイ泊地",
               "パラオ泊地",
               "ブルネイ泊地",
               "単冠湾泊地",
               "幌筵泊地",
               "宿毛湾泊地",
               "鹿屋基地",
               "岩川基地",
               "佐伯湾泊地",
               "柱島泊地",
        };

        public const string api_start2 = "kcsapi/api_start2";

        public const string UserAgent = "Mozilla/5.0 (Android; U; zh-CN) AppleWebKit/533.19.4 (KHTML, like Gecko) AdobeAIR/21.0 rqxbjmdizgzp";
        public const string Referrer = "app:/AppMain.swf/[[DYNAMIC]]/1";

        public static readonly MediaTypeWithQualityHeaderValue[] Accepts = {
            new MediaTypeWithQualityHeaderValue("text/xml"),
            new MediaTypeWithQualityHeaderValue("application/xml"),
            new MediaTypeWithQualityHeaderValue("application/xhtml+xml"),
            new MediaTypeWithQualityHeaderValue("text/html",0.9),
            new MediaTypeWithQualityHeaderValue("text/plain",0.8),
            new MediaTypeWithQualityHeaderValue("text/css"),
            new MediaTypeWithQualityHeaderValue("image/png"),
            new MediaTypeWithQualityHeaderValue("image/jpeg"),
            new MediaTypeWithQualityHeaderValue("image/gif",0.8),
            new MediaTypeWithQualityHeaderValue("application/x-shockwave-flash"),
            new MediaTypeWithQualityHeaderValue("video/mp4",0.9),
            new MediaTypeWithQualityHeaderValue("flv-application/octet-stream",0.8),
            new MediaTypeWithQualityHeaderValue("video/x-flv",0.7),
            new MediaTypeWithQualityHeaderValue("audio/mp4"),
            new MediaTypeWithQualityHeaderValue("application/futuresplash"),
            new MediaTypeWithQualityHeaderValue("*/*",0.5),
        };

    }
}
