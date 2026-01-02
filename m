Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23439FC6160
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 20:20:01 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12655.1767385191782318008
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 12:19:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=epDMv0dW;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8888546d570so183858506d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 12:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767385191; x=1767989991; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Od1+PNImRfnRDtxF7yr4Y7xciTpHeS5WLO7QBTlFco=;
        b=epDMv0dWGuMDf7yTlNdzyiQ+Uyre3LhXqRq00Ucd8tFdTyGGEQ3imtA9EGhwunnhDh
         CHcCveb6Jz4NMnjJgO1TZvv2LIvZXhZo0LLwcTlUBpGuYXXQbgp2u0k+5Ic/oRRs17ob
         a9ZYoAnyPXzo7zHr1KSOcBRgxdQ/qUckMgKFlRxdv9fHMlLBit7n0S74iWNOI1tKD6D0
         o6Za9G95DlxdBvggJwk/DGRm0YVjOogg7UbhTL2FjKAsYSvkM7FhSL87AvLdnLusJtWt
         kdQGihIFfr8xNYU8K2WHHp3F0mmT8BBkSZEmfsarjqKQlJP4U7wYfJMcru0XedPaQ6NH
         goNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767385191; x=1767989991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Od1+PNImRfnRDtxF7yr4Y7xciTpHeS5WLO7QBTlFco=;
        b=CWLYLK0BF0e+C1OnZu4HBBwX1Z+Hs+yc2y5ygLI11Um6iEtW9qDaIfj4LPKpEaQ+wh
         laNfHUcyPSx/GkAAd5IHt+/x8FRFPX2Ti2TKpP9c4XQFMmuzIOs2qloblAkdB5hg6aNb
         VQIvG9UjUBjj9Ch5SwZeZJ3JTSqSvFnDi5qOEwTUM05W2oQCQRDPvHq/X0emD/sfDR9e
         AQfJXhhW0JQWRWtaqB0FLfaqeaI/lpROkTLD8+twEML3NO7SiC12Ui830xTNmzsBrjj0
         KrncZ4G/U1nUO1YgMMyd680PU5V9mkUMjDKGgBpotF/bVkZn/wyGkGVs9Z96mH53RO9q
         qgoA==
X-Gm-Message-State: AOJu0YxPBz08UKNtcuufNiZDX/PivWkKinPM6KQGuoFFxt6MGXo44R82
	5VhA81VwJcObm+O8pNamQ0dxNy+48zZBz0pdxun+FH5h/t9KwA0iu96egjFeRdgHK8Vd7jPezzx
	62llzzW8uC7RPlYParvKNhgjHZOZyLfk=
X-Gm-Gg: AY/fxX5ncBq/7497bNg0UiHMKSvciOLxY8R3JsEt9XRYBdHcpOdEUX5dA2Hx8EsW6of
	Zz6/Eslxn+A3ULZhKrPpkZ5HP+f+UP2WTNdFrkc4zT2B7fEUAuPiDcTmhVsLI8q0dj9LH2LjZOH
	h9Wr2xutVxkRasGHAar7OOMSIVKdGWmCQDKWpcqRelkMGASOe35WsKhA7FWx3m+mAu1unOc4DYq
	TKr46uutjCzgWb8tI3d8WeBh4WBz77GUsvveSqDtZB91mISV3zHlcbxnO4e2iNeGO58+EyPK8yt
	F2MSlBa+blS5x4b8/OPTaztPVsj7lg==
X-Google-Smtp-Source: AGHT+IFnhmiICfr6WSdy0rZ4bIKaq9lY0fdUVtDeVw58k2+dFj/X4Jv9+fL5els382RtLPd8FYPKs4XzrsxSGQwug6A=
X-Received: by 2002:a05:6214:260b:b0:890:59fc:d00c with SMTP id
 6a1803df08f44-89059fcd13emr8242476d6.4.1767385190727; Fri, 02 Jan 2026
 12:19:50 -0800 (PST)
MIME-Version: 1.0
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com> <1883858B93EFC423.1614991@lists.openembedded.org>
 <188385EDFF4B6429.1342979@lists.openembedded.org>
In-Reply-To: <188385EDFF4B6429.1342979@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 2 Jan 2026 21:19:39 +0100
X-Gm-Features: AQt7F2oytPaF2caXjvlnhwMUefynTO7fMlRMevxsLyVPgMIE0H_S9-FwGhtqcpg
Message-ID: <CANNYZj_xWBywPnOQ65NF=baZZWoG=e4ThBNC7axpjnMBE+zg6w@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, uvv.mail@gmail.com, 
	Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 20:20:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18682

On Mon, 22 Dec 2025 at 12:25, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> > Sadly yes, this is how bitbake's git fetcher performs unpack(). It's a
> > forced overwrite, with no consideration for whether there have been
> > local changes. We do need a guard in bb-setup for this, I guess the
> > good one would check the revision that was previously unpacked (it's
> > written into config/sources-fixed-revisions.json), and if the revision
> > in the actual layer doesn't match then it would ask the user in the
> > same way that it asks about making build/conf/ changes.
>
> If the revision does match, it should also check if there are
> additional local branches. If either is true then ask to choose one
> of:
> 1. Stop the update right now.
> 2. Move the existing layer directory to a backup location.

I posted a patch which adds the local modifications check.
Unfortunately I couldn't figure out how to check for additional local
branches: it checks only if there are uncommitted changes, or changes
on the current branch. If you have ideas I'd appreciate (simply
running 'git branch' and counting the lines does not work, as git
fetcher's unpack first unpacks master, then checks out the final
branch if necessary, so both one and two branches can mean no local
modifications).

Alex

