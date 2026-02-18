Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F9E9A03B
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 08:47:50 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8053.1771404463635956128
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 00:47:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=P9y86UBB;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2E97AC1D732
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 08:47:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5946F60738;
	Wed, 18 Feb 2026 08:47:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E187710368334;
	Wed, 18 Feb 2026 09:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771404460; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zksTQQCXG4aroURmYqTk+v32xStAoZXGHMkNar2r/u0=;
	b=P9y86UBBesQt37iOqogkMiI0Plj/P3q2ZDYYr/gQ2LNe3wLxeELKxhJi8eLzij5MokM3AC
	swjHN+3+U3B7xrkIddIIUppGly67XVc5XC8jmd069uldWl+/8dQck7tNwEqfXIt1TbCujz
	UUrfrJznLkGH55A8IwNn0inDOAZ7qOdjo+JEu0J4jzKeC1EkXFwhwhl4P0qTzrdgTtqKJF
	/T2H9/Ufuu44fUunrevZr4QuJ3TMXAULSbRX4hUlTDO3Vlz/Xiw/2t73tAmXhe1zERAfOL
	FO1+j/0tJGwmE8wcSFS8dIvkwEraheogd35C9lePM4KEt9r9ZgI+UgPRMHTErQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 09:47:39 +0100
Message-Id: <DGHYH2CB1NGG.265ZFRUDDWCJG@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] bitbake-setup: print plain messages
 in quiet mode
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com> <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com> <1894D252853C99A9.200918@lists.openembedded.org> <CANNYZj94DXwkDaucq4Du2Pnvv+PD084SmHU+URb6djKFuUf4Pg@mail.gmail.com> <DGH4W65QBJ7Q.3NRH3Z4SBANMN@bootlin.com> <CANNYZj-Ta+QKHXpzCyPS0eLOX6irVadGGEO1T7RJSTeAKGzpvA@mail.gmail.com>
In-Reply-To: <CANNYZj-Ta+QKHXpzCyPS0eLOX6irVadGGEO1T7RJSTeAKGzpvA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 08:47:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19057

On Tue Feb 17, 2026 at 11:18 AM CET, Alexander Kanavin via lists.openembedd=
ed.org wrote:
> On Tue, 17 Feb 2026 at 10:36, Antonin Godard <antonin.godard@bootlin.com>=
 wrote:
>
>> Actually, when I was testing things I was in interactive mode. Previousl=
y,
>> passing --quiet in interactive mode would just leave you with nothing pr=
inted
>> on the console (only warning and errors), which is strange for an intera=
ctive
>> progem. However I forgot than in non-interactive mode you may want that =
to
>> happen (nothing printed).
>>
>> So maybe, we should look at the --non-interactive option value and print=
 nothing
>> (i.e. leave the current state, only warnings and errors are printed) whe=
n True,
>> but raise the loglevel to have at least PLAIN messages when True? Or giv=
e the
>> user a warning that running the init command shouldn't be run with --qui=
et?
>
> I'd suggest that we start with setting clear criteria for using
> various printing/logging levels:
>
> - any interactive selections and prompts should be using
> logger.verbnote (which is higher level than plain or info, but isn't a
> warning).

Agreed. I think verbnote messages appear with a "NOTE: " prefix though, whi=
ch I
don't think is necessary for bitbake-setup.

> - regular messages right now are using a mix of plain and info -
> what's the difference and criteria for picking one or the other?
> Should they be unified, or do we still need to use both?

It was a bit arbitrary, but info messages seemed less "important" to me tha=
n
plain messages (their "NOTE:" prefix is what this feels like to me at least=
).

> Then, modes could be defined like this: quiet mode prints only
> verbnote and higher. Regular mode prints info and higher. Debug mode
> prints debug and higher.
>
> One possibility with modes is to actually remove --quiet altogether -
> is there really a use case for it? Bitbake-setup doesn't flood the
> console, and what it prints can be useful in finding out what went
> wrong, in addition to the actual error.

I think it's ok to keep it, it shouldn't be hard to support and there might=
 be a
use-case for it for some people.

I will take this out of this series, as this requires more thought-processi=
ng. I
will try to follow-up with some proposal when I have some time, including
verbnote, etc.

Thanks!
Antonin

