Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E880C6FA8F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 09:08:26 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by mx.groups.io with SMTP id smtpd.web10.6955.1692868098339786762
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 02:08:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myneves.com header.s=protonmail2 header.b=TooPPnO2;
 spf=pass (domain: myneves.com, ip: 185.70.43.17, mailfrom: paulo@myneves.com)
Date: Thu, 24 Aug 2023 09:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail2; t=1692868095; x=1693127295;
	bh=Dh2LFuVpdSEPk6cgyc0xxKSMu3gJtA714PvrvY68Ris=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TooPPnO2Q71rL4YHY7QF5mgKmKqhqi1XdvQkoEVgRlKwnu6ZDcX8yuMR+lih9yFp+
	 Iy9RXFzfpyDvBTggMsDC6865ECwJYruOjlI2oS/aMjgZiOqkCmsyNzwImqSkJWvlVr
	 04ujrEyfbzdDgOUrFa7Z/c4wS11AX+P/RSLyZJGLfoiQQ8ZZFj6IbcwoIsyIvkrOSI
	 WHS3+xCbboQNVQ1DBJ7SBexW+OlSwQm5sP0AZTMLLblOYqZ4LbeMvw9uuIWwmlmaAy
	 hRvAHM1ma8s1WqrzDaxMnpw/Kjvr7VFLulNG+fDXHP7aduwNnbcKvw/ZA3P611aIip
	 W24JN6p9Im3iA==
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
From: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/1] siggen.py: Improve taskhash reproducibility
Message-ID: <144d51e1-327d-c150-04ca-167574eaa6bc@myneves.com>
In-Reply-To: <20230824095806.356563f2@booty>
References: <20230822203350.264625-1-paulo@myneves.com> <20230824095806.356563f2@booty>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 09:08:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14973

On 24/08/2023 09:58, Luca Ceresoli wrote:
> Hello Paulo,
>
> On Tue, 22 Aug 2023 20:33:58 +0000
> "Paulo Neves" <paulo@myneves.com> wrote:
>
>> file checksums are part of the data checksummed
>> to generate the task hash. The list of file checksums
>> was not ordered.
>>
>> In this commit we make sure the task hash checksum takes
>> a list of checksum data that is ordered by unique file name
>> thus guaranteeing reproducibility.
>>
>> Signed-off-by: Paulo Neves <paulo@myneves.com>
> Lots of errors like the following on the autobuilders are possibly
> caused by this patch:
>
> Hash for task dependency pseudo-native:do_populate_sysroot changed from f=
4435f759ac00c51c07eaa840d9d61249f38f82d39a8dbffa4e8f599d874a3c6 to 07a20019=
8639768d86d5c2c654fcbd0d4ea23d333e735848ac22c12474db1c2d
> (and a lot more errors)
>
> Logs:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5592/st=
eps/14/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5646/st=
eps/14/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1954/s=
teps/15/logs/stdio
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Thank you! I will have a look. Can you tell me how to run the test case=20
which is showing this? I think this may be related to me having a=20
different signature handler than the ones on the test.



