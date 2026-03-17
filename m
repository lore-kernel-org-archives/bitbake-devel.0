Return-Path: <pierre-loup.gosse@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E141F3381B
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:39 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71390.1773737675378281466
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 01:54:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=SivEqIy4;
 spf=pass (domain: smile.fr, ip: 209.85.208.181, mailfrom: pierre-loup.gosse@smile.fr)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38b50c79f2fso1998151fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 01:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773737673; cv=none;
        d=google.com; s=arc-20240605;
        b=FWc3fdGAyNkl6OMBE7PEmUzfDKFEJR1F6ou+rOKEbUp96pYDk4kh3idZhVsgyHBKYy
         LV1+7Tt/Olbgx2gocubhWcAvgU7NC0lg4+wwQ5ZNSPiaZ8fwGeJAtK0Cw/4vwEgNrg4v
         zuGNG4mk6wvk43FSJs3+r40kIwVgBjqH2IsrKXbwUEmJTWHw3w4dh4wwT6XNaagrVx20
         BW8613S1WGrxUuLD/EO2x+neW+DWA9PGTL7+6da/1gLCgIU3H7rFQgRzoauJKnRtdgEV
         /AQLXedGllsGH2UaTjhXGYrzbGLPsJUMbvfwI7hGFEwrKRBq5CN2mjZwpzfQAaOp3iYQ
         3CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PhMG5i0RssdZkJR1TcLIAg3TfuZQTR0gCR8K1FWHzws=;
        fh=dGhMZmBQcdDlInfqMh/AGf4gkCSnr037ETBnNt2bW84=;
        b=X/YqBXBZNZSek3Am7iQSB0U6ZsjI675/2VSr0lzMozR5XxiHgB+MuUzIVMyP6G57Bx
         xaYaMFFDhF7kcwsRZBZkrG/FiBmeUTsBo1SdW5LHwov43gEnyYh5postm3aH50W94zmJ
         pD8aw/N4HtrwABuuiwDsPvhQwauBxHH1e5ts63inkk0l0aV21oNkmDHlbklRZtPHRITh
         xujj49hYJE0EeJ9pldCSoDDVLav7y2z79iuJRbd5ANfa/SrJBsvCK+AAGcAKxySefPYB
         DY06b6/GTpVdY63dMhZ+7p7a3FniJNYF7f+3en1oh01qA1rRuHj10iYe/cUqA40kbykW
         l3EA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773737673; x=1774342473; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhMG5i0RssdZkJR1TcLIAg3TfuZQTR0gCR8K1FWHzws=;
        b=SivEqIy4Z/QflF0jrMKbc0Dw3bipHhmJBoDMjaYv7QtXRzWBBAtYj7+vKyPWMShNMO
         yaf14flmX8Yu5Ao+83i7ll5oVVS8u06aeGYHEkUfq4dWr18VmUQaKPABnoAyGgbZPTTG
         kIdyyfAnwNeFU62//h5ibsq9TgZ78NHgHspzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773737673; x=1774342473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhMG5i0RssdZkJR1TcLIAg3TfuZQTR0gCR8K1FWHzws=;
        b=gZPgpi/klWwvfB+dDUjgrvOm7yxENMcrcTYDCEY1+Ds3efGUbT1HNld+Zfpl4jrK5U
         OthnQpZNIse5j6vk0vgbQIktcs+JwBs0G8nY+RAoI8XJczFmo1dq155N5N7HaoqQGOwl
         maYYAR1lTkvfGcbS8UVldF/ovnUX1tZm3zTx/KZFYQI0mG6F64J5Kb6tcMIHTWz7HbcR
         s5cR4R9oKBJC+sXn+3lh46k9AlevQTDiuqhOxO6skKl+2i2Ay7hmnOzXdlEJz4+xXQL/
         lhX+EEzRxpcEIl4Orz/brMnMacQlqJHaV3Q8Cqdf2U+sYx8XKqkfj4fpfmHdP24a5nY6
         1djw==
X-Gm-Message-State: AOJu0Yxa3dpO85SzO9RqWlrNh8+zoDvh5akRHu0X/XP5mAfTTSGoeW+y
	JjvMVvGUtoWbqaI9sI1d9C2WC1vR6aUcSHfgQKMkxzOg9mNbUJAsWiLkM/1FRnIAUEDvA8IO43V
	6dRceh9ikeG4S/JYbMInn6XftLR9Fwy9nBInRzB30Ug==
