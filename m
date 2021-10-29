Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B66C433F5
	for <webhook@archiver.kernel.org>; Fri, 29 Oct 2021 13:00:51 +0000 (UTC)
Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web10.4996.1635512450940982007
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Oct 2021 06:00:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com
 ([174.114.107.13]:36202 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1mgRV4-0004IX-V9; Fri, 29 Oct 2021 09:00:49 -0400
Date: Fri, 29 Oct 2021 09:00:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Add a warning asking users
 to set a branch in git urls
In-Reply-To: <20211029125759.3422953-1-richard.purdie@linuxfoundation.org>
Message-ID: <6bf1558f-a35b-a349-2d43-3ce34945b69a@crashcourse.ca>
References: <20211029125759.3422953-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id:
 rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Oct 2021 13:00:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12847

On Fri, 29 Oct 2021, Richard Purdie wrote:

> There is much uncertainty around what tools and hosting providers will
> do about default git branch naming in the future. To help ensure we
> can handle the various scenarios, we will make branch names required in
> SRC_URI. To start that process, show users a warning if it isn't set.
> This may also allow us to change the default at some point in the future.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 51b616bad7..17a7927e52 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -165,7 +165,10 @@ class Git(FetchMethod):
>              ud.nocheckout = 1
>
>          ud.unresolvedrev = {}
> -        branches = ud.parm.get("branch", "master").split(',')
> +        branches = ud.parm.get("branch", "").split(',')
> +        if branches == [""]:
> +            bb.warn("URL: %s does not have any branch set. The uncertainty around the default branch used by tools and repositories means we will soon require this in all git urls so please add it." % ud.url)
> +            branches = ["master"]
>          if len(branches) != len(ud.names):
>              raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)

  pedantically, i would "git urls" -> "Git URLs".

rday

