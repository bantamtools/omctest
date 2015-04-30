#!/usr/sbin/dtrace -Cs
/* 
 *  INFO --> http://dtrace.org/blogs/brendan/2011/02/11/dtrace-pid-provider-arguments/
 * 
 *  dtrace script to track usages of OLMillingPlanController:runJob
 *
 *  % sudo ./toolSequencing.d -p <process ID>
 *
 */

#include "../../othercam/OMC/Source/OLJob.h"
 
objc$target::-runJob*:entry
{
	this->job = (OLJob *)copyin(arg2, sizeof (OLJob));
        //trace(copyinstr(arg2));
}

