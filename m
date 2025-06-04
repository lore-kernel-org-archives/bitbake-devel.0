Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C367C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 19:52:56 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.26184.1749066767300997321
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 12:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hEdJcE3A;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so2358151fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749066765; x=1749671565; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGAztn+kFC0MnMamsQuc8suZC/v2BCayO4e5f4ObF1I=;
        b=hEdJcE3A7ZHfvC7/CUdT3PlPfLbmkci66+JKK3h0MVPJtoGz7wsZbCLhBy9biRRpi7
         vsupR2Oh1MFlTAk0WPTa09SxysoAGd7LbP2kgZE8KE/412IopD85WP1I7tuxk5tG17g8
         BhWfv5VXmH7bV8lZ/TcQH0mWIFcnsUCywepBaDMqonCOrOFWrZlREp7oROWlWIR3AxzX
         DzXqYS7T1GKYaYTl0pHzpHsDC4XcS2GTJRJpD8wq4fov+QWO5y6zJaahWaYwd24ttzwb
         T9RMIVDfDR8F37RP1sabmXQwakwX/4YC+vHD70ujDKMjL/Vv5ShN5QI/NxPoGyeQ4mul
         /bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749066765; x=1749671565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGAztn+kFC0MnMamsQuc8suZC/v2BCayO4e5f4ObF1I=;
        b=ETKj55mA6lOL2Yxe5G4h5IifXuwRQYffHpihZx4+4kH9q2rU1RAHItYC73URE2pqqf
         6jNHgjK/ei92P2qvkp1MjC8FOs4xKszy7HFBPgSp1jFUq2Ks7cJ435T7DcWYr713X8zR
         +MxuXJySAEwb5rxmOdIeUDWCa6zJcgpy+LiBd4NYwlUcyIWECAGv2w3gdRIC/pp6nN9A
         YFC46B4uJxQiF3MNAueYCOQNmfggx943ITUR0VT/So7b/Gw7gXcvilp926uND/nE+hxf
         E4/S73+4zkd7kKiBJZjAxdMEGGUrDEXGEYv5oeH8LIj1aBzrHcEr+AkhWLaaJInos/y1
         X/zw==
X-Gm-Message-State: AOJu0Yyh8sOzVcJ+F6lgOklOtackqyMoPu2e0q91mQ956szVKoumMf+P
	s/kASCtki3Gct28Wuy9+6WxeigqePSe8V2c67YMP5fXpqWMM/580Nrs1zQte+ifC+431vBMRjET
	MQLYqLyc1y2iSmeHR9SmcEN9w72VXx3c=
X-Gm-Gg: ASbGncu6n8nBo0COL7i34+WMINDz3DBCQlW+yLSgSeE7lS+7s5OtiSHTb1vsLi9PcRj
	NUFTUorT16/31psX1aLveivrTXL/PNebr/+HfGEXv6belqJ0XqX/x8Iur0gMXo4VoOFa3c2KSq5
	CjKDVRZBr8Sa5Ys7pu0+Cg1ja5LadVvAi5Wg==
X-Google-Smtp-Source: AGHT+IEuno3LasLsdurUky6Im72+kSaB1BwUb2zhXSHmSzpFqeVrSeCIN3cJi8z8ApEwsREX3HPBgY1ar7B+tW1yWyY=
X-Received: by 2002:a05:651c:146f:b0:32a:7a12:92ab with SMTP id
 38308e7fff4ca-32ac72aaddbmr16796371fa.28.1749066765130; Wed, 04 Jun 2025
 12:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <1845E4E00D65053D.10841@lists.openembedded.org> <0944f7e3d239cad26fec3d2eb49f0a2342a73c50.camel@linuxfoundation.org>
In-Reply-To: <0944f7e3d239cad26fec3d2eb49f0a2342a73c50.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 4 Jun 2025 13:52:32 -0600
X-Gm-Features: AX0GCFvBHOL3EdD3MLQWMHLEAsjT55tcqbRhh0ARD8k9rgkWYufB-urjg8xnY6c
Message-ID: <CAJdd5GY0VEjV2-QfP+1EJr6UNN2+C+QBw7a=Qpgq+YrLJ5tZbA@mail.gmail.com>
Subject: Re: [bitbake-devel] Parsing speed/efficiency, native class extensions
 and the expand cache
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 19:52:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17684

On Wed, Jun 4, 2025 at 12:02=E2=80=AFPM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2025-06-04 at 17:47 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > Going back in time, Joshua and I discussed the idea of a [filter]
> > function being applied to variables to try and avoid this kind of
> > problem. Given how horrible the above is, I think it may be time to
> > look at that again...
>
> I did managed to find the discussion I'm referring to:
>
> https://lists.openembedded.org/g/openembedded-architecture/message/1054
> https://lists.openembedded.org/g/openembedded-architecture/message/1061

There is also a jpew/bb-filters branch in poky-contrib

>
> Cheers,
>
> Richard

