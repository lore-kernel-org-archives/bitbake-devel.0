Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E50BECD98C
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 17:03:42 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25758.1770311015597701813
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 09:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iXdbenWR;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A51791A2C2E;
	Thu,  5 Feb 2026 17:03:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5DB196074D;
	Thu,  5 Feb 2026 17:03:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45C0C119A865B;
	Thu,  5 Feb 2026 18:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770311011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dCGjQldTwmcyVbpTKB4MoROqlHJPRAGr7GQk4QUKQcQ=;
	b=iXdbenWRDwuwtmDeMojvStkWgYgyLOSnCHZpry0JgGgexNN7sakFGpprtHf59HhHm9rp8F
	xqtHd+C2c4/F6OijK0Yk+4bOfSkD4gqxcyjSPQPj9A/tHw+CuCUok6JYTLQ+6ocA0TFZbB
	PxLWVjXiSSwegV2nsnSlSObtUJOiIxpF6siFtyVq+lezi9m35VOqHCY/GBZS0a2Md860e/
	OF0rpKkvmUf5cmlwEEPp3I4z+kN/5hrLAKp0urWgEm7AUf4/uKWhj2yW9eLm3SIZxHlQNX
	098O1TZVnA4hLTvxqLmSqWPJzFSVqI+YfPdRAA+Bh4kaUGj5eetZdehuTu8QfA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 18:03:27 +0100
Message-Id: <DG76VLF8D903.YLEI8EUYHKPV@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bin: Hide os.fork() deprecation warning
 at module level
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Chen Qi"
 <Qi.Chen@windriver.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260205-mathieu-fork-warning-filter-v1-1-e4bef89403c1@bootlin.com> <3fd43d892d87fee01b906801cec60b05bb203feb.camel@linuxfoundation.org>
In-Reply-To: <3fd43d892d87fee01b906801cec60b05bb203feb.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 17:03:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18973

On Thu Feb 5, 2026 at 4:29 PM CET, Richard Purdie wrote:
> On Thu, 2026-02-05 at 15:13 +0100, Mathieu Dubois-Briand via lists.openem=
bedded.org wrote:
>> Add the message filtering directly in the python module where the error
>> happens, so we do not need to repeat the filter in all consumers. This
>> will also make sure the filter is applied in any user of createDaemon().
>>=20
>> Fixes [YOCTO #16080]
>>=20
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> Suggested-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
>> =C2=A0bin/bitbake=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>> =C2=A0bin/bitbake-layers=C2=A0 | 1 -
>> =C2=A0bin/bitbake-server=C2=A0 | 1 -
>> =C2=A0bin/bitbake-worker=C2=A0 | 1 -
>
> Nearly! :)
>
> You need to leave bitbake-worker alone as it has a different use of
> os.fork().
>

Right! I missed that point, sending a v2.

Thanks,
Mathieu


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


