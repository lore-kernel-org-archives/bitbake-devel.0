Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D157DC5B572
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 20:56:53 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22531.1786741009515988816
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 13:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B4yftSzJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so19605965e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786741008; x=1787345808; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sTczbHohsJMYIwIGt2z2q1NBezZYB6iE0W02Wp/Jv04=;
        b=B4yftSzJnZ9ZBfa+88A0TiHr/xbVvxFkUIgBwA9PG2oWS4vDGENzr/8KEoJ9EolDzP
         4lLb2yKvn3mFSw2uO4bkoK0APeLThjozRh/6X7TKNcKiniJfZgh98VK71aAVDQ4/Au75
         WfKk76xUtQFccj3eI0PDNfogm8eUrXcbqHtZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741008; x=1787345808;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTczbHohsJMYIwIGt2z2q1NBezZYB6iE0W02Wp/Jv04=;
        b=Ny+00YKhWJmDcaIttLlR7sgOGK0BZOIlZ7o87RX+bNv+OrM5RAgrNnUZt48HMqOalV
         nqktqIBDIm4P6AWwdPgTaOMURdHoz1Cwq/Ji4FSCss2BfVnh1zkhFA8q0FRTeDxXPhDt
         an4rs7HEt60N7I4alMM+fuvbh4lhvweQtMTlUsQREXMi7uLB3E90q73dvoTAAZCdfVB3
         4vbIEmylG8yDpjDjtCxR1/x3E8ldF66vdoMiJQ1gR4G+tK7WVlZwm1O0F7j0voOyo+na
         C7NrE7qPqbIg4pPRhmvFuBAbxktSgcLC/vcos/LanqTmwTHRK+5ImfjlOh726K9fVSSi
         P2xg==
X-Gm-Message-State: AOJu0YypO0latDD7j3dqmFJ7YhqJc6biZuJMhhCdHkHeFFyFpaF3So8A
	PeuXEVAHKbtSpPJn6w721WhD6IotCFjWpYduufIWWjIlH3Y9Dsd7hyjUz3EjoJqg/ZHjZ3zKh1O
	YHNQNTjc=
X-Gm-Gg: AR+sD11uRM5LasR7BC0P5gGOwz+95oOF1B4domXDi9sSLKWKWCB3RKK+YaqStD+L1HL
	pJXvKmr671tn3EBEvqczRF93oOJYGOnaunzGTW4uRTg9H8r8jPxpvUErYzBFDjrS2NMtTgNnNwJ
	sGHopp8kP0aiI7uLB+VSjIZN2cX8HpRyytsDMwEFog8ngi89oe3FhWl8KtRGe8ZC0RvRELXc6IR
	4HgBwC0cndjmuvAXjqw75BDJsezxRMhkbbgGGpxfwGE9SsfRawUxIeFFqsaRFSSDxchsYRiQz2E
	07vdyCb+HvHwSPrMU25TCcq/f7nGqOpro9xDT480IuUVq99modJpfSeshXpk9DLqq6LQ5rKm7HP
	Xc6RSwpdqnrW5jaYApHMUzm58um9vDB2ClEQmBGK8MB/kvWO3rZwYKeG0if7VigpsvKUZiV/KLd
	i0nCLqV/+PyzpegTAM+zfbH8P4dO4cz4D8Iu7uB/dNjxVXMk2+X7IYZT363PFkigf9IFkn4KEf9
	4fqoWc0/1KcM8B2ne63NDTLcM6bVEtyM91CuU3Ck28btGTzZxdABMYp4WfBK3+C
X-Received: by 2002:a05:600c:83c6:b0:493:e983:806e with SMTP id 5b1f17b1804b1-4998793583cmr136006525e9.3.1786741007668;
        Fri, 14 Aug 2026 13:56:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d4b:5078:8ac7:d466? ([2001:8b0:aba:5f3c:3d4b:5078:8ac7:d466])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d9fasm87267345e9.9.2026.08.14.13.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:56:46 -0700 (PDT)
Message-ID: <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 14 Aug 2026 21:56:45 +0100
In-Reply-To: <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
	 <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
	 <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com>
	 <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org>
	 <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 20:56:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19947

On Fri, 2026-08-14 at 10:31 -0400, Paolo Wattebled wrote:
> Thanks for the feedback.
>=20
> The 598 figure is the number of recipes in that build, not the number of
> variables. Each recipe has its own build-specific snapshot, giving 19,756
> variable and flag entries in total=E2=80=94around 33 per recipe on averag=
e.

The cache you've added is per parsed recipe, not per recipe used in the
build. Was the patch AI assisted?

33 differences per recipe seems very low as well.=20

bitbake -e bash | grep -v ^# > a
bitbake -e quilt | grep -v ^# > b
diff -u a b | grep ^-[A-Z] | grep -v : | wc

So I've filtered only variables not functions, nothing with an override
and I still get 132 differences.

> Each snapshot contains the final resolved values specific to that recipe,
> including changes from its .bb, matching .bbappend and included .inc file=
s, as
> well as flags such as PACKAGECONFIG[...]. Values inherited unchanged from
> global configuration or classes are excluded, along with functions and in=
active
> overrides.

I think you're missing a lot of values.

> Screenshots of the linux-imx variables, bluez5 PACKAGECONFIG values and f=
lags,
> and variable counts in the recipes table are available here:
>=20
> https://imgur.com/a/u20rf3O
>=20
> Regarding history, the current implementation stores one resolved snapsho=
t per
> build. If build 1 resolves A to 1 and build 2 resolves it to 2, both buil=
ds
> retain their respective values. It uses BitBake variable history for sele=
ction,
> but does not persist the complete assignment and operation history.

Ok, how does it use variable history for selection?

> To provide a little more context, this work supports vulnerability assess=
ment
> in VulnScout through its new MCP functionality.

My concern is that it could well be based on flawed input data then :/.

> Build metadata and resolved variables provide useful context for producin=
g an
> accurate assessment. For example, PACKAGECONFIG can help identify the fea=
tures
> enabled in a recipe and the resulting attack surface.

Did I suggest otherwise?

> Our longer-term goal is to expose relevant recipe and global variables th=
rough
> Toaster and MCP, together with selected layer configuration such as kerne=
l
> defconfigs. This should give an agent enough build-specific context to pr=
oduce
> a more informed vulnerability assessment. For more information on VulnSco=
ut:
>=20
> https://github.com/savoirfairelinux/vulnscout
>=20
> Thank you also for the encouragement regarding the Toaster use case. I wi=
ll
> prepare v2 as an incremental series, separating data collection, database
> storage and the user interface.

I'm not convinced you understand the implications of the code changes
you're proposing and that is a significant problem :/

Cheers,

Richard

