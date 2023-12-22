mutable_variable_checkbox_id="mutable variable checkbox"
track_variable_name_id="track variable name"
session_filename_id="session filename"
session_file_id="session file"
load_session_id="load session"

if (document.getElementById(mutable_variable_checkbox_id).checked)
{
	document.getElementById(mutable_variable_checkbox_id).checked = false
}

document.getElementById(mutable_variable_checkbox_id).addEventListener
(
	"click",
	(e) => 
	{
		track_variable_name = document.getElementById(track_variable_name_id)

		if (document.getElementById(mutable_variable_checkbox_id).checked)
		{
			track_variable_name.classList.remove("is-hidden")
		}
		
		else
		{
			track_variable_name.classList.remove("is-hidden")
			track_variable_name.classList.add("is-hidden")
		}
	}
)

document.getElementById(session_file_id).addEventListener
(
	'change', 
	function(e) 
	{
		if (e.target.files[0]) 
		{
			document.getElementById(session_filename_id).innerText = e.target.files[0].name
		}
	}
);

document.getElementById(load_session_id).addEventListener
(
	"click",
	function(e)
	{
		var fileObj = document.getElementById(session_file_id).files[0];
		var url =  "/download_file"; 

		var form = new FormData();
		form.append("file", fileObj);

		xhr = new XMLHttpRequest();
		xhr.open("post", url, true);

		xhr.send(form); 
	}
)