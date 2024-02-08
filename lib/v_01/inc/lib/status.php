<?PHP

	//setStatusFor(<id>)->getKey('BKCNST')->setValue('BKCNSTGVER')->setNote('note')->whereCurrentStatusAs('BKCNSTCONF')->run();
		// run/go

class Status extends General{

	protected $status = ['key'	=>[	'ec_id'			=> '',
								   	'attr_code'		=> '',
								   	'new_status'	=> '',
								   	'curr_status'	=> '',
									'note'			=> '']
						]; // end of status

	protected $isDebug=0;

	function debugOn(){	$this->isDebug=1;}  // will prevent to run the query
	function debugOff(){ $this->isDebug=0;}

	function clearStatus(){

		foreach(array_keys($this->status['key']) as $sk=>$sv){
			$this->status['key'][$sk]='';
		}	

	} //end

	// set status
	function setStatus($k,$v){
		if(array_key_exists($k,$this->status['key'])==true){
			$this->status['key'][$k]=$v;
		}else{
			throw new Exception("$k is not a valid token");	
		}			
	} // set status

	function updateStatus($ec_id){

		$lv = (object) ['match_count'=>''];

		if(is_integer((int) $ec_id)!=1){
			throw new Exception("Needs an integer. Given input <b>$ec_id</b> is not a valid input");
		}else{

			$lv->match_count = $this->get_one_column(['table'=>'entity_child','field'=>"count(*)",
														'manipulation'=>" WHERE id=$ec_id "]);
			
			if($lv->match_count!=1){
				throw new Exception("The id <b>$ec_id</b> seems not a valid one for the context");	
			}else{
				$this->clearStatus(); 
				$this->setStatus('ec_id',$ec_id);
				return $this;
			}		

		} // end of condition check

	} // end of status_info
	
	
	function getKey($attr_code){
		$this->setStatus('attr_code',$attr_code);
		return $this;
	}

	function setValue($new_status){
		$this->setStatus('new_status',$new_status);
		return $this;
	}

	function setNote($note){
		$this->setStatus('note',$note);
		return $this;
	}

	function whereCurrentStatusAs($curr_status){
		$this->setStatus('curr_status',$curr_status);
		return $this;
	}

	function run(){

		$lv = (object) ['query'=>'','update_query'=>'','user_id'=>''];

		$status = (object) $this->status['key'];
		$lv->user_id=$this->getUserId();

		// insert status
		$lv->query 	=	"INSERT INTO 
									status_info(status_code,entity_code,child_comm_id,note,user_id)
								VALUES
									('$status->new_status',
										(SELECT entity_code FROM entity_child_base WHERE token='$status->attr_code'),
										$status->ec_id,
										'$status->note',
										$lv->user_id)";	

		if($this->isDebug==1){ echo "StatusInfoQuery:$lv->query"; }

		if($this->isDebug==0){
			$this->rdsql->exec_query($lv->query,'Status Query');
		}

		// update status
		$lv->update_query = "	UPDATE 
									exav_addon_exa_token
								SET 
									exa_value_token = '$status->new_status'
								WHERE 
									parent_id = $status->ec_id AND 
									exa_token='$status->attr_code' AND
									exa_value_token='$status->curr_status'";

		if($this->isDebug==1){ echo "StatusUpdateQuery:$lv->update_query"; }							

		if($this->isDebug==0){
			$this->rdsql->exec_query($lv->update_query,'Update Query');
		}

		return true;

	} // end

	

} // end of class

$S=new Status();

?>