Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE3C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 13:17:35 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web11.11743.1636463854153597297
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 05:17:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=F+g2L5ib;
 spf=pass (domain: gmail.com, ip: 209.85.222.44,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f44.google.com with SMTP id v3so38292551uam.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 05:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nniw0WokTN7ahPrlF0fTxfZDDyj1VT1N9Z8tAeQ91x8=;
        b=F+g2L5ib6zl3ZfuNz/Fjl0JqBU3TOEqEXjgLPkdkvNNZYS5KyZUULPbvZAk5b88StI
         vLEiImB637kkpYwrTMqynEHDUNkHvw5p4pm6zLW0QHKDCPPB6uCeVzCGeuaQAskpmjtL
         eYtRSXd9pWiFSjh35OahD07RlixFK+eDqa5MBvWZUmbUrgAlIKzB+5hkiNlq8gHwzzZr
         H+U2J5szXvbB1PLU6iUBmHjtp2cG9brZOb1jN1J7q0YLnp6lebqW5N8AsKYk25V/Qt0J
         zh/K9G2spfwsKCdWhws98df3+moFWvLuxgF4OQk/3qrQ+osynlPPe4j3orUvKmaPWgN9
         O/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nniw0WokTN7ahPrlF0fTxfZDDyj1VT1N9Z8tAeQ91x8=;
        b=2pUxVWXgYD7oMFdPwOne6ubS8Tvw8gqQmnwXFekjDemTot1GsnqNtUWmKz6oao3R2D
         Bbi7WYu9rdn7Gv7T9mf0HRcp16xYokyhAw0LfiYb843D6krO9T/jjbZbyYb/5qqWKUzf
         rKvI/cPJG1u9SJDgZyBZATaeV0KMM90YPQoB3FMfZGfgXU9Qkc7lsttm237ErIpDtHPh
         HSBYhMZ0VH4/juzCQ5otyiT/DEYv7GfY6wsANnUnT45Ysa0myz2lm60+oc5p5YuguyJy
         TvTe2w7l1Yf3D9CZlVHiQ4qs1s1Zq0Uz8ykBVYOGSEv6vjgBhZf/vbzIJNPOsr+inHsi
         iULA==
X-Gm-Message-State: AOAM533//QfcEpfrI+PWYzFP4xzLcMbxa2nSXOPQGxKRhMK1QzErwOLu
	gSbj4qyNo+PkqTiUkpRQ6md1DtouN/ToBfkwpIE=
X-Google-Smtp-Source: 
 ABdhPJxq9nT00VTepSCgcvVriypKnrDWbogVpaeqh680AWgDhRhPfLBd7ZJxsoy935hsczkDPgJefL0J4RaCLYuXxNE=
X-Received: by 2002:a9f:2c98:: with SMTP id w24mr10046729uaj.89.1636463853213;
 Tue, 09 Nov 2021 05:17:33 -0800 (PST)
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
 <e5b2f8439e5aab93a2841728e00650185ff60573.camel@linuxfoundation.org>
 <16B5E0648E5826A2.410@lists.openembedded.org>
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
 <CAD=4a=VtVpxjFUUB-0KPePw-Js5vctqDEYZitM8H4vgaE1TNCA@mail.gmail.com>
In-Reply-To: 
 <CAD=4a=VtVpxjFUUB-0KPePw-Js5vctqDEYZitM8H4vgaE1TNCA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Nov 2021 14:17:22 +0100
Message-ID: 
 <CANNYZj8P8qdgBZy_okH8ENpfumpj4=rNUZ4Ey2xFOLzSM5QcvQ@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Cc: Marius Kriegerowski <marius.kriegerowski@gmail.com>, Mikko.Rapeli@bmw.de,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000a89bbc05d05aeec7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 13:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12972

--000000000000a89bbc05d05aeec7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have to note that being forced to use outlook/exchange at work is not, in
itself, a reason to abandon or dislike email based contribution process.

Alex

On Tue 9. Nov 2021 at 13.57, Ernst Sj=C3=B6strand <ernstp@gmail.com> wrote:

> Hi,
>
> jumping into the thread a bit randomly.
>
> I work with Yocto at $DAYJOB and the use of a mailing list for patches ha=
s
> really hindered me from contributing, with Outlook and DMARC etc.
> I'd much prefer something like Gitlab! When the Mesa project switched to
> Gitlab I set up an email subscription for all new merge requests
> which emulated the old feed of emails pretty well IMHO.
>
> For the code review I've always preferred Gerrit for it's powerful system
> of patchsets and ability to review the commit messages very clearly.
>
> Regards
> //Ernst
>

--000000000000a89bbc05d05aeec7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I have to note that being forced to use outlook/exchange =
at work is not, in itself, a reason to abandon or dislike email based contr=
ibution process.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</d=
iv><div dir=3D"auto"><br></div><div><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Tue 9. Nov 2021 at 13.57, Ernst Sj=C3=B6strand=
 &lt;<a href=3D"mailto:ernstp@gmail.com">ernstp@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)"><div dir=3D"ltr"><div style=3D"font-family:arial,he=
lvetica,sans-serif" class=3D"gmail_default">Hi,</div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif" class=3D"gmail_default"><br></div><div styl=
e=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail_default">jumpin=
g into the thread a bit randomly.<br></div><div style=3D"font-family:arial,=
helvetica,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-=
family:arial,helvetica,sans-serif" class=3D"gmail_default">I work with Yoct=
o at $DAYJOB and the use of a mailing list for patches has really hindered =
me from contributing, with Outlook and DMARC etc.</div><div style=3D"font-f=
amily:arial,helvetica,sans-serif" class=3D"gmail_default">I&#39;d much pref=
er something like Gitlab! When the Mesa project switched to Gitlab I set up=
 an email subscription for all new merge requests</div><div style=3D"font-f=
amily:arial,helvetica,sans-serif" class=3D"gmail_default">which emulated th=
e old feed of emails pretty well IMHO.</div><div style=3D"font-family:arial=
,helvetica,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font=
-family:arial,helvetica,sans-serif" class=3D"gmail_default">For the code re=
view I&#39;ve always preferred Gerrit for it&#39;s powerful system of patch=
sets and ability to review the commit messages very clearly.</div><div styl=
e=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail_default"><br></=
div><div style=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail_de=
fault">Regards</div></div><div dir=3D"ltr"><div style=3D"font-family:arial,=
helvetica,sans-serif" class=3D"gmail_default">//Ernst<br></div></div>
</blockquote></div></div>

--000000000000a89bbc05d05aeec7--

