Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6760CC6B08
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 12:09:50 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5530.1791893379548319898
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 05:09:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=uS9mNM2s;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 422A81A11FE;
	Tue, 13 Oct 2026 12:09:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA4E160362;
	Tue, 13 Oct 2026 12:09:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AB3111D7102C;
	Tue, 13 Oct 2026 14:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791893376; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EedBgx7OtibGBr2Q2OXHGRNXd8+8LXhQvaqKnfWFPqQ=;
	b=uS9mNM2sf1cAxfHfNUxmFzOMfjeX3arssZoPQoxSkRuDBQycKwnwL2LZPwGQpxolvldjWM
	OdDMi1jWhowPF2yCO/2bc7Z7RH0oz65giYIzo/q/UTdBaiM+Ph+zJ6U9i3tHbzarEt4Qnq
	VN55rlw1EW5W0B5WAqTGukZqRYoL9vgJAakV8eNgez1WEnBaSowBFUt1delhJ6HJ1BM8U+
	3W++Pg1iYS4gWgrLu04wu72ZW3dx3FElTU92/TcDIdyGPL2TTk/1uyNZSWV8XZyD4ktb15
	y+1k8qFEC1Gb65kzin7xxl/szRuzmFVPJPZK4i9pgvMUDowKgzf+pmvlkG3xYQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 14:09:32 +0200
Message-Id: <DM3P6R5ZRVPM.3PW3QYG9BZOEI@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>,
 <richard.purdie@linuxfoundation.org>
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech> <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com> <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com> <1791885365.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425@vates.tech>
In-Reply-To: <1791885365.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425@vates.tech>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:09:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20324

On Tue Oct 13, 2026 at 11:56 AM CEST, Yann Dirson via lists.openembedded.or=
g wrote:
>
>
> On 10/12/26 3:20 PM, Antonin Godard wrote:
>> On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists.openembedd=
ed.org wrote:
>>> Hi,
>>>
>>> On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists.openembedde=
d.org wrote:
>>>> Reported-by: Claude Opus 5.5
>>>> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
>>>> ---
>>>>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 +++++++=
+
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> index 621aab253..eef1f9624 100644
>>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automatic=
ally, and if the imported
>>>>   module specifies an attribute named ``BBIMPORTS``, that list of
>>>>   sub-modules is iterated and imported too.
>>>>  =20
>>>> +Additionally, Bitbake will detect usage of functions from such a
>>>> +library and include them in task hashes, so changes in those function=
s
>>>> +trigger task rebuilds.  Note that only functions inside modules
>>>> +declared using ``BBIMPORTS`` benefit from this dependency tracking,
>>>> +any name defined directly in the specified namespace (e.g. in
>>>> +`<namespace>/__init__.py`, or in a library hat would be defined as
>>>
>>> s/hat/that/
>>>
>>>> +`<namespace>.py`) would *not* benefit from this tracking.
>>>
>>> Otherwise, this is clear to me. I did not know about this limitation/fe=
ature,
>>> and this is definitely important to document, thanks!
>>=20
>> Reading the code[1], it seems that functions prefixed with _ are not inc=
luded
>> in the task checksums - if I understood correctly. I think it would be a=
lso
>> important to mention that. Could you add it in a v2?
>
> It could be asked why we would want to exclude them.  Usually that would=
=20
> be internal functions, to be called by the exported ones, so they would=
=20
> equally matter - but then they are actually not included in the task=20
> hash, so it rather looks like a bug rather than something to document?

You're right, it seems strange to exclude them entirely. You may want to se=
nd a
patch to remove this then? At least it will kick-off the discussion on this
list.

Thanks,
Antonin

