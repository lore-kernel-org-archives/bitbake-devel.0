Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC8C43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 06:52:43 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63957.1782975154034083738
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jul 2026 23:52:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lAw962w0;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c167c58f2so8853481cf.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Jul 2026 23:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782975153; cv=none;
        d=google.com; s=arc-20260327;
        b=r0FkKZh0sVYViez9Po2SLEI/n5NniyPHqFkHRO0InceBkZT2KQgfv0P72SkjitiICc
         K/6/e5bBjemHf6gJTwhRe9R42kIYxy0YDHdcQPxMn07v4JpG407fTTtSH/z4l6S5fwGt
         WG2K5kbX+sVqH+JH7CrNFwFlGiyGcfb6qs4K7s9Fun+0AC2nQmTMdX/E22WPpB68CbHG
         4gjCprABhYnK1qWAWtTMUOOKdE/tZbWY+tn4eDcD+TmKirsDvFaMH52kRJuLd7hgGrSn
         jcpcgZHxxntF8DFTJkFEeq1qFfDFIAYvHtH/UhhfbHi+PQ6tQNWF6qS4uxvcWf+GmTE1
         0mVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hxnR2YzKWqdd7Rkp24vO3kxaaY2XxpOwJ8j5nfMJPiQ=;
        fh=kNzlaiOf+I3fxr8rYtONbFCy93KUWZbbIgSXfzF831I=;
        b=sRCxsLILH1FMYm6Wyx12QllsIWA9sHeiV2wHy/a9nY1VN80E48U/yifCPkW3l2kmQ5
         A/wUQCwRPB80Sd4/8/IPwDwhPdMqSDoQrFQTU9BeWk1IXHYs4Xp0+ymiRWVD8P7mK0FP
         RDfpiQcvPFVG/3/I4NDe59RJckP6glwIZjhduW2p1nWGdPPdPYLAdxJe2OC+GtJagmgU
         E8nUnwKurs36SJIBv2ucOrWYHYxGIWYoM1s57ZNY4EDMspLVhEj4GT9OwCha+Ra+d+ri
         s4EDv6NXasOs2m54o0/4IN7LWuPNwJe+9PHFOfJ1TcInkWqRKADP9ugL8C3h3ukr6Usg
         MUSw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782975153; x=1783579953; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hxnR2YzKWqdd7Rkp24vO3kxaaY2XxpOwJ8j5nfMJPiQ=;
        b=lAw962w0ZbSyPrLNTjvW+gCkiSOGm4rAhVFbaW1rGp3Ee6HLiNVg5HlZ+7A71cpz+2
         7GtXX++BRYSXtA44fVXo+4HHGOtbaVW3S8dovxPbbCPKeSR5H3DjJT1MtM5aBpVrooCv
         9xSiPoFAfCjRKnR2Xio1xiDrIdDFMmTdvNYfNuqCaPIm0f9KYhUSrq7YaNoccqhEzIFj
         jBPoynz0bYggAH0ALiyiL/ECnvQd/5TDkTdTE9sNh/IqHyk3n7t2j2U9QIMb2IhzA3n5
         1m3i5JwyrBf2L1C22DygdE5ezHlHdnQaD0MoUnZ83jK0f8eZtbOpg/oA9A7MjuAOE1q1
         eE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782975153; x=1783579953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxnR2YzKWqdd7Rkp24vO3kxaaY2XxpOwJ8j5nfMJPiQ=;
        b=UxV/DXoCGvO3kJo3wrNLDkje9g8HD6HorAjT4u/FF94CA20hnTmNVj2lrnoqMeJiEr
         Jn93zg+j3PG1XjoBmP7Ol3aPSIp58tqiJUquKcdNMWlmiTOBIqf3M5vFbkSNbzsAJNlD
         K20l1LfSZ2cPARnXDB3/SJMQYk/93nV34mS9GX2Co3sJ1NHU0UawvQpxPMKz87ldENST
         Z+RRaD0k1WdAFvnRp6y+EsmLZyfT8JnawEHgBeSgGoJxRlEaui1M/LaxRPA5wfTQ0P08
         ZK/UOKAAVfCUckU/yBlfMcnJVvWhhIXoMY7XQPeaQpa2rD7qoaALxsuo6JnSoBDM7DhH
         XNaw==
X-Gm-Message-State: AOJu0YyTi+133An+zWEDFsnASQeIjjVIYPbe+2p5iVSXRk3H+lj5/TDN
	B0CAV7UuseM4ED1tmwJ8h6yJmI9clWndz3K/TUd/IHIcLULR36cQJSY5hJ7JmnY4uNHe1NtayyB
	/JFetCsGgs47XeSLL9V60yk9PJFszN50=
X-Gm-Gg: AfdE7cldHdhprsIWDVjlNteDGe4pMGY8Qwf1U5cKnSci05nuFJT0gSe+YhBWSVuqyAW
	2jvgxGNAU3a10heNmiG0SBgMtAF+xl21pUeTjKxLYpYhvx3Pfv0TXGEppJf88xbJNqk3Do8IgTd
	sQfBdW2JbFb9Rhau9s1q3RrO/dargZrZhIQ7X36ENhoJr6uSBChbnalMtLdakGMibqibIcnAWE6
	Wj91zO5mg1R0gwkGVUILXRN3wFPPfNI7mDktxqGJ2V2hW3Uo2eQZVpJLYhqsR6Cj9qph9h3/uhh
	4d7/voyBAYIFtjwnX6yhriUT1Zs=
X-Received: by 2002:a05:622a:1812:b0:51c:1967:5091 with SMTP id
 d75a77b69052e-51c26b15334mr73147611cf.41.1782975152820; Wed, 01 Jul 2026
 23:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANDCFSymKLKTANt3dti9YW+OncTfCQyArCjoSY=EzvBLyoi1WQ@mail.gmail.com>
In-Reply-To: <CANDCFSymKLKTANt3dti9YW+OncTfCQyArCjoSY=EzvBLyoi1WQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 2 Jul 2026 09:52:20 +0300
X-Gm-Features: AVVi8Cdm-OYb28g1u3CmgKE-80p0EY0TZH-7Ci74Pa_U1U1_XWVHeByQ8vx6ZFM
Message-ID: <CANNYZj9G4NeNhOOoamY2XcdaqnKDsW_xffhiEgLHL9FYK-mOig@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: support --update-bb-conf on init and fix
 site.conf symlink for setup-dir == top-dir #bitbake #yocto
To: Daniel Chaves <dchvs11@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000a0976006559b404c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jul 2026 06:52:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19812

--000000000000a0976006559b404c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you please send this patch with =E2=80=98git send-email=E2=80=99? Attac=
hment are
difficult to review.

Alex

On Thu 2. Jul 2026 at 5.25, Daniel Chaves <dchvs11@gmail.com> wrote:

>

--000000000000a0976006559b404c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Can you please send this patch with =E2=80=98git send-ema=
il=E2=80=99? Attachment are difficult to review.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Alex</div><div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu 2. Jul 2026 =
at 5.25, Daniel Chaves &lt;<a href=3D"mailto:dchvs11@gmail.com">dchvs11@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"></blockquote></div></div>

--000000000000a0976006559b404c--

