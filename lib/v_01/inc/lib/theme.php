<?PHP

 class Theme{
		
	private $master	   	= [];
	private $config		= ['blend'=>'','path'=>'','theme'=>''];
							
	private $theme	   	= ['blend'=>'',	'gate'	=> '', 'menu'=>'', 'route'=>''];
						 

	// master
	public function __construct($master){
		$this->masterAA = $master;
		$this->master =(object) $master;	
		$this->config=(object) $this->config;	
		$this->theme=(object) $this->theme;		
	}	

	public function setTheme($param){

		// set config
		$this->config->theme 	= $param['theme'];
		$this->config->blend 	= $param['blend'];
		$this->config->path 	= $param['path'];

		// set theme route
		$this->theme->route = $this->config->path.'/'.( $this->master->theme ?? $this->config->theme);
		$this->theme->blend = ( $this->master->theme_blend ?? $this->config->blend);
		$this->theme->gate  = $this->setThemeBlend('gate');
		$this->theme->menu  = $this->setThemeBlend('menu');
	}

	public function getThemeRoute(){
		return $this->theme->route;
	}

	public function setThemeBlend($page){
		return  $this->theme->route.'/'.((@$this->masterAA["theme_blend_has_$page"])?'blend/'.$this->theme->blend.'/':'').'template/';
	}

	public function getThemeBlendMenu(){return  $this->theme->menu;}
	public function getThemeBlendGate(){return  $this->theme->gate;}
	
 
} // end of theme

?>
