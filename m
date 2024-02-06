Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E151CC4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 16:31:17 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.25780.1707237076288428309
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Feb 2024 08:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=R6NQkfCA;
 spf=pass (domain: snapchat.com, ip: 209.85.218.45, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a383016f428so87193966b.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Feb 2024 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1707237075; x=1707841875; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf40gq0yEgsOu5skpIZ+Wz3t+ah5AeX23qvZBaJyuRw=;
        b=R6NQkfCALXyKHyhb2YIq09WKdrrWNDX5MKX/biDy/aSUkTfnPA1ouI/Rhk+8siAEqg
         BKRcDClKoCbOJePGuuan+Su9PnzE+jDupPVG4BjTgL5UEnLfz63kFZ99n/c1Lnv9dguk
         YMsiXtLhm1s4D2G7wyIO4XMcg2VUQTKbTVUPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237075; x=1707841875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf40gq0yEgsOu5skpIZ+Wz3t+ah5AeX23qvZBaJyuRw=;
        b=Xyc7XEDH9HbDDcpscE9gWO1q/MOxUU+YiGhLU2PSVbYTLgT7Z0GLXVWIGq/ncRqaGu
         +wjAs3jNSTIqOntFWZ108yBTm+aTw0MKTXdkontJysQzFwrBtQpkoJE6d0xYEu4F6nOL
         I55GKH/26RvwqphEKPsniRtTkkr1Yzt4Vn6CgY8xB0Gz4uuzggQEOZn5EDDmxEMO6frT
         RFaDb4fWJQIqeT3WVGf8qGSyejWf9oFdvAahINtiygc+aT+UaQZTpKRAxIn6M/xwzeA+
         7KyBeeb/eJkm2oi65D/8aji4nlZTU8idjsVuP0N3acHeRz93GuWZYGYVCtTXLwHxbQKr
         9yGg==
X-Gm-Message-State: AOJu0YwgBJlLcuZ1k2pZx/JOByvotMF1SxGOiizLIWd6igABMK34o4Me
	rq6rc7v8NxUX9IJZeVxovoyM/puQBpOy+vO6qgsnfGhkkXtIzlqPLrkjHGNJuOAil2+6n8Ixhvp
	khXs0xKZyKO9aRND7LROaZjOLoQBBl2c1dYRCJQ==
X-Google-Smtp-Source: AGHT+IF9TRWQQUxizxdYS3xLtq5hAha2A9nWNYGk6/EaHkF7bpzIQal1uOG+1rkWcl0Skii9sbfKEqZ+C/FsHD3CGpo=
X-Received: by 2002:a17:906:e209:b0:a37:2c28:d5da with SMTP id
 gf9-20020a170906e20900b00a372c28d5damr2194384ejb.9.1707237074675; Tue, 06 Feb
 2024 08:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20240206121528.2581233-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYbjs=_ijo2Jy5a1JCx5jrSJB5Ucoza99yBL2ya+qvwpRg@mail.gmail.com> <dfe902c9baab3bdc38bb7afae1455565ab8c0117.camel@linuxfoundation.org>
In-Reply-To: <dfe902c9baab3bdc38bb7afae1455565ab8c0117.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 6 Feb 2024 17:31:03 +0100
Message-ID: <CAHUKmYY1fMCiNq36MzoeuQ5EKQYm_ZAEkkDuRUTeg94a+ZnubQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb: Drop BBFILE_PRIORITY support
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000062e1190610b91ba2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Feb 2024 16:31:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15832

--00000000000062e1190610b91ba2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is the BBFILE_PRIORITY not controlling the order in which bbappends from
different layers gets applied? I thought it was important e.g. when
applying kernel configuration files (the last one to be applied override
the previous ones).

On Tue, Feb 6, 2024 at 4:56=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2024-02-06 at 16:26 +0100, Etienne Cordonnier wrote:
> > Hi Richard, there is a word missing in the commit message:
> > " The functionality had a and place" -> "the functionality had a time
> and place"
> > Also a typo: "comparibility" -> " compatibility "
>
> Thanks, I'll tweak those on the branch.
>
> > What is the correct way to set layer priorities after this patch (I'm
> > asking because the BSP I'm using makes use of BBFILE_PRIORITY)?
>
> It may set it, but what is it trying to achieve by setting it?
>
> As far as I know, the potential issue is needing to set specific
> PREFERRED_VERSION entries where older recipes need to be used.
>
> Cheers,
>
> Richard
>

--00000000000062e1190610b91ba2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is the BBFILE_PRIORITY not controlling the order in which =
bbappends from different layers gets applied? I thought it was important e.=
g. when applying kernel configuration files (the last one to be applied ove=
rride the previous ones).<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Feb 6, 2024 at 4:56=E2=80=AFPM Richar=
d Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.=
purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Tue, 2024-02-06 at 16:26 +0100, Etienne Cordon=
nier wrote:<br>
&gt; Hi Richard, there is a word missing in the commit message:<br>
&gt; &quot;=C2=A0The functionality had a and place&quot; -&gt; &quot;the fu=
nctionality had a time and place&quot;<br>
&gt; Also a typo: &quot;comparibility&quot; -&gt; &quot;=C2=A0compatibility=
=C2=A0&quot;<br>
<br>
Thanks, I&#39;ll tweak those on the branch.<br>
<br>
&gt; What is the correct way to set layer priorities after this patch (I&#3=
9;m=C2=A0<br>
&gt; asking because the BSP I&#39;m using makes use of BBFILE_PRIORITY)?<br=
>
<br>
It may set it, but what is it trying to achieve by setting it?<br>
<br>
As far as I know, the potential issue is needing to set specific<br>
PREFERRED_VERSION entries where older recipes need to be used.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--00000000000062e1190610b91ba2--

