Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB693CCFA13
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 09:56:35 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.39069.1727344586989712210
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Sep 2024 02:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=foy15vTc;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66F671C0003;
	Thu, 26 Sep 2024 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727344584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5WOC1D+wWy6WRw+4cpXskcObDRAB+IXmic3GJAbkEAM=;
	b=foy15vTcesyZhHuUfjf0t82gjegdwZ6XEcj0GjRrk9vFYXaaXSGTh2c3Vuo3KoVSlx7Tl2
	SOvHVEv3X+GkV2kmhcItL0113lzwZbWhOrUbs62DqVktntpm3erRbUTdHOPuuX71YIcF7g
	4bR/+jaV/cMUN2sFhQPqnfKlRraKcNRO8lkC9ZfDk8WxlgRnq8CiTn9Cp39ggBCZUPJXkk
	PwEx2v27LUxj0jYlGC97oW5lJCcP/SqrEzJBZ7z5sfhbSTn+blond89uuNxyJCoiobDx0c
	c2DTe8MW97GpOq5Tk4oDcGkmerB6KGUr+ubwIRQ1gvAFJmDUnS/SLHMTx6CjLg==
Date: Thu, 26 Sep 2024 11:56:22 +0200
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: swat@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Subject: toaster test_create_new_project_kirkstone fails
Message-ID: <ZvUvxuOLF6C_KD3F@bootlin-mathieu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 09:56:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16604

Hi,

Toaster TestCreateNewProject.test_create_new_project_kirkstone test is
failing for a few days with following error:

AssertionError: None is not true : The project release is not defined

Could you have a look ?

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/429/steps/12/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/428/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/427/steps/12/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/426/steps/12/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/425/steps/12/logs/stdio

-- 
Mathieu Dubois-briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

