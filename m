Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S21Nt-0002XU-Vb
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 15:17:02 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 06:08:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="115262784"
Received: from unknown (HELO helios.localnet) ([10.252.123.30])
	by orsmga002.jf.intel.com with ESMTP; 27 Feb 2012 06:08:34 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 14:08:33 +0000
Message-ID: <6969393.EIjsJuEBEq@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <fe2f1bcd135d8079b884c006daec70c4d282bc65.1330351287.git.paul.eggleton@linux.intel.com>
References: <cover.1330351287.git.paul.eggleton@linux.intel.com>
	<fe2f1bcd135d8079b884c006daec70c4d282bc65.1330351287.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: implement BB_VERBOSE_LOGS
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
X-List-Received-Date: Mon, 27 Feb 2012 14:17:02 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 February 2012 14:06:18 Paul Eggleton wrote:
> Enable configuring whether "set +x" is added to all shell tasks rather
> than forcing it; this is enabled by setting BB_VERBOSE_LOGS to 1.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/build.py  |    3 ++-
>  bitbake/lib/bb/cooker.py |    4 ++++
>  bitbake/lib/bb/msg.py    |    5 ++++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index e85d7c4..37686f8 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -221,9 +221,10 @@ def exec_func_shell(function, d, runfile, cwd=None):
> 
>      with open(runfile, 'w') as script:
>          script.write('#!/bin/sh -e\n')
> +        if bb.msg.loggerVerboseLogs:
> +            script.write("set -x\n")
>          data.emit_func(function, script, d)
> 
> -        script.write("set -x\n")
>          if cwd:
>              script.write("cd %s\n" % cwd)
>          script.write("%s\n" % function)
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 12b526b..d3bdd17 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -206,6 +206,10 @@ class BBCooker:
> 
>      def parseConfiguration(self):
> 
> +        # Set log file verbosity
> +        verboselogs =
> bb.utils.to_boolean(self.configuration.data.getVar("BB_VERBOSE_LOGS", "0"))
> +        if verboselogs:
> +            bb.msg.loggerVerboseLogs = True
> 
>          # Change nice level if we're asked to
>          nice = self.configuration.data.getVar("BB_NICE_LEVEL", True)
> diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
> index 20d9bdd..94865ee 100644
> --- a/bitbake/lib/bb/msg.py
> +++ b/bitbake/lib/bb/msg.py
> @@ -100,14 +100,17 @@ class BBLogFilter(object):
> 
>  loggerDefaultDebugLevel = 0
>  loggerDefaultVerbose = False
> +loggerVerboseLogs = False
>  loggerDefaultDomains = []
> 
> -def init_msgconfig(verbose, debug, debug_domains = []):
> +def init_msgconfig(verbose, debug, debug_domains = [], verboselogsonly =
> False): """

Whoops, this crept in from an earlier version. v2 on the way.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


