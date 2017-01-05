Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id CF93F605C3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jan 2017 14:46:56 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP; 05 Jan 2017 06:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,321,1477983600"; d="scan'208";a="49857582"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.28.202])
	by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2017 06:46:55 -0800
Message-ID: <1483627614.7913.1.camel@linux.intel.com>
From: Joshua Lock <joshua.g.lock@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 05 Jan 2017 14:46:54 +0000
In-Reply-To: <1483624327-18607-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1483624327-18607-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: Evolution 3.22.3 (3.22.3-1.fc25) 
Mime-Version: 1.0
Subject: Re: [PATCH v2] prserv/serv: Tweak stdout manipulation to be stream safe
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
X-List-Received-Date: Thu, 05 Jan 2017 14:47:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-01-05 at 13:52 +0000, Richard Purdie wrote:
> We've been seeing oe-selftest failures under puzzling circumstances.
> It
> turns out if you run oe-selftest on a machine with xmlrunner
> installed
> and have the recent tinfoil2 changes, the launching of PR server
> crashes
> leading to selftest hanging if using an autoloaded PR server.
> 
> The reason is that xmlrunner uses an io.StringIO object as
> stdout/stderr
> instead of the usual io.TextIOWrapper and StringIO lacks a fileno()
> method.
> 
> We have to deal with both cases and in the python way, we try and
> then seek
> forgivness if we see an AttributeError or UnSupportedOperation
> exception.
> Unfortunately we have to deal with both cases as we may be performing
> a
> traditiional double fork() from the commandline, or a larger python
> program.
> 
> [YOCTO #10866]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/prserv/serv.py | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 350b085..d9b602f 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -242,12 +242,25 @@ class PRServer(SimpleXMLRPCServer):
>  
>          sys.stdout.flush()
>          sys.stderr.flush()
> +
> +        # We could be called from a python thread with io.StringIO
> as
> +        # stdout/stderr or it could be 'real' unix fd forking where
> we need
> +        # to physically close the fds to prevent the program
> launching us from
> +        # potentially hanging on a pipe. Handle both cases.
>          si = open('/dev/null', 'r')
> +        try:
> +            os.dup2(si.fileno(),sys.stdin.fileno())
> +        except (AttributeError, io.UnsupportedOperation):
> +            sys.stdin = si
>          so = open(self.logfile, 'a+')
> -        se = so
> -        os.dup2(si.fileno(),sys.stdin.fileno())
> -        os.dup2(so.fileno(),sys.stdout.fileno())
> -        os.dup2(se.fileno(),sys.stderr.fileno())
> +        try:
> +            os.dup2(so.fileno(),sys.stdout.fileno())
> +        except (AttributeError, io.UnsupportedOperation):
> +            sys.stdout = so
> +        try:
> +            os.dup2(so.fileno(),sys.stderr.fileno())
> +        except (AttributeError, io.UnsupportedOperation):
> +            sys.stderr = so

I think there's a copy/paste error here — shouldn't the second
try/except be duplicating/assigning se not so?

Joshua

>  
>          # Clear out all log handlers prior to the fork() to avoid
> calling
>          # event handlers not part of the PRserver
> -- 
> 2.7.4
> 

