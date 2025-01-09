Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D37E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 08:36:07 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.43472.1736411758051777718
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 00:35:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Vvg5Kh0F;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436281c8a38so4742445e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736411756; x=1737016556; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeUL+zMv1rcUruADCG01yydDcVhwAXnckO85sGv1blk=;
        b=Vvg5Kh0FFikgxNzdJ/nQsQNUOwLaD1amOglfqvfqra7gYRhOZZZpCJjmsnPWWhWBpe
         Pkhp+FZZFLv953EwqMOoRILgistAGN8PH5dTaAMei+4jMRDe+eHsjc3ujEAbc3ym0Wgo
         DAb9xGRj/3qaYt72LUpPhbQb6cOgpSdq74wyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736411756; x=1737016556;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YeUL+zMv1rcUruADCG01yydDcVhwAXnckO85sGv1blk=;
        b=E5B99dYmoC0642R9Tl416WBoLy0dyGe7ZnhwjMk4CrNb1Py5cTOTjaZI80Wva4JpGQ
         iWhAThLSQcPgRIr07I+7bVtR9gh1XqrLGNLfuiE+QRaoT2XtV5SDSepa/waDsd4W8TuW
         QPI+jj5I/g/s2lbIyRdDGTLNRNMw29f3uGmkSUP13mTroPen9KGtgO4sDSouT7GVSdL8
         UmPLxxx5hwDCPwzo9PvmT/eBTAE1RyiJqilFH+E20Qbt0+qjyldlmkAn4ppKWWWokoZ/
         B4a7gdDM1BNg0r3inVYCRzJbBBCC7CLKxPDC8Kol+EkKoi9Ri+kpglxCvqmBLxaGJp9n
         KdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkaKC3aHhUga/+FMosLWI/fQDA1g8Umw2y1P6fdrLWSUjNjnabBBDXhBfYopA7eeX6JJCQ9UFRcSV22x9P@lists.openembedded.org
X-Gm-Message-State: AOJu0YzfuQUDa//E6ZxWo8gmg+5lDv4/o2Q4YxgnraqJATFgtqHuDseJ
	GnsWgeJKWnNR55I2MDzrYn4Y5gT/uZYdsCSYORMgheyHS6ka/bL8MHEV3pNuGcc=
X-Gm-Gg: ASbGncujJpMpwiTJqH3XnIvXyC4LLOJj43FbFiosE/IDUPef0Kw5m5KL+K4+TBa04u9
	FXBB70HHSVUG6Ei9Bjloq8vnM+jsbHPkScqIfdHhZ258FrXT5XwMRfuuKFGqA6K+ls+sMxmLhEV
	4bMmlrQjhiGkt+ZUXnuVNlBZ0ZdKL7DG9mBNFDtmGsfneX4/V5tFGGtv4LTy8YRKdaCIpvL6xnG
	HAhyBUTWvSImoAm3jxPV7azYDi5tslNzL/kuHJxd2yMBM9JPt0aMwsdwf5bR2lP91/QspjIO16g
	mBAjHIYiaEz6gvvB2e61vgqz2U2yKT0KMCXeoYfFpE1Sjw==
X-Google-Smtp-Source: AGHT+IGJowHYrhnYrLif01n13S6OccMM9QG11Vl3YiWWoBUxjJPr6HZyD9sezJgND2U4Nu1CdmdY2Q==
X-Received: by 2002:adf:c08d:0:b0:38a:87cc:fb2c with SMTP id ffacd0b85a97d-38a87ccfc17mr3213379f8f.18.1736411756224;
        Thu, 09 Jan 2025 00:35:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6dd3:3af3:9d4c:53d4? ([2001:8b0:aba:5f3c:6dd3:3af3:9d4c:53d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm1175091f8f.13.2025.01.09.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 00:35:55 -0800 (PST)
Message-ID: <d666c407c0ab5a16733869b03acd15e18bcdbfe2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] git-make-shallow: use stdin mode
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: nick.owens@eero.com, bitbake-devel@lists.openembedded.org
Date: Thu, 09 Jan 2025 08:35:54 +0000
In-Reply-To: <20250105021848.3048010-1-nick.owens@eero.com>
References: <20250105021848.3048010-1-nick.owens@eero.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 08:36:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16991

On Sat, 2025-01-04 at 18:18 -0800, Nick Owens via lists.openembedded.org wr=
ote:
> when there are many refs to delete, using xargs to exec git can take a ve=
ry long
> time. make this faster by only running git update-ref with stdin mode.
>=20
> for a repo with over 34000 git tags this makes git-make-shallow finish
> in 2 seconds instead of 3 minutes for me.
>=20
> Signed-off-by: Nick Owens <nick.owens@eero.com>
> ---
> =C2=A0bin/git-make-shallow | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/bin/git-make-shallow b/bin/git-make-shallow
> index 9de557c10..8ad704fae 100755
> --- a/bin/git-make-shallow
> +++ b/bin/git-make-shallow
> @@ -115,8 +115,8 @@ def filter_refs(refs):
> =C2=A0=C2=A0=C2=A0=C2=A0 all_refs =3D get_all_refs()
> =C2=A0=C2=A0=C2=A0=C2=A0 to_remove =3D set(all_refs) - set(refs)
> =C2=A0=C2=A0=C2=A0=C2=A0 if to_remove:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_output(['xargs', '-0', =
'-n', '1'] + git_cmd + ['update-ref', '-d', '--no-deref'],
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input=3D''.join(l + '\0' f=
or l in to_remove))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_output(git_cmd + ['upda=
te-ref', '--no-deref', '--stdin', '-z'],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input=3D''.join('delete ' =
+ l + '\0\0' for l in to_remove) + 'commit\0')
> =C2=A0
> =C2=A0

This sounded really good and it merged however we're seeing intermittent fa=
ilures:

https://valkyrie.yoctoproject.org/#/builders/54/builds/725/steps/11/logs/st=
dio
https://valkyrie.yoctoproject.org/#/builders/23/builds/810/steps/11/logs/st=
dio

This appears like it might me python or git version specific, there is
a deprecation warning in the log which I also wonder about...

Cheers,

Richard

