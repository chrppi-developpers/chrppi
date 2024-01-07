// Idendifiers of HTML elements
let id =
{
	// Path
	upload_session_path: 'upload_session',

	// Error
	error_section: 'error section',
	error_list: 'error list',

	// Load an example
	select_example: 'select example',
	disable_option: 'disable option',
	chr_examples: 'chr examples',

	// Compile chr code
	compile: 'compile',

	// CHR code
	chr_code: 'chr code',

	// Download/upload session
	download_session: 'download session',
	upload_session: 'upload session',

	// Add Constraint 
	add_constraint_value: 'add constraint value',
	add_constraint: 'add constraint',

	// Add variable
	add_variable: 'add variable',
	variable_mutable: 'variable mutable',
	variable_name: 'variable name',
	variable_value: 'variable value',
	variable_type: 'variable type',

	// Constraint Store
	constraint_store: 'constraint store',
	store_body: 'store body',
	remove_constraint: 'remove constraint',
	clear_constraint_store: 'clear constraint store',

	// Variables
	variables: 'variables',
	variables_body: 'variables body',
	remove_variable: 'remove variable',
	clear_variables: 'clear variables',

	// Ajax request
	ajax_request: 'ajax request'
}

// Disable value field if variable is not mutable
document.getElementById(id.variable_value).disabled = !document.getElementById(id.variable_mutable).checked;

function send(data, url, download_file=false) 
{
	// Set loading animations
	document.body.style.cursor = 'wait';
	if (data[id.compile])
		document.getElementById(id.compile).classList.add('is-loading');
	else if (data[id.select_example])
		document.getElementById(id.select_example).parentNode.classList.add('is-loading');

	// Create XHR request
	const XHR = new XMLHttpRequest();	
	XHR.onload = function()
	{
		// Unset loading animations
		document.body.style.cursor = 'default';
		if (data[id.compile])
			document.getElementById(id.compile).classList.remove('is-loading');
		else if (data[id.select_example])
			document.getElementById(id.select_example).parentNode.classList.remove('is-loading');

		if (XHR.status >= 200 && XHR.status < 300)
		{
			// Trigger download
			if (download_file)
			{
				// Create a Blob containing the text
				const file_download = new Blob([XHR.responseText], { type: 'text/plain' });
			  
				// Create a temporary link element
				const download_link = document.createElement('a');
				download_link.href = URL.createObjectURL(file_download);
				download_link.setAttribute('download', 'session.json');
			  
				// Append the link to the body
				document.body.appendChild(download_link);
			  
				// Trigger a click event on the link
				download_link.click();
			  
				// Clean up: remove the link and the created object URL
				document.body.removeChild(download_link);
				URL.revokeObjectURL(download_link.href);
			}

			// Get server response
			let response = JSON.parse(XHR.response);
				
			// Empty previous data
			document.getElementById(id.error_section).classList.add('is-hidden');
			let error_list = document.getElementById(id.error_list);
			while (error_list.firstChild)
				error_list.removeChild(error_list.firstChild);
			let store_body = document.getElementById(id.store_body)
			while (store_body.firstChild)
				store_body.removeChild(store_body.firstChild);
			let variables_body = document.getElementById(id.variables_body)
			while (variables_body.firstChild) 
				variables_body.removeChild(variables_body.firstChild);

			// Update CHR code
			if (response[id.chr_code])
				document.getElementById(id.chr_code).value = response[id.chr_code];

			// Update error
			if (response[id.error_list])
			{
				document.getElementById(id.error_section).classList.remove('is-hidden');
				for (error_item_text of response[id.error_list])
				{
					let error_item = document.createElement('li');
					error_item.setAttribute('class', 'subtitle');
					error_item.innerText = error_item_text;
					error_list.appendChild(error_item);
				}
			}
		
			// Update examples
			if (response[id.chr_examples])
			{
				let select_example = document.getElementById(id.select_example);
				while (select_example.childNodes.length != 2)
					select_example.removeChild(select_example.lastChild);
				document.getElementById(id.disable_option).disabled = false;
				select_example.selectedIndex = 0;
				document.getElementById(id.disable_option).disabled = true;
				for (chr_example of response[id.chr_examples])
				{
					let option = document.createElement('option');
					option.setAttribute('value', chr_example);
					option.innerText = chr_example.substr(0, chr_example.lastIndexOf('.'));
					select_example.appendChild(option);
				}
			}

			// Update constraint store
			if (response[id.constraint_store])
			{
				for (constraint_text of response[id.constraint_store])
				{
					// Create remove button
					let remove_button = document.createElement('button');
					remove_button.setAttribute('type', 'button');
					remove_button.classList.add('button');
					remove_button.classList.add('is-danger');
					remove_button.setAttribute('name', id.remove_constraint);
					remove_button.addEventListener
					(
						'click', 
						(event) => 
						{
							data = ajax_data();
							data[id.remove_constraint] = constraint_text;
							send(data, '/');
						}
					)
					let span = document.createElement('span');
					span.classList.add('icon');
					span.classList.add('is-small');
					let i = document.createElement('i');
					i.classList.add('fas');
					i.classList.add('fa-times');
					span.appendChild(i);
					remove_button.appendChild(span);
					
					// Create table data
					let constraint_td = document.createElement('td');
					constraint_td.appendChild(document.createTextNode(constraint_text));
					let remove_td = document.createElement('td');
					remove_td.appendChild(remove_button);

					// Create and append table row
					let constraint_tr = document.createElement('tr');
					constraint_tr.appendChild(constraint_td);
					constraint_tr.appendChild(remove_td);
					store_body.appendChild(constraint_tr);
				}
		
			}
		
			// Update variables
			if (response[id.variables])
			{
				for (variable of response[id.variables])
				{
					// Create remove button
					let remove_button = document.createElement('button');
					remove_button.setAttribute('type', 'button');
					remove_button.classList.add('button');
					remove_button.classList.add('is-danger');
					remove_button.setAttribute('name', id.remove_variable);		
					remove_button.addEventListener
					(
						'click', 
						(event) => 
						{
							data = ajax_data();
							data[id.remove_variable] = variable[1];
							send(data, '/');
						}
					)
					let span = document.createElement('span');
					span.classList.add('icon');
					span.classList.add('is-small');
					let i = document.createElement('i');
					i.classList.add('fas');
					i.classList.add('fa-times');
					span.appendChild(i);
					remove_button.appendChild(span);
					
					// Create table data
					let type_td = document.createElement('td');
					type_td.textContent = variable[0];
					let name_td = document.createElement('td');
					name_td.textContent = variable[1];
					let value_td = document.createElement('td');
					value_td.textContent = variable[2];
					let remove_td = document.createElement('td');
					remove_td.appendChild(remove_button);

					// Create and append table row
					let variable_tr = document.createElement('tr');
					variable_tr.appendChild(type_td);
					variable_tr.appendChild(name_td);
					variable_tr.appendChild(value_td);
					variable_tr.appendChild(remove_td);
					variables_body.appendChild(variable_tr);
				}
			}
		}

		// Handle errors here, if the server returns a status code outside the 200-299 range
		else
			console.error('The request failed with status:', XHR.status);
	}
	XHR.open('POST', url, true);

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
  data[id.ajax_request] = true;
  return data;
}

