Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919BC3DA59
	for <webhook@archiver.kernel.org>; Sat, 20 Jul 2024 09:17:23 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.3184.1721467038936192215
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Jul 2024 02:17:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MWWCjhvw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427d2c8c632so17163315e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Jul 2024 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721467037; x=1722071837; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dcesx4N8Za1m3PdJvRJCy48obQ7q5vSLKMwEmORdBFo=;
        b=MWWCjhvw8tni9/WcSpcEux6X/bX2qkdCJR8JopGSPFlKFZkFxV+kTlHcveFLt2K+FC
         XgD+ooA9Yc999Qlp97ZvubguiBJNIOFTprzdZ+TcUM95Owpm8SCrnCRLK+U/Exv37Ihq
         Gll3F/a+IYJeQbbbOme+XbnrOaBjarV7B8kFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467037; x=1722071837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dcesx4N8Za1m3PdJvRJCy48obQ7q5vSLKMwEmORdBFo=;
        b=uZ+uWHnj5JJ11xLOeeSZDnmqpKHE1azyHDMAvhj8+QwtdHkoroh/c4EEDb9cZTTP2h
         xXaHInT7Lcd7g2mAOafQi33SrIqNQKo8ehs06XXl6T6W49N7QX3VVDMq/kgHO1ESvGpn
         RbCfagu/n2Q3L+YTaDAYDTXDX+rbEiCqmH7kSzWK3r7Ke9NUmZ+OMg95OwfRZdHmuak1
         jU5HbdoSsNU7Y2HgYuBlHoX28G6h2cHAIrxTFcSoCnderzLDlUyOY5fhXnmoFkDqlkyh
         vU+JfVP/2sIPntJGEVihBm7MLlnD/1iSt+EtC1/Vg2YGx2W08bNyzaDkqvOQBeCQi2t3
         nleQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOH5mRgM3GxemIbpiLIvBftCARL+xhlbpKu672Vo1fP+bkm11kk7C1o/u8YZiEQyss9nnjbMV2G/sG8zP4xW4K9F7to1UCB4AW+1hZQ+OJe1V9hy4=
X-Gm-Message-State: AOJu0YzfNaRLLKShCqNiHQk9zD0120xAMMk1kTFoOeXlocrvgi5gvvpA
	H1wRzoYbN2h+YljuIT6Xmi+gbkVOzLApLAP5xbtUhICKOwfx278V2sVsCpaL5L0=
X-Google-Smtp-Source: AGHT+IHhnG0MeW/iq7/pOKTMtmd/gw/nnER6cUWVoRJPd1Pk27FYUURRbvgY0nNT2UP4yac/IsP2gQ==
X-Received: by 2002:a05:600c:a009:b0:426:54c9:dfe5 with SMTP id 5b1f17b1804b1-427dc547651mr6654475e9.10.1721467037123;
        Sat, 20 Jul 2024 02:17:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3cdb:fb4f:5ba1:eadb? ([2001:8b0:aba:5f3c:3cdb:fb4f:5ba1:eadb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6901405sm50586455e9.16.2024.07.20.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:17:16 -0700 (PDT)
Message-ID: <26282cf9c5e70b58f4c77744f68b24f278f8d8dc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake does not perform to unpack tarball
 after second and other downloads for PREMIRRORs and MIRRORS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: andrii.sosiuk@seco.com, bitbake-devel@lists.openembedded.org
Date: Sat, 20 Jul 2024 10:17:15 +0100
In-Reply-To: <9TpF.1721383981109709443.Rgoj@lists.openembedded.org>
References: <9TpF.1721383981109709443.Rgoj@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Jul 2024 09:17:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16432

On Fri, 2024-07-19 at 03:13 -0700, andrii.sosiuk via lists.openembedded.org=
 wrote:
> I've encountered a bug, but I'm unable to report it directly as only regi=
stered users can create bug reports on Yocto Project's Bugzilla.=20
> Therefore, I'm raising the issue here to see if anyone else has experienc=
ed this problem.
> The bug pertains to the use of MREMIRROR in a project setup where multipl=
e source code tarballs are linked for a recipe.=20
> Bitbake is designed to download and untar the tarball from the first prov=
ided link.=20
> If there's an issue with this tarball=E2=80=94for instance, if the requir=
ed revision is missing=E2=80=94Bitbake then attempts to download the tarbal=
l from the next link.=20
> However, it fails to untar this second tarball, leading to subsequent che=
cks being incorrectly performed on outdated data from the first tarball sin=
ce the untar step is skipped.=20
> As a result, even if the second tarball has the correct revision, the che=
cks fail.
> This problem can be observed in the fetch log file, where the fetcher use=
s wget followed by a tar command for the first link.=20
> In contrast, for the second link, after wget, it bypasses the tar step an=
d proceeds directly to performing git checks.
> Is anyone else facing this issue, or does anyone have insights on a possi=
ble workaround or an instruction how to create a bug report?

Which version of bitbake/release of the project is this?

I can tell from the commandline it isn't master and it would be helpful
to know if the issue is present there.

Cheers,

Richard

