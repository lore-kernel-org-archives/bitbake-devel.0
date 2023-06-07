Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DAC77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 19:44:56 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.7939.1686167093935642319
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Jun 2023 12:44:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Y2TdRpSQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: alexandre.belloni@bootlin.com)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686167091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcRjhCLc/rkY1IYCgCoCXhD7OZt901DBwppBfnxQo6A=;
	b=Y2TdRpSQDNta5SWr+V/LMwJkouv4kid817FGT0IzI6FFnJk97OmegCx+ysJ9k4d9qcjWji
	ZZHLtwGc+qXRQAUcTz8FQf8g0HBqJvWZEpNlTS1Ez+ldlDF7+3xyWHYZ8SIBgiQYjEWZPw
	k9sJRsSUmC3dXMfHG3/aOY01SAi173SeiMEOmJsJaVFp0PjOd4gmGTINWukQwhyv9yQLyE
	DgSBa5/0V5mQcBT7inOgg3YDdLs4CQ//rPPZQwmrZQv1wQOQSpm5h5+/TfgfGlYAox+F/R
	9JKibMjpus7+9jqHWSiTjwlaJ+IeXpjNbkZKWQOVyFPL9l5Ye249857kBIq/aA==
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94E75E0002;
	Wed,  7 Jun 2023 19:44:51 +0000 (UTC)
Date: Wed, 7 Jun 2023 21:44:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: belouargamohamed@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [master][PATCH v2 1/3] bitbake: fetch2: npmsw:
 Add support for the new format of the shrinkwrap file
Message-ID: <2023060719445181fe929b@mail.local>
References: <20230607124341cf23201f@mail.local>
 <10759.1686143126935354416@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10759.1686143126935354416@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Jun 2023 19:44:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14834

On 07/06/2023 06:05:26-0700, belouargamohamed@gmail.com wrote:
> Hello,
> 
> I just made a look on this test: test_npmsw_no_network_no_tarball
> 
> It seems to me that it is outdated. Latest versions of Nodejs do not use the shrinkwrap that test_npmsw_no_network_no_tarball used.

Then, you need to update the test and ideally, add coverage for what you
are adding.

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14833): https://lists.openembedded.org/g/bitbake-devel/message/14833
> Mute This Topic: https://lists.openembedded.org/mt/99314980/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

