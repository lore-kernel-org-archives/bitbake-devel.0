Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CFC433FE
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 16:43:43 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web11.8535.1639759419317399773
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 08:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [192.168.67.164] (mm-214-81-214-37.mgts.dynamic.pppoe.byfly.by
 [37.214.81.214] (may be forged))
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 1BHGhWqw019296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Dec 2021 17:43:35 +0100
Subject: Re: [bitbake-devel] [PATCH] process: Do not mix stderr with stdout
To: bitbake-devel@lists.openembedded.org
References: <16BED60D9AF8ECE2.12270@lists.openembedded.org>
Cc: Baurzhan Ismagulov <ibr@ilbers.de>
From: Anton Mikanovich <amikan@ilbers.de>
Message-ID: <dc689a39-6fa3-a839-32a0-653e09b8d448@ilbers.de>
Date: Fri, 17 Dec 2021 19:43:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <16BED60D9AF8ECE2.12270@lists.openembedded.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Dec 2021 16:43:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13190

08.12.2021 19:57, Anton Mikanovich wrote:
> We should not redirect stderr to stdout if we need to get separated
> stdout and stderr contents from Popen.communicate() later.
>
> Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
> ---
>   lib/bb/process.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/process.py b/lib/bb/process.py
> index d5a1775f..af5d804a 100644
> --- a/lib/bb/process.py
> +++ b/lib/bb/process.py
> @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):
>           "close_fds": True,
>           "preexec_fn": subprocess_setup,
>           "stdout": subprocess.PIPE,
> -        "stderr": subprocess.STDOUT,
> +        "stderr": subprocess.PIPE,
>           "stdin": subprocess.PIPE,
>           "shell": False,
>       }

Can anyone review this change to proof the fix is correct?

-- 
Anton Mikanovich
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov


