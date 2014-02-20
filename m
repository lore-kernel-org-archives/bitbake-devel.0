Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8BE6960167
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:42:32 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s1KFgW9K001943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 07:42:32 -0800 (PST)
Received: from Marks-MacBook-Pro.local (172.25.36.235) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.347.0; Thu, 20 Feb 2014 07:42:32 -0800
Message-ID: <53062267.3060605@windriver.com>
Date: Thu, 20 Feb 2014 09:42:31 -0600
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9;
	rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
In-Reply-To: <c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
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
X-List-Received-Date: Thu, 20 Feb 2014 15:42:34 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/14, 8:55 AM, Peter Kjellerstedt wrote:
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
>   bitbake/lib/bb/fetch2/__init__.py | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index de95074..1c3ee4f 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -680,6 +680,9 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
>           if val:
>               cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
>
> +    # Disable pseudo as it may affect ssh, potentially causing it to hang.
> +    cmd = 'export PSEUDO_DISABLED=1; ' + cmd
> +

This may be a reasonable workaround... but is there any way we can identify the 
offending command and create a reproducer for pseudo?  It would be nice to 
identify what the actual problem is -- as something else in the system may 
encounter it.

--Mark

>       logger.debug(1, "Running %s", cmd)
>
>       success = False
>


