Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9437CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 13:42:21 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11646.1762522941014954016
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 05:42:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gy/XKflb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so6436065e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762522939; x=1763127739; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pNKy9gowXWFekeVuEZg00B0SER/OCWvjIX+HbHjNN7o=;
        b=gy/XKflbfXPsGuGdqejluBudbDEhSO3RFT6NUiYuFj5UX+6oQeM/qtdHYTD3P0HT5g
         K6txPf+D7hv+Umg4roFY7RqGYcU643hQUdClSXVMFd7YJ4iHXRul//AFwsHzGDwXP7uo
         ftMAFWpzBsBBvDrqy9wFQ44xSE2KrxQsLi7iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522939; x=1763127739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNKy9gowXWFekeVuEZg00B0SER/OCWvjIX+HbHjNN7o=;
        b=U3OOJrA1RN0mPuH8/OKdTAxa49c3HemMiTPSo+I6kabsvu/SbgMFBY9enqrgipn66a
         rJbz1Ucq88wpMWOUNjRR/wXOY85YVXHKIGL7coEj0+LmF2ADUJYLauP+KM7qfWpBoI9q
         V+7yzQZaAVETlYF1F5+84zn7IuPOEr6T34qQqTh8zf9MBgoM8It0vS0SS0ObljfBL3pt
         7RLgI38azSoXtARhFPRgqqhVJLuCCrk/vnQckE0eJOHiKbSNrqbphdK573npLE4uT4td
         +zlalAwjdvst5BRGcsexiqxIWRgghkz6+g9j3QmJ0F21OupH7be3mcY+8zr63RHoy/nn
         x2/Q==
X-Gm-Message-State: AOJu0YzqUl011z0ZktNnIqrcQzDstdsOYaGRdbn5w+u2ZvBNiDXD7nt+
	ApHWHF7KY+xUtFXtKlC8KL6/xyAi1iTxYDaDkBtuFd2YsrWghA+yy+9M3h0yiXwAOIA=
X-Gm-Gg: ASbGncvvwipL7oTv85RhkdhQLb9mg99ztVFJFQTDljWoFX6hzQt2UQDQhikEVNRM7g+
	XUobWdxjnmJoAn/BSYtdmUjg95OrYPEiqAJoI1w2GuMI5EBm8qILYRcSXCagmoD1YMSnCxnZPC9
	qNykZZ4tM8h/OLLTkVr1OZHLzRCKGNqpTnuSoMTPRbPxFEVAl7DJXV2vM1bjxvqGjP3TgTqUC5Z
	M24HWderKXneJKcsy7ynomI4rBYD+7yTfM0u7PCipCW7sn0+5JUMo8YbROp/BeKGUu9d51zLfY3
	OvD3rW7ay8R2WlpBazOs3EozWsD1r+r1J+TolNsw3ZjS69rW4YbelXN4MlHdd7XIyDjFXH1P1ZO
	rEO6XqWQ0uxLcsS4gNtq6gEUaLN+A86e2VKuu91mxBHgj1UaY/ftVtKKv0/cjcLOzRVPFQ9P3Ej
	V/sb5IZViW9HLmeNsETguBWPxa6thbL/UB4nTH6CilrQkwJsejYRTmshh+9D3CD+NC
X-Google-Smtp-Source: AGHT+IE8FcJmZ7d4cF0Hh32Bl6OTYS4WDCP6oH5YRRa7zhM6PwTkoMeSDL9nwKJrqw2hsrGOnoObgQ==
X-Received: by 2002:a05:600c:1f94:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4776bcae60fmr27785555e9.13.1762522939425;
        Fri, 07 Nov 2025 05:42:19 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm170853895e9.7.2025.11.07.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:42:18 -0800 (PST)
Message-ID: <cd2f5d1f6b78589aed6386d0ab03d487ad8f43d5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar
 method
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ross.burton@arm.com, "bhstalel@gmail.com" <bhstalel@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Nov 2025 13:42:18 +0000
In-Reply-To: <BC551E3C-97AA-4962-A325-50630AF76ABD@arm.com>
References: <20251009175300.7480-1-bhstalel@gmail.com>
	 <BC551E3C-97AA-4962-A325-50630AF76ABD@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 13:42:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18312

On Thu, 2025-11-06 at 13:18 +0000, Ross Burton via
lists.openembedded.org wrote:
> On 9 Oct 2025, at 18:53, BELHADJ SALEM Talel via
> lists.openembedded.org <bhstalel=3Dgmail.com@lists.openembedded.org>
> wrote:
> >=20
> > Tested with:
> >=20
> > MY_VARIABLE =3D "foo hello foo world"
> > python () {
> > =C2=A0=C2=A0 d.removeFromVar('MY_VARIABLE', 'foo')
> > }
> >=20
> > $ bitbake-getvar -r example --value MY_VARIABLE
> > hello=C2=A0 world
>=20
> I=E2=80=99m curious what the use case for this: if you=E2=80=99re program=
matically
> manipulating the data store can you not just make the desired changes
> directly, instead of adding another operator which has to be
> evaluated and has a performance hit?

I haven't taken this as I have the same feelings as Ross. Whilst we can
add API, the real question is whether it does something which is useful
and can't easily be done another way.

In this case, whilst it might have some minor use cases, it can be done
other ways. It also doesn't allow for optimisation, which was the
reason for adding some other APIs.

As such I'm not sure this patch meets the high bar requirements for new
API...

Cheers,

Richard

