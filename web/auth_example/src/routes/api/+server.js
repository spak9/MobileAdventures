import { json } from '@sveltejs/kit';

export async function GET({ locals }) {
	
	console.log('GET() @ /api')

	const pb = locals.pb;
	const record = await pb.collection('messages').getOne('lcykz05hpqsw4tq', {});
	return json(record);
}