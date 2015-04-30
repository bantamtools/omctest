1) multiSimpleBoard.mill - the same simple board tiles 24 times with differing rotations per row.
  * to test loading times for saved .mill files with lots of plans
  * to test Otherplan responsiveness when lots of plans are imported

2) rotationTest.mill - the same simple board tiled 6 times to test for different positive and negative rotations.
  * the higher 3 boards are rotated, from left to right, by -90, -180 & -270 degrees
  * the lower 3 boards are rotated, from left to right, by +90, +180 & +270 degrees

3) toolSequencing.mill - one of each supported file type w/ multiple .brd files
  * differing combinations of tools per plan
  * to test tool sequencing when Cut Visible is used
  * there should be a minimal number of tool changes
  * use in conjunction with omctest:probes/toolSequencing.d - run the probe first, then click Cut Visible 

4) all Otherplan*.mill files - used to check compatibility between different versions of Otherplan
-- Versioning changes --
Version >= 0.13.0
  - Changed Tool Selection: trace/outline tools were changed to allow user to 
                            select up to 3 tools & Otherplan now determines 
                            which tool to use for each operation
  - Added Cut Selection   : user can select any combination of Traces, Holes
                            and Outline to be cut
  - Exposed in plans      : trace cut depth 
Version >= 0.14.0
  - Exposed in Facing Plan: max pass depth & spindle speed 
  - Exposed in plans      : feed rate, plunge rate, spindle speed, max pass 
                            depth & step over on a per tool basis.  Also
                            exposed rotation on a per plan basis.
Version >= 0.14.2
  - Exposed in Facing Plan: max recut length
  - Exposed in plans      : max recut length



NOTE: all defaults should be changed - this makes it easier to tell if the mill
      file isn't being parsed correctly
* For all versions, the following should be true (if the values were not yet 
  exposed, ignore them):
  1) lighthouse_board.brd should be imported
    + Material settings:
      - type   = Single-Sided FR1
      - size   = 50mm x 50mm x 1mm
      - offset = 10mm x 10mm x 10mm
    + Plan settings:
      - Placement:
        *             offset   = 10mm x 10mm x 10mm
        * [>= 0.14.0] rotation = 45 degrees
      - [>= 0.13.0] Parts to Cut: only Outline should be selected for cutting
      - Tools to Use: 
        * 1/16" [trace tool if < 0.13.0]
        * 1/8"  [outline tool if < 0.13.0]
      - Advanced:
        * trace clearance = 0.0mm
        * [>= 0.13.0] trace cut depth = 0.65mm
        * [>= 0.14.0] Speeds and feeds for tool (1/8" | 1/16"):
          -             feed rate        =  111mm/min | 222 mm/min 
          -             plunge rate      =  111mm/min | 222 mm/min 
          -             spindle speed    =    8000rpm | 16000rpm
          -             max pass depth   =     0.11mm | 0.22mm
          -             step over        =        11% | 22%
          - [>= 0.14.2] max recut length =       11mm | 22mm 
       

  2) Face Material plan should be present
    + Tool to Use = 1/100"
    + Advanced:
      -             feed rate        = 1234mm/min
      -             plunge rate      = 567mm/min
      - [>= 0.14.0] spindle speed    = 10000rpm
      - [>= 0.14.0] max pass depth   = 0.10mm
      -             step over        = 225%
      - [>= 0.14.2] max recut length = 10mm
    + Facing Depth = 1.00mm

