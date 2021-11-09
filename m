Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D316C433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:25:02 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.11120.1636460701890029006
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lJ3b6M4e;
 spf=pass (domain: gmail.com, ip: 209.85.214.179,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id t21so20589947plr.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6eikVcBzFn3dRY7mXUaEm60esiiwt+c+A2y2FSVqsI=;
        b=lJ3b6M4eSAoV30Hu7RViKMzfc63CIXbkiW6J0exFnxCb1yeCbW8Ww8wSapEK6ZK2CX
         B8haRAq6sWA3DIjTcSzs6kD+U5F9kaU0STXXlfqg6KCyiCBNlQIecfb77ILNF5Q/eVqQ
         tygGx8A+bsWRaBeYOyWMzTSBpcvkegtfhYa903vfxA2RdxcOSQTJS+oSpYecW3ptLzXe
         9UdS6ttFYuv0RdyC2EIudDPUxyuKPa2u8cD26GmcTDFq1JtDhlc9rIjKGUEYER2cV2gG
         3tWMlWLHZGb1Bzs8XDs14jrFcKgpVW73ELJyPrFR2hlNNDP0UHb68ZccZGxfPdEb/tdp
         Slfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6eikVcBzFn3dRY7mXUaEm60esiiwt+c+A2y2FSVqsI=;
        b=UIttxYb8SQcmRrTsgYxAY5Yn9P6UXNjBjM8NJVc9PMP9Fn4HFIZZTl9dmXeoJgFBb1
         qjrTnWOmNI8O11+3QkPrf/8VTiOdYhOGQP1ewVM75xA0xnvEKtXKPiAKu8yHMicTikRL
         RkLmQgZcnFpqlMxI5+fNt7SIERpEsQLm9e42UYxwt2IfF5LzsAaHrCtfzM1sXU5cG98Q
         WoszwzBtz0Ho1yNahO2GDNTyrnBotijmNhMFNGGUewNHXOe2cPQs6i+IfYNhuy/cKXe9
         Zb7Rr9Yjt2f7zhzY2vj2RV0iszE3AwHDkTEAd3EqzjA6hx1TB0fV51bBMCWWcZsy4phV
         NAZg==
X-Gm-Message-State: AOAM531WdF50ApMtpnF3MFDidZG7xuraw5KWFj3nPKK2ZAR7MUvjfDOr
	V+/5xnbofrFf/UCwgzn9PSqndnIVjMgv7s8oNTk=
X-Google-Smtp-Source: 
 ABdhPJzLtkL1GDlzd+qWYcdOOs8R77nzbDl9Eayy6BXhzCsvLDyWlzGapPXGuigRiIu6IWYKi7CR6mMySy/uRt5+ELE=
X-Received: by 2002:a17:90a:dc15:: with SMTP id
 i21mr5208627pjv.183.1636460701354;
 Tue, 09 Nov 2021 04:25:01 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
In-Reply-To: 
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 9 Nov 2021 13:24:49 +0100
Message-ID: 
 <CA+chaQdsfGMSXJ0ASH=dM8TafcdsbkTUFQZP66w9W5E5_7conw@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: mikko.rapeli@bmw.de, Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000cb0db005d05a32f1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12967

--000000000000cb0db005d05a32f1
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 9, 2021 at 12:56 PM Marius Kriegerowski <
marius.kriegerowski@gmail.com> wrote:

> Okay, one thing I have to add after killing some time with this: I quickly
> scrutinized the git history of `bitbake` and `meta-openembedded`.
>
> Attached are two figures that show the first time contributor count of
> both projects over the last ~ten years. While `bitbake` shows a linear
> growth of first-time contributors, `meta-openembedded` is exponential. I
> didn't analyze the first derivative but to me it looks like there is a kink
> following that timestamp indicated by the vertical bar. That line
> represents a subtle, yet important change in intonation in the merge
> requests. Before that there was always a comment "Please read README and
> send patches to openembedded-devel@lists.openembedded.org for review." or
> alike. After that the intonation changed to messages "Patches should be
> sent to openembedded-devel as described in README." and if I interprete the
> following MRs correctly the maintainers (mostly @kraj) were kind enough to
> apply the MRs as patches.
>

and as you can see in the ML, Khem is sending those commits from meta-oe
PRs as e-mails to openembedded-devel ML for others to review, which is very
kind of him, but also causes a lot of overhead (especially when there is a
feedback on ML which he needs to forward back to the discussion on the
github PR and then resend the vN patch to ML and so on).

And it's not only the review process of the new changes, there is a lot of
discussions in various MLs which even occasional contributors should find
useful (especially some global changes or project directions discussed in
openembedded-architecture ML).

I'm sure there is a readon not to hit the merge button but instead doing
> that manually which I don't understand.
>

github.com/openembedded are read-only mirrors of authoritative git server
https://git.openembedded.org/ so just hitting the merge button would break
the synchronization. And the changes are first cherry-picked to various
branches to be at least build tested in some world build, before they are
considered for merge.

PS: I'm retro, I actually prefer black and white plain text e-mails. And
for review in other projects I'm involved with I definitely prefer gerrit
over github/gitlab. Not only it allows correct review of commit messages,
but also is significantly better at comparing various revisions of the same
changes and tracking inline comments there.

Regards,

--000000000000cb0db005d05a32f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Nov 9, 2021 at 12:56 PM Marius Kr=
iegerowski &lt;<a href=3D"mailto:marius.kriegerowski@gmail.com" target=3D"_=
blank">marius.kriegerowski@gmail.com</a>&gt; wrote:<br></div><div dir=3D"lt=
r"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div>Okay, one thing I have to add after killing some=
 time with this: I quickly scrutinized the git history of `bitbake` and `me=
ta-openembedded`.</div><div><br></div><div>Attached are two figures that sh=
ow the first time contributor count of both projects over the last ~ten yea=
rs. While `bitbake` shows a linear growth of first-time contributors, `meta=
-openembedded` is exponential. I didn&#39;t analyze the first derivative bu=
t to me it looks like there is a kink following that timestamp indicated by=
 the vertical bar. That line represents a subtle, yet important change in i=
ntonation in the merge requests. Before that there was always a comment &qu=
ot;Please read README and send patches to <a href=3D"mailto:openembedded-de=
vel@lists.openembedded.org" target=3D"_blank">openembedded-devel@lists.open=
embedded.org</a> for review.&quot; or alike. After that the intonation chan=
ged to messages &quot;Patches should be sent to openembedded-devel as descr=
ibed in README.&quot; and if I interprete the following MRs correctly the m=
aintainers (mostly @kraj) were kind enough to apply the MRs as patches.</di=
v></div></blockquote><div><br></div><div>and as you can see in the ML, Khem=
 is sending those commits from meta-oe PRs as e-mails to openembedded-devel=
 ML for others to review, which is very kind of him, but also causes a lot =
of overhead (especially when there is a feedback on ML which he needs to fo=
rward back to the discussion on the github PR and then resend the vN patch =
to ML and so on).</div><div><br></div><div>And it&#39;s not only the review=
 process of the new changes, there is a lot of discussions in various MLs w=
hich even occasional contributors should find useful (especially some globa=
l changes or project directions discussed in openembedded-architecture ML).=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div>I&#39;m sure there is a readon not to hit the merge butto=
n but instead doing that manually which I don&#39;t understand.</div></div>=
</blockquote><div><br></div><div><a href=3D"http://github.com/openembedded"=
>github.com/openembedded</a> are read-only mirrors of authoritative git ser=
ver=C2=A0<a href=3D"https://git.openembedded.org/">https://git.openembedded=
.org/</a> so just hitting the merge button would break the synchronization.=
 And the changes are first cherry-picked to various branches to be at least=
 build tested in some world build, before they are considered for merge.</d=
iv><div><br></div><div>PS: I&#39;m retro, I actually prefer black and white=
 plain text e-mails. And for review in other projects I&#39;m involved with=
 I definitely prefer gerrit over github/gitlab. Not only it allows correct =
review of commit messages, but also is significantly better at comparing va=
rious revisions of the same changes and tracking inline comments there.</di=
v><div><br></div><div>Regards,</div></div></div>
</div>

--000000000000cb0db005d05a32f1--

