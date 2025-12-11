Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805EBD41C10
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 09:04:21 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5202.1765443527845682340
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 00:58:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BcG2Kazz;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: swami310@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eda26a04bfso7699991cf.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765443527; x=1766048327; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8UzVxbREB0wkpmBvKj/ZzzH4h3N/Z40JgBKAmvKvuC4=;
        b=BcG2KazzFfhJDhTVtTtyZW5v9FGAcsZ9fGipzgG947ECnYiWrcH0nfQRec2/wE121d
         t0KUp2YWY0gUOToYET3uBfTOLOZIH2Zn9Bme4fKMT6q0w1gfuxQKwdmBkQAID0ejAYvH
         mcRFqHJyfMlwedZmdiTPuzie67LRidpkmoOy74s13HDLePnEnf+sfSS3sJXdUkxsm0s0
         G8Qazdt3SbhEmK+UQbNtA2/4GFBfkKuIbwlnFsR45xUmIk7Ui5nyEek+vwR2kHbWvgzF
         gud3ygjGCPH8bKou67vWTsGe10x5a5py5S0JgJ3KtTOZH8H46jqINOR/vy10U8Zew3A3
         H7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765443527; x=1766048327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UzVxbREB0wkpmBvKj/ZzzH4h3N/Z40JgBKAmvKvuC4=;
        b=FOxoulgSpqZOuIFsf5iQKYt++z86pzNancCHL0M0rHJPMBDv+7oNSpUG1mKasXleyK
         N/CTaG4i7zZFCOiS/T8oJdrhJ8zyD+e39GbqS8lAASNT+5yXygied++3234FvtLR7D4/
         De9PoEMp+Yzmygveg6j22WFcMd3xCsZDQohWc70PrSt5S0QF8WUGLZG0aYrtGPI5vG6v
         3D0UFBrvaNbad0e41XfBwlH29ag9kxOQfFW0epGJSlvM1fk8Ehw64m6IEQJao5Dev2hD
         yMEdeRzMD1HQzj/7kHspF5C0S/Q/RKkjmLIWV5Z1LxBXy9JHnP/99qCNSHpyRXK1BLbF
         Qtwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBCYOYAUY924so5ZdkCCBmWHl/Q0B2MREXDJVqXrCWNoj51w+YYzjYIcZGz44Um0/cpTRfJdGVItKR7ZlJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YwuR4+9YSnVSgnA0FjqeG5M4KRVzB3u1jNdWINZJK7V+PYp2y/C
	qacx+nTUJGrZM7tejpRhrWmP9q277tP6INu8EOShhe2iaA7wyr/2+WtjfQB2yYVbzx5869puxi9
	7rEZ2H2Q7zA6nfUw2Dz0oPOKj55Vo5IA=
X-Gm-Gg: AY/fxX6zS+TFj8/WGcVQAdxToWh+PPaVy0mv7osFs85TUEI2QVK7se1zzPdm5wj6wcr
	S90QyTq9A8YveYZwoARsPA7fU5d+Nq97qKV/AQtGakLFlIXVg+wklxrRyxB7iAFNA8+DC62SEZ6
	95NPil8nRELePoDX6Abqc9ad1H0ImgVvPhczAOpwvDLZa8UEmewopaHpfifAle6svaL9D/Gsnky
	cHnwchAzLlE+EN8RVnC/9FmUja0hMTf81zJcWkJkiSUt9SuN6vEvg5n/XQiu0D15p36VYW3KJ72
	sOze1A==
X-Google-Smtp-Source: AGHT+IFz5MeKz41V7jx9Hc59Mtu6Zmjix+JsyXUY4B7mGV0N1qZJvEyoXf4Wdxa6SBaxg59AnaddKmFPPMIASV/MQRg=
X-Received: by 2002:a05:622a:549:b0:4f1:adf6:5b77 with SMTP id
 d75a77b69052e-4f1b1b49973mr67532101cf.59.1765443526532; Thu, 11 Dec 2025
 00:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20251205234033.6363-1-swami310@gmail.com> <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
 <CAMSfU+5enXOdO03=d2Nfx6infFOoema2Y7xQG9VErNN1DgbE9A@mail.gmail.com> <CANNYZj_a=DgXvyRRr8igP6HLee819-DKfjTnWd8WHu9Fs5Wv9A@mail.gmail.com>
