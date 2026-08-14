Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA7C5CFCF
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 21:25:03 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23097.1786742694522429153
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 14:24:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G8saCJI+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4998e0916faso845925e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786742693; x=1787347493; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2P6BjP69c3sr6jJG6yfA5naGd5eimG9ykE8Vwui6Q8o=;
        b=G8saCJI+BaECNOOzz5rMe0Ul2vJWKGtWSOepTDn1RpZNhCDS/Ep0iPDp7g4uyGQ2Eh
         xjv7XCEecBOOLLNMcujbHXT/GWk81J/EA76zoLt/rCSsWMhQOeCuwSfWXm8NIx1jWzTk
         xGLx+h7HYWqWdCwsXZRrI2lOWKBH4+/NU+vQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786742693; x=1787347493;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P6BjP69c3sr6jJG6yfA5naGd5eimG9ykE8Vwui6Q8o=;
        b=hNr4IYuA5yKgV1zUk8tA1HXxTZSvT47qMID7bGYipgDMeyTO47BzXRAI9lU7aL4TAp
         Tm03YYwmbyWN7s5b68J4ko7NW2X5yooXD4RO4E7GagEokYNVB3QgRFwX+sGt8UOXoxv0
         2Lx9vCpZ/ssVOpmweEkbQr+4lQQpcEhpJdzzgoFCQGmXxP+Niutd3NDv/07GYJMeNS/6
         OhZvxWZo4RT/CaKoUPKNMLphP30BbcQ+IxwSWJRYeqxSPD81E4cS6drYBNe+cy32+isy
         LaodMsD5CQlVWoVWNmFjWBhPMtKUU4/LVV19MeIBCvGAeOhGSaeBI733guS4EZA3mAYT
         12jQ==
X-Forwarded-Encrypted: i=1; AHgh+RrP0t8l3dvpXAOl4OEJazoQnEhmsLfGXL8b42TU3JXF4HB9BuRN2/cQ/GU7PFj5+AhX02HKYSKFOdWu65Yb@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy9wj2RhJ3hbFWZLzDcSRUx7iZfE/Lu267ZIJPK21uqXXMDO41k
	QRVdPr3H+HDlgKIJoQpbCqMFqKcsFT3sU01SA5kayxsgdOdq3kI5Fp24iMl6imqxuAQ=
X-Gm-Gg: AR+sD100OMwSxaUr/+Pn0wwVHpfpJoturtcWrw/wD5ML6qM6VsPjb7F9NKNwYBvko0t
	+mcHaDeX46FdrZKcEhVXWL+NA1jA2qH0D+fyMi1KloxhIQXROmPHQIOxCPMG79uZC+ssllmCxbN
	4hh7QMxgpJgTBsUIyH7AAJWwVHYNUkIt3QaSaYjZ7QfAXbwY43bpsPgLLle8Py72cDVmoObCH/g
	wIRJEyN9NlxGW5rzVVUhYftzwWII1shzt2SqQEFAqpP2yhxy2JEXZZlvWFb91JTK5aihteLozYu
	wJGtHArs42sPLV+JH6CJIeOIAWH7How6R0WtmRjv7IcaZWQg2ujp/ZpL2Izp17T3MSJ7FfJVfia
	SNaPSYA8+2U1wqHZBtCbH+geMNUMqoLI33/EEZCTJ95sSMSm++ww0KuOeMYJFn7hlsSwdg2ze4c
	RlIUPWZG45aWRRY6MSs0QLkol/MbdTyjP4wUwfYAUVr9fkbUgxqbNlFngD2oMLg87S+6OeCHH3B
	IkbemK0fwk1vuXlnI+CMv9m9ng8Pl5z0E6pcrFrY+Mu6JzLQMytDng0F5nwvktN
X-Received: by 2002:a05:600c:628c:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-49987f3a33emr137887045e9.15.1786742692668;
        Fri, 14 Aug 2026 14:24:52 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d4b:5078:8ac7:d466? ([2001:8b0:aba:5f3c:3d4b:5078:8ac7:d466])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899b5ad0sm59830355e9.4.2026.08.14.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 14:24:51 -0700 (PDT)
Message-ID: <2a1dfb64170ef90dde4f5def6fe7d86f720257f6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel]
 =?ISO-8859-1?Q?=5BPATCH=A0v2=5D=A0fetch2=2Fwget?=
 =?ISO-8859-1?Q?=3A=A0reuse=A0cached=A0HTTPS?=
 =?ISO-8859-1?Q?=A0connections?=
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: svsvenss@cisco.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Aug 2026 22:24:51 +0100
In-Reply-To: <DM6PR11MB396271299B36AB33F27D6BE2CBDA2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
	<DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <02b6e335731bb1bd9ddce4ce8867144c9491a2ed.camel@linuxfoundation.org>
	 <DM6PR11MB396271299B36AB33F27D6BE2CBDA2@DM6PR11MB3962.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 21:25:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19948

On Fri, 2026-08-14 at 20:12 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:
> The failure happens while the new self-test is generating its
> temporary certificate, before it exercises the HTTPS connection
> cache. Unfortunately, the test currently redirects both stdout and
> stderr to /dev/null, so the log only contains the exit status.
>=20
> I reproduced the command in an AlmaLinux 8 container using the same
> Yocto 5.1 buildtools, where it succeeds. This therefore looks
> specific to the alma8-vk-2worker, possibly its crypto/FIPS
> configuration or local state.
>=20
> I will prepare a small follow-up patch which captures the OpenSSL
> output and includes it in the log. A rerun with that patch should
> expose the actual reason.

Thanks, I applied it and the result was:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4383/ste=
ps/15/logs/stdio

which suggests buildtools isn't working quite right. What is odd is
that if I ssh in and run that bitbake-selftest command on the same
build directory, it works and doesn't show the error. I'm not quite
sure what is going on here...

Cheers,

Richard

