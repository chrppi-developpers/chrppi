id_value_variable_semie_instancier_checkbox="mutable checkbox id"
id_value_variable_semie_instancier="mutable id"

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