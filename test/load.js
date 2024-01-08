import FormData from 'form-data';
import fetch from 'node-fetch';

import {id} from '../app/document_root/js/id.js';

async function send(method, data, url, session_id)
{
	console.error('@' + session_id + ': ' + method + ' ' + data + ' on ' + url);

	await fetch
	(
		url, 
		{
			method: method,
			headers: { cookie: 'JSESSIONID=' + session_id}
		}
	)
		// Successful response
		.then(response => console.error('@' + session_id + ': ' + response.status))

		// Error
		.catch(err => console.error(err))
	;
}

for (let i = 1; i <= 10; ++i)
{
	send('GET', null, 'http://0.0.0.0:8080', i);
}