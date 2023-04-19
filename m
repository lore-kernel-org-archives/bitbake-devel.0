Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C6AC77B73
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 07:46:08 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web11.32199.1681890366439095822
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Apr 2023 00:46:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mFrKHnoB;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2F053100003;
	Wed, 19 Apr 2023 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681890364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFsERlStMP0sGGEF1r60itJQuM5CKsDWbW3Y0Dg5gag=;
	b=mFrKHnoB1pJeml51V+X6rrWAS5QfBUFnd/R1djXGGImUETNIYvtT4C2G4PfKihHjHKyOSC
	mqccNey8FHbHxZPllS748IH3Z5K/1wEAIoxljdMs191HePGYryT4XfU0Ml0sNiyUow5kj0
	yyUZ1Kz/6betcr0wUUf5j3BAtRjxeUfUVme3r02AFXZsMiAWGKesdHy0rbxLLBL5CN6jPK
	F1cIv8zj7085DkEUYU02uBKBiaEQbJM6l+QEZP5vVC7wHa3pr2GExd0i+G9UREuAOv95xT
	0uLf2lqdrjoWXkH/FuKCA4BofAVFa2WlAZ5okXLDTHTIm/Q2A//KjpRxcBurgQ==
Date: Wed, 19 Apr 2023 09:46:01 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Svend Meyland Nicolaisen" <public@smn.dk>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] npmsw fetcher: Avoid instantiating
 Fetch class if url list is empty
Message-ID: <20230419094601.534c38c2@booty>
In-Reply-To: <17294.1681851379281342528@lists.openembedded.org>
References: <20230418122451.2e24ce87@booty>
	<17294.1681851379281342528@lists.openembedded.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Apr 2023 07:46:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14719

Hi Svend,

On Tue, 18 Apr 2023 13:56:19 -0700
"Svend Meyland Nicolaisen" <public@smn.dk> wrote:

> Hi Luca,
> 
> Thank you for your mail. I am sorry that I forgot the sign-off option the second time around. I have now sent the patch again including sign-off and tagged as PATCH v2.
> 
> I could however not get the -v option on git commit to work. As far as I can see the -v option means verbose. I used --subject-prefix on git send-email instead. I hope everything is OK now.

Ah, sure, my mistake: the -v<N> option is for git format-patch, not git
commit. Apologies.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

