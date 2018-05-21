Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by mail.openembedded.org (Postfix) with ESMTP id 2E1E474CEA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2018 04:13:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2018 21:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,425,1520924400"; d="scan'208";a="42847774"
Received: from syadandx-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.168.242])
	by orsmga008.jf.intel.com with ESMTP; 20 May 2018 21:13:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Tzu Hsiang Lin <t9360341@ntut.org.tw>
Date: Mon, 21 May 2018 16:13:48 +1200
Message-ID: <3897955.EcvcaXkbTx@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <20180520145152.1619-1-t9360341@ntut.org.tw>
References: <20180520145152.1619-1-t9360341@ntut.org.tw>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix import spawn error on Python 3.6.5(Default Python version on Ubuntu 18.04 LTS). - Copy the find_executable() function from python3.5/distutils/spawn.py - npm.py do not need to import spawn
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 21 May 2018 04:13:54 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi there,

Thanks for the patch. A few comments:

1) All patches need to have Signed-off-by and a proper commit message. Please 
refer to: http://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines

2) We shouldn't be copying in functions verbatim from Python, that's 
potentially problematic for licensing reasons if nothing else.

3) I wonder, is this even necessary? It should be searching PATH already, thus 
we should be able to just put the name of the executable we want to run 
without needing to find the full path. Looking at the other fetcher modules we 
typically use "/usr/bin/env <command> <options>" so I think that should work 
here as well.

Cheers,
Paul

On Monday, 21 May 2018 2:51:52 AM NZST Tzu Hsiang Lin wrote:
> ---
>  lib/bb/fetch2/clearcase.py | 28 ++++++++++++++++++++++++++--
>  lib/bb/fetch2/npm.py       |  1 -
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
> index 36beab6a..28589dbc 100644
> --- a/lib/bb/fetch2/clearcase.py
> +++ b/lib/bb/fetch2/clearcase.py
> @@ -69,7 +69,6 @@ from   bb.fetch2 import FetchMethod
>  from   bb.fetch2 import FetchError
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
> -from   distutils import spawn
>  
>  class ClearCase(FetchMethod):
>      """Class to fetch urls via 'clearcase'"""
> @@ -107,7 +106,7 @@ class ClearCase(FetchMethod):
>          else:
>              ud.module = ""
>  
> -        ud.basecmd = d.getVar("FETCHCMD_ccrc") or 
spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
> +        ud.basecmd = d.getVar("FETCHCMD_ccrc") or 
_find_executable("cleartool") or _find_executable("rcleartool")
>  
>          if d.getVar("SRCREV") == "INVALID":
>            raise FetchError("Set a valid SRCREV for the clearcase fetcher in 
your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your 
choice.")
> @@ -207,6 +206,31 @@ class ClearCase(FetchMethod):
>              output = runfetchcmd(cmd, d, workdir=ud.ccasedir)
>              logger.info("rmview output: %s", output)
>  
> +    def _find_executable(executable, path=None):
> +        """Tries to find 'executable' in the directories listed in 'path'.
> +
> +        A string listing directories separated by 'os.pathsep'; defaults to
> +        os.environ['PATH'].  Returns the complete filename or None if not 
found.
> +        """
> +        if path is None:
> +            path = os.environ['PATH']
> +
> +        paths = path.split(os.pathsep)
> +        base, ext = os.path.splitext(executable)
> +
> +        if (sys.platform == 'win32') and (ext != '.exe'):
> +            executable = executable + '.exe'
> +
> +        if not os.path.isfile(executable):
> +            for p in paths:
> +                f = os.path.join(p, executable)
> +                if os.path.isfile(f):
> +                    # the file exists, we have a shot at spawn working
> +                    return f
> +            return None
> +        else:
> +            return executable
> +
>      def need_update(self, ud, d):
>          if ("LATEST" in ud.label) or (ud.customspec and "LATEST" in 
ud.customspec):
>              ud.identifier += "-%s" % d.getVar("DATETIME",d, True)
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index 730c346a..408dfc3d 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -32,7 +32,6 @@ from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
>  from   bb.fetch2 import UnpackError
>  from   bb.fetch2 import ParameterError
> -from   distutils import spawn
>  
>  def subprocess_setup():
>      # Python installs a SIGPIPE handler by default. This is usually not 
what
> 


-- 

Paul Eggleton
Intel Open Source Technology Centre



