Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F807CFA753
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 09:14:43 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.17806.1728033282098170294
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Oct 2024 02:14:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=BfLTXmL2;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 185201BF207;
	Fri,  4 Oct 2024 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728033280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IG1tPU0lUNrEmWLX/D/o0ETYOHIhqJSyS2byuNln3Aw=;
	b=BfLTXmL2KVKys+wCdXc3NHemLWllnGPZarzMFaNzcQhKHV7HydweuMTIvoF/X6wUBNLzcz
	obgbD5VREgpj3Vyva9gCc97ku8oxsGFHtTGPvZyGs/TMqmMvhIihE8++wV/xSqagD+s+Rq
	1s6WR8LjqZC+c5M7gZVGv4sBsbxUMZKmWWudt7YZgVSEwW/ckJ0N3fJgUEnVk7WrQcOLb8
	GFFq7GT5MJcGVqCyHUcST0iny6wnRlezDHE05QMDkMuGSwAFqlwaXbF/ZWzRMklppZsKfj
	PMjYkj4pR+LpB8dpxU3p7U7aqVjyjJpi4yBVFwqB/SDBHrJLtgOnyj7Z4Y/k/A==
Date: Fri, 4 Oct 2024 11:14:38 +0200
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Cc: swat@lists.yoctoproject.org
Subject: Re: toaster test_create_new_project_kirkstone fails
Message-ID: <Zv-x_rjngPYSdnGX@bootlin-mathieu>
References: <ZvUvxuOLF6C_KD3F@bootlin-mathieu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvUvxuOLF6C_KD3F@bootlin-mathieu>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Oct 2024 09:14:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16637

On Thu, Sep 26, 2024 at 11:56:24AM +0200, Mathieu Dubois-Briand wrote:
> Toaster TestCreateNewProject.test_create_new_project_kirkstone test is
> failing for a few days with following error:
> 
> AssertionError: None is not true : The project release is not defined
> 

Hi Richard,

Any thought about this issue ?

I'm not sure what is the exact root cause of the error, it might be
related to commit d3c84198771b in bitbake:

https://git.openembedded.org/bitbake/commit/?id=d3c84198771b7f79aa84dc73061d8ca071fe18f3

Anyway, the issue is still present in today builds:

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/437/steps/11/logs/stdio

Best regards,
Mathieu

