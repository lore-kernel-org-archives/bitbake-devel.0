Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11317C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 09:42:59 +0000 (UTC)
Received: from forward501o.mail.yandex.net (forward501o.mail.yandex.net
 [37.140.190.203])
 by mx.groups.io with SMTP id smtpd.web12.8250.1644486176815263953
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 01:42:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=mail header.b=E8U5Z0ni;
 spf=pass (domain: zhukoff.net, ip: 37.140.190.203,
 mailfrom: pavel@zhukoff.net)
Received: from myt5-6c0659e8c6cb.qloud-c.yandex.net
 (myt5-6c0659e8c6cb.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:271e:0:640:6c06:59e8])
	by forward501o.mail.yandex.net (Yandex) with ESMTP id E9AF145C4C8C;
	Thu, 10 Feb 2022 12:42:52 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net
 (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
	by myt5-6c0659e8c6cb.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 wQb1l4l2e4-gqcOW0Wi;
	Thu, 10 Feb 2022 12:42:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; s=mail;
 t=1644486172;
	bh=0fgAWfFFUTRkO7JtCJCwhYwL+XfJYn1YUXgSUz64gIE=;
	h=In-reply-to:Reply-To:Subject:From:To:Date:References:Message-ID:
	 Cc;
	b=E8U5Z0ni1lczPzmFGbwhp8f1UvKBfdVDfh3cRqvtixEgnZUyBhm/ixHQKlyfQF57i
	 3MN7tC90deU2T4SAD1nd+s2abKkTuFq9tXimvMOi6nKd6l/39IBNV72cGJ2oNEN7Mt
	 fdnLUhZJXrWYr5HIGkye/g6qnCA0h2ngXNtrOhDE=
Authentication-Results: myt5-6c0659e8c6cb.qloud-c.yandex.net;
 dkim=pass header.i=@zhukoff.net
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id ukqlnW6zXO-gpHOfrqN;
	Thu, 10 Feb 2022 12:42:51 +0300
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Fwd: 2
References: <20220210092119.3994-1-tomasz.dziendzielski@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Pavel Zhukov <pavel@zhukoff.net>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Jan Brzezanski <jan.brzezanski@gmail.com>,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/git.py: Check if clonedir is not
 empty after shallow tarball clone
Date: Thu, 10 Feb 2022 10:39:14 +0100
Reply-To: pavel@zhukoff.net
In-reply-to: <20220210092119.3994-1-tomasz.dziendzielski@gmail.com>
Message-ID: <87fsor3vmp.fsf@gentoo.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 09:42:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13327


On 2022-02-10 at 10:21 +01, "Tomasz Dziendzielski" 
<tomasz.dziendzielski@gmail.com> wrote...
> If shallow tarball clone is used and if tar unpacking fails for 
> any
> reason it might end up with empty directory created. Since 
> runfetchcmd
> does not check any return code we might not detect the issue and 
> we will
> not clone from git. Then due to missing hash it will replace 
> main
> repository's git remote with the remote of failing recipe.
Maybe we should also check if ud.clonedir is top git directory (if
os.path.exist(".git") or better "git rev-parse --show-toplevel" ==
ud.clonedir) ? to prevent this from hapenning in the future. 
>
> Signed-off-by: Tomasz Dziendzielski 
> <tomasz.dziendzielski@gmail.com>
> Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 30da8e95..cd317633 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -356,8 +356,8 @@ class Git(FetchMethod):
>  
>          repourl = self._get_repo_url(ud)
>  
> -        # If the repo still doesn't exist, fallback to cloning 
> it
> -        if not os.path.exists(ud.clonedir):
> +        # If the repo still doesn't exist or is empty, fallback 
> to cloning it
> +        if not os.path.exists(ud.clonedir) or not 
> os.listdir(ud.clonedir):
>              # We do this since git will use a "-l" option 
>              automatically for local urls where possible
>              if repourl.startswith("file://"):
>                  repourl = repourl[7:]


-- 
Pavel

