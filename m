Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D993C4332F
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 17:22:42 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web11.318.1664817751587846925
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Oct 2022 10:22:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MpLpULOe;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 01C64100008;
	Mon,  3 Oct 2022 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1664817749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTXyxuGxfMDST+0byw4zoX7ICMwLrTPfBnf3dBJy74Y=;
	b=MpLpULOeZDm6Ez/kHS1XLgCrNtOgRO+yNSV2HGyjc+sm4NAN15Luw6TFcK5Lu3JMElDzMr
	ouZ80gCJEoypKdjyWL+KJ2WWdoPXook8eb1vLQzrwuH8VUGXe4AW6vbIggPFVZj6LHHxTw
	bPhZf5MIXK7q7vtN/vEBy/+Nhlgp15zWgK0grF5eOz85Fgk68xuCuQLJXU9/XQg1pg29Gk
	UbKxTxBcLWdoewH/WX/RqSXLNU03mLg7/jwQUDyeiab4n+khjgegus8mjtpAIHb9Ak8AeX
	72Sya92ExwCS/9L20TmywMK4FQ9vNfU7Wgh20rar7EDRvSr1ANKWfX+cTc5lZg==
Message-ID: <94f999c9-88ea-64a2-b4dc-1651bd52453e@bootlin.com>
Date: Mon, 3 Oct 2022 19:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ross Burton <ross.burton@arm.com>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>, docs@lists.yoctoproject.org,
 bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH v2] bitbake: user-manual: inform about spaces in
 :remove
Content-Language: en-US
To: Johan Korsnes <johan.korsnes@remarkable.no>
References: <20220929122133.261961-1-johan.korsnes@remarkable.no>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220929122133.261961-1-johan.korsnes@remarkable.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Oct 2022 17:22:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14012


On 29.09.22 14:21, Johan Korsnes wrote:
> Inform the reader that there should be no need for spaces in the value
> when using removal override `:remove`.
>
> Considering why spaces are used in the other override operators, it
> might seem obvious that they aren't needed for the removal operator.
> But, it seems like I'm not the first to be confused about this.
>
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Cc: Ross Burton <ross.burton@arm.com>
> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
>
> ---
> v1->v2
>   * better wording :)
> ---
>   .../doc/bitbake-user-manual/bitbake-user-manual-metadata.rst   | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 337821612c..bc27eb1b6b 100644
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -330,7 +330,8 @@ Removal (Override Style Syntax)
>   
>   You can remove values from lists using the removal override style
>   syntax. Specifying a value for removal causes all occurrences of that
> -value to be removed from the variable.
> +value to be removed from the variable. Unlike ":append" and ":prepend",
> +there is no need to add a leading or trailing space to the value.
>   
>   When you use this syntax, BitBake expects one or more strings.
>   Surrounding spaces and spacing are preserved. Here is an example::


Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


