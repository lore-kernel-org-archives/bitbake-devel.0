Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C03CCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 10:17:19 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8268.1762510629168387355
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 02:17:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R4YohfZW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775638d819so2990885e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762510627; x=1763115427; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q8sFYCRqM43H8xIjg9a7d0iXJjdu0k1/rnBge8oD/KI=;
        b=R4YohfZWM5itagNMdi2V43AfUw43TkvoLzo2pHTMKSDm8ziZpwGbXWP1WFYDYZCUpJ
         JPW8UDQuXOK2vriXgZ82+/klTVWRDWzk5Q7N/VL1Ber1wp8/5sjyF40Xj+A0D+DtlI58
         mPK1sHDHSAhXfPYphKMvINpRFsGCBvm7xrwig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510627; x=1763115427;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8sFYCRqM43H8xIjg9a7d0iXJjdu0k1/rnBge8oD/KI=;
        b=Q7ku9AGh8WRXsEX1H7iTksVdyIlegpK3pyM5o3lDv5ssCTlevKBcXqySgGSROATMLa
         zkYS6USYLhG0wpRw2ocoss4rKLETXp4cHiu4aIyU7cZZhqXcX5ZQOacsAtvpu4xEMKyx
         Gq9VjkMB6aVbQNOAfsJfDbwoY91hdnXkbLPzYSfs4fWpj80C3pa4qyOssNUmIp9faWZq
         RZQQxj9svYYutumsRXHG2GYgaqA+JVkEwrQDml1qZuOANTJplBjZX10RpDqV7rFYO1wC
         z96dMs/t8MGbaGwfyPep0Skfr9NmWEqR4EkNeiAGZXK1vRMJoQSfyh83C/SoaLV0WLWV
         LXdg==
X-Forwarded-Encrypted: i=1; AJvYcCW1rmjTNBcaEkzEzIXRqJvz8JmODv+LjHGhtsccNoWHVMDTAl5kw9rNQmDzi76EgSf0klQ4Zo2yBrmBc3WM@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy0PtmfRUcsgMWYSqcUnWpo8QP/QFnHMmIvZpfPhnKC3+icoTnJ
	TtqmVkejKMXjXtSXaN4LpEfxjXPTbczCPHqxrj4YQCWf72XnPgVp8nmsFM2EQTOUQpg=
X-Gm-Gg: ASbGncuY0snQYuRNsjL6GeAtZt4eAuCy0jcvqJwyx3mDopv6Gkwf+8cDMENhywZC4i9
	3C2yw5QMUsxuPpfQLLJK16Sew27Rxkc3lj2D1hA7R6UXAxTGJEoFFcpDCHuDF3XnsZ84XuZfSHG
	js+do5j8axBu5eOfNB9eEPGBjdwf9HWzk2IyCLYrGWoOlbHARGgmlgkHbOOgyzuohMDyJX8hWVp
	cN/z66lNDhXRl2/6P17ljwNkl5I9afba95CqbHF5uclkYkIHqd1nO2dlvzVNdY+ZMMtxmOBMZ8x
	YNS1exHP3SV8ypJ9aD2gWxrcuHuyDtsDSbYDyI1EuxlQI21b5yvqrAjL6lb0DhOnNrA8MaEcvNN
	1J1YL3PvVzKC/Y7xWSst31jdzDxU5E5UGh8PCsvBRwo5IGrzLDJ1+YE71sq7VDvap21VyoLsYje
	OnJPWIuoCzrXe8Tx3M/AD047t1uy1z/I6EL5grfPJb9xo8oDCAkNwxKwcVcB9reVOb
X-Google-Smtp-Source: AGHT+IH5MNcJyKtjCdctwUOBR84N0IikbHgluJuTeRvwnk/MD5e4T2DOF2d/Rt7L7GzrQ/DmSwOlQw==
X-Received: by 2002:a05:6000:40db:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-42ae58812c9mr2070343f8f.23.1762510627461;
        Fri, 07 Nov 2025 02:17:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d54fsm4406514f8f.45.2025.11.07.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:17:06 -0800 (PST)
Message-ID: <23ceab57be35384282f708b8a0a4f9d0c9f7d338.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Antonin Godard	
 <antonin.godard@bootlin.com>, "bitbake-devel@lists.openembedded.org"	
 <bitbake-devel@lists.openembedded.org>, Alexander Kanavin
 <alex@linutronix.de>
Date: Fri, 07 Nov 2025 10:17:06 +0000
In-Reply-To: <CANNYZj96A91YLjusG__6Nb0G+5xzsqTXSmPxha_H25J2H6RpVg@mail.gmail.com>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
	 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
	 <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
	 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
	 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com>
	 <daa19e97cfc92bdfdfdebc0b344dc11c6462d0fc.camel@linuxfoundation.org>
	 <CANNYZj96A91YLjusG__6Nb0G+5xzsqTXSmPxha_H25J2H6RpVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 10:17:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18304

On Fri, 2025-11-07 at 11:14 +0100, Alexander Kanavin via lists.openembedded=
.org wrote:
> On Fri, 7 Nov 2025 at 10:55, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > > I tend to agree. I=E2=80=99d rather call them =E2=80=98bb-layers-in-s=
ources=E2=80=99 and =E2=80=98bb-
> > > layers-in-this-dir=E2=80=99. Patch is coming even though I=E2=80=99m =
technically on
> > > holiday since midnight. This is important.
> >=20
> > I don't agree with "sources" in here.
> >=20
> > I think if we call them:
> >=20
> > bb-layers
> >=20
> > and
> >=20
> > bb-layers-file-relative
> >=20
> > then this should be ok? I agree we need to get this right.
>=20
> That's not too bad, I'm ok with it. Sadly I'm running out out of time,
> as travel is happening today, so this last tweak is on someone else
> than me :-/

No problem, I can make this one based on one of your patches.

Cheers,

Richard

