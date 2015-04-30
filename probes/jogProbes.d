#!/usr/sbin/dtrace -s
/* 
 *  % sudo ./jogProbes.d -p <process ID>
 *
 */

objc$target:OLJogButtonCell:-startTrackingAt*:entry { }
objc$target:OLJogButtonCell:-action:entry { }
objc$target:OLJogButtonCell:-stopTracking*:entry { } 
objc$target:OLJogButtonCell:-continueTracking*:entry { } 
objc$target:OLJogButtonCell:-trackMouse*:entry { } 
objc$target:OLMillController:-stopJogging*:entry { }
/* objc$target:OLMachine:-jogStop*:entry { } */
objc$target:OLTinyG:-jogStop*:entry { }
