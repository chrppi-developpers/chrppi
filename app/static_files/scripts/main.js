id_value_variable_semie_instancier_checkbox="mutable checkbox id"
id_value_variable_semie_instancier="mutable id"
id_session_filename="id session filename"
name_file_session="name file session"
id_session_file="id session file"
id_load_session="id load session"
if(document.getElementById(id_value_variable_semie_instancier_checkbox).checked)
{
    document.getElementById(id_value_variable_semie_instancier_checkbox).checked=false
}
document.getElementById(id_value_variable_semie_instancier_checkbox).addEventListener("click",(e)=>{
    
    variable_semie_instancier=document.getElementById(id_value_variable_semie_instancier)
    if(document.getElementById(id_value_variable_semie_instancier_checkbox).checked)
    {
        variable_semie_instancier.classList.remove("is-hidden")
    }else{
        variable_semie_instancier.classList.remove("is-hidden")
        variable_semie_instancier.classList.add("is-hidden")
    }
})

  document.getElementById(id_session_file).addEventListener('change', function(e) {
    if (e.target.files[0]) {
        //document.getElementById(id_session_filename).TEXT_NODE//=e.target.files[0].name
        document.getElementById(id_session_filename).innerText=e.target.files[0].name

    }
  });

  document.getElementById(id_load_session).addEventListener("click",function(e){
    const
	form = new FormData();
    console.log(document.getElementById(id_session_file).files[0]);
    form.append("file",document.getElementById(id_session_file).files[0] );
    fetch("", {
	method: "POST",
	body: form,
	headers: {
		"Content-Type": "multipart/form-data",
	},
    });
  })

  