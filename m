Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C0C5516D
	for <webhook@archiver.kernel.org>; Fri, 20 Feb 2026 09:15:01 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34413.1771578891596608343
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Feb 2026 01:14:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=k6el44ck;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2396C16541
	for <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 09:15:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 38F695FA8F;
	Fri, 20 Feb 2026 09:14:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70FF110368C6E;
	Fri, 20 Feb 2026 10:14:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771578888; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1bY82OtZpZEVbptdk+ijXxAu4sAOdh+SVPNEPdCeFXc=;
	b=k6el44ckwvvcq5PvSPDvOrJqRkZGhODH+yDq1PKSANRvs2rGfAVkCM1XZSmj9aJbgIhuft
	1JYA7R1xFL8kM0vDWAaApPlZsaKqJOrOnhy58Bp5sKujwR9vSB0jlwLZU6KxWwBg30THwN
	f5Agk6Cn/1Pqezh9XpfM3DjfVZRc5n5w5NYWO2UAof8lag/PqaoFX0rqbyDVjdmKeH+xzq
	D5Nfi91h/gLGBCU9ZxMa1IgsFXQ+PmQY2+NTu7rzkbOWwxvK/PAUASd43OoyknDgAsyHtw
	wHVtomauVhn21Su4BPf1XYNnpKbvnT3GLbZDMr3Ggr6L+da1WYGyuv/MgCQUIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 10:14:48 +0100
Message-Id: <DGJOAXSZ50FZ.EK06RN4G1XC@bootlin.com>
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 3/4] bitbake-setup: print colored
 diffs
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com> <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com> <DGI6Z0US5NPC.6Y8DAVVEYWRG@bootlin.com> <CANNYZj9grDk3dYjGARxhyca6a++GtHYaSKB0ouxpaoX03NWt+Q@mail.gmail.com> <DGIV1GKTYP9C.1OMEZARTNTX1U@bootlin.com> <CANNYZj8qG7NJHmMOLmUvPXM_=mHahRCtZ6uX1NWM7rdjxxON7A@mail.gmail.com>
In-Reply-To: <CANNYZj8qG7NJHmMOLmUvPXM_=mHahRCtZ6uX1NWM7rdjxxON7A@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 09:15:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19075

On Thu Feb 19, 2026 at 12:13 PM CET, Alexander Kanavin via lists.openembedd=
ed.org wrote:
> On Thu, 19 Feb 2026 at 11:18, Antonin Godard <antonin.godard@bootlin.com>=
 wrote:
>> Not sure I follow.
>>
>> def color_enabled() -> bool:
>>     return logger.handlers[0].formatter.color_enabled
>>
>> IMO this is better than the previous version which did:
>>
>> global BBSETUP_COLOR
>> if args.color =3D=3D 'always' or (args.color =3D=3D 'auto' and sys.stdou=
t.isatty() and os.environ.get('NO_COLOR', '') =3D=3D ''):
>>     BBSETUP_COLOR =3D True
>>
>> That logic is already present in the logger object, in msg.py, when crea=
ting the
>> logger:
>>
>> if color =3D=3D 'always' or (color =3D=3D 'auto' and output.isatty() and=
 os.environ.get('NO_COLOR', '') =3D=3D ''):
>>     format.enable_color()
>>
>> The proposal here was to get rid of BBSETUP_COLOR entirely and avoid
>> duplication. Not sure how this is *way* over-engineered, I'd rather see =
it as a
>> simplification
>
> Apologies, I started writing emails before putting enough coffee in my
> bloodstream and got everyone confused.
>
> What I mean is that run_git_diff() ended up being too complex, because
> it aims to cover all possible use cases of getting a diff. I know I
> had asked for that :) but I wonder if instead of that whole new
> function, we could simply add:
>
> def get_color_param():
>     return "--color=3D{}".format("always" if color_enabled() else "never"=
)
>
> and then tweak all existing invocations of 'diff' and 'git diff', e.g.:
>
> -        bb.process.run('diff -uNr {} {}'.format(file1, file2))
> +        bb.process.run('diff {} -uNr {} {}'.format(get_color_param(),
> file1, file2))
>
> Would be a much simpler change, with the same end result.

Gotcha, just sent a new version :)

Antonin

