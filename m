Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rlcrt-00033g-Pf for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 09:52:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0D8ieh4018878;
	Fri, 13 Jan 2012 08:44:40 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18711-03; Fri, 13 Jan 2012 08:44:35 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0D8iX5o018872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Jan 2012 08:44:34 GMT
Message-ID: <1326444277.11214.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthew McClintock <msm@freescale.com>
Date: Fri, 13 Jan 2012 08:44:37 +0000
In-Reply-To: <1326409741-17390-1-git-send-email-msm@freescale.com>
References: <1326409741-17390-1-git-send-email-msm@freescale.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake/fetch2: add support for wrapper command
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
X-List-Received-Date: Fri, 13 Jan 2012 08:52:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-01-12 at 17:09 -0600, Matthew McClintock wrote:
> cc: bitbake-devel@lists.openembedded.org
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
>  lib/bb/fetch2/__init__.py |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 3af56e5..1d7d5c7 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -389,6 +389,8 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
>      Optionally remove the files/directories listed in cleanup upon failure
>      """
>  
> +    cmd = "%s %s" % (bb.data.getVar("BB_FETCH_WRAPPER", d, True), cmd)
> +
>      # Need to export PATH as binary could be in metadata paths
>      # rather than host provided
>      # Also include some other variables.

Er, this is going to break for anyone who doesn't have BB_FETCH_WRAPPER
set. It would be nice to document why you require this in the commit
message (I can guess). Since I'm rejecting this patch, can the next one
document the new variable in the fetcher section of bitbake manual too
please? :)

Cheers,

Richard



