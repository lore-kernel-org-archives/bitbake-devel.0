Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A748D65530
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:15:45 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11098.1765966537907304112
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Dec 2025 02:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Fm4RBL7f;
 spf=pass (domain: smile.fr, ip: 209.85.218.48, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b713c7096f9so927506066b.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 02:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765966536; x=1766571336; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7sht0x3JduNvm3b9x0fkKEzZ4FnEJuFNgq+dzsbM1LI=;
        b=Fm4RBL7fA8pAftkKhEEjoVeS0Zltw/TxdTYjgTUjbfq0sO1Njk+8CkMWCIXs09cEEe
         +nWOKE0ulfxjJll6dU3oCpOMEGDmmOe0R38TmGLFRuzZlPTkiYF3ab6hnqghqJ6vQdRb
         ly5ZvGwBIRy3ypltqnYB9PmtwSNt78UTGlEgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966536; x=1766571336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sht0x3JduNvm3b9x0fkKEzZ4FnEJuFNgq+dzsbM1LI=;
        b=xRhTt1P3/T+X7XfFmQg+lneFePnmAbNgeMYWIzkZHgpcZvRgpQvubv8F8YZ2rUa+Mo
         okeZHBithcXdDuFW16kgqovoa+bGFs/S5nAyLRMzWzsjWJCmR6TuJ+eRRvWKvfez/yBC
         RejecxjOKtnhIIz2F2Rp+XKov9L7t1bTvjsjPptbGN68vREkrsQHDOV60YKQc9MgDQVj
         v3FkEQMdovMIroiqNXX1sDfMSR/13T3KYaRDsd7F/26ikiI7Em7T8w3MzlaGITTT1z85
         aERad/0NR3ex9ftjGlK+wbabhwdKghrQgLQYsecIJOvmj05FrynZuXqVUkV0uoWvvHKr
         u/FA==
X-Gm-Message-State: AOJu0Yy/YN98mR+XvmhAubt1JioffruqNnj8VCaxv0ed77ZKV0f8yMXx
	ACubZ7htMwVciwZYWF+mSY00dlPTzPXqVELoDMQTp1Eccc+YzXd02k0tfnyGM51Tj8yVYfryJTv
	lOS67yGrO8Lu/IL6PHoTVuJyXa1ac9URDCTmTZKPm+g==
X-Gm-Gg: AY/fxX7J8sl8qWaBUUT+75iIeV0WO1Cg6y5zYNjSZjiT5Wfl/+dnGdBMOGdwlWwztRX
	BnLffWxPS3aNrnYidDiE6ruIpdqg7lkDjevRofHBkyxg06go+ccstO2fN5lPfqv2Vezrs7273pw
	Z++CxJe9hw/WOijw0LBoW3SNOCqN4mOuMElhQTyKQ+KOj7CysjqTfuoKhfdyRtsXf72GFRue7Ab
	++BAqCzmCypDO53skX0KwEZboiQ7FRSiu+HG4xS5Oi7cwxiL+NHwT7cQuW45eCPQNDnVeoSi9lp
	O7Xmlr4iStoXfwApycgI72Q+bw==
X-Google-Smtp-Source: AGHT+IE0QUaApC2rbtp+gtxodfJdDomyFxfKt2ZqqGXDpWIt95J0rTooj8I9tzf1GHCs+YA8N94eQiKQIjHsSElliLA=
X-Received: by 2002:a17:906:7956:b0:b76:ece6:2ca1 with SMTP id
 a640c23a62f3a-b7d23a9c7ffmr1954361366b.57.1765966536091; Wed, 17 Dec 2025
 02:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20251215103256.902711-1-corentin.guillevic@smile.fr>
 <CANNYZj_4XFj2Sgv1Q4_=BwDBCAtCpj5X=XfQ2=CuiJjoqOrA4w@mail.gmail.com>
 <CAMFqQmq8G-JLzZ6zfkrXThSnCYQq16jjLY0spUhOrHv+=xA0DQ@mail.gmail.com> <CANNYZj8yH_5zB7rR=Xu-gb5B7XJe65yaeW9m4E23zz9f1vBegg@mail.gmail.com>
In-Reply-To: <CANNYZj8yH_5zB7rR=Xu-gb5B7XJe65yaeW9m4E23zz9f1vBegg@mail.gmail.com>
From: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Date: Wed, 17 Dec 2025 11:15:25 +0100
X-Gm-Features: AQt7F2qZUiL1kXXh_JLa_SxI_Z_hA3U8Mq1XuFo6uv6T6WGnac7Pz5M8asyqpFs
Message-ID: <CAMFqQmrBJEwNPGN9zFGiW1+qgFJqRAFK5eqVr7ThWLZ9U=00Uw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/3] bitbake-setup: add inline URI
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000011be39064623206e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 10:15:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18606

