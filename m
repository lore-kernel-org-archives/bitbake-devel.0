Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D4EC6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:40:13 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.39408.1679481609327894235
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Mar 2023 03:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=cyzxsR7V;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E3DDA60007;
	Wed, 22 Mar 2023 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1679481607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EkPH5UF6sB06m9olPkYJgXyw/OsYZ+tRWnaZjXMJsY=;
	b=cyzxsR7VkIq6C1eEcxajFc5DUtQmGdAmOehMKV8a9fP0asoHlVQcJVCIzpOJRG0kiYD1sG
	5m5AcRIz6nsoCn3EjuxQvyud4zmxgvoPdO4KaJIQFE/lNgz4by4OBf65aZe3YIIi7RZJvV
	UdEHTviHfz+iTre/7GnnEy4f/9Lvfz8twwSIzJiIqWaDK6wv7n6WiIMjCMj3PgqfLI8fut
	bUocIFFFAhZlTBy2DaXCKxy6CpjMzive8c/DZGk+znSW5Xj1P7a/u7CPiTBUb4MFMNZpq7
	QsfauccB5/1j9i9svjINHr2xQ12lRNz6ZABqMfZgjdt5doqdpqHuPCcZYPXcSg==
Message-ID: <29be3de3-8f66-6773-91c6-f0463d180d52@bootlin.com>
Date: Wed, 22 Mar 2023 11:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: git fetcher: use urllib quote
 ...
Content-Language: en-US
To: thilo.cestonaro@thalesgroup.com
References: <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Mar 2023 10:40:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14613

Hi Thilo,


Thanks for the patch!


On 22.03.23 at 09:37, Thilo C. via lists.openembedded.org wrote:
> to use the path url-compatible. This needs to happen before the shell 
> quotation happens.
>
> Without this commit, spaces in the clone URL will be used as " " and 
> not as "%20" which will fail.
> This commit changes the " " in the URL to "%20" when it is a http or 
> https url.
>
> Signed-off-by: Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>


Oops, are you sure it applies to the latest "master" branch? I tried and 
it didn't, though I don't see why...


Another issue with your patch is the commit author name, which will be 
"Thilo C. via lists.openembedded.org 
<thilo.cestonaro=thalesgroup.com@lists.openembedded.org>" instead of 
"Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>".


See 
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded#Fixing_your_From_identity 
for details and a solution.


Don't hesitate to try to send the patch again to me privately before 
resending to the mailing list...


Thanks again
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


