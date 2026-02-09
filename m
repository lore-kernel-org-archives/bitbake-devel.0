Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE3E81BC8
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 13:59:19 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47770.1770645558613029940
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 05:59:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G791uRJA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-436263e31abso3083933f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 05:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770645557; x=1771250357; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1bxEk5wX/hZwp+Bz47Ks54kkeTd2i17QOskZ552EJ1k=;
        b=G791uRJA97o9hAiE99GM4Itf3d6Y8xsVwKAS644aMOoetX2oUosoKNxYKW5gdLUCOf
         3lFt2QXpmEYNPZBoS3jXsaANPM5T0nIQoY/8nGJKkWALMgUaz3rV/8vpfKGciRhnxVq8
         buIo3tB5i/oAPWqTXxHecciftWI7ITklSCfJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770645557; x=1771250357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bxEk5wX/hZwp+Bz47Ks54kkeTd2i17QOskZ552EJ1k=;
        b=pDu+ZrexCwoc/YnI2KP9iy3ImGbGPRHsGKqP2b8C0C7LjaYCHIbPCAg3YP0KFkW5c1
         RrmmmlRO0LSsx7ZxxQ/OSuv28rympIbOcvLqaqd303etEVNWoQGtqYXQ0bH3gLDpY1tw
         099JrGnxaFrzthtrMnxiFmbVdHW3ZxomHN57Cbtb7Ry81+QctPqvSygYf/bFt6TpUQ3o
         2UwOcQz09hEgJGmklYYhLoupoC2HSZLtN9uFncXps9ZtUeWU0XrgTvwYZljM3AJvJnlX
         cstzhStr/r/e58+qtk6P0aglruInBGlgoCVxN/GXhMrPOJeLEawOi0G+3QPtQeOIOO7x
         ZTkg==
X-Gm-Message-State: AOJu0YwE8gBgP5jnU4sNUx8aoggkRYHcQfAhyyZf8AfdtEISTFQ+0WQs
	KIsp7lKkbVdy3RYKC9mwXHhAvm8RX+IzluMuMpvscl+1B3wYn6R7c1O2DUdSaRalv1A=
X-Gm-Gg: AZuq6aJUclEWMPOkVGvC9N9t2ybeimKFY5XtjnXywueZRTsvpLOWIMEaKlxejWNLd5T
	v6mrRsNnOVHdPI/+NA0+eTng6FZRN/9PRkw6CGa9j1KD32Wdlg8DDLY7sflfZKg+js6bLg3XKci
	gR7i5JJeixfUzVCUlc/Or15nXikYCbbDZ0SbSO6I9Q63ViVGNyMj4Ts13i/dtdwxDMkIX8xhqWs
	XWNIkkoJhRDl3D+vwks/FqOCGqGLeVTpUP8Fkxpd0tnlnUouVXpSqmLvs5Wo/LCIQkoVct0LqTR
	IbgZj7W0ald/2S2yu27rDz42R0Z4L6y8UdqkB2ZmEEkshulYN6nVpp9Qm1k4gwsnYmwgyI7Pz2D
	OrwlyljqMx3bk6OnuTSAYZpt25W/kL7fN69FZ4c3gxQ7L3FDOSbOBf49SkYna5tYstaLr8vVggc
	sYIX4vz/BcZDmkc/0O7Tbd97iDxjkNf0VixEc/0zP4aHfepRALw37rh++UbWl4n9FT6HhkIOb+8
	sw=
X-Received: by 2002:a5d:5c8a:0:b0:436:18d3:25 with SMTP id ffacd0b85a97d-4362933b989mr16254874f8f.10.1770645556885;
        Mon, 09 Feb 2026 05:59:16 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e749:8913:1613:3eff? ([2001:8b0:aba:5f3c:e749:8913:1613:3eff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376bd5a074sm10025569f8f.11.2026.02.09.05.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:59:16 -0800 (PST)
Message-ID: <7f16ef8510fc41b162bc54c8fe6e105a77094b88.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 2/2] bitbake-setup: share sstate by
 default between builds
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, Mathieu Dubois-Briand
	 <mathieu.dubois-briand@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, Alexander Kanavin
 <alex@linutronix.de>
Date: Mon, 09 Feb 2026 13:59:15 +0000
In-Reply-To: <CANNYZj-EPfHrGL25=MMYGhB401mnj3LVmeQ1Dm884JCDhH2fCQ@mail.gmail.com>
References: <20260129120421.4413-1-alex.kanavin@gmail.com>
	 <20260129120421.4413-2-alex.kanavin@gmail.com>
	 <DGAGEOPPKN0O.1PO5OD6RTZXLX@bootlin.com>
	 <CANNYZj-EPfHrGL25=MMYGhB401mnj3LVmeQ1Dm884JCDhH2fCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 13:59:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18991

On Mon, 2026-02-09 at 14:55 +0100, Alexander Kanavin wrote:
> On Mon, 9 Feb 2026 at 14:09, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
> > I noted some performance regression on the autobuilder with this patch.
> > I did not had time to fully investigate the underlying reasons so far,
> > but I'm fairly convinced they were introduced by this change.
> >=20
> > This is visible at least on selftest builds, rising from 1-3 hours to
> > something like 5-8 hours.
> >=20
> > A build with my branch on the commit just before: https://autobuilder.y=
octoproject.org/valkyrie/#/builders/35/builds/3158
> > A build with my branch on this commit: https://autobuilder.yoctoproject=
.org/valkyrie/#/builders/35/builds/3161
> >=20
> > Some tests appear to be way longer to run, typically:
> >=20
> > 2026-02-05 11:26:19,583 - oe-selftest - INFO - buildoptions.ArchiverTes=
t.test_arch_work_dir_and_export_source (subunit.RemotedTestCase)
> > 2026-02-05 11:26:19,583 - oe-selftest - INFO -=C2=A0 ... ok
> > 2026-02-05 11:26:19,583 - oe-selftest - INFO - 11: 1/34 11/664 (36.33s)=
 (0 failed) (buildoptions.ArchiverTest.test_arch_work_dir_and_export_source=
)
> >=20
> > 2026-02-05 15:48:59,247 - oe-selftest - INFO - buildoptions.ArchiverTes=
t.test_arch_work_dir_and_export_source (subunit.RemotedTestCase)
> > 2026-02-05 15:48:59,247 - oe-selftest - INFO -=C2=A0 ... ok
> > 2026-02-05 15:48:59,247 - oe-selftest - INFO - 11: 1/34 59/664 (1568.37=
s) (0 failed) (buildoptions.ArchiverTest.test_arch_work_dir_and_export_sour=
ce)
> >=20
> > Maybe the configuration is clashing with the configuration we have on
> > the autobuilder, or maybe this is just something else in my branch.
>=20
> Thanks Mathieu, we're aware of this, and the patch is used as a
> 'canary' to find where SSTATE_DIR isn't set entirely correctly.
> Particularly, config.json is using ?=3D, and I believe it should be a
> hard assignment with =3D
>=20
> https://git.yoctoproject.org/yocto-autobuilder-helper/tree/config.json#n3=
8

I did try that:

https://git.yoctoproject.org/yocto-autobuilder-helper/commit/?h=3Dmaster-ne=
xt

however it still lead to eSDK failures:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3177

which makes me wonder if we're still missing some detail about how we
think this works vs. the reality. :/

Cheers,

Richard

