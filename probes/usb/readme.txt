-- Usage --
To record dtrace information, you must run as root:
    sudo dtrace -s readTime.d <Otherplan pid> > <output file>

To visualize the dtrace information:
    python plotReads.py <dtrace output file>
The plot components can be toggled by clicking in the legend.
