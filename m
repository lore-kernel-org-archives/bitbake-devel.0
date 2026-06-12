Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18F9CD4F2C
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 08:49:11 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66134.1781254141357151939
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 01:49:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cU7HuW4E;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so611522f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781254140; x=1781858940; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLofcTl/9EW272e3qq+TmZ95MKMmd5ziTj6grS7b6lw=;
        b=cU7HuW4EFMu8Xmo4ny3C7KWtR99l0sgg/y+WCYFVMZEvBiPk1bLfA+ekMja/wtTG0x
         Kt713QlFLHWWC75bdxmy9l9aqHah7vuDWI/uRUDWlawkHEa40BLjhDaywVyX0gjtucqI
         kGQlW1hVhmChUG7gKGkPXPT79/9iVN7B5Ib/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254140; x=1781858940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLofcTl/9EW272e3qq+TmZ95MKMmd5ziTj6grS7b6lw=;
        b=LU5kC4iBiwAS+aCKtG572q7UXh3p7eqJ30VWgyHSYZKlFeg2+iQDXDPMHgl69kSRvK
         +Gq5LhjJ4ADpTHIR6VlESMB02CDXBzzVb60gfkBxbN+Mr6U0LHhsSBtqSdssbPPxxHQw
         A0TRE2Fr0eSimGLED0nTs88p8dicWKZ2aswuuaa57dAntF2V8Z9ndtUsCm5D95ksn6TU
         YqiC/n3nb5cY++wKkqd6LnxYTxJMmZikDVFphE/FvBEijKEqGaQuZuiYXE0NbxVTM0LG
         iR2UaEqpUWacpRld2QVmynUVHlcvZT3xggbPWps8CAzTZBQUdMNcJSaV4jEVivIGPjsE
         ZFkw==
X-Forwarded-Encrypted: i=1; AFNElJ+AwiSX/S+qYLkdIyCtStnOLLm5zfOIEyXjKFqFTk0qvZ9wjkKzMBCBVoncsvIBAbqZ0mb4/5nHvhELoVqc@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw1H25BM96/GgYG4Cn6vCKVCb3CdO6hAp3mtUAhi8BJLmrZ065Z
	5g4r5AME95HO4MF2JCIZYUxDbbrdnNMmCqwyxw46ADNMguZocKVrtcBsfNwQzFNfVixQBNZj5Y8
	4oWfo
X-Gm-Gg: Acq92OGs2U/ViuQNt6YRfQBpZP7Z2aBhwgW/D8zZpwJdynIPFVeAvpIzoveLGyNAyXW
	5YQeyIcGerqgVmMo3HUEpJ/WPCLi8XgLbE44YWqLDMQwuCy74lJuj3+quf1obp/lacd++uQUqgW
	f8hFkQsaCPujqk5lAC1C0F157d3LBwMPKLybsg+cv8xWtEkwmdh0pf8OX905PN7MLby5OE7hhBb
	CrvSwIkYm3Kwo2/Vbittwv4hdYP8cie9zAIvovfMsmylKaAiHDJGVvJUpdNWmdlD2o4olUQx6r7
	hJyXDLlX5ZxSHjNlJacz2b0rOpQthLjbR5qfvg9j58OScEwTKKtwWdzVX3Y06E9D4cEO4AymjWG
	zBGMFTN4DxGl+nSgZfaNw2qwsUBiVEEva+tes6p5HJPpmx9tHTxRy3lsHfeY3nOmqBorS98T1Uv
	QZSPNyKyP+rOm4ZaAy4Sw700wBjKZ78BsQX7FT9za29/Sz0vB9Heg/Su08XtYGwG0l8fUtTTnhN
	EdkqEP6hbGfFwps
X-Received: by 2002:a05:6000:2609:b0:460:70e6:c7ea with SMTP id ffacd0b85a97d-46070e6c8b8mr1723805f8f.11.1781254139667;
        Fri, 12 Jun 2026 01:48:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f50c:d0e7:6f94:47a9? ([2001:8b0:aba:5f3c:f50c:d0e7:6f94:47a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm3958912f8f.35.2026.06.12.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:48:59 -0700 (PDT)
Message-ID: <bd1b5bcaaa13ee58f3b04b1daaa883b2733cee59.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: sync release list for Toaster,
 test, and Layer Index
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: david.reyna@windriver.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 12 Jun 2026 09:48:58 +0100
In-Reply-To: <IA1PR11MB767743DDC0B4E26265566228EA1B2@IA1PR11MB7677.namprd11.prod.outlook.com>
References: 
	<IA1PR11MB767743DDC0B4E26265566228EA1B2@IA1PR11MB7677.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 08:49:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19671

On Thu, 2026-06-11 at 22:57 +0000, Reyna, David via lists.openembedded.org =
wrote:
> From 21858028a7448ff2d92e388f96da7127cfd7048e Mon Sep 17 00:00:00 2001
> From: David Reyna mailto:David.Reyna@windriver.com
> Date: Thu, 11 Jun 2026 14:55:37 -0700
> Subject: [PATCH] toaster: sync release list for Toaster, test, and Layer =
Index
>=20
> Details:
> =C2=A0 * check_fixtures.py: ignore releases not yet in Layer Index (e.g. =
'blacksail')
> =C2=A0 * gen_fixtures.py: also sync 'test_create_new_project.py'
> =C2=A0 * test_create_new_project.py: now a generated release list, in slo=
t order
> =C2=A0 * toaster: remove 'exit()' from this sourced script
>=20
> [YOCTO #16280]
>=20
> Signed-off-by: David Reyna mailto:David.Reyna@windriver.com
> ---
> =C2=A0bin/toaster=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 2 +-
> =C2=A0lib/toaster/orm/fixtures/check_fixtures.py=C2=A0=C2=A0=C2=A0 | 55 +=
+++++++++----
> =C2=A0lib/toaster/orm/fixtures/gen_fixtures.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 74 +++++++++++++++++--
> =C2=A0.../functional/test_create_new_project.py=C2=A0=C2=A0=C2=A0=C2=A0 |=
 49 ++++++------
> =C2=A04 files changed, 133 insertions(+), 47 deletions(-)

Thanks David! I've been meaning to try and do something about the
fixture dependant tests for a while so this is great to see :)

(also fixing the autobuilder warning which I've been trying to get to)

Very much appreciated.

Cheers,

Richard

