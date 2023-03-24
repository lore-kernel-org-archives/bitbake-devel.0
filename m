Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA88C6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 10:13:26 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.97245.1679652800398510861
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Mar 2023 03:13:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=UGGIhroS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 52078FF804;
	Fri, 24 Mar 2023 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1679652798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATQ/3P8bkOnlbuKVZYuMsBrnqgd0t+V76ra2od13MyI=;
	b=UGGIhroSf29Nll6138UfcGs+J9/2ODaKCxZkxsgeT2jedTaud4z/XVMInpo/JD75VmX+gI
	Mkv0weAXs1z2UqiBkbjKqzDXlC+9KBuG3rq6fadYF+sb/uF7yI3dAWhTbnhNwogwmR3WMP
	gF8W0mrBQ2xxGOT0VDe5s80o+uP9wkQ0SCMoP1d6cCPf7G8oiw7MzIZ6gNbtODFcgVQRNX
	DtXESskKOd1XY8TbL62i0TcVzjezaC1NTBi2MvdMAFy3LHgThvXlponmAKHEkOlInAI+Sd
	QMcSOa8jnIqx7dh/ssm9hYGiKg8EYkktXDXbz116m6TMnIpswxUDsT3fzIbGgg==
Date: Fri, 24 Mar 2023 11:13:18 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: thilo.cestonaro@thalesgroup.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: git fetcher: use urllib quote
 ...
Message-ID: <202303241013185928d3b5@mail.local>
References: <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 10:13:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14617

Hello,

This doesn't apply on master, can you rebase?

Thanks

On 22/03/2023 08:37:15+0000, Thilo C. via lists.openembedded.org wrote:
> to use the path url-compatible. This needs to happen before the shell quotation happens.
> 
> Without this commit, spaces in the clone URL will be used as " " and not as "%20" which will fail.
> This commit changes the " " in the URL to "%20" when it is a http or https url.
> 
> Signed-off-by: Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>
> ---
>  lib/bb/fetch2/git.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 578edc59..dc7f848d 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -66,6 +66,7 @@ import re
>  import shlex
>  import subprocess
>  import tempfile
> +import urllib
>  import bb
>  import bb.progress
>  from contextlib import contextmanager
> @@ -697,7 +698,12 @@ class Git(FetchMethod):
>              username = ud.user + '@'
>          else:
>              username = ""
> -        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
> +
> +        path = ud.path
> +        if ud.proto in [ 'http', 'https' ]:
> +            path = urllib.parse.quote(ud.path)
> +
> +        return "%s://%s%s%s" % (ud.proto, username, ud.host, path)
> 
>      def _revision_key(self, ud, d, name):
>          """
> --
> 2.37.2
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14612): https://lists.openembedded.org/g/bitbake-devel/message/14612
> Mute This Topic: https://lists.openembedded.org/mt/97773918/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

