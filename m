Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C0BCCA47A
	for <webhook@archiver.kernel.org>; Sat, 11 Jun 2022 14:03:02 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web08.6038.1654956175795056710
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Jun 2022 07:02:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ZlAMHBvh;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6FBDA1C0008;
	Sat, 11 Jun 2022 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1654956173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9KtvwdI6qgXS3CrFbTUMP6A28T7yJ9p/tX5Rob4YWk=;
	b=ZlAMHBvh4VEfvIiuYztj4bI+Uvl68FKOaWdZ3/AjGKQUns750m++WVgjDCuQljh+QR3SOq
	sVBad4qwiiuNNpx8w66a1pYtWI4eHn7VEh+CcFRAaVThf3qmqVbGhhmy+nrxH8pMySVT9Y
	4WmPewKE69/AhLHAcHxTx1+r2GWsXOZvLCwibNB0Fy+J3LyluIwE3RjF3BwjlRMdNCg3fr
	PcuaDocIRC/cVz92lICiaKlGthRyqAXBD7EUCvaN7aUL89ET/0gfpcSfZ/1ueWCzzooME0
	5tqC3sSz4HiOLMZAJTeLmKHxx1ijC2TZ9EvU/BNKs9j01f4xLAGBzvxmqc4/Pg==
Message-ID: <676e7ec4-b9db-49f2-f24f-7a842ac66680@bootlin.com>
Date: Sat, 11 Jun 2022 16:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20220610190845.181330-1-jacob.kroon@gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220610190845.181330-1-jacob.kroon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Jun 2022 14:03:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13756

Hi Jacob

On 6/10/22 21:08, Jacob Kroon wrote:
> Stating that the assignment is done at the end of parsing is misleading.
> The weak default value is the value which a variable will expand to if no value
> has been assigned to it using any of the assignment operators.
>
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>


Many thanks for this update!
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


