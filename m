Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B0D2ED11
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 08:57:33 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2497.1768899451269356717
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 00:57:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mpMq+60h;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B5FF01A2956;
	Tue, 20 Jan 2026 08:57:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E7FD606AB;
	Tue, 20 Jan 2026 08:57:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2441110B6B31A;
	Tue, 20 Jan 2026 09:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768899449; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xO+cDepZgS0o2SHJH3DN1ETT7qcFFdg15JP9n9il3+Y=;
	b=mpMq+60hzvbyQ7qttPftJae+N9txp9OqOFwN1nTBvj/LacUiO2194cl/UQj7NgilMTsQU+
	vTsl1g9gGUZCcB1wbSWM2F2a6rdxsomnOvUiqpnHMa+Yi4IAhH+66BgYoWEYg8EO0QtrGT
	IckXu2/lKyRyWzprJuUSRAfK64Qp4sTT6qT9MwUfSOvjfSN5r/DY8ZJLrWOdBrqGWZVgdI
	PVuFbZfSH0lIodOBbO1TBXliSYm069VI0r/tNwxCpUxDf7eo4KLmpGcE1Warb2MBGTRX+T
	r3ANDGkrTGzzUdhDVGHmhDm+sKYU+J9ZwG+7dqqzGo3Dita8Fp+rI5Lly3yXEQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 09:57:27 +0100
Message-Id: <DFTAIRV9TAO0.L3XG0TA399R@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
Subject: Re: [docs] [PATCH 1/2] bin/bitbake-setup: add descriptions for
 fragment choices
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <docs@lists.yoctoproject.org>
References: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com> <20260116-bitbake-setup-choose-builtin-v1-1-8d66666a9efd@bootlin.com> <CANNYZj-Oh-WWLEhX=ZKpB2ddrR=oYseXBBgT-zQQ0CPUdA+HBg@mail.gmail.com>
In-Reply-To: <CANNYZj-Oh-WWLEhX=ZKpB2ddrR=oYseXBBgT-zQQ0CPUdA+HBg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 08:57:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18810

Hi,

On Fri Jan 16, 2026 at 7:23 PM CET, Alexander Kanavin wrote:
> On Fri, 16 Jan 2026 at 16:49, Antonin Godard via
> lists.yoctoproject.org
> <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
>> -                        "options" : ["machine/qemux86-64", "machine/qem=
uarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86=
-64"]
>> +                        "options" : {
>> +                            "machine/qemux86-64": "Machine configuratio=
n for running an x86-64 system on QEMU",
>> +                            "machine/qemuarm64": "Machine configuration=
 for running an ARMv8 system on QEMU",
>> +                            "machine/qemuriscv64": "Machine configurati=
on for running an RISC-V system on QEMU",
>> +                            "machine/genericarm64": "Machine configurat=
ion for Arm64 SystemReady IR/ES platforms",
>> +                            "machine/genericx86-64": "Machine configura=
tion for generic x86_64 (64-bit) PCs and servers"
>
> Let's make this properly extensible:
>
> options: [ {"name":"machine/qemux86-64","description":"Machine
> configuration for ..."}, {"name":...},...]
>
> Basically "options" remains a list, but each item in that list can be
> either a string, or a dictionary. That way more keys can be added to
> the dictionary in the future if needed.

Makes total sense, I'm about to send a v2. Thanks :)

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


