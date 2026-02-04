Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9BE9537D
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 11:00:36 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17975.1770202834487106484
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 03:00:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=fEE23Uih;
 spf=pass (domain: smile.fr, ip: 209.85.208.46, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so8696163a12.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 03:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770202833; cv=none;
        d=google.com; s=arc-20240605;
        b=Zg+cllQpmlTOXvLuqhSQzTy8HxD2yvsZB3DaKk2aFB1PqYGHZOrDYGVQz5xj/lgW1b
         5C6iGN+agGTfplHPRzP3ApRUJM/yWECSfVJEQ6eZFSNWmvdMQoeFjmw86wJOITc8cPZq
         w3pIWHS+5LJu+LbXCDsDDs2yqo9Kx72l3X9z3vatUYSFgVvyfu4I5tiu+KbmbCdn5P5P
         RoXhbrnknh6vIgOrSNHiw/+76safo4UqChufPLBcU8DpnmRg6op5eJIDbqpyj4JntCLG
         jYHQL2HKR0/bRDmd4+I82cGRyCCmtFOVH5eEvHjonVUgLYpTMCipFEpl9eSb3TU6xcNS
         u4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3UbiLl81KXTCcAijvIIOtmQch1CHjHa0L8PV5g7395E=;
        fh=dGhMZmBQcdDlInfqMh/AGf4gkCSnr037ETBnNt2bW84=;
        b=dgE+Sce5ZJYzTbIKBzdzNwS1IqNZkfyFeFx2KoLEBbb5B5IwH2+AGz1BjCdcvtgn/7
         BNzwfyDxgNa3mRGEOGUYVXMit5uX69mrpSpyromPXy8IystIuzsMJ1XCxZRLnG0pOPmS
         dx+NKUTMlNgI9PUc5nCZ6lsMbS3pLJGMsb4a5ui7uXPCBiSeqIsb5lmPcePegHUEAC//
         3Z0st2kSJXr1up4oJpyGDkENoBSdcVC0O2BJpmfCRA7Ai53OmtUmm6A9xHfH3q1rZdSa
         6N2vKT9DZUdU2/PTAxyf8UFiX0Q83w4tY7mv903YVZxtS83XKFXgCelkWXS4r7sbQyVA
         K+cA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770202833; x=1770807633; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3UbiLl81KXTCcAijvIIOtmQch1CHjHa0L8PV5g7395E=;
        b=fEE23Uih3hTWQxv2hf5X8+kq50rnfclEgFCkS4v4GMeztZ6OhCue1hvJA5ZNYbjxeI
         7fMp8z2pYqIO0zLiNPRvN4RpV6iz9kEi6BqrB0Z7yWKwAn5lLP/nU4zaYbV7WU0dF5DW
         lnb0thV3Bi4ES6kzfiAgZSeUA7AdXFIS2B3bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770202833; x=1770807633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UbiLl81KXTCcAijvIIOtmQch1CHjHa0L8PV5g7395E=;
        b=t6h+YO2TmAc75iTkmgjcL4+kQAhJABcB1hrALDFd35y7oq2CEH1bIu8NsWnVj6m6ki
         yM0I0OfEvmrN7zVazkqHEJFaf7eD6kSBQZ7VT4AoTtnyoduFTPmDAhUGWZnxNv//wTPn
         a8Q7AtDm+kVQf23GyUZ7iCby1Kol5z8zwOlf4kEDN0y1+NACHjC+q5pfD6/lz55WKySf
         TAxVWna5elmNH21gR2ZYZFE8HQGp0SqwXCtKGRNWDNy2dbKi8jWabUoxJRLKp9el8C0K
         iSbURJCbiwannOMZn29LTq/1HmDcykiJ0fb4C24B2kjv4SN5Kkf48sH5SWj27F1VuGvt
         8TrQ==
X-Gm-Message-State: AOJu0Yz9q47w0sOGY0zk2KW8LJi2okDcaCulQQAgxsuW2SBZuQozaLRf
	MYDlQYs97EehZS6qYVMrziXk+t9aI43kUDf8m3yts0BLfklEUxohD6X1ERnnMjvi1vXlGXY0kJB
	hHqTgRAnrC4SKPuXeN5PARdxFoNaKjy7GrHb+IPYRWw==
X-Gm-Gg: AZuq6aJ3iI99GkrG5iSJmENRAquwiblIB71voEMTIuQg2aLDNT3UsJpFdgAFD7QfBfX
	3fQpe1sm7M96AdVvQXGXQJWlxo72uxD8pGXOf8hd7pabVmwOKEt2zINHnPimim5zqqNaCuGF+Km
	McY7j/NT29PByyS2+5PRWZK6nFOvHD25bBDGD5u4yaN+jehngbccg7TxO8cP/Wnc0weo9azD/1m
	AlsmPL7DLDpkhjJiel8gXauP2xrwVU2I6mkgvZcw5UfZpoh+oPejty7pp6nzP+Nwvvs16Ij7fvd
	qXHeB0Pba6vrSDVx+12hqcMoWQ==
X-Received: by 2002:a05:6402:280a:b0:658:e2ed:f313 with SMTP id
 4fb4d7f45d1cf-65949dc941fmr1570868a12.23.1770202832482; Wed, 04 Feb 2026
 03:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
 <20260123172422.3304682-3-corentin.guillevic@smile.fr> <CANNYZj-pU7BHRsBYG+Zgrxqqk=Z57CxbTcfqtkPc4VSk-RqGHg@mail.gmail.com>
In-Reply-To: <CANNYZj-pU7BHRsBYG+Zgrxqqk=Z57CxbTcfqtkPc4VSk-RqGHg@mail.gmail.com>
From: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Date: Wed, 4 Feb 2026 12:00:21 +0100
X-Gm-Features: AZwV_QgFo-qWy8n7aWJl8tjwi2EvCDlD6M7czdnIn7w2Iuaehad6Y7_Ktq5TOX4
Message-ID: <CAMFqQmo4DEib=QTRcdi6MimuTu200Fqf+GS7EA-yzFnHyE0NKQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v6 3/4] bitbake-setup: use URI shortcut
 for all configurations
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000002c5c20649fd778a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 11:00:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18949

