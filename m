Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D5C5CFCF
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 14:31:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14135.1786717893738406039
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 07:31:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=PzVG0FBj;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 65A053D817DF;
	Fri, 14 Aug 2026 10:31:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6iUEb305zhXD; Fri, 14 Aug 2026 10:31:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E03EE3D81898;
	Fri, 14 Aug 2026 10:31:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E03EE3D81898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786717890; bh=Jy9MDqHTXHT9/S2+JRJUduVOJ9r0f0v5szy8pesN4ds=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=PzVG0FBj+cLtNqAc1hyf71RnDU5khWtDd6syQHJiqzkxyOd9tCAF3MCuHPY3MYr28
	 cTEXTWw6ZsJyTcj/Y4Eh16yOL+8ECWBF3puIWYQNMw8a+CwaLkALrvSB228x8rG8/B
	 xq3v5DzeY18KMR1G5yDZr98/CZuqPiASR7IMrWgxFxQ3V1X6PPF9kXqR7TzocB3LUY
	 V4EDTO2IoRkUHIJml1hrcFo+bGDEHto9rdVfMwHLye/LBlTlRtgFHX+p9NLxS917Fi
	 MphM3pm4GY2nj6uYlXPf61VumDLkoO4bBGsrl1ZCAWn5+u9evCSDPPF8xAz/rAXYoI
	 vws8z8TSLbDUQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OdB5iAukrgOs; Fri, 14 Aug 2026 10:31:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AA0F03D8182A;
	Fri, 14 Aug 2026 10:31:30 -0400 (EDT)
Date: Fri, 14 Aug 2026 10:31:30 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com> <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org> <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com> <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.15_GA_0126 (ZimbraWebClient - FF153 (Linux)/10.1.15_GA_0126)
Thread-Topic: toaster: Add recipe variables view
Thread-Index: FzqigGXBd+t8/KHi1qPc/wmlGo3Gxw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 14:31:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19936

Hi Richard,

Thanks for the feedback.

The 598 figure is the number of recipes in that build, not the number of
variables. Each recipe has its own build-specific snapshot, giving 19,756
variable and flag entries in total=E2=80=94around 33 per recipe on average.

Each snapshot contains the final resolved values specific to that recipe,
including changes from its .bb, matching .bbappend and included .inc files,=
 as
well as flags such as PACKAGECONFIG[...]. Values inherited unchanged from
global configuration or classes are excluded, along with functions and inac=
tive
overrides.

Screenshots of the linux-imx variables, bluez5 PACKAGECONFIG values and fla=
gs,
and variable counts in the recipes table are available here:

https://imgur.com/a/u20rf3O

Regarding history, the current implementation stores one resolved snapshot =
per
build. If build 1 resolves A to 1 and build 2 resolves it to 2, both builds
retain their respective values. It uses BitBake variable history for select=
ion,
but does not persist the complete assignment and operation history.

To provide a little more context, this work supports vulnerability assessme=
nt
in VulnScout through its new MCP functionality.

Build metadata and resolved variables provide useful context for producing =
an
accurate assessment. For example, PACKAGECONFIG can help identify the featu=
res
enabled in a recipe and the resulting attack surface.

Our longer-term goal is to expose relevant recipe and global variables thro=
ugh
Toaster and MCP, together with selected layer configuration such as kernel
defconfigs. This should give an agent enough build-specific context to prod=
uce
a more informed vulnerability assessment. For more information on VulnScout=
:

https://github.com/savoirfairelinux/vulnscout

Thank you also for the encouragement regarding the Toaster use case. I will
prepare v2 as an incremental series, separating data collection, database
storage and the user interface.

Cheers,
Paolo


----- Original Message -----
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Paolo Wattebled" <paolo.wattebled@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Sent: Thursday, August 13, 2026 11:58:45 AM
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view

On Thu, 2026-08-13 at 11:31 -0400, Paolo Wattebled wrote:
> Thanks for raising this. I ran a quick comparison with and without the ch=
ange.
> Toaster startup and recipe parsing were effectively unchanged (2m46.554s =
vs
> 2m46.835s). A cached imx-image-core build took 4m23.648s versus 4m07.387s=
,
> about 16 seconds slower. After vacuuming, both SQLite databases rounded t=
o 74
> MiB, including 598 per-recipe variable snapshots. I understand that some =
of
> this data is stored twice. However, I only store variables changed by rec=
ipes
> or bbappends, and I compress them before saving them. In my test, this di=
d not
> noticeably increase the database size.

This does raise a few more questions. I don't think you're covering all
the cases where variables change in recipes as *every* recipe will have
recipe specific values and 598 seems like a low number.

You appear to be only considering where overrides are used but
overrides aren't the only way variables can be changed as =3D+ and so on
are possible, or the value can just be overwritten.

I don't mind toaster reading out and storing the data but you may as
well just read the data, there is little point in changing the cache
structures to add/cache it?

It does also raise questions about whether you want the variable
history information too? (or will in future?)

> Our intended use of Toaster is as the backend for an MCP server for AI ag=
ents.
> Rather than having agents repeatedly parse and search recipe files or inv=
oke
> bitbake-getvar, the server would expose resolved, build-specific metadata
> through a stable API. The MCP layer is still under development, but per-r=
ecipe
> variable values are one of its planned endpoints. We chose Toaster becaus=
e it
> already models builds, recipes, packages and variables; extending it avoi=
ds
> creating a separate metadata store. It will run headlessly in this use ca=
se,
> with the MCP server translating between Toaster=E2=80=99s API and the age=
nt.

Thanks for the info, that does sound like an interesting use case for
it. It is reasons like this I've pushed back against deleting toaster!
Knowing a bit about your plans here does help me keep fighting to keep
that code!

I'd also note that your original patch is quite large and really should
make more increamental separte changes given the breadth of what it is
doing.

Cheers,

Richard