In-Reply-To: <CANNYZj_a=DgXvyRRr8igP6HLee819-DKfjTnWd8WHu9Fs5Wv9A@mail.gmail.com>
From: "Swami" <swami310@gmail.com>
Date: Thu, 11 Dec 2025 14:28:35 +0530
X-Gm-Features: AQt7F2qneIWlxBouHYaxp5eCTUwtq993s8hE-QcTawQplkMqb8g5-BWv71B-hXI
Message-ID: <CA+-_CqnfAQu_-h=smym8CayOxCdh1PHa7dOhvMnq6axerYWO_Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v7] bitbake-user-manual: Document BB_CMDLINE
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org, michael.opdenacker@rootcommit.com
Content-Type: multipart/alternative; boundary="0000000000004523470645a95af8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 09:04:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18566

--0000000000004523470645a95af8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for the clarifications. This has been one huge learning
journey for me.
I will start working on the next bug :)

regards
Swami

On Thu, Dec 11, 2025 at 2:21=E2=80=AFPM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Thu, 11 Dec 2025 at 08:50, Yoann Congal via lists.openembedded.org
> <yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
> > > I have not heard anything after I submitted Patch V7. Is it accepted
> ?  How can I know the latest status ?
> > > Please help me understand.
> >
> > Your patch is in the master-next branch :
> > https://git.openembedded.org/bitbake/log/?h=3Dmaster-next
> >
> > Which means it has been selected for review and tests. Once those
> > happen you will either receive a review by mail or see your patch get
> > merged on master.
> > Merges usually happen after the patch review calls (which are on
> > monday and thursday :
> > https://www.yoctoproject.org/community/get-involved/).
> > Ping back if nothing happens in a week or so.
>
> While the process description is correct, all of this has already
> happened, and the patch landed in master some days ago. Which can be
> seen in the link above! It's just that master and master-next are the
> same at the moment.
>
> There are no separate notifications for when patches are accepted, you
> just need to check the upstream branches, either get the latest
> commits with git locally, or look at the commit log in a browser.
>
> Alex
>

--0000000000004523470645a95af8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks a lot for the clarifications. This has been on=
e huge learning journey for me.</div><div>I will start working on the next =
bug :)</div><div><br></div><div>regards</div><div>Swami</div></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Thu, Dec 11, 2025 at 2:21=E2=80=AFPM Alexander Kanavin &lt;<a hr=
ef=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 11 Dec 2=
025 at 08:50, Yoann Congal via <a href=3D"http://lists.openembedded.org" re=
l=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a><br>
&lt;yoann.congal=3D<a href=3D"mailto:smile.fr@lists.openembedded.org" targe=
t=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
&gt; &gt; I have not heard anything after I submitted Patch V7. Is it accep=
ted ?=C2=A0 How can I know the latest status ?<br>
&gt; &gt; Please help me understand.<br>
&gt;<br>
&gt; Your patch is in the master-next branch :<br>
&gt; <a href=3D"https://git.openembedded.org/bitbake/log/?h=3Dmaster-next" =
rel=3D"noreferrer" target=3D"_blank">https://git.openembedded.org/bitbake/l=
og/?h=3Dmaster-next</a><br>
&gt;<br>
&gt; Which means it has been selected for review and tests. Once those<br>
&gt; happen you will either receive a review by mail or see your patch get<=
br>
&gt; merged on master.<br>
&gt; Merges usually happen after the patch review calls (which are on<br>
&gt; monday and thursday :<br>
&gt; <a href=3D"https://www.yoctoproject.org/community/get-involved/" rel=
=3D"noreferrer" target=3D"_blank">https://www.yoctoproject.org/community/ge=
t-involved/</a>).<br>
&gt; Ping back if nothing happens in a week or so.<br>
<br>
While the process description is correct, all of this has already<br>
happened, and the patch landed in master some days ago. Which can be<br>
seen in the link above! It&#39;s just that master and master-next are the<b=
r>
same at the moment.<br>
<br>
There are no separate notifications for when patches are accepted, you<br>
just need to check the upstream branches, either get the latest<br>
commits with git locally, or look at the commit log in a browser.<br>
<br>
Alex<br>
</blockquote></div>

--0000000000004523470645a95af8--

