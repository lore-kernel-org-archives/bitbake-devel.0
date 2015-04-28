Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8E26672A78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 16:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3SGkCc3003154; Tue, 28 Apr 2015 17:46:12 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ONFPwlwZHdtZ; Tue, 28 Apr 2015 17:46:12 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3SGk18I003112
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Apr 2015 17:46:12 +0100
Message-ID: <1430239561.13022.239.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mariano Lopez <mariano.lopez@linux.intel.com>
Date: Tue, 28 Apr 2015 17:46:01 +0100
In-Reply-To: <553E609E.2090608@linux.intel.com>
References: <553E609E.2090608@linux.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2/git: Add URL when latest_revision generates an exception.
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
X-List-Received-Date: Tue, 28 Apr 2015 16:46:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-04-27 at 11:15 -0500, Mariano Lopez wrote:
> The URL is not sent when _latest_revision generates and exception.
> When performing the sanity checks it is not possible to know the URI 
> that failed.
> 
> This add the URL when latest_revision generates an exception.
> 
> Please disregard previous patch with the same topic.

Please put a message like the above which need not be part of the final
commit below the --- separator below.

> [YOCTO: #7592]
> 
> Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
> ---
>   bitbake/lib/bb/fetch2/git.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 0fd9bee..0d91431 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -352,7 +352,7 @@ class Git(FetchMethod):
>               for l in output.split('\n'):
>                   if s in l:
>                       return l.split()[0]
> -        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream 
> git repository in git ls-remote output" % ud.unresolvedrev[name])
> +        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream 
> git repository in git ls-remote output for %s" % 
> (ud.unresolvedrev[name], ud.host+ud.path))
> 
>       def latest_versionstring(self, ud, d):
>           """

Sadly I can't get this patch to apply since the mail client you've sent
this with has mangled the patch with linewrap and done something ugly to
the whitespace.

Cheers,

Richard


