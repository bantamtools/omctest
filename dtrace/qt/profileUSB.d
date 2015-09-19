/* 
 *
 *  dtrace script to profile ftdi read and write behavior
 *
 *  % sudo dtrace -s readTime.d <process ID>
 *
 */
pid$1::QIODevice??readyRead():entry
{
    self->lastReadyRead = timestamp;
    printf("ReadyRead signal sent");
} 

pid$1::QIODevice??readAll():entry
{
    self->lastReadStart = timestamp;
} 

pid$1::QIODevice??bytesWritten*:entry
{
    printf("bytes written: %li", arg1);
} 

pid$1::*dtraceReadEnd*:entry
/self->lastReadStart/
{
    this->nowRead = timestamp;
    printf("readEnd len: %d diff: %lu time: %lu\n", arg1, this->nowRead - self->lastReadStart, this->nowRead);
}


pid$1::QIODevice??write*:entry
{
    self->lastWriteStart = timestamp;
    printf("sendingToMill: %s\n", copyinstr(arg1));
} 

pid$1::*dtraceWriteEnd*:entry
/self->lastWriteStart/
{
    this->nowWrite = timestamp;
    printf("writeEnd len: %d channel: %s diff: %lu time: %lu\n", arg1, (arg2 ? "control" : "data"), this->nowWrite - self->lastWriteStart, this->nowWrite);
}

