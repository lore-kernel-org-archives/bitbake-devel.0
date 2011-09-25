Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R7qgL-0001jo-GY for bitbake-devel@lists.openembedded.org;
	Sun, 25 Sep 2011 17:31:53 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8PFWjNI014734; Sun, 25 Sep 2011 16:32:45 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id imeKNrmEgL3F; Sun, 25 Sep 2011 16:32:45 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8PFWgTP014728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Sep 2011 16:32:44 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Sun, 25 Sep 2011 16:26:19 +0100
In-Reply-To: <8e4d22e7d6339849c7efb9460cafdfddb5ece76f.1316793495.git.paul.eggleton@linux.intel.com>
References: <cover.1316793495.git.paul.eggleton@linux.intel.com>
	<8e4d22e7d6339849c7efb9460cafdfddb5ece76f.1316793495.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316964386.8185.19.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake/lib/bb/msg.py: fix setting debug and verbosity levels
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
X-List-Received-Date: Sun, 25 Sep 2011 15:31:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-23 at 17:05 +0100, Paul Eggleton wrote:
> The debug and verbosity levels (as set by the -D and -v command line
> options respectively)  were not being passed through within msg.py since
> bitbake revision 45aad2f9647df14bcfa5e755b57e1ddab377939a due to
> incorrect variable names.
> 
> Fixes [YOCTO #1513].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/build.py |    4 ++--
>  bitbake/lib/bb/msg.py   |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 00304b4..8937f08 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -223,7 +223,7 @@ def exec_func_shell(function, d, runfile, cwd=None):
>  
>      with open(runfile, 'w') as script:
>          script.write('#!/bin/sh -e\n')
> -        if bb.msg.loggerVerbose:
> +        if bb.msg.loggerDefaultVerbose:
>              script.write("set -x\n")
>          data.emit_func(function, script, d)
>          if cwd:
> @@ -234,7 +234,7 @@ def exec_func_shell(function, d, runfile, cwd=None):
>  
>      cmd = runfile
>  
> -    if bb.msg.loggerVerbose:
> +    if bb.msg.loggerDefaultVerbose:
>          logfile = LogTee(logger, sys.stdout)
>      else:
>          logfile = sys.stdout
> diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
> index b7ae761..20d9bdd 100644
> --- a/bitbake/lib/bb/msg.py
> +++ b/bitbake/lib/bb/msg.py
> @@ -106,8 +106,8 @@ def init_msgconfig(verbose, debug, debug_domains = []):
>      """
>      Set default verbosity and debug levels config the logger
>      """
> -    bb.msg.loggerDebugLevel = debug
> -    bb.msg.loggerVerbose = verbose
> +    bb.msg.loggerDefaultDebugLevel = debug
> +    bb.msg.loggerDefaultVerbose = verbose
>      bb.msg.loggerDefaultDomains = debug_domains
>  
>  def addDefaultlogFilter(handler):

Merged to master, thanks.

Richard




