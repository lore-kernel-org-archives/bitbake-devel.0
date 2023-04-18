Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E683C77B71
	for <webhook@archiver.kernel.org>; Tue, 18 Apr 2023 08:12:12 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.3278.1681805522024315718
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Apr 2023 01:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=b+tXhGmt;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 99F7720004;
	Tue, 18 Apr 2023 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681805520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzBotsuaLiW86aJxacK2vq9NBHkf5uXFSBLeUy4m/EU=;
	b=b+tXhGmtcwkBo+sqRqfwRJBwGD8rbf5MSKQXu3Zwtwp9jk3L5msGtT+qqCev61hbnJfIQV
	IU/ODwwDeOqUZ1Hu45+koOazSBuKJiI/DVqiMqtDCekT+3uyuHazIW9P2+N8GbLVND5NYR
	bNJvkgFow3DtkyTpuXHgRLHZAHht2pEzE2kH25f+Hg9TXndzhk+hWZO4JMqKGs2C6UYFss
	hRUgX1JhLczQ+HHWSuy6wF38LnYbCefRtUuM7Gb3sbUzq8F38HYkq2P3iujDKZLWnCT1ze
	wSl9P1MUEU2IJo+EQAiVQl4UcXvNfpIjNz7dQHfeLuYV7Mkd6o/8tWT6X2Dq9Q==
Message-ID: <4fac0d61-e7c6-ee9a-56e7-c06d728e6c45@bootlin.com>
Date: Tue, 18 Apr 2023 10:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel] [PATCH] npmsw fetcher: Avoid instantiating Fetch
 class if url list is empty
Content-Language: en-US
To: Svend Meyland Nicolaisen <public@smn.dk>,
 bitbake-devel@lists.openembedded.org
References: <a9dc503a-7de8-1daa-1987-d6fcfa9dbef1@bootlin.com>
 <25517.1681766281669450073@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <25517.1681766281669450073@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Apr 2023 08:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14713

Hi Svend

On 17.04.23 at 23:18, Svend Meyland Nicolaisen wrote:
> Thank you for your replies. I had a hassle getting SMTP to work using 
> gmail.com. Now I have sent the patch using "my own" smtp server, 
> wonder why I didn't do that on the first attempts.....
>
> Anyway the patch sent using git send-email ended up in this thread. Is 
> that OK?


Yes, everything looks good now and your patch applies nicely.
Thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


