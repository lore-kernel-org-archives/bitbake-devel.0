Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A8C77B70
	for <webhook@archiver.kernel.org>; Mon, 17 Apr 2023 09:26:31 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.50393.1681723585686498612
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Apr 2023 02:26:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ScJ1wa5f;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A52E81C000E;
	Mon, 17 Apr 2023 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681723583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IAalhDUp44QVkJesfOLvbWgHVbsb7P5w/CksT2LUnQ=;
	b=ScJ1wa5fxoay7dIigbWPnWeS9osds6eKVFUwm7+t8EA7ebp4F/7fBFm4P5zp2a5Fb09t4T
	qOMN4IyiL3XepX100kM6+LmoFUyCBhNdguSSnbzhitni54Vv0mqj5I0iZr8pFD8bsJM2H6
	aeyGRqKR28dk1WchUFFaiIjEnE/Xd0CnnUCDANwD7KfXPs70bw09zRoP3HlSjaKjdChAau
	bUJt6bQYOYhUM3FDyuruatHGy0/Iu+jr9DPaeD2FlgIaCjNPwpeC1zrazjNcZ/bak4yrSb
	qhqbIjuHC6VP9YM0Yz5iPPWGvnJNMCQgBbA+r/7flP++Z+7ri9SsCAJTyBcE8w==
Message-ID: <a9dc503a-7de8-1daa-1987-d6fcfa9dbef1@bootlin.com>
Date: Mon, 17 Apr 2023 11:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: bitbake-devel@lists.openembedded.org, luca.ceresoli@bootlin.com
Subject: Re: [bitbake-devel] [PATCH] npmsw fetcher: Avoid instantiating Fetch
 class if url list is empty
Content-Language: en-US
To: public@smn.dk
References: <czCu.1681675635331210887.i1y4@lists.openembedded.org>
 <20230417095342.67ee03f9@booty>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230417095342.67ee03f9@booty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Apr 2023 09:26:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14709

Hi Svend

On 17.04.23 at 09:53, Luca Ceresoli via lists.openembedded.org wrote:
> Hello Svend,
>
> On Sun, 16 Apr 2023 13:07:15 -0700
> public@smn.dk wrote:
>
>> Recipes containing both git and npmsw sources in the SRC_URI
>> fail during fetch from the shrinkwrap. It seems that when the fetcher is
>> fetching from the shrinkwrap, the SRCREV variable has been deleted but it
>> still ends up fetching from the git source resulting in an error because
>> SRCREV is undefined. The root cause of this is that the Fetch class defaults
>> to urls from the SRC_URI when the urls parameter contains an empty list. This
>> patch will ensure that Fetch is not instantiated if the urls list is empty.
>>
>> Signed-off-by: Svend Meyland Nicolaisen <public@smn.dk>
> Thanks for your patch. However it does not apply using 'git am',
> because it is an HTML e-mail.
>
> The simplest way to send a properly formatted patch is using 'git
> send-email'.
>
> For more info read:
> https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded


In particular, make sure you don't miss 
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded#Fixing_your_From_identity, 
because the way your e-mail is configured, you won't have a correct git 
"Author" field, which should match your "Signed-off-by" information.

Thanks in advance :)
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


