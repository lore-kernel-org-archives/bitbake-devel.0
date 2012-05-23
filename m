Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXC6u-0004df-F0 for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 16:00:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NDoB8g013108;
	Wed, 23 May 2012 14:50:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12644-05; Wed, 23 May 2012 14:50:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NDo4E6013075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 14:50:06 +0100
Message-ID: <1337781002.8248.75.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Wed, 23 May 2012 14:50:02 +0100
In-Reply-To: <1337737597-5964-2-git-send-email-mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
	<1337737597-5964-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] build.py: Add additional debug messages
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
X-List-Received-Date: Wed, 23 May 2012 14:00:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-05-22 at 20:46 -0500, Mark Hatle wrote:
> We now add a debug message when entering and exiting a python or
> shell function.  This makes it easier to inspect a log and figure
> out the run order from the logs.
> 
> Also minor cleanup in th exec_func_shell to match the exec_func_python
> variables.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/build.py |   20 +++++++++++++++-----
>  1 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 4f06b15..2fbe120 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -206,6 +206,8 @@ def exec_func_python(func, d, runfile, cwd=None):
>              olddir = None
>          os.chdir(cwd)
>  
> +    bb.debug(2, "Executing python function %s" % func)
> +
>      try:
>          comp = utils.better_compile(code, func, bbfile)
>          utils.better_exec(comp, {"d": d}, code, bbfile)
> @@ -215,13 +217,15 @@ def exec_func_python(func, d, runfile, cwd=None):
>  
>          raise FuncFailed(func, None)
>      finally:
> +        bb.debug(2, "Python function %s finished" % func)
> +
>          if cwd and olddir:
>              try:
>                  os.chdir(olddir)
>              except OSError:
>                  pass
>  
> -def exec_func_shell(function, d, runfile, cwd=None):
> +def exec_func_shell(func, d, runfile, cwd=None):

Mixing variable renames with other code changes isn't really a good idea
and confuses this patch :/.

Cheers,

Richard



