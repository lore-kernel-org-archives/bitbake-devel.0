Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE6C5DF81
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 19:04:38 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16502.1787079872957572120
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Aug 2026 12:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Xi+iYmd2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so2564085e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787079871; x=1787684671; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eQbH0dtIxAD0cDTY55bQYfSxgqhrlSVNUzNroQkZWnA=;
        b=Xi+iYmd2tfHP08UD448i5ry8mXjCpGffhPY9sjGfLKFkqH8ZwGRSBFZAhxeXhB+aJY
         ZGqh0XSNpf+MmRO8RysaBMcshzFzaAzKjMhGatdkmeLMpG2gH/eA2tz/IeV+DIH5ZQan
         5IjVDk1rLPwn2moXhKSk59eRPRZMQkLa0T38g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787079871; x=1787684671;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQbH0dtIxAD0cDTY55bQYfSxgqhrlSVNUzNroQkZWnA=;
        b=DUltAiTi5u1Kn9JlPoiH/U6J1sGeWWja2tJ7+9fqXNNMDEBjABAZ6YDdp3SMG4mcxE
         6LABa+2AsRQHRjUG3C4agcgaJhBP1TA3r/xdzX0E56xq8HTNTbypWYubreS+SuW5B2tO
         8IXq8wpx9lCZezfnBquvG8QUfO1G8fVfn9BjCxxYJwU1kXjk3OQUEsnTiSAim7yuOog+
         dxuEwF3vnqfHXf3E3+jB8aO6YRZWW7rBLwXnDxrCF9A0dwmEy6TapOnZazlup1awV4Jh
         9VdtDBykUDJ0U2IkHANENEznBhZmGC26TZh6C8C342oUHVymNlb+EzfIUOnT0DCLLGLk
         PDqQ==
X-Gm-Message-State: AOJu0YyCWeVf6fWaAL5nm72ZmpHiClDonN/Pp7H6hLj1L31Iw/KDJpkb
	qCbIZE8NYyxQr+nP8kxdueBZIg2B6FHxg4AZ0IVxMWTBeVZtl6/w2n3hC4An2oH2lO8=
X-Gm-Gg: AR+sD11dhHDfJ/L7iU4yNrEJFjI3t/DxhfDGopDDtf+OjNiQ4yzZwIviEj/aBzjnlDc
	OURnQrZ3v4vmRzi/mALUGxzItgv10hhlEtDUH7OcYYW5NPfwJEobLZKYrHQv0nKc8xOevIcTcHw
	aSqjY9E9N5TdQon9GfCLhj0qgY+xptTFsAIuqZA3/Mp3Y8mKuOSAiAK1/Hb6H0NXeuadxbhsMJd
	BKAnqrxQL1TSqLmHmuVaMo5mgThm82R7tL/9lxRgpUicPygTXtyHs3TlyoandXh9QKF87nWfVL/
	6tCKC74sjI03fyMVzo4TcrV/kYf0HIoe89+KSgtlw2jUIj3CSQGNFa0DUQ0fkwLzWqiM7OCWwdH
	est/n3mUENyNR+AJuQZGecxj9Fqg89gJpXD7mGtKdeMTfDpu6ILXv9mFxkuAmSllryjQcmdoqIH
	Yo8gW+JS7paDOcaxWgAlkSO72QcKO5ZNAwPi39d+5mR4KkVhNR4spWIKmfqEmnZ9mpIklgPXGcH
	yUpsXTI5bPzKnFIw7GAxd0VRMwHeWRfYzaUBaPh9t3d4N2S/pdPpA==
X-Received: by 2002:a05:600c:6091:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-499a8f151e4mr4431795e9.2.1787079871015;
        Tue, 18 Aug 2026 12:04:31 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ee4b:f6b4:d308:732d? ([2001:8b0:aba:5f3c:ee4b:f6b4:d308:732d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d11f073sm169189005e9.15.2026.08.18.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:04:30 -0700 (PDT)
Message-ID: <58e087a5908a808a3557f92d3844f79b1cce61cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Aug 2026 20:04:29 +0100
In-Reply-To: <515257189.1172159.1787078030404.JavaMail.zimbra@savoirfairelinux.com>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
	 <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
	 <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com>
	 <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org>
	 <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com>
	 <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org>
	 <1200355947.1128688.1786996086820.JavaMail.zimbra@savoirfairelinux.com>
	 <8558d54fda8e977ea6e677693db0586b8e10e80a.camel@linuxfoundation.org>
	 <515257189.1172159.1787078030404.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 19:04:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19983

On Tue, 2026-08-18 at 14:33 -0400, Paolo Wattebled wrote:
> Hi Richard,
>=20
> > For example if the core metadata has:
> >=20
> > X =3D "${Y}"
> > Y =3D "Z"
> >=20
> > then the recipe sets Y =3D "A", the variable history for X doesn't chan=
ge
> > but the value does.
>=20
> You are right. My filtering happened before expansion and relied on
> `VariableHistory`, which records direct operations but not changes caused=
 by
> references to other variables. It could therefore omit `X`, even though i=
ts
> effective value had changed.
>=20
> I removed this history-based filter. The implementation now iterates the
> parsed recipe datastore and stores the expanded value of each included
> variable. I added your example as a regression test, and the snapshot con=
tains
> both `X =3D "A"` and `Y =3D "A"`.
>=20
> Variables marked as functions and explicit override keys are not stored.
> Active overrides are represented under their logical variable names, and
> non-function flags are stored as `VAR[flag]` entries. Values detected as
> involving inline Python are also omitted to avoid expansion side effects.
>=20
> On an `imx-image-core` build, Toaster persisted 598 recipe snapshots with=
 an
> average of 1663 entries, a minimum of 1627 and a maximum of 1944. The com=
pressed
> payload was about 86 MB in total, or 145 kB per recipe on average.
>=20
> If you agree with the current scope and semantics, I will generate and se=
nd a
> v3 of the series.
>=20
> Thanks for pointing this out.

My big concern is that this was the simple example of a problem with
these patches I could find and easily demonstrate. I've tried to hint
at the bigger architecture issues with them but that is a lot harder
for me to try and explain but I don't think you're seeing it.

It leaves me with a dilemma as I doubt the patches are right in their
current form but we're at an impasse over addressing the concerns
without me doing a lot more work.

Not really sure what to do from here.

Cheers,

Richard