--00000000000002c5c20649fd778a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

My apologies, I missed your previous message... I will be more careful next
time.

Corentin

Le lun. 26 janv. 2026 =C3=A0 10:48, Alexander Kanavin <alex.kanavin@gmail.c=
om> a
=C3=A9crit :

> On Fri, 23 Jan 2026 at 18:24, Corentin Guillevic via
> lists.openembedded.org
> <corentin.guillevic=3Dsmile.fr@lists.openembedded.org> wrote:
> >  .../oe-nodistro-master.conf.json              | 18 +++-----------
> >  .../oe-nodistro-whinlatter.conf.json          | 18 +++-----------
> >  .../configurations/poky-master.conf.json      | 24 ++++---------------
> >  .../configurations/poky-whinlatter.conf.json  | 24 ++++---------------
>
> In v5 review I've asked to use the new format only in master configs,
> and this wasn't done :-/
>
> Alex
>

--00000000000002c5c20649fd778a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alexander,</div><div><br></div><div>My apologies, =
I missed your previous message... I will be more careful next time.</div><d=
iv><br></div><div>Corentin</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 26 janv. 2026 =C3=A0=C2=A010:4=
8, Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 23 Jan 2026 at 18:24=
, Corentin Guillevic via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;corentin.guillevic=3D<a href=3D"mailto:smile.fr@lists.openembedded.org"=
 target=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
&gt;=C2=A0 .../oe-nodistro-master.conf.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 18 +++-----------<br>
&gt;=C2=A0 .../oe-nodistro-whinlatter.conf.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 18 +++-----------<br>
&gt;=C2=A0 .../configurations/poky-master.conf.json=C2=A0 =C2=A0 =C2=A0 | 2=
4 ++++---------------<br>
&gt;=C2=A0 .../configurations/poky-whinlatter.conf.json=C2=A0 | 24 ++++----=
-----------<br>
<br>
In v5 review I&#39;ve asked to use the new format only in master configs,<b=
r>
and this wasn&#39;t done :-/<br>
<br>
Alex<br>
</blockquote></div>

--00000000000002c5c20649fd778a--

