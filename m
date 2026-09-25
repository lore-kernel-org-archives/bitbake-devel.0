Return-Path: <git@cookiesoft.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6477C9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 12:16:14 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6699.1790338571138925028
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Sep 2026 05:16:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cookiesoft.de header.s=MBO0001 header.b=LM2NOCl+;
 spf=pass (domain: cookiesoft.de, ip: 80.241.56.152, mailfrom: git@cookiesoft.de)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hrqRq2BRjzKp6q
	for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 14:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cookiesoft.de;
	s=MBO0001; t=1790338567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OjEWqJ7s8StISQX83EXuQyDKxie+ME3yVNPaNUELrZA=;
	b=LM2NOCl+vZNJoNxctc4WnLCNIQuuc0V+3H+soqjrkJpcq656cohhXThVpKMQCxUShzRnOS
	btwmVTWU1jQUMeQdfPYhKPUVSOM6Hpr/wu19VfvITrS3ZGKImcDENzl23qUi8T5Rl5BdR7
	/3Rn7IkXDDwUMFYHuLbRX/zD2rf/q7HvjXHh1myYXf8B/2pStVGIwhQgtnatPHXRIl4y3B
	p+Vb+9RnLBDB6qajyFR8O/DHQKCP2dChVSK7YXMEIrqNp1ioCrXwe1R0adVd8oIM3MOJBH
	WzV73iyk5WquwV969JYFxYYLZ1+2G2R7VXWv8dmbeZrSHK1cG8736hDstdT+Nw==
Date: Fri, 25 Sep 2026 14:16:06 +0200 (CEST)
From: git@cookiesoft.de
To: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Message-ID: <719659404.262685.1790338566452@app.mailbox.org>
Subject: Add OSC 9;4 to bitbake terminal runner
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 12:16:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20254

Hey everyone,

BitBake runs can take quite some time, and it bothers me that I don't have =
any visual feedback while a build is running.
So, I tried to make use of the OSC 9;4 feature[0] to get some visual feedba=
ck on what is happening.

I managed to get a first draft working, but honestly, I'm not really happy =
with how I integrated it into BitBake yet, and I could use some help with t=
hat.

I uploaded a diff that can be applied to the scarthgap branch[1].

I would really appreciate some feedback on the patch and on how I should go=
 about getting this merged. If someone is willing to take a look at it and =
maybe merge it directly, that would of course also be great.

Thank you very much!
Marcel


[0]: https://learn.microsoft.com/en-us/windows/terminal/tutorials/progress-=
bar-sequences
[1]:=C2=A0https://gist.github.com/hellow554/257ffa02b4e236ede8f1a5a46cc9ae8=
2

