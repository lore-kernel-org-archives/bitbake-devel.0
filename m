Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF4EC25B76
	for <webhook@archiver.kernel.org>; Sat,  8 Jun 2024 10:18:56 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.3927.1717841930971124061
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Jun 2024 03:18:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eAna1FcH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4216724ced1so14717315e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 Jun 2024 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717841929; x=1718446729; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFW2mVhpkEb6dL+2RpXJjzeb/1vk3Rtdpe/JYiWAaLM=;
        b=eAna1FcHtAMgZ+eepiMTS+zDzgoBJuF0EBcPX+J3J9e4QngpamEvfkHrQYkcOm87Wq
         Us3C4FfnabC8hrhbqWzQz0uC/uC6IBaABDMyxJwOo1JD+cLO7pj/Py1Z0r02L9Qlncwx
         bCkCcF8swy1nS/ORZCS/oPMd4Z5wRTwOB1Ss0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717841929; x=1718446729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFW2mVhpkEb6dL+2RpXJjzeb/1vk3Rtdpe/JYiWAaLM=;
        b=WfjPpy0hy4Fenv7i9RRczXFcuNyQ+kdaC4Bs27DfaQMallAlNnsYo9303i6yJC41NI
         CUfT/JwrpvPI/Z+k1gKwfoKGXDU7BOdCLejKLtSgTwnjguBxUHRgZZUVu2eKZbDCH9Yo
         o3IzxEXT16xigT0yrFYZkKdSSGjK43knq8AeADWAiCq5K3r0lpWEiTGN3fx1hBLlJo+s
         LIqGzf+vv4/GGT32umijqjmdlHn+ijHG08EIOSo3nVQQgyXny6c2QCl5WZXLg6P8TAkl
         ScPh0UUGcYfFcSwZ3PqUtBco1d8aY85WXkFZtch5LBKNB8WL05z6g2m3oD/Po5AHBB4S
         HTSA==
X-Gm-Message-State: AOJu0YzSrW1gPb9qEJcv5aHZFZ6XJniCfOpYPAAQoJgQLpofYS4Gq3l2
	DIk+HcTU6R8Nt0JD0lqpfC/amKXj3gWV1XjIMIsd1M+eygv07kXpG0+s0lCvePE=
X-Google-Smtp-Source: AGHT+IGxgxGYYHhF+XRJqWFW51kUBbEq/YDVoQ4tZw2L+8UEyGh/7Wr4ZJotCSJ0CJMo8kUXlCPmIQ==
X-Received: by 2002:a05:600c:35c6:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-4217f3080bamr3370925e9.1.1717841929167;
        Sat, 08 Jun 2024 03:18:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:633c:65a3:cf4c:7321? ([2001:8b0:aba:5f3c:633c:65a3:cf4c:7321])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29b05sm5971275f8f.23.2024.06.08.03.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 03:18:48 -0700 (PDT)
Message-ID: <28eec7ae10919151679dbaefb9db807c92b1f1cf.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] siggen: Drop copy_unihashes function
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 08 Jun 2024 11:18:48 +0100
In-Reply-To: <202406081016282d36c3ad@mail.local>
References: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
	 <202406081016282d36c3ad@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Jun 2024 10:18:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16331

On Sat, 2024-06-08 at 12:16 +0200, Alexandre Belloni wrote:
> Hello Richard,
>=20
>=20
> On 04/06/2024 15:28:02+0100, Richard Purdie wrote:
> > The code in OE-Core using this has been replaced with something
> > more fit
> > for purpose. Drop these function calls as they were never a great
> > idea in the
> > first place and cause IO slowdown for runqueue needing to sync the
> > cache.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0lib/bb/siggen.py | 6 ------
> > =C2=A01 file changed, 6 deletions(-)
> >=20
> > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > index 92066da00c..89b70fb6a4 100644
> > --- a/lib/bb/siggen.py
> > +++ b/lib/bb/siggen.py
> > @@ -201,9 +201,6 @@ class SignatureGenerator(object):
> > =C2=A0=C2=A0=C2=A0=C2=A0 def save_unitaskhashes(self):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 def copy_unitaskhashes(self, targetdir):
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0 def set_setscene_tasks(self, setscene_tasks):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> > =C2=A0
> > @@ -418,9 +415,6 @@ class
> > SignatureGeneratorBasic(SignatureGenerator):
> > =C2=A0=C2=A0=C2=A0=C2=A0 def save_unitaskhashes(self):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.unihash_cache.sav=
e(self.unitaskhashes)
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 def copy_unitaskhashes(self, targetdir):
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.unihash_cache.copyfile=
(targetdir)
> > -
>=20
> It breaks sstatetests.SStateBundles.test_minimal_bundle which uses
> copy_unitaskhashes


Is that patch only in your -next branch? I didn't see this issue in my
own testing which makes me wonder...

Cheers,

Richard


