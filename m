Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988FCC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:42:57 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.41014.1744011766947827760
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Apr 2025 00:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=m+h1ZT+u;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B47E744374;
	Mon,  7 Apr 2025 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744011765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQGDy1HsBwj4vPGCyDdOznRXwXIf61jC2nOOm6Qtscs=;
	b=m+h1ZT+u3NEFHWo5SQvyuiwwsbTGyM56V6C2t3pGXgUeNJpFkAIymUu2gecNI7K5hcmh3E
	ltaB85GmnzGij5k+JQpobLUppXz0HZZ9zmpd/5CTonFdXq/5LOq78Vlv/2JLtxpBBz+PZU
	8VvVpSNGDrClXAI43xwm4DpZ+S5JMjgureq+MVZo84fEy97+5p7kvPgPFFwk3lbf3FIBiw
	iQlU3nsqiuH3kxycipU/TJ4Y5M7X2OGd+mg0PCsZ/croTMyQDYZ007Fwkob5GVU/nRusZ2
	cMJz1Z/n03MXNqe6OmQsM7pvV16Gv7IjMF8r6Vx4OWPrnTdoLvAro6x/jWoU4A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Apr 2025 09:42:44 +0200
Message-Id: <D908KO2WFRBX.SV929Z98B99D@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: always fetch lfs when
 creating shallow tarball
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>,
 <peter.marko@siemens.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250404185911.137153-1-peter.marko@siemens.com>
 <D8ZMVRQ93Y3I.3NO1L0B4OG69A@bootlin.com>
In-Reply-To: <D8ZMVRQ93Y3I.3NO1L0B4OG69A@bootlin.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffellefgveekfeegheejiedutedukeffkeduvdevvddtgefgffffveefgfdvudenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrr
 hhkohesshhivghmvghnshdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Apr 2025 07:42:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17521

On Sun Apr 6, 2025 at 4:42 PM CEST, Mathieu Dubois-Briand wrote:
> On Fri Apr 4, 2025 at 8:59 PM CEST, Peter Marko via lists.openembedded.or=
g wrote:
>> From: Peter Marko <peter.marko@siemens.com>
>>
>> Before fast shallow tarballs the shallow tarball with lfs worked only
>> if the original .../downloads/git2/... directory existed. Once it was
>> not there, do_unpack on shallow tarball without lfs files failed due to
>> disabled network.
>> It was fixed for fast shallow tarballs and this commit fixes the other
>> scenarios, too.
>>
>> This can happen when such shallow tarball is put to mirror or if
>> someone does cleanup to reclaim disk space.
>>
>> Signed-off-by: Peter Marko <peter.marko@siemens.com>
>> ---
>
> Hi,
>
> Thanks for your patch.
>
> I have a failure on the autobuilder, it might come from this series but
> I'm not fully confident so far. I will try to drop it and see if this
> error remains:
>

Ok, I still have the same failure without this series. I will put it
back in my -next branches.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


