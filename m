Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RytxV-0004aA-9b; Sun, 19 Feb 2012 00:44:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1INaaCL018861;
	Sat, 18 Feb 2012 23:36:36 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12100-10; Sat, 18 Feb 2012 23:36:32 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1INaOHC018855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 18 Feb 2012 23:36:27 GMT
Message-ID: <1329608182.4436.48.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, openembedded-core
	<openembedded-core@lists.openembedded.org>
Date: Sat, 18 Feb 2012 23:36:22 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: Bitbake Memory Usage
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 18 Feb 2012 23:44:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

One of the advantages of conferences is that you can talk to others
about current issues and discuss them. At ELC, I talked with Chris
Larson about the memory usage of bitbake and how I'd been having trouble
tracking usage down. Chris should take credit for pointing me at the
tools I'm mentioning here but I wanted to write down some of the things
I've found so far when looking around bitbake with the tools.

Before I dive into bitbake's memory usage, its probably worth refreshing
how system memory management roughly works for those who've not had the
pleasure of working more closely with it. In simple terms, the kernel is
clever and does things to try and share memory pages between processes.
Part of this is when you make a fork() call, it uses CoW (copy on write)
for the process's pages. This means that you can have ten forked
processes, each looking like they use 100MB but the total usage can be
100MB if they all never write to memory. When files like dynamic
libraries are loaded, particularly read only sections, those mapped
pages can also be shared between different processes. Prelink is such a
benefit because that makes the load addresses consistent and hence even
the precomputed offset tables can be shared between processes. Finally,
its worth keeping in mind the kernel only maps memory to a process when
it writes to it. Until a read/write happens, the memory mapping can
point to the kernel's empty page. This means that a system generally
over commits to processes knowing most processes don't ever use all the
memory they request.

I decided to poke around the memory used in a bitbake "worker" process.
This is where we do the real work and ideally we want a low memory
overhead when we fork these off. To start with to see where we were, I
added:

import meliae
from meliae import scanner
scanner.dump_all_objects("/tmp/dump2") 

to runqeueue.py, just before the bb.build.exec_task() call. There is a
visualisation tool I'd never used before called "runsnakemem" which
provides a graphical view of where the large users are (and will load
the saved dump in /tmp/dump2). Its semi cryptic in that you don't get
the full variable names of the users but there is enough information
there to be able to look for the problem. I would note that the memory
sizes displayed by runsnakemem (if they are memory sizes?) seem totally
bogus. They are still proportional though (see more info below).

Its pretty easy to spot our worst memory offenders so I started to
remove a few of these from memory (all still in the child process).
These are mostly cache objects and we can neutralise them with:

bb.codeparser.pythonparsecache = {}
bb.codeparser.shellparsecache = {}
bb.providers.regexp_cache = {}
bb.parse.parse_py.BBHandler.cached_statements = {}

I was looking at our process with top and sadly, this shows zero change
in bitbake memory usage, with it being stable at 206M. What is worth
noting is I've seen instability and had problems reproducing numbers in
the past. It now appears the first time you edit any of bitbake's .py
files and run it, you will get a higher memory usage (say 267M). The
second time you run bitbake having changed none of its .py files, the
usage will go back down. I can only assume there is some overhead in
creating the .pyc files and this pushes the memory usage up. I'd like to
understand that problem further.

I started wondering what the size of the objects we were removing were
and whether the statistics were somehow misleading things. The dump file
itself is human readable and was varying heavily in size before and
after the above changes which was a good sign. There is also a second
way to summarise the data using the python:

import meliae
from meliae import loader
om = loader.load("/tmp/dump2")
print om.summarize()

which in the above case gives he before and after of:

Total 762502 objects, 188 types, Total size = 114.7MiB (120289900 bytes)
 Index   Count   %      Size   % Cum     Max Kind
     0   55345   7  41224216  34  34 3146008 dict
     1  480494  63  28878839  24  58   14798 str
     2   50615   6  26939864  22  80   33000 set
     3   98452  12  10339600   8  89   23736 list
     4    1111   0   3751400   3  92    3416 CoreRecipeInfo
     5    2203   0   3271776   2  95  786720 collections.defaultdict
     6   48389   6   1161336   0  96      24 int
     7    9687   1    721248   0  96     424 tuple
     8     213   0    687504   0  97   12624 module
     9     629   0    568616   0  97     904 type
    10     446   0    495952   0  98    1112 LRItem
    11    3542   0    453376   0  98     128 code
    12    3645   0    437400   0  98     120 function
    13     148   0    164576   0  99    1112 Production
    14     131   0    145672   0  99    1112 LogRecord
    15     388   0    133472   0  99     344 DataNode
    16    1159   0     92720   0  99      80 wrapper_descriptor
    17      68   0     75616   0  99    1112 BufferedLogger
    18     834   0     73392   0  99      88 _sre.SRE_Pattern
    19     825   0     72600   0  99      88 weakref


