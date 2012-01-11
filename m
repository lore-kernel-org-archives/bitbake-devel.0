Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkyHP-00006q-Aj for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 14:31:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BDOHjL024314;
	Wed, 11 Jan 2012 13:24:17 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22821-10; Wed, 11 Jan 2012 13:24:13 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BDO7BM024307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2012 13:24:09 GMT
Message-ID: <1326288250.23315.50.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Wang, Shane" <shane.wang@intel.com>
Date: Wed, 11 Jan 2012 13:24:10 +0000
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC0FCAA7DE@SHSMSX102.ccr.corp.intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
	<d628d53679aa12f5803d0bbf30aa21ed3bc4779d.1326249301.git.dongxiao.xu@intel.com>
	<1326281642.23315.21.camel@ted>
	<3AB6CE7F274E534CAFD089D127A8A1FC0FCAA7DE@SHSMSX102.ccr.corp.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 7/8] command.py: add new command to get the CPU info
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
X-List-Received-Date: Wed, 11 Jan 2012 13:31:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-01-11 at 11:52 +0000, Wang, Shane wrote:
> Richard Purdie wrote on 2012-01-11:
> 
> > On Wed, 2012-01-11 at 11:03 +0800, Dongxiao Xu wrote:
> >> Add new API in command.py to get the CPU core and threads information
> >> in order to set the appropriate BB_NUMBER_THREADS and PARALLEL_MAKE
> >> variables.
> >> 
> >> Signed-off-by: Shane Wang <shane.wang@intel.com>
> >> ---
> >>  bitbake/lib/bb/helper.py |   39
> >>  +++++++++++++++++++++++++++++++++++++++ lib/bb/command.py        |  
> >>  12 ++++++++++++ 2 files changed, 51 insertions(+), 0 deletions(-)
> >>  create mode 100644 bitbake/lib/bb/helper.py
> >> diff --git a/bitbake/lib/bb/helper.py b/bitbake/lib/bb/helper.py new
> >> file mode 100644 index 0000000..291158b --- /dev/null +++
> >> b/bitbake/lib/bb/helper.py @@ -0,0 +1,39 @@ +# +# Helper for BitBake
> >> Graphical GTK User Interface +# +# Copyright (C) 2011        Intel
> >> Corporation +# +# Authored by Shane Wang <shane.wang@intel.com> +# +#
> >> This program is free software; you can redistribute it and/or modify +#
> >> it under the terms of the GNU General Public License version 2 as +#
> >> published by the Free Software Foundation. +# +# This program is
> >> distributed in the hope that it will be useful, +# but WITHOUT ANY
> >> WARRANTY; without even the implied warranty of +# MERCHANTABILITY or
> >> FITNESS FOR A PARTICULAR PURPOSE.  See the +# GNU General Public
> >> License for more details. +# +# You should have received a copy of the
> >> GNU General Public License along +# with this program; if not, write to
> >> the Free Software Foundation, Inc., +# 51 Franklin Street, Fifth Floor,
> >> Boston, MA 02110-1301 USA. + +import os + +class CpuInfo(object): + +  
> >>  coefficient = 4
> > 
> > This is setting off alarm bells...
> > 
> >> +    @classmethod
> >> +    def getNumOfCpus(cls):
> >> +        pfile = os.popen('cat /proc/cpuinfo | grep cpu\ cores')
> >> +        num = len(pfile.readlines())
> >> +        return num
> > 
> > You can get this number with something like:
> > 
> > import multiprocessing
> > multiprocessing.cpu_count()
> Good to see this works, will change that.
> 
> > 
> >> +    @classmethod +    def getNumOfCpuCores(cls): +        pfile =
> >> os.popen('cat /proc/cpuinfo | grep cpu\ cores | cut -d: -f2') +       
> >> contents = pfile.readlines() +        num = int(contents[0]) +       
> >> return num
> > 
> > I'm curious what you're using the number of cores to do? It doesn't seem
> > used by your code?
> > 
> > 
> >> diff --git a/lib/bb/command.py b/lib/bb/command.py
> >> index 05555c5..eaf8236 100644
> >> --- a/lib/bb/command.py
> >> +++ b/lib/bb/command.py
> >> @@ -30,6 +30,7 @@ Commands are queued in a CommandQueue
> >> 
> >>  import bb.event
> >>  import bb.cooker
> >> +import bb.helper
> >> 
> >>  class CommandCompleted(bb.event.Event):
> >>      pass
> >> @@ -173,6 +174,17 @@ class CommandsSync:
> >>          """
> >>          command.cooker.reset()
> >> +    def getDefaultNumOfThreads(self, command, params): +        """ + 
> >>       Get the default number of threads on the server = number of CPUs
> >> +        """ +        return bb.helper.CpuInfo.getNumOfCpus() + +   
> >> def getMaxNumOfThreads(self, command, params): +        """ +       
> >> Get the max number of threads that the server can tolerate +        """
> >> +        return bb.helper.CpuInfo.getNumOfCpus() *
> >> bb.helper.CpuInfo.coefficient
> >> 
> > 
> > I can understand needing to query the number of cpus but this last
> > function seems rather arbitrary. If you want to do bounds checking, I'd
> > suggest just adding the factor of 4 into the UI.
> OK
> 
> > I'm still not convinced
> > we should be setting any value for this though, or doing any bounds
> > checking on the value.
> Which value? We hope when the UI starts up, the UI can take advantage of cpus for build and set it as default.
> But users can change between 0 ~ max num of threads.

You can either:

a) Make it a text input (and then attempt to convert to an int, error if
its not an int). This means you don't need a maximum value.
b) In the UI, just show options up to 4 * cpu count.

I'd probably prefer a) but I can see why b) is easier. I don't see any
value in encoding "4" in the bitbake server though.

Cheers,

Richard



