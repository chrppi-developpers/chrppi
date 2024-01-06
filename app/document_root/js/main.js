// Path
const upload_session_path = 'upload_session';

// Error
const section_error_hidden = 'section error hidden';
const error_id = 'error';

// Load an example
const select_example = 'select example';
const disable_option = 'disable option';
const chr_examples = 'chr examples';

// Compile chr code
const compile = 'compile';

// CHR code
const chr_code = 'chr code';

// Download/upload session
const download_session = 'download session';
const upload_session = 'upload session';

// Add Constraint 
const add_constraint_value = 'add constraint value';
const add_constraint = 'add constraint';

// Add variable
const add_variable = 'add variable';
const variable_mutable = 'variable mutable';
const variable_name = 'variable name';
const field_variable = 'field variable';
const variable_value = 'variable value';
const variable_type = 'variable type';

// Constraint Store
const constraint_store = 'constraint store';
const tbody_id = 'tbody id';
const remove_constraint = 'remove constraint';
const clear_constraint_store = 'clear constraint store';

// Variables
const variables = 'variables'; 
const tbody_id_variable = 'tbody id variable';
const remove_variable = 'remove variable';
const clear_variables = 'clear variables';

// Ajax request
const ajax_request = 'ajax request';

// Onload
document.getElementById(section_error_hidden).classList.remove('is-hidden');
document.getElementById(section_error_hidden).classList.add('is-hidden');
if (document.getElementById(variable_mutable).checked)
	document.getElementById(field_variable).classList.remove('is-hidden');
else
{
	document.getElementById(field_variable).classList.remove('is-hidden');
	document.getElementById(field_variable).classList.add('is-hidden');
}

let tbody = document.getElementById(tbody_id);
while (tbody.firstChild)
	tbody.removeChild(tbody.firstChild);

let tbodyVariable = document.getElementById(tbody_id_variable);
while (tbodyVariable.firstChild) 
	tbodyVariable.removeChild(tbodyVariable.firstChild);

function downloadTextFile(text, fileName) 
{
	// Create a Blob containing the text
	const blob = new Blob([text], { type: 'text/plain' });
  
	// Create a temporary link element
	const link = document.createElement('a');
	link.href = URL.createObjectURL(blob);
	link.setAttribute('download', fileName);
  
	// Append the link to the body
	document.body.appendChild(link);
  
	// Trigger a click event on the link
	link.click();
  
	// Clean up: remove the link and the created object URL
	document.body.removeChild(link);
	URL.revokeObjectURL(link.href);
}

function send(data, method='Post', url='/', download_file=false, replace=false) 
{
	// Set cursor style to wait until getting response
	document.body.style.cursor = 'wait';

	// Create XHR request
	const XHR = new XMLHttpRequest();	
	XHR.onload = function()
	{
		// Reset cursor style to default
		document.body.style.cursor = 'default';

		if (XHR.status >= 200 && XHR.status < 300) 
		{
			if (download_file)
				downloadTextFile(XHR.responseText, 'session.json');

			if (replace)
			{
				document.open();
				document.write(XHR.responseText);
				document.close();
			}

			// Process Ajax
			else
			{
				let Json = JSON.parse(XHR.response);
				document.getElementById(section_error_hidden).classList.remove('is-hidden');
				document.getElementById(section_error_hidden).classList.add('is-hidden');
				if (Json[chr_code])
					document.getElementById(chr_code).value = Json[chr_code];
				if (Json[error_id])
				{
					let error = document.getElementById(error_id);
					while (error.firstChild)
						error.removeChild(error.firstChild);
			
					document.getElementById(section_error_hidden).classList.remove('is-hidden');
					
					for (text of Json[error_id])
					{
						let li = document.createElement('li');
						li.setAttribute('class', 'subtitle');
						li.innerText = text;
						error.appendChild(li);
					}
				}
			
				if (Json[chr_examples])
				{
					let example = document.getElementById(select_example);
					while (example.childNodes.length != 2)
						example.removeChild(example.lastChild);
					document.getElementById(disable_option).disabled = false;
					example.selectedIndex = 0;
					document.getElementById(disable_option).disabled = true;
					for (text of Json[chr_examples])
					{
						let option=document.createElement('option');
						option.setAttribute('value', text);
						option.innerText = text.substr(0, text.lastIndexOf('.'));
						example.appendChild(option);
					}
				}
				let tbody = document.getElementById(tbody_id)
				while (tbody.firstChild)
					tbody.removeChild(tbody.firstChild);
				if (Json[constraint_store])
				{
					for (text of Json[constraint_store])
					{
						let tr = document.createElement('tr');
						let td = document.createElement('td');
						let button = document.createElement('button');
						let span = document.createElement('span');
						let i = document.createElement('i');
						let textNode = document.createTextNode(text);
						
						button.setAttribute('type', 'button');
						button.classList.add('button');
						button.classList.add('is-danger');
						button.setAttribute('name', remove_constraint);
						button.setAttribute('value', text);
			
						button.addEventListener
						(
							'click', 
							(e) => 
							{
								data = ajax_data();
								data[remove_constraint] = text;
								send(data);
							  }
						)
						
						span.classList.add('icon');
						span.classList.add('is-small');
			
						i.classList.add('fas');
						i.classList.add('fa-times');
			
						span.appendChild(i);
						button.appendChild(span);
						
						td.appendChild(textNode);
						td.appendChild(button);
						tr.appendChild(td);
						tbody.appendChild(tr);
					}
			
				}
				let tbodyVariable = document.getElementById(tbody_id_variable)
				while (tbodyVariable.firstChild) 
					tbodyVariable.removeChild(tbodyVariable.firstChild);
			
				if (Json[ variables])
				{
					for (value of Json[variables])
					{
						let tr = document.createElement('tr');
						let td = document.createElement('td');
						let td2 = document.createElement('td');
						let button = document.createElement('button');
						let span = document.createElement('span');
						let i = document.createElement('i');
						let textNode = document.createTextNode(value[0]);
						
						button.setAttribute('type', 'button');
						button.classList.add('button');
						button.classList.add('is-danger');
						button.setAttribute('name', remove_variable);
						button.setAttribute('value', value[0]);
			
						button.addEventListener
						(
							'click', 
							(e) => 
							{
								data = ajax_data();
								data[remove_variable] = value[0];
								send(data);
							}
						)
			
						span.classList.add('icon');
						span.classList.add('is-small');
			
						i.classList.add('fas');
						i.classList.add('fa-times');
						
						td2.textContent = value[1];
			
						span.appendChild(i);
						button.appendChild(span);
						td.appendChild(textNode);
						tr.appendChild(td);
						tr.appendChild(td2);
						
						let td3 = document.createElement('td');
						td3.append(button);
						tr.append(td3);
			
						tbodyVariable.appendChild(tr);
					}
				}
			}
		}

		// Handle errors here, if the server returns a status code outside the 200-299 range
		else
			console.error('The request failed with status:', XHR.status);
	}
	XHR.open(method, url, true);

	// Create and send
	const FD = new FormData();
	for (const [name, value] of Object.entries(data))
		FD.append(name, value);
	XHR.send(FD);
}

