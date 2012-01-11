Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkwYk-0005Sg-Rv for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 12:41:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BBY84j023301;
	Wed, 11 Jan 2012 11:34:08 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22821-03; Wed, 11 Jan 2012 11:34:04 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BBY0Yt023294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2012 11:34:01 GMT
Message-ID: <1326281642.23315.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Wed, 11 Jan 2012 11:34:02 +0000
In-Reply-To: <d628d53679aa12f5803d0bbf30aa21ed3bc4779d.1326249301.git.dongxiao.xu@intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
	<d628d53679aa12f5803d0bbf30aa21ed3bc4779d.1326249301.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Wed, 11 Jan 2012 11:41:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-01-11 at 11:03 +0800, Dongxiao Xu wrote:
> Add new API in command.py to get the CPU core and threads information
> in order to set the appropriate BB_NUMBER_THREADS and PARALLEL_MAKE
> variables.
> 
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> ---
>  bitbake/lib/bb/helper.py |   39 +++++++++++++++++++++++++++++++++++++++
>  lib/bb/command.py        |   12 ++++++++++++
>  2 files changed, 51 insertions(+), 0 deletions(-)
>  create mode 100644 bitbake/lib/bb/helper.py
> 
> diff --git a/bitbake/lib/bb/helper.py b/bitbake/lib/bb/helper.py
> new file mode 100644
> index 0000000..291158b
> --- /dev/null
> +++ b/bitbake/lib/bb/helper.py
> @@ -0,0 +1,39 @@
> +#
> +# Helper for BitBake Graphical GTK User Interface
> +#
> +# Copyright (C) 2011        Intel Corporation
> +#
> +# Authored by Shane Wang <shane.wang@intel.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import os
> +
> +class CpuInfo(object):
> +
> +    coefficient = 4

This is setting off alarm bells...

> +    @classmethod
> +    def getNumOfCpus(cls):
> +        pfile = os.popen('cat /proc/cpuinfo | grep cpu\ cores')
> +        num = len(pfile.readlines())
> +        return num

You can get this number with something like:

import multiprocessing
multiprocessing.cpu_count()

> +    @classmethod
> +    def getNumOfCpuCores(cls):
> +        pfile = os.popen('cat /proc/cpuinfo | grep cpu\ cores | cut -d: -f2')
> +        contents = pfile.readlines()
> +        num = int(contents[0])
> +        return num

I'm curious what you're using the number of cores to do? It doesn't seem
used by your code?


> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 05555c5..eaf8236 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -30,6 +30,7 @@ Commands are queued in a CommandQueue
>  
>  import bb.event
>  import bb.cooker
> +import bb.helper
>  
>  class CommandCompleted(bb.event.Event):
>      pass
> @@ -173,6 +174,17 @@ class CommandsSync:
>          """
>          command.cooker.reset()
>  
> +    def getDefaultNumOfThreads(self, command, params):
> +        """
> +        Get the default number of threads on the server = number of CPUs
> +        """
> +        return bb.helper.CpuInfo.getNumOfCpus()
> +
> +    def getMaxNumOfThreads(self, command, params):
> +        """
> +        Get the max number of threads that the server can tolerate
> +        """
> +        return bb.helper.CpuInfo.getNumOfCpus() * bb.helper.CpuInfo.coefficient
>  

I can understand needing to query the number of cpus but this last
function seems rather arbitrary. If you want to do bounds checking, I'd
suggest just adding the factor of 4 into the UI. I'm still not convinced
we should be setting any value for this though, or doing any bounds
checking on the value.


My only other comment would be to use bb.utils instead of creating a
bb.helper.

Cheers,

Richard




