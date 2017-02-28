package a24.tween.plugins.proxy
{
   import a24.tween.plugins.SocialPlugin;
   
   public class SocialPulginProxy
   {
       
      
      public function SocialPulginProxy()
      {
         super();
      }
      
      public function tweet(param1:String) : SocialPlugin
      {
         return SocialPlugin.tweet(param1);
      }
      
      public function tweetShare(param1:String, param2:String, param3:String = null) : SocialPlugin
      {
         return SocialPlugin.tweetShare(param1,param2,param3);
      }
      
      public function facebokShare(param1:String) : SocialPlugin
      {
         return SocialPlugin.facebokShare(param1);
      }
      
      public function mixiCheck(param1:String, param2:String) : SocialPlugin
      {
         return SocialPlugin.mixiCheck(param1,param2);
      }
   }
}
