Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC6C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 09:14:32 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.19476.1740129264679169961
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 01:14:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AFJfghUo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399ca9d338so10948105e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740129263; x=1740734063; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g3mWh71Dxvvr56zK6nU9fFR4ui4TPl52JG1BaYVoBkY=;
        b=AFJfghUowIV30pc0YkJnO7Tmo3pXWxNhNyZN3w4sa6fi97eX5LfdnTO2UeEtUDiDBR
         UZCMDCLGxFaG1L4URNDzmYhmg0evZ/njzety7uxi1yDl1faQdBaR7lcMUEjbc3yAmyOL
         ybBCKA0cYif5BN5cwi1pKpDmxrJiTT4i0tRm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129263; x=1740734063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3mWh71Dxvvr56zK6nU9fFR4ui4TPl52JG1BaYVoBkY=;
        b=Aoaobn1hO1TdnH/MkheAmz+QmbB13jApM1lI0VkzgoBVBWC0JHlm+6zXlDc1UrdNTG
         jT+fmtJRbUli0YY705mhOzdJKgAbs5O4MtfxYhAF62naMF5UcVK2E/w7LWEaRVAEtVvi
         APcmw2BcRrEzfipT8d7Xn4yF/33K54g/h8Mr4Hw4dehJoF8guTEJ+qo63wjcfKUoRQT/
         zpd1K1e/jjcxIlMqhdTbk++/7kDyxDYgyldXdpim+hI0zZw0UU5XjwZxF77diISYVGZj
         9+rsjAF6JcoKOFXpZcF5VvNADQnK3WM2VwCbPrpq8moZcqtSGzatvbS9hnBaXm5YTfbl
         qSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUtufSCPEzioZg+LToG8GpMeEn/4KrTFHBRoNepq8vcfwRq930HrHTSbY+ZEGXdLULPJncKwPCAEoB51paS@lists.openembedded.org
X-Gm-Message-State: AOJu0YyLOUhUPNSCozF5q0m5yAWdWnSjDpM21wxSHKrW6iBHfEXfFfrk
	XxSOJWjksaEEzH+kd65ptThOvElMeUaHF8JTjSGIO2QNFveqF05x+WivOcwFxT4=
X-Gm-Gg: ASbGncvcV/r9hC+EIDkbVzjKNJN0132l3OChL3QocJA7QZzMdvSfQgw0peNvlvsn8Sf
	vypbxSU11MuVe9hsQfGvrvl7BvBr2Ew88MkFqL2xgrDoEf4GbjooLZZoNwqAccqCXTBSW2iVlI9
	JOdPgri1NWuMGw3CTMe/2Yp8NGrGxWxwr1+shxxh/FqoxD533PCPNBJUeohdHIPkCX1LWegm6bg
	MXe1rnhi7fy8xLlf2F6UfRbJ61H6gJcROEKXASB5sT2nu5B1UY1Yy1kzQYI12naoa1P1Cvop4Qe
	fJDFbdIpnbPKPSmhneug5GRIzqraX196JDQDUcjxE/1xDfXSBqjl613FjXURzjwZ+y5ddO1OHl8
	r+9UBVqpeSIRl
X-Google-Smtp-Source: AGHT+IHXavIUBnNEzuTXpmgP+yjIIw8pYtxGY8LiJJzKApNrefZVI7DWny34I31u5u91I0w7Dca6Bg==
X-Received: by 2002:a05:600c:1396:b0:439:a01d:379c with SMTP id 5b1f17b1804b1-439ae1d7cf4mr19721985e9.4.1740129263104;
        Fri, 21 Feb 2025 01:14:23 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46? ([2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b03675dfsm11061485e9.29.2025.02.21.01.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:14:22 -0800 (PST)
Message-ID: <b78c624ef4f48bf9f4c8d571555dd693ea8da4de.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: JPEWhacker@gmail.com
Date: Fri, 21 Feb 2025 09:14:21 +0000
In-Reply-To: <CANNYZj8LynhGChryLLHYFSz3=G70nO1938FwbfHN58rucuQ2sw@mail.gmail.com>
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
	 <1825F6393BB749ED.25123@lists.openembedded.org>
	 <CANNYZj8LynhGChryLLHYFSz3=G70nO1938FwbfHN58rucuQ2sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 09:14:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17272

On Fri, 2025-02-21 at 10:11 +0100, Alexander Kanavin wrote:
> On Thu, 20 Feb 2025 at 17:05, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
>=20
> > - we can extend bitbake-setup configurations with 'install-buildtoos:
> > true' parameter, and then use it in all official configurations that
> > need functional websockets to access pre-built sstate to always
> > install buildtools, even on systems where it's not actually necessary.
> >=20
> > None of these are great, but I'm leaning towards the last. Looking for
> > better ideas!
>=20
> Ok, I've slept on it, and concluded that bitbake-setup should simply
> always install buildtools by default. It's a front line tool for new
> users, and it can't afford to fail in mysterious ways. There will be a
> setting to turn it off, for those who know what they're doing and know
> they don't need buildtools.

I think that should be an option but I'm reluctant to say to use it by
default as we're just not going to find out about host issues until it
is too late. Our sanity tests are supposed to detect and give human
readable errors for the common issues you'd encounter.

Cheers,

Richard