X-Gm-Gg: ATEYQzz+lkKiOFVgG7i91h3OyS17/rGyTNRHoqgWkyvKnFQtsxh0kcceU/q43woGB0K
	EDN4hpBk20O+CD88apvPavcj6mygx+phk4L9xhVAsXIxbufEl9nhfJWM6KIv6+jmEh4E+dOPsIv
	eZSc3MQNmfKDEls/iZ0AdZCeSBUOu959ZkARnXBZcn6TtZacDDYNAW/5WIzEv46DxNCwFuD4alo
	zhK2pXxTtKq0M01GW0zioBWcWIsWagB+p3k9sroX3+lO0vpxS7nN6kDtOIeHy00RtKAl6j0Yckh
	B2SFzr80o99k8kHCiJU7s1dPbeudMtLnzWecDkcov+mBLZQS1ev0LKc6CCrv7UZBe+RXw5LEfwQ
	GBSn7Pg==
X-Received: by 2002:a2e:bcc4:0:b0:38a:35be:bf4e with SMTP id
 38308e7fff4ca-38a8973bebfmr54217431fa.24.1773737673411; Tue, 17 Mar 2026
 01:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260316090420.914602-1-pierre-loup.gosse@smile.fr> <CANNYZj-BGkGbQcq3yTdp1f2pMpPdEQrpQQj2as4w53bJoyj26w@mail.gmail.com>
In-Reply-To: <CANNYZj-BGkGbQcq3yTdp1f2pMpPdEQrpQQj2as4w53bJoyj26w@mail.gmail.com>
From: Pierre-loup GOSSE <pierre-loup.gosse@smile.fr>
Date: Tue, 17 Mar 2026 09:54:22 +0100
X-Gm-Features: AaiRm51AZUnJdu09RuhSgvvxUktVbG0LNwJTMxNZUpQb_8Q2g50Bh86I9tJRsVc
Message-ID: <CAHT-cZsyY4fAoooa+UwE8D_Ttau7p-W1CnVTjS4aEdvBjOM=eQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch: AWS Codeartifact fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000f2da30064d347b4e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 08:54:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19158

--000000000000f2da30064d347b4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I followed the requirements described in the README and took inspiration
from the S3 fetcher, as they are quite similar.

However, only point 'j' (*API to query for possible version upgrades*) is
not supported, since this Codeartifact repositories are usually private.

Pierre-Loup,


On Mon, Mar 16, 2026 at 10:26=E2=80=AFAM Alexander Kanavin <alex.kanavin@gm=
ail.com>
wrote:

> On Mon, 16 Mar 2026 at 10:04, Pierre-loup GOSSE via
> lists.openembedded.org
> <pierre-loup.gosse=3Dsmile.fr@lists.openembedded.org> wrote:
> > Class to fetch AWS Codeartifact asset with the AWS cli. The aws tool
> > must be correctly installed and configured prior to use.
> >
> > Signed-off-by: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
> > ---
> >  lib/bb/fetch2/__init__.py     |  2 +
> >  lib/bb/fetch2/codeartifact.py | 94 +++++++++++++++++++++++++++++++++++
>
> Please note the fetcher requirements in lib/bb/fetch2/README. Does
> this fulfil them?
>
> Alex
>

--000000000000f2da30064d347b4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I followed the requireme=
nts described in the README and took inspiration from the S3 fetcher, as th=
ey are quite similar.</div><div><br></div><div>However, only point &#39;j&#=
39; (<i>API to query for possible version upgrades</i>) is not supported, s=
ince this Codeartifact repositories are usually private.</div><div><br></di=
v><div>Pierre-Loup,</div><div><br></div></div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 1=
6, 2026 at 10:26=E2=80=AFAM Alexander Kanavin &lt;<a href=3D"mailto:alex.ka=
navin@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Mon, 16 Mar 2026 at 10:04, Pierre=
-loup GOSSE via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;pierre-loup.gosse=3D<a href=3D"mailto:smile.fr@lists.openembedded.org" =
target=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
&gt; Class to fetch AWS Codeartifact asset with the AWS cli. The aws tool<b=
r>
&gt; must be correctly installed and configured prior to use.<br>
&gt;<br>
&gt; Signed-off-by: Pierre-Loup GOSSE &lt;<a href=3D"mailto:pierre-loup.gos=
se@smile.fr" target=3D"_blank">pierre-loup.gosse@smile.fr</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/__init__.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
&gt;=C2=A0 lib/bb/fetch2/codeartifact.py | 94 +++++++++++++++++++++++++++++=
++++++<br>
<br>
Please note the fetcher requirements in lib/bb/fetch2/README. Does<br>
this fulfil them?<br>
<br>
Alex<br>
</blockquote></div>

--000000000000f2da30064d347b4e--