--00000000000011be39064623206e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> It isn't entirely clear how to map multiple remotes (when specified in
> json) into bb-setup's behavior, but I think the current behavior at
> least makes sure they're all cloned into DL_DIR, so DL_DIR has a local
> copy for all of them.
Yes I confirm that all URIs are cloned into DL_DIR. Currently, this is the
last treated URI that will always be used in the final layer, as every git
unpack prunes any previous destination directory.

Corentin

Le mar. 16 d=C3=A9c. 2025 =C3=A0 20:18, Alexander Kanavin <alex.kanavin@gma=
il.com> a
=C3=A9crit :

> On Tue, 16 Dec 2025 at 17:11, Corentin GUILLEVIC
> <corentin.guillevic@smile.fr> wrote:
> > However, what is it expected of the registered remote(s) once the sourc=
e
> has been cloned? When using several remotes for one source, I discovered
> that they are all cloned but only one is registered in the final layer (i=
n
> the layers/ directory). For example, we can add another remote to the
> bitbake layer in the 'oe-nodistro-master' configuration, but this results
> in only one remote in bitbake-builds/oe-nodistro-master/layers/bitbake/.
>
> Hello Corentin,
>
> bitbake-setup is using bitbake's git fetcher to perform fetch/unpack:
>
>         fetcher =3D bb.fetch.Fetch([src_uri], d)
>         fetcher.download()
>         fetcher.unpack(dir)
>
>  and I think that doesn't have support for multiple remotes that
> unpack into the same directory.
>
> It isn't entirely clear how to map multiple remotes (when specified in
> json) into bb-setup's behavior, but I think the current behavior at
> least makes sure they're all cloned into DL_DIR, so DL_DIR has a local
> copy for all of them. We could probably add some after-the fact 'git
> remote add <some-remote> ...' operation to the directory that gets
> unpacked by the fetcher, but that's a separate issue, and probably a
> fairly marginal use case. I have a hunch almost everyone will put just
> one remote per source into the json config.
>
> Alex
>

--00000000000011be39064623206e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;=C2=A0It isn&#39;t entirely clear how to map multiple =
remotes (when specified in<br>&gt; json) into bb-setup&#39;s behavior, but =
I think the current behavior at<br>&gt; least makes sure they&#39;re all cl=
oned into DL_DIR, so DL_DIR has a local<br><div>&gt; copy for all of them.<=
/div><div>Yes I confirm that all URIs are cloned into DL_DIR. Currently, th=
is is the last treated URI that will=C2=A0always=C2=A0be used=C2=A0in the f=
inal layer, as every git unpack prunes any previous destination directory.<=
/div><div><br></div><div>Corentin</div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 1=
6 d=C3=A9c. 2025 =C3=A0=C2=A020:18, Alexander Kanavin &lt;<a href=3D"mailto=
:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 16 Dec =
2025 at 17:11, Corentin GUILLEVIC<br>
&lt;<a href=3D"mailto:corentin.guillevic@smile.fr" target=3D"_blank">corent=
in.guillevic@smile.fr</a>&gt; wrote:<br>
&gt; However, what is it expected of the registered remote(s) once the sour=
ce has been cloned? When using several remotes for one source, I discovered=
 that they are all cloned but only one is registered in the final layer (in=
 the layers/ directory). For example, we can add another remote to the bitb=
ake layer in the &#39;oe-nodistro-master&#39; configuration, but this resul=
ts in only one remote in bitbake-builds/oe-nodistro-master/layers/bitbake/.=
<br>
<br>
Hello Corentin,<br>
<br>
bitbake-setup is using bitbake&#39;s git fetcher to perform fetch/unpack:<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([src_uri], d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.unpack(dir)<br>
<br>
=C2=A0and I think that doesn&#39;t have support for multiple remotes that<b=
r>
unpack into the same directory.<br>
<br>
It isn&#39;t entirely clear how to map multiple remotes (when specified in<=
br>
json) into bb-setup&#39;s behavior, but I think the current behavior at<br>
least makes sure they&#39;re all cloned into DL_DIR, so DL_DIR has a local<=
br>
copy for all of them. We could probably add some after-the fact &#39;git<br=
>
remote add &lt;some-remote&gt; ...&#39; operation to the directory that get=
s<br>
unpacked by the fetcher, but that&#39;s a separate issue, and probably a<br=
>
fairly marginal use case. I have a hunch almost everyone will put just<br>
one remote per source into the json config.<br>
<br>
Alex<br>
</blockquote></div>

--00000000000011be39064623206e--

