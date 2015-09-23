package core.embeddedAssets 
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Oleg Poluliashchenko
	 */
	public class EmbeddedAssets 
	{
		[Embed(source = "../../../assets/bubbles.png")]
		private static const BubblesAtlas:Class;
		
		[Embed(source = "../../../assets/bubbles.xml", mimeType = "application/octet-stream")]
		private static const BubblesXML:Class;
		
		[Embed(source = "../../../assets/animation/traceEffect/particle.pex", mimeType = "application/octet-stream")]
		public static const TraceEffectConfig:Class;
		
		[Embed(source = "../../../assets/animation/traceEffect/texture.png")]
		public static const TraceEffectTexture:Class;
		
		[Embed(source = "../../../assets/animation/collisionEffect/particle.pex", mimeType = "application/octet-stream")]
		public static const CollisonEffectConfig:Class;
		
		[Embed(source = "../../../assets/animation/collisionEffect/texture.png")]
		public static const CollisonEffectTexture:Class;
		
		public static const textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(BubblesAtlas), XML(new BubblesXML()));
		
		public static const URL_SETTINGS:String = "input.txt";
		
		public static const COUNT_POINTS:int = 20;
		
		public static const BORN_TIME:int = 500;
		
		public static const LIFE_TIME:int = 1000;
		
	}

}