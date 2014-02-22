Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E13EB6E890
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 11:24:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1MBOJiX024885; Sat, 22 Feb 2014 11:24:20 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LqoMltEWnmVH; Sat, 22 Feb 2014 11:24:19 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1MBODta024879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 22 Feb 2014 11:24:16 GMT
Message-ID: <1393068245.5181.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Date: Sat, 22 Feb 2014 11:24:05 +0000
In-Reply-To: <c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: Disable pseudo in runfetchcmd()
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
X-List-Received-Date: Sat, 22 Feb 2014 11:24:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-02-20 at 15:55 +0100, Peter Kjellerstedt wrote:
> If a fetcher, e.g., git, is run when pseudo is active it will think it
> is running as root. If it in turn uses ssh (as git does), ssh too will
> think it is running as root. This will cause it to try to read root's
> ssh configuration from /root/.ssh which will fail. If ssh then needs to
> ask for credentials it will hang indefinitely as there is nowhere for it
> to ask the user for them (and even if there was it would not access the
> correct private keys).
> 
> The solution to the above is to temporarily disable pseudo while
> executing any fetcher commands. There should be no reason for them to be
> executed under pseudo anyway so this should not be a problem.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 3 +++
>  1 file changed, 3 insertions(+)

I'm more than a little concerned about why pseudo is active during
do_patch. It shouldn't be. Are you doing anything different with pseudo
in your build?

Cheers,

Richard

> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index de95074..1c3ee4f 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -680,6 +680,9 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
>          if val:
>              cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
>  
> +    # Disable pseudo as it may affect ssh, potentially causing it to hang.
> +    cmd = 'export PSEUDO_DISABLED=1; ' + cmd
> +
>      logger.debug(1, "Running %s", cmd)
>  
>      success = False



