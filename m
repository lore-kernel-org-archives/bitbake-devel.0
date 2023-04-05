Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C38C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 16:32:19 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.135279.1680712335329848867
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 09:32:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BcvcJK0U;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id g17so47438137lfv.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680712333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+u87uwBRDaDGRo4fFcCdeT8jIUoprslGzPEGf4jHBwY=;
        b=BcvcJK0UFB0KCyA3jFGz6G0R7CFUHsmbwC5ydI2mjE7WNbefZSS0742vFPdoE9uz2w
         ghZvzD1r6BVlKqmalFKoSJ6Cr4VXNWZ8p09/W9mXEXdi5JbnaYleesfzAGDNmr9giv45
         U5iprAoeju5maCJirEfdfu2++tuqQIlHnFGAG13TtwFz3jTO83KuxCbhpjs5klcRUCOk
         IgAqmVT85VjlD6VBrUepgwps3Qn8fxQF7rJa4YmBiKaaXeu2lzfBBwQ9jGbkQEMCWNuw
         /AtIavcJdmiKHZaZzlj6ln1QVtTVQ4JcymVccwuHJt7Q2URPSv3VodqFbBFNLB1nOrt2
         OaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u87uwBRDaDGRo4fFcCdeT8jIUoprslGzPEGf4jHBwY=;
        b=EIUs1fejkCUSkS7mflgO2LgvCSOlXs9GQ+7LK/3Q0GV+IgGmP7vQSeFjCkZIt20c/W
         HplVXipr3ghwVtoj/yztQE+Wom+UqjA/BWSbQBODOkntvsjSkgxwIATBBFhn7Fv7oPne
         oJfDTHHMmdaqa5MFZCvQTupf/6n40NwK7MdUyhnyYeyxU0In3fvcK0NBIANxk/8VOLdo
         0JZ/YSbAJdqCPFYsdt9SMNSaXrwbgvEB8Ib5ts0FpLeqDuju5Ick8z2a5JjMB2d97YJB
         YWADk+nJM4m5kl5s4cCDjkYF1ETHvB69BKIwYb0RbuwPHpScprmHV1anGhQbp7Yza4RH
         V/Pw==
X-Gm-Message-State: AAQBX9cgLKwD4KQK6B08LkZ9pKiPESLiDgvp4Yikzu+pMpIT943BnS2H
	fioSf76DDFxTESt/CYaWUTcP280jmsnPGn16rx7dmXQ3
X-Google-Smtp-Source: AKy350a2prA0u6A/HcY/So4Wx0ECzaU4XtbxeLRRzP78QXPYe5Tp3c59GE2oWN4rYTPR6XVNCQBa/X4fCuxm6H0TXdI=
X-Received: by 2002:a05:6512:38d1:b0:4e8:45d5:53cd with SMTP id
 p17-20020a05651238d100b004e845d553cdmr2116196lft.12.1680712333375; Wed, 05
 Apr 2023 09:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com> <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com> <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
 <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
 <d3bdc504-a8d2-b925-cfd4-78655df7e4cd@mvista.com> <CA+cAker7RbVScDT_C8PmsRJ_03dXCx62WwGDRQbtSnkSBe1ujw@mail.gmail.com>
 <a1a3ca96-3cd2-10b7-4dee-59bfc2163d7e@gmail.com>
In-Reply-To: <a1a3ca96-3cd2-10b7-4dee-59bfc2163d7e@gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 18:32:02 +0200
Message-ID: <CA+cAkeoxhzv1JOvUZtv96NMKwa93PpR=JMSnmb=uP0nGtQDBcQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: akuster808 <akuster808@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000099bd6e05f8995578"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 16:32:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14660

--00000000000099bd6e05f8995578
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 5 avr. 2023, 18:26, akuster808 <akuster808@gmail.com> a =C3=A9crit =
:

>
>
> On 4/5/23 8:51 AM, Fr=C3=A9d=C3=A9ric Martinsons wrote:
> > What is the problem of having name there?
>
> I deleted both alloc-no-stdlib and autocfg Cargo.* files and
> update_crates worked. I appears is missed a bunch that I manually added.
>
> I got is building again.
>
> Thanks for your help.
>
> - Armin
>
>
You're welcome, glad to see that you manage to build those recipes. Have a
good day.

--00000000000099bd6e05f8995578
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">Le mer. 5 avr. 2023, 18:26, akuster808 &lt;<a=
 href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com</a>&gt; a =C3=A9=
crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 4/5/23 8:51 AM, Fr=C3=A9d=C3=A9ric Martinsons wrote:<br>
&gt; What is the problem of having name there?<br>
<br>
I deleted both alloc-no-stdlib and autocfg Cargo.* files and <br>
update_crates worked. I appears is missed a bunch that I manually added.<br=
>
<br>
I got is building again.<br>
<br>
Thanks for your help.<br>
<br>
- Armin<br><br></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">You&#39;re welcome, glad to see that you manage to build those recipes=
. Have a good day.=C2=A0</div><div class=3D"gmail_quote" dir=3D"auto"></div=
></div>

--00000000000099bd6e05f8995578--