// Add contraint
document.getElementById(id.add_constraint).addEventListener
(
	'click', 
	(event) => 
	{
		data = ajax_data();
		data[id.add_constraint_value] = document.getElementById(id.add_constraint_value).value;
		data[id.add_constraint] = true;
		send(data, '/');
  	}
)

// Select example
document.getElementById(id.select_example).addEventListener
(
	'change', 
	(event) => 
	{
		data = ajax_data();
		data[id.select_example] = document.getElementById(id.select_example).value;
		send(data, '/');
	}
)

// Compile
document.getElementById(id.compile).addEventListener
(
	'click',
	(event) => 
	{
		data = ajax_data();
		data[id.compile] = true;
		data[id.chr_code] = document.getElementById(id.chr_code).value;
		console.log(data);
		send(data, '/');
	}
)

// Download session
document.getElementById(id.download_session).addEventListener
(
	'click', 
	(event) => 
	{
		data = ajax_data();
		data[id.download_session] = true;
		send(data, '/', true);
  	}
)

// Upload session
document.getElementById(id.upload_session).addEventListener
(
	'change', 
	(event) => 
	{
		data = ajax_data();
		data[id.upload_session] = true;
		data['file'] = event.target.files[0];
		send(data, id.upload_session_path);
	}
)

// Add variable
document.getElementById(id.add_variable).addEventListener
(
	'click', 
	(event) => 
	{
		data = ajax_data();
		data[id.add_variable] = true;
		data[id.variable_mutable] = document.getElementById(id.variable_mutable).checked;
		data[id.variable_name] = document.getElementById(id.variable_name).value;
		data[id.variable_type] = document.getElementById(id.variable_type).value;
		if (document.getElementById(id.variable_mutable).checked && document.getElementById(id.variable_value).value)
			data[id.variable_value] = document.getElementById(id.variable_value).value;
		send(data, '/');
	}
)

// Mutable variable
document.getElementById(id.variable_mutable).addEventListener
(
	'click', 
	(event) =>
	{
		document.getElementById(id.variable_value).disabled = !document.getElementById(id.variable_mutable).checked;
	}
)

// Clear constraint store 
document.getElementById(id.clear_constraint_store).addEventListener
(
	'click', 
	(event) => 
	{
		data = ajax_data();
		data[id.clear_constraint_store] = true;
		send(data, '/');
  	}
)

// Clear Variables 
document.getElementById(id.clear_variables).addEventListener
(
	'click', 
	(event) => 
	{
		data = ajax_data();
		data[id.clear_variables] = true;
		send(data, '/');
	}
)