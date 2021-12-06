Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5BC433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 17:02:16 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by mx.groups.io with SMTP id smtpd.web11.54507.1638810134836430227
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 09:02:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=WSfL7HDN;
 spf=pass (domain: gmail.com, ip: 209.85.222.49,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f49.google.com with SMTP id 30so2340439uag.13
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 09:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udWQz3d+zg0oyvrYrmVT7m4MBtdcM2kRVionD3zkRKA=;
        b=WSfL7HDNjEcqZxRjmNMFFo+gVoOMnBjjDl3FJ1jHNmqW5JaIiRuJhNy/R4sQTUmvGb
         MyfQ4TQzGc0Pmk/6L9Q2Ey6Pi4CIJ54h4eXWOEJRsC8RYhniARQMXgV1jo7Ov1Rbtc0v
         U+ABGUZ1AtmweveVDgbLXNmIYC3hy1puPTceSFm0dX3FrbAj38c/fbeZAVm2gNJSl4pT
         M7cZfOQ+vHDnzwsF+zEpfZG6Omax09g9MUbuoL4+ualeFPEjnOztGKOjtpkHiwK+RmJz
         +ZQkMuJiJvtV3V1IhJKrbXMZYf2n2kxkz0dp0EAy8/k51/RHpvutP6OnTCEu6JA/csJS
         3EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udWQz3d+zg0oyvrYrmVT7m4MBtdcM2kRVionD3zkRKA=;
        b=2p0ODw0A2J0Hw5d/jjXfp+KW+RIov5S3DNRFlD5ouh+vvuL6sDD/+iim2ofNyD7h/Q
         XxyddRe+AxtaVzIfdrBqtZDZicC6nG2JCsJl4kCg8UjnOaIwCYyM+CAUkccCLLE0i1QE
         7wrwlTdw1SfnooAAEfefq4TSG/E8v4p+hZOIWcg2M8T57SJn+DjhFS8oBFvk1I63Umvw
         BhaGI0kJ0fU7mgzyHZGDS8lHJ6/HLATwLCEtuqSG2OIdeDTK4NNAB+cNdra14kpOnVLW
         uwtXnVtyl4zDLOZjRVNt/h+rEQQbyq0yELXmrLNn3Pgnd469CeHL1qzqG2ohJxYgWL5Q
         Onvg==
X-Gm-Message-State: AOAM531l17j8OVUfbTdhRiPHGPIiJSdbt3+hha1pf/X4lBjYxMHeMCa9
	56nNcjkawi6BYLvcHQemCya9B52xOLGZKwSTfps=
X-Google-Smtp-Source: 
 ABdhPJxEXP6boXHOzLBl9fPvgICGqxI5LmorpqCpxz7ICawLH2/1CQ51ygyvp+NxArqL3SN31aLP79yiX+Mpf851LNw=
X-Received: by 2002:ab0:55ce:: with SMTP id w14mr41281624uaa.93.1638810133845;
 Mon, 06 Dec 2021 09:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20211206164119.4076119-1-alex@linutronix.de>
 <AM9PR09MB46420E6720273B75BE7A8E7BA86D9@AM9PR09MB4642.eurprd09.prod.outlook.com>
In-Reply-To: 
 <AM9PR09MB46420E6720273B75BE7A8E7BA86D9@AM9PR09MB4642.eurprd09.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 6 Dec 2021 18:02:02 +0100
Message-ID: 
 <CANNYZj-ni2jXwQXWH0NRZ6RV+db9dSPXraCjofrxj80ijuTkww@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: do not hardcode tarball
 compressors in version check
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000e1dc9505d27d37ef"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Dec 2021 17:02:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13135

--000000000000e1dc9505d27d37ef
Content-Type: text/plain; charset="UTF-8"

I'd hope that those always come in tandem with the actual tarballs, if that
proves to be not the case, we can tweak things further.

Alex

On Mon, 6 Dec 2021 at 17:50, Konrad Weihmann <kweihmann@outlook.com> wrote:

>
>
> On 06.12.21 17:41, Alexander Kanavin wrote:
> > Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> > ---
> >   bitbake/lib/bb/fetch2/wget.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/fetch2/wget.py
> b/bitbake/lib/bb/fetch2/wget.py
> > index fd9b304961..3021ef359e 100644
> > --- a/bitbake/lib/bb/fetch2/wget.py
> > +++ b/bitbake/lib/bb/fetch2/wget.py
> > @@ -583,7 +583,7 @@ class Wget(FetchMethod):
> >
> >           # src.rpm extension was added only for rpm package. Can be
> removed if the rpm
> >           # packaged will always be considered as having to be manually
> upgraded
> > -        psuffix_regex =
> r"(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
> > +        psuffix_regex =
> r"(tar\.\w+|tgz|zip|xz|rpm|bz2|orig\.tar\.\w+|src\.tar\.\w+|src\.tgz|svnr\d+\.tar\.\w+|stable\.tar\.\w+|src\.rpm)"
>
> I've seen tar.gz.md5, tar.gz.sig, tar.siz or even tar.sum files on a
> bunch of server - unfortunately those would now be considered as well.
> Not sure if that causes any negative effect on the actual version
> parsing...
>
> >
> >           # match name, version and archive type of a package
> >           package_regex_comp =
> re.compile(r"(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
> >
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#13133):
> https://lists.openembedded.org/g/bitbake-devel/message/13133
> > Mute This Topic: https://lists.openembedded.org/mt/87544042/3647476
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> kweihmann@outlook.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
>

--000000000000e1dc9505d27d37ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;d hope that those always come in tandem with th=
e actual tarballs, if that proves to be not the case, we can tweak things f=
urther.<br></div><div><br></div><div>Alex<br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 6 Dec 2021 at 17=
:50, Konrad Weihmann &lt;<a href=3D"mailto:kweihmann@outlook.com">kweihmann=
@outlook.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
<br>
On 06.12.21 17:41, Alexander Kanavin wrote:<br>
&gt; Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix=
.de" target=3D"_blank">alex@linutronix.de</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bitbake/lib/bb/fetch2/wget.py | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wge=
t.py<br>
&gt; index fd9b304961..3021ef359e 100644<br>
&gt; --- a/bitbake/lib/bb/fetch2/wget.py<br>
&gt; +++ b/bitbake/lib/bb/fetch2/wget.py<br>
&gt; @@ -583,7 +583,7 @@ class Wget(FetchMethod):<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# src.rpm extension was added =
only for rpm package. Can be removed if the rpm<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# packaged will always be cons=
idered as having to be manually upgraded<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 psuffix_regex =3D r&quot;(tar\.gz|tgz|tar=
\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|sv=
nr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 psuffix_regex =3D r&quot;(tar\.\w+|tgz|zi=
p|xz|rpm|bz2|orig\.tar\.\w+|src\.tar\.\w+|src\.tgz|svnr\d+\.tar\.\w+|stable=
\.tar\.\w+|src\.rpm)&quot;<br>
<br>
I&#39;ve seen tar.gz.md5, tar.gz.sig, tar.siz or even tar.sum files on a <b=
r>
bunch of server - unfortunately those would now be considered as well. <br>
Not sure if that causes any negative effect on the actual version <br>
parsing...<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# match name, version and arch=
ive type of a package<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0package_regex_comp =3D re.comp=
ile(r&quot;(?P&lt;name&gt;%s?\.?v?)(?P&lt;pver&gt;%s)(?P&lt;arch&gt;%s)?[\.=
-](?P&lt;type&gt;%s$)&quot;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#13133): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/13133" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/13133</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/87544042=
/3647476" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.o=
rg/mt/87544042/3647476</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:kweihmann@outlook.com" target=
=3D"_blank">kweihmann@outlook.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
</blockquote></div>

--000000000000e1dc9505d27d37ef--

