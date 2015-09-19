/* 
 *
 *  dtrace script to profile ftdi read and write behavior
 *
 *  % sudo dtrace -s readTime.d <process ID>
 *
 */
 
/*
 *  Currently using this to signal when a JSON parsing error occurs. 
 *  Could move this method call elsewhere in Otherplan for another 
 *  debugging purpose.                 
 */
objc$1::-dtraceTrigger:entry
{
	printf("ERROR!!!! time: %lu\n", timestamp);
}

/*
 *  FTDI Reads  
 *  Using ftdi_read_data() entry to start timing
 *  Using +dtraceReadEnd:(long)length to stop timing and log bytes read
 *  (Not using ftdi_read_data() return because I want to log the return value)              
 */
pid$1::ftdi_read_data:entry
{
	lastReadStart = timestamp;
}

/*
 *  VCP Reads  
 *  Using read() entry to start timing
 *  Using +dtraceReadEnd:(long)length to stop timing and log bytes read
 *  (Not using read() return because I want to log the return value)              
 */
pid$1::read:entry
{
	lastReadStart = timestamp;
} 

/* 
pid$1::read:return
/lastReadStart/
{
	self->nowRead = timestamp;
	printf("readEnd len: 0 diff: %lu time: %lu\n", self->nowRead - lastReadStart, self->nowRead);
}
*/

objc$1::+dtraceReadEnd*:entry
/lastReadStart/
{
	self->nowRead = timestamp;
	printf("readEnd len: %li diff: %lu time: %lu\n", arg2, self->nowRead - lastReadStart, self->nowRead);
}

/*
 *  FTDI Writes  
 *  Using ftdi_write_data() entry to start timing
 *  Using +dtraceWriteEnd:(long)length to stop timing and log bytes written               
 */
pid$1::ftdi_write_data:entry
{
	lastWriteStart = timestamp;
} 

/*
 *  VCP Writes  
 *  Using write() entry to start timing
 *  Using +dtraceWriteEnd:(long)length to stop timing and log bytes written               
 */
pid$1::write:entry
{
	lastWriteStart = timestamp;
} 

/*
pid$1::write:return
/lastWriteStart/
{
	self->nowWrite = timestamp;
	printf("writeEnd len: 0 diff: %lu time: %lu\n", self->nowWrite - lastWriteStart, self->nowWrite);
}
*/

objc$1::+dtraceWriteEnd*:entry
/lastWriteStart/
{
	self->nowWrite = timestamp;
	printf("writeEnd len: %li diff: %lu time: %lu\n", arg2, self->nowWrite - lastWriteStart, self->nowWrite);
}

objc$1::-bufferDataForDelegate*:entry
{
	bufferDataStart = timestamp;
}

objc$1::-bufferDataForDelegate*:return
/bufferDataStart/
{
	self->now = timestamp;
	printf("bufferDataForDelegate diff: %lu time: %lu\n", self->now - bufferDataStart, self->now);
}

/*
objc$1::-_dtraceSendStatus*:entry
{
	printf("sendCommandBytes: %li txAvail: %li pbAvail: %li reason: %d prevRepeats: %li\n", arg2, arg3, arg4, arg5, arg6);
}
*/
