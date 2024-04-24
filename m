Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B6C4345F
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 09:20:45 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.12189.1713950442510233815
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Apr 2024 02:20:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=RMl56SYO;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 770314000C;
	Wed, 24 Apr 2024 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713950440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7WaJpZetEzwguOubk26g/dmdjgmt+5MHKffouo3lIU=;
	b=RMl56SYOtUGOpEYVm5IIaxzNOlsFcO8rHUNfUyFIlcyujeaEdVV5mcmTOxMn6rNt+naOS1
	HVxe/iO72bjXxMP3gQQogGDvK7hGhI0xtwtxDklCl1Fi2Rtuv1gjYigqXVEbLI4w5fDt+8
	v9fUkWWb7Tn0NJciC4zPwIfpUuFSFsioeudGGwZ6zsR4g07diMNmvFYfKgnwzXTnVmYd5g
	v557jI0VF/OMGQaExIuCI/XzVzR1VCSKDcUxfQnA9fyZes8k5yBgq7r2mK35yHTKUpjxXD
	tZkQ2h/91wsDgCOv25/xBOifFGBtwHiTVKS6AOAOMYBpnb8GNTE8t09kDWTS8Q==
Message-ID: <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
Date: Wed, 24 Apr 2024 11:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240423182543.226113-1-JPEWhacker@gmail.com>
 <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C929449F85DB18.1247@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Apr 2024 09:20:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16138

Hi Joshua

On 4/24/24 at 10:15, Michael Opdenacker via lists.openembedded.org wrote:
> Which branch did you use to generate your patch? I can't manage to 
> apply it to either "master", "master-next" or the branch I shared 
> recently...
>
> Ah, just found it. You used "nanbield".
>
> I'll test it in my branch and "torture" it with regular tests and my 
> new bitbake selftests.

Oops, the tests are failing:

======================================================================
ERROR: test_0b_db (prserv.tests.FunctionTests)
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/mike/work/yocto/poky/bitbake/lib/prserv/tests.py", line 
114, in test_0b_db
     self.assertTrue(self.table.test_package(version, pkgarch))
   File "/home/mike/work/yocto/poky/bitbake/lib/prserv/db.py", line 76, 
in test_package
     row=data.fetchone()
sqlite3.ProgrammingError: Cannot operate on a closed cursor.

Let me send you my patch series with your change included. I'll send 
them through a private e-mail. Don't want to spam the list at this stage.
Thanks
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