Total 371890 objects, 176 types, Total size = 65.4MiB (68581634 bytes)
 Index   Count   %      Size   % Cum     Max Kind
     0   21282   5  29763504  43  43 3146008 dict
     1  208546  56  15827021  23  66   14798 str
     2   97478  26  10204048  14  81   23736 list
     3    1111   0   3751400   5  86    3416 CoreRecipeInfo
     4    2203   0   3271776   4  91  786720 collections.defaultdict
     5    2488   0   1044160   1  93   33000 set
     6    9685   2    721120   1  94     424 tuple
     7     213   0    687504   1  95   12624 module
     8     629   0    568616   0  96     904 type
     9     446   0    495952   0  96    1112 LRItem
    10    3542   0    453376   0  97     128 code
    11    3645   0    437400   0  98     120 function
    12   14539   3    348936   0  98      24 int
    13     148   0    164576   0  98    1112 Production
    14     129   0    143448   0  98    1112 LogRecord
    15    1159   0     92720   0  99      80 wrapper_descriptor
    16      67   0     74504   0  99    1112 BufferedLogger
    17     829   0     72952   0  99      88 weakref
    18     797   0     57384   0  99      72 builtin_function_or_method
    19     652   0     46944   0  99      72 method_descriptor

So we got rid of about half the objects from memory and nearly halved
the memory consumption. Seems a shame the overall memory usage therefore
didn't change then? :/.

I therefore added in some other calls and also called in smem to get a
better look at the numbers. smem dives a bit deeper into process memory
usage by working through /proc/xxx/smaps which describe all memory
mappings for a process.

I'm going to give three sets of numbers here using 'smem -c "pid user
command swap uss pss rss vss maps" -P python'. Before we do anything
after the fork() we have:

  PID User     Command                         Swap      USS      PSS      RSS      VSS  Maps 
 4937 richard  python /media/data1/build1/        0    65392    72681    89052   141140   107 
 4941 richard  python /media/data1/build1/        0    10404    75968   149476   211032   109 
 4961 richard  python /media/data1/build1/        0    11416    76421   149136   211032   109

and then after we free the caches we've identified, we have:

  PID User     Command                         Swap      USS      PSS      RSS      VSS  Maps 
 4937 richard  python /media/data1/build1/        0    65392    74830    89052   141140   107 
 4941 richard  python /media/data1/build1/        0    68260   107045   149476   211032   109 
 4961 richard  python /media/data1/build1/        0    82164   113944   149136   211032   109 

for fun, I then wondered what difference the python garbage collection
routines would make using:

import gc
gc.collect(2)

which gave:

  PID User     Command                         Swap      USS      PSS      RSS      VSS  Maps 
 4937 richard  python /media/data1/build1/        0    65392    74831    89052   141140   107 
 4941 richard  python /media/data1/build1/        0    96684   121258   149476   211032   109 
 4961 richard  python /media/data1/build1/        0   110596   128163   149152   211032   109 

Incidentally, I also checked len(gc.garbage) which was zero so we didn't
have uncollectable objects.

So what does the above mean? Firstly, to define what these numbers mean:

USS: Unique Set Size - Is memory unique to the process. If you kill it, 
     you get this much back
PSS: Proportional Set Size - Includes a measurement accounting for 
     shared pages (size of page is divided by he number of users it has)
RSS: Resident Set Size - Ignores sharing and is how much memory the 
     process has actively used
VSS: Virtual Set Size - A total of all the memory mapped by the process 
     used, or otherwise.

Why three processes? One is the UI process, the second is the main
runqueue, the process parent and the third is the child worker running
the actual task.

So bitbake is using about 150M of memory and mapping 211M. When we fork
off the child worker, its got a surprisingly low overhead of unique
pages (USS) of about 11M. As soon as the child starts trying to remove
things from memory, we lose the benefits of CoW and USS and PSS rise.
RSS and VSS remain unchanged. We then call the garbage collection and it
just makes USS and PSS worse.

So by trying to make things better here, we've taken the unique overhead
of the workers from 11M and made it about ten times worse.

I have to say this doesn't surprise me and I kind of expected this but
its nice to see the numbers. The piece of the puzzle I don't understand
is why even with the gc calls, RSS does not decrease. It appears python
is not returning memory to the system even when we do free it up.

So in summary, our fork() execution model may have some scary looking
memory numbers but in reality the overhead is good with CoW. There are
some puzzles remaining about how/when we can cooerce python to give
memory back to the system. We should also look at the memory hogging
variables identified and see if we can't do something better with them
in the core.

I'm going to continue to look at this when I have time but I hope this
reassures some people about the fork() overhead and enthuses some people
to further look around bitbake's memory usage.

Cheers,

Richard