// Return Ajax data
function ajax_data() 
{
  let data = {};
  data[ajax_request] = 'true';
  return data;
}
  
// Return the data associated by the id
function gather_data(data_id)
{
  return document.getElementById(data_id).value;
}

// Add contraint
document.getElementById(add_constraint).addEventListener
(
	'click', 
	(e) => 
	{
		data = ajax_data();
		data[add_constraint] = 'true';
		data[add_constraint_value] = gather_data(add_constraint_value);
		send(data);
  	}
)

// Select example
document.getElementById(select_example).addEventListener
(
	'change', 
	(e) => 
	{
		data = ajax_data();
		data[select_example] = gather_data(select_example);
		send(data);
	}
)

// Compile
document.getElementById(compile).addEventListener
(
	'click', 
	(e) => 
	{
		data = ajax_data();
		data[compile] = true;
		data[chr_code] = gather_data(chr_code);
		send(data);
	}
)

// Download session
document.getElementById(download_session).addEventListener
(
	'click', 
	(e) => 
	{
		data = ajax_data();
		data[download_session] = true;
		send(data, 'Post', '/', true);
  	}
)

// Upload session
document.getElementById(upload_session).addEventListener
(
	'change', 
	(e) => 
	{
		data = ajax_data();
		data[upload_session] = true;
		data['file'] = e.target.files[0];
		send(data, 'Post', upload_session_path);
	}
)

// Add variable
document.getElementById(add_variable).addEventListener
(
	'click', 
	(e) => 
	{
		data = ajax_data();
		data[add_variable] = true;
		data[variable_mutable] = document.getElementById(variable_mutable).checked;
		data[variable_name] = gather_data(variable_name);
		data[variable_type] = gather_data(variable_type);
		if (document.getElementById(variable_mutable).checked)
			data[variable_value] = gather_data(variable_value);
		send(data);
	}
)

// Mutable variable
document.getElementById(variable_mutable).addEventListener
(
	'click', 
	(e) => 
	{
		if (document.getElementById(variable_mutable).checked)
			document.getElementById(field_variable).classList.remove('is-hidden');
		else
		{
			document.getElementById(field_variable).classList.remove('is-hidden');
			document.getElementById(field_variable).classList.add('is-hidden');
		}
	}
)

// Clear constraint store 
document.getElementById(clear_constraint_store).addEventListener
(
	'click', 
	(e) => 
	{
		data = ajax_data();
		data[clear_constraint_store] = true;
		send(data);
  	}
)

// Clear Variables 
document.getElementById(clear_variables).addEventListener
(
	'click', 
	(e) => 
	{
		data = ajax_data();
		data[clear_variables] = true;
		send(data);
	}
)