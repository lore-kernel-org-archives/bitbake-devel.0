Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05BC54E60
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 13:50:50 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.15968.1710856245094860774
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Mar 2024 06:50:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=c6DTj+eD;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 427A51C0002;
	Tue, 19 Mar 2024 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710856242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkG6wrXBJWt0DHteo7bGFuOq9cQQLjmlkSon2lk4H6k=;
	b=c6DTj+eDV2S8yx1w4XwkWo5vLlEu3OKZCYUGpQl9AJLcaCQ+HX2zyAPdL5d13jgWVpmSQZ
	5kT4w8dfKxVX3UZ1Y2LVtJT6r7VIoG80LOkFtdeOBKTDzOnbdIqeAdeFNy9eHVdcETfgCE
	TepAt/deslFRJ1Rje92UZmvgfZYLQSpH9Xb4dGH5DYgqSXREjFNvS3zzBawPpDuaJSlY89
	g2bSCARHjLDM6gTKdSZBge8wg4neHg/ukFWMgnZ2YdrHyJeUk+c/JC36nADK7N7gJUxTiy
	9NWF/SHmbChDA1jdiNg2SvBzyclI+8U0qnPp56Hi3lLr3PuQM9rhn8VQHVNkJw==
Message-ID: <f83c0876-9fb0-4b41-be6b-cc0dd0fa36f8@bootlin.com>
Date: Tue, 19 Mar 2024 14:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Alexander Kanavin <alex@linutronix.de>,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] bitbake: improve descriptions of '-S
 printdiff'
Content-Language: en-US
To: Alexander Kanavin <alex.kanavin@gmail.com>
References: <20240318145218.1192363-1-alex@linutronix.de>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240318145218.1192363-1-alex@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Mar 2024 13:50:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16010

Hi Alex,

On 3/18/24 at 15:52, Alexander Kanavin wrote:
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   .../bitbake-user-manual/bitbake-user-manual-execution.rst  | 7 ++++---
>   bitbake/lib/bb/main.py                                     | 4 +++-
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index 4fa3ca4b54f..d58fbb32ea0 100644
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -586,10 +586,11 @@ or possibly those defined in the metadata/signature handler itself. The
>   simplest parameter to pass is "none", which causes a set of signature
>   information to be written out into ``STAMPS_DIR`` corresponding to the
>   targets specified. The other currently available parameter is
> -"printdiff", which causes BitBake to try to establish the closest
> +"printdiff", which causes BitBake to try to establish the most recent
>   signature match it can (e.g. in the sstate cache) and then run


Not your original text, but removing "it can" would be clearer as in the 
documentation patch you also sent.
By the way, don't forget to CC the docs@ mailing list when a BitBake 
patch touches the BitBake manual. This way, you make sure I don't miss it :)

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


