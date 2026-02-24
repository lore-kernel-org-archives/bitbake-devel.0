Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB0EEFB815
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 08:04:18 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15729.1771920253707233605
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Feb 2026 00:04:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ok72CqEK;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 91B304E41053;
	Tue, 24 Feb 2026 08:04:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 610135FD9D;
	Tue, 24 Feb 2026 08:04:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2F8C10368B84;
	Tue, 24 Feb 2026 09:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771920250; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lSSF0z7vIWA9QxrScYzqvzsRViFwVzbzZXedM2eqS/E=;
	b=ok72CqEKCPISbQr4u/dcj8jZbGzLljVRt/pVGdwWD2Wu9Al8xcZVTN4tpZpC3zJV3/x3pb
	23sC7dOklQxLMEn4X2t6Re35kMz/BxpytOeH1X+hKs47LhC5774cAEMmoDf7XklESeGi8u
	YKxcO85BpLa1rLlE1Jnlq/pF7uh4QudGdDreFG/LD5OCsKhWrBrke5uGrC1MLG4TOdGU0F
	eSKvQE/yJEw+6Kfe/KwYNtAXmYW7TugWhEMmzv5mwBQ2qrFtFC1OYA+Q2/MH6KG1QrJ1pK
	jgDTPTNyw7JV4zZaNSu90X+SyEC1uZqUXDZ3cpYSxT8RNSsAf9CS8MFnnzHb9A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 09:04:06 +0100
Message-Id: <DGN1AZTS0P6Q.2G1QBUYVST3ME@bootlin.com>
Cc: <docs@lists.yoctoproject.org>, "Robert P. J. Day"
 <rpjday@crashcourse.ca>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <quentin.schulz@cherry.de>, "Quentin Schulz" <foss+yocto@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual-ref-variables:
 BB_ENV_PASSTHROUGH is not in default BB_ENV_PASSTHROUGH_ADDITIONS (anymore)
X-Mailer: aerc 0.21.0-124-ga1ff16134ae6
References: <20260114-env-passthru-v1-1-fd5ef76eab61@cherry.de>
 <a0b211c4-320f-46cb-80db-d4dcbd56ef04@cherry.de>
In-Reply-To: <a0b211c4-320f-46cb-80db-d4dcbd56ef04@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Feb 2026 08:04:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19080

On Mon Feb 23, 2026 at 7:03 PM CET, Quentin Schulz via lists.yoctoproject.o=
rg wrote:
> Hi all,
>
> I don't see this in master/master-next so gentle ping (feedback of=20
> course welcome).
>
> Cheers,
> Quentin
>
> On 1/14/26 4:41 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>=20
>> BB_ENV_PASSTHROUGH_ADDITIONS variable doesn't contain BB_ENV_PASSTHROUGH
>> anymore since commit 0a33b560233b ("utils: remove BB_ENV_PASSTHROUGH
>> from preserved_envvars()") so let's fix this oversight.
>>=20
>> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> Suggested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.r=
st b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index af911f306..345da647e 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -286,8 +286,8 @@ overview of their function and contents.
>>         Specifies the internal list of variables to allow through from
>>         the external environment into BitBake's datastore. If the value =
of
>>         this variable is not specified (which is the default), the follo=
wing
>> -      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`,
>> -      :term:`BB_ENV_PASSTHROUGH`, and :term:`BB_ENV_PASSTHROUGH_ADDITIO=
NS`.
>> +      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`, and
>> +      :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
>>  =20
>>         .. note::
>>  =20
>>=20
>> ---
>> base-commit: f23e186a75e71ba885b9b53a1dfda99af29c67b0
>> change-id: 20260114-env-passthru-456899fe5a83
>>=20
>> Best regards,

Looking good to me

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

