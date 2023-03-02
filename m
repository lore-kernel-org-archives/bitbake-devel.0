Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D48C6FA8E
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 14:24:00 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.16854.1677767035499663376
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Mar 2023 06:23:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jKXQErvu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id D942C1C000A;
	Thu,  2 Mar 2023 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677767033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSIYDCS+h+HEBiJZzBjPzj5+aZar8b75qqmYw4iHrww=;
	b=jKXQErvu8oMQl7hNyufaaFeWwhDQVb/qv8+tDFcH/fsnwu31VfsJG2NMs07bUytvtcFRO0
	PSdj0GC2otwqdCV8I6qf13GuGetoJ50oh1NCprWpbm1gjKXn0rqklCMprFKFWbJSjCOQ1n
	zxF7RNh53QPZv2GjPZ1hKrbP1VhvauL6e7AD0s8SJ9DsXwK3hjcXI2m6vja4yk4TDI/8bb
	0NxYodNJ+FpBleyNrlz8qvfSpxcL/fuardF4p8h0kNwgKRCYTFWpR/Rfs2CBvYv9UQi3I0
	3wydCnNM2voFgqU22bB5PYSua9a4JqBlUG0+QkwV9aJeOTi8owbsLI8J5YXAGg==
Message-ID: <cdbc02fc-3e88-0fff-58c4-18a54b8f84c1@bootlin.com>
Date: Thu, 2 Mar 2023 15:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: docs@lists.yoctoproject.org, Ever ATILANO <ever.atilano@smile.fr>,
 Yoann CONGAL <yoann.congal@smile.fr>
Subject: Re: [docs] [PATCH v3 2/2] bitbake-user-manual: update Hello World
 example
Content-Language: en-US
To: Fawzi KHABER <fawzi.khaber@smile.fr>, bitbake-devel@lists.openembedded.org
References: <20230301131611.16265-1-fawzi.khaber@smile.fr>
 <20230301131611.16265-2-fawzi.khaber@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230301131611.16265-2-fawzi.khaber@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Mar 2023 14:24:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14513

Hi Fawzi,

Thank you for this other patch update.

For your information, the patch applies with whitespace warnings when I 
run "git am":

.git/rebase-apply/patch:102: trailing whitespace.

.git/rebase-apply/patch:114: trailing whitespace.

.git/rebase-apply/patch:116: trailing whitespace.

.git/rebase-apply/patch:136: trailing whitespace.

At least I see three lines containing just a few whitespaces. Not 
critical, but a bit distracting (my vim editor highlights them in red).

You may try to apply your own patch on branch "master", and see whether 
you're getting this or not.

On 01.03.23 at 14:16, Fawzi KHABER wrote:
> Fix broken link "Obtaining bitbake".
> Update documentation for the bitbake hello world example, the output was
> outdated.
> Fix LAYERSERIES_COMPAT warning by adding dunfell as default compatible release.
> Add proper formating for base.bbclass command.
>
> Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
> Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
> Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
> ---
>   .../bitbake-user-manual-hello.rst             | 89 ++++++++-----------
>   1 file changed, 39 insertions(+), 50 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> index 722dc5a2..2afa8e5c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> @@ -18,7 +18,7 @@ it.
>   Obtaining BitBake
>   =================
>   
> -See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
> +See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for
>   information on how to obtain BitBake. Once you have the source code on
>   your machine, the BitBake directory appears as follows::


Ouch, I also realize that the bitbake source directory contents in this 
section ("6.2 Obtaining BitBake") have changed too. Could you update 
them too?

All the rest is fine now (thanks!), and I get the same output as you do. 
Could you just resend a quick V4 correcting these?

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


