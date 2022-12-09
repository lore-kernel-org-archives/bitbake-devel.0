Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FEDC4332F
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 14:46:54 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.3057.1670597212610606676
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Dec 2022 06:46:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Q6s+sBiD;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 1so7371468lfz.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HxyRgrZUWpppAqrw8w6SoRUqJKRbq3QaWYVW8ij9pU=;
        b=Q6s+sBiDpCvTLLx25NrMbeJU+un/z0vWMOADkrunCwZP3xjmwbq7dg32mif2Sd5JkQ
         SHInoJHctu/8BHykRKv7407UnJd5QH9QqDJvM2/4m0n8d29OG0YrVz3JpsJn/7mfZlK5
         vWQnXgGmoiD4iHdr7m7TSqwD22K8qSbxkN1dpBhBMfL68PeloNU3rtJKsiq4fVPY+/dI
         HApgkjBhxk/RhCZcTYpIfZd2EVkX0PkMfs7uOYeJ4pbUj4IwSGCvKS8KrJLaU91TcS21
         sXUlQyntYQCFb30IPYpKFrbNz+rPHVm5mEbEjRu4r6ocMN067QrB1w8Ss0YRE62zgaYe
         VRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HxyRgrZUWpppAqrw8w6SoRUqJKRbq3QaWYVW8ij9pU=;
        b=3Rvj68n/DrjNk9qS2dhbjT7R3UzT2QkkzsoAPr7S924Znu2TOQNxyFQRWEtnIXNH8M
         +1x4CBN8j3Wf1cHUOsmLsoRjnELQhx106YXos9CU9cejrco+U5NsiDX0LXLWQvygbSG2
         lSIFLF7kIw7z2XClkSbjo4f9txPg8AgOqfLrXoCe7LMn4nprTiFB9erKHNz6bSu4DIyz
         /oQobF8cHTyKSixGo+k5RbGP1N1kVwOiMMk8SFG+EUzSbm20FrjPtMfyuIaK7feELISO
         ROTvirHLZsaWues2bE0gXcuzjkhn8hgNNvQggTXoVM1yDoHnEDRcU36OvUe1GK7onD8j
         5tWg==
X-Gm-Message-State: ANoB5pmqEYX0bGJ2sH5HqryZIHfxmKrlmV3pMpMAZJ8ell71vO6o/HZs
	SCovbK8m4Fjo089sTZ0U9+PPM4qK/PeqhYT608jWaTcl
X-Google-Smtp-Source: AA0mqf6E6pEGXrQj49H51r/Xp336DnP8yVm7CT8dkSbeegONKgK4DIDitdfviTLZfSYIvHlwitnM9htFQar26YhwmI8=
X-Received: by 2002:a05:6512:259f:b0:4b5:a6ba:b1e4 with SMTP id
 bf31-20020a056512259f00b004b5a6bab1e4mr783669lfb.393.1670597210619; Fri, 09
 Dec 2022 06:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20221209085840.3733809-1-alex@linutronix.de> <Y5NJPlVxNR7kQsG1@mail.local>
In-Reply-To: <Y5NJPlVxNR7kQsG1@mail.local>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Dec 2022 15:46:39 +0100
Message-ID: <CANNYZj_WLrfAUWjDu1Bqd+MTc+JO9p7YMH0qaQMFpe212Bx=0A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/wget.py: correctly match
 versioned directories
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 14:46:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14163

That is not a failure. It tries ipv6 first, then ipv4 - the former
fails, the latter succeeds. Are you getting an actual red result, and
can I see the link?

Alex

On Fri, 9 Dec 2022 at 15:42, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> This patch applied correctly but failed:
>
> 2022-12-09 13:21:18 (456 MB/s) - =E2=80=98/tmp/wget-index-ypaf69js/wget-l=
isting-m180p7ds=E2=80=99 saved [34419/34419]
> --2022-12-09 13:21:18--  http://localhost:46501/files/v3.16/
> Resolving localhost (localhost)... ::1, 127.0.0.1
> Connecting to localhost (localhost)|::1|:46501... failed: Connection refu=
sed.
> Connecting to localhost (localhost)|127.0.0.1|:46501... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 17922 (18K) [text/html]
> Saving to: =E2=80=98/tmp/wget-index-3i6kh677/wget-listing-w93f0eg3=E2=80=
=99
>
> I suspect we can't connect to random ports on the AB
>
>
> On 09/12/2022 09:58:40+0100, Alexander Kanavin wrote:
> > When obtaining latest upstream versions, the code needs
> > to check if the existing tarball is in a versioned directory
> > (e.g. component-name/x.y/component-name-x.y.z.tar.gz) and
> > if it is, it needs to first obtain the list of all
> > such versioned directories and then check all of them by going
> > one step up in the directory hierarchy.
> >
> > Existing code was returning a correct match when the component
> > name did not have numbers, e.g. a check on 'source/epiphany/43/'
> > would return 43, but was stopping too soon when the component
> > name itself had numbers ('source/libxml2/2.10/' would return libxml2).
> >
> > This change ensures the last match is taken instead of the first.
> >
> > Also, adjust the fetcher tests to check that versioned directories
> > are correctly traversed in this case (e.g. the step to go one level
> > up is taken and a new tarball is discovered in a different versioned
> > directory).
> >
> > Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> > ---
> >  bitbake/lib/bb/fetch2/wget.py                 |  4 +-
> >  .../software/libxml2/2.10/index.html          | 20 ++++++++++
> >  .../software/libxml2/2.9/index.html           | 40 +++++++++++++++++++
> >  .../software/libxml2/index.html               | 19 +++++++++
> >  bitbake/lib/bb/tests/fetch.py                 |  3 ++
> >  5 files changed, 84 insertions(+), 2 deletions(-)
> >  create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml=
2/2.10/index.html
> >  create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml=
2/2.9/index.html
> >  create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml=
2/index.html
> >
> > diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget=
.py
> > index 821afa5b58..7ccea3ad89 100644
> > --- a/bitbake/lib/bb/fetch2/wget.py
> > +++ b/bitbake/lib/bb/fetch2/wget.py
> > @@ -644,10 +644,10 @@ class Wget(FetchMethod):
> >              # search for version matches on folders inside the path, l=
ike:
> >              # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${P=
N}-${PV}.tar.gz
> >              dirver_regex =3D re.compile(r"(?P<dirver>[^/]*(\d+\.)*\d+(=
[-_]r\d+)*)/")
> > -            m =3D dirver_regex.search(path)
> > +            m =3D dirver_regex.findall(path)
> >              if m:
> >                  pn =3D d.getVar('PN')
> > -                dirver =3D m.group('dirver')
> > +                dirver =3D m[-1][0]
> >
> >                  dirver_pn_regex =3D re.compile(r"%s\d?" % (re.escape(p=
n)))
> >                  if not dirver_pn_regex.search(dirver):
> > diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/=
index.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/inde=
x.html
> > new file mode 100644
> > index 0000000000..4e41af6d6a
> > --- /dev/null
> > +++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.h=
tml
> > @@ -0,0 +1,20 @@
> > +<!DOCTYPE html><html><head><meta http-equiv=3D"content-type" content=
=3D"text/html; charset=3Dutf-8"><meta name=3D"viewport" content=3D"width=3D=
device-width"><style type=3D"text/css">body,html {background:#fff;font-fami=
ly:"Bitstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verd=
ana,Lucida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {paddi=
ng:0.1em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border=
-bottom:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#=
a33;}a:hover {color:#e33;}</style>
> > +
> > +<title>Index of /sources/libxml2/2.10/</title>
> > +</head><body><h1>Index of /sources/libxml2/2.10/</h1>
> > +<table id=3D"list"><thead><tr><th style=3D"width:55%"><a href=3D"?C=3D=
N&amp;O=3DA">File Name</a>&nbsp;<a href=3D"?C=3DN&amp;O=3DD">&nbsp;&darr;&n=
bsp;</a></th><th style=3D"width:20%"><a href=3D"?C=3DS&amp;O=3DA">File Size=
</a>&nbsp;<a href=3D"?C=3DS&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th><th style=
=3D"width:25%"><a href=3D"?C=3DM&amp;O=3DA">Date</a>&nbsp;<a href=3D"?C=3DM=
&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th></tr></thead>
> > +<tbody><tr><td class=3D"link"><a href=3D"../">Parent directory/</a></t=
d><td class=3D"size">-</td><td class=3D"date">-</td></tr>
> > +<tr><td class=3D"link"><a href=3D"LATEST-IS-2.10.3" title=3D"LATEST-IS=
-2.10.3">LATEST-IS-2.10.3</a></td><td class=3D"size">2.5 MiB</td><td class=
=3D"date">2022-Oct-14 12:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.0.news" title=3D"libxml=
2-2.10.0.news">libxml2-2.10.0.news</a></td><td class=3D"size">7.1 KiB</td><=
td class=3D"date">2022-Aug-17 11:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.0.sha256sum" title=3D"l=
ibxml2-2.10.0.sha256sum">libxml2-2.10.0.sha256sum</a></td><td class=3D"size=
">174 B</td><td class=3D"date">2022-Aug-17 11:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.0.tar.xz" title=3D"libx=
ml2-2.10.0.tar.xz">libxml2-2.10.0.tar.xz</a></td><td class=3D"size">2.6 MiB=
</td><td class=3D"date">2022-Aug-17 11:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.1.news" title=3D"libxml=
2-2.10.1.news">libxml2-2.10.1.news</a></td><td class=3D"size">455 B</td><td=
 class=3D"date">2022-Aug-25 11:33</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.1.sha256sum" title=3D"l=
ibxml2-2.10.1.sha256sum">libxml2-2.10.1.sha256sum</a></td><td class=3D"size=
">174 B</td><td class=3D"date">2022-Aug-25 11:33</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.1.tar.xz" title=3D"libx=
ml2-2.10.1.tar.xz">libxml2-2.10.1.tar.xz</a></td><td class=3D"size">2.6 MiB=
</td><td class=3D"date">2022-Aug-25 11:33</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.2.news" title=3D"libxml=
2-2.10.2.news">libxml2-2.10.2.news</a></td><td class=3D"size">309 B</td><td=
 class=3D"date">2022-Aug-29 14:56</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.2.sha256sum" title=3D"l=
ibxml2-2.10.2.sha256sum">libxml2-2.10.2.sha256sum</a></td><td class=3D"size=
">174 B</td><td class=3D"date">2022-Aug-29 14:56</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.2.tar.xz" title=3D"libx=
ml2-2.10.2.tar.xz">libxml2-2.10.2.tar.xz</a></td><td class=3D"size">2.5 MiB=
</td><td class=3D"date">2022-Aug-29 14:56</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.3.news" title=3D"libxml=
2-2.10.3.news">libxml2-2.10.3.news</a></td><td class=3D"size">294 B</td><td=
 class=3D"date">2022-Oct-14 12:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.3.sha256sum" title=3D"l=
ibxml2-2.10.3.sha256sum">libxml2-2.10.3.sha256sum</a></td><td class=3D"size=
">174 B</td><td class=3D"date">2022-Oct-14 12:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.10.3.tar.xz" title=3D"libx=
ml2-2.10.3.tar.xz">libxml2-2.10.3.tar.xz</a></td><td class=3D"size">2.5 MiB=
</td><td class=3D"date">2022-Oct-14 12:55</td></tr>
> > +</tbody></table></body></html>
> > diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/i=
ndex.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.=
html
> > new file mode 100644
> > index 0000000000..abdfdd0fa2
> > --- /dev/null
> > +++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.ht=
ml
> > @@ -0,0 +1,40 @@
> > +<!DOCTYPE html><html><head><meta http-equiv=3D"content-type" content=
=3D"text/html; charset=3Dutf-8"><meta name=3D"viewport" content=3D"width=3D=
device-width"><style type=3D"text/css">body,html {background:#fff;font-fami=
ly:"Bitstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verd=
ana,Lucida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {paddi=
ng:0.1em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border=
-bottom:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#=
a33;}a:hover {color:#e33;}</style>
> > +
> > +<title>Index of /sources/libxml2/2.9/</title>
> > +</head><body><h1>Index of /sources/libxml2/2.9/</h1>
> > +<table id=3D"list"><thead><tr><th style=3D"width:55%"><a href=3D"?C=3D=
N&amp;O=3DA">File Name</a>&nbsp;<a href=3D"?C=3DN&amp;O=3DD">&nbsp;&darr;&n=
bsp;</a></th><th style=3D"width:20%"><a href=3D"?C=3DS&amp;O=3DA">File Size=
</a>&nbsp;<a href=3D"?C=3DS&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th><th style=
=3D"width:25%"><a href=3D"?C=3DM&amp;O=3DA">Date</a>&nbsp;<a href=3D"?C=3DM=
&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th></tr></thead>
> > +<tbody><tr><td class=3D"link"><a href=3D"../">Parent directory/</a></t=
d><td class=3D"size">-</td><td class=3D"date">-</td></tr>
> > +<tr><td class=3D"link"><a href=3D"LATEST-IS-2.9.14" title=3D"LATEST-IS=
-2.9.14">LATEST-IS-2.9.14</a></td><td class=3D"size">3.0 MiB</td><td class=
=3D"date">2022-May-02 12:03</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.0.sha256sum" title=3D"li=
bxml2-2.9.0.sha256sum">libxml2-2.9.0.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:27</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.0.tar.xz" title=3D"libxm=
l2-2.9.0.tar.xz">libxml2-2.9.0.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:27</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.1.sha256sum" title=3D"li=
bxml2-2.9.1.sha256sum">libxml2-2.9.1.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:28</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.1.tar.xz" title=3D"libxm=
l2-2.9.1.tar.xz">libxml2-2.9.1.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:28</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.10.sha256sum" title=3D"l=
ibxml2-2.9.10.sha256sum">libxml2-2.9.10.sha256sum</a></td><td class=3D"size=
">88 B</td><td class=3D"date">2022-Feb-14 18:42</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.10.tar.xz" title=3D"libx=
ml2-2.9.10.tar.xz">libxml2-2.9.10.tar.xz</a></td><td class=3D"size">3.2 MiB=
</td><td class=3D"date">2022-Feb-14 18:42</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.11.sha256sum" title=3D"l=
ibxml2-2.9.11.sha256sum">libxml2-2.9.11.sha256sum</a></td><td class=3D"size=
">88 B</td><td class=3D"date">2022-Feb-14 18:43</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.11.tar.xz" title=3D"libx=
ml2-2.9.11.tar.xz">libxml2-2.9.11.tar.xz</a></td><td class=3D"size">3.2 MiB=
</td><td class=3D"date">2022-Feb-14 18:43</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.12.sha256sum" title=3D"l=
ibxml2-2.9.12.sha256sum">libxml2-2.9.12.sha256sum</a></td><td class=3D"size=
">88 B</td><td class=3D"date">2022-Feb-14 18:45</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.12.tar.xz" title=3D"libx=
ml2-2.9.12.tar.xz">libxml2-2.9.12.tar.xz</a></td><td class=3D"size">3.2 MiB=
</td><td class=3D"date">2022-Feb-14 18:45</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.13.news" title=3D"libxml=
2-2.9.13.news">libxml2-2.9.13.news</a></td><td class=3D"size">26.6 KiB</td>=
<td class=3D"date">2022-Feb-20 12:42</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.13.sha256sum" title=3D"l=
ibxml2-2.9.13.sha256sum">libxml2-2.9.13.sha256sum</a></td><td class=3D"size=
">174 B</td><td class=3D"date">2022-Feb-20 12:42</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.13.tar.xz" title=3D"libx=
ml2-2.9.13.tar.xz">libxml2-2.9.13.tar.xz</a></td><td class=3D"size">3.1 MiB=
</td><td class=3D"date">2022-Feb-20 12:42</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.14.news" title=3D"libxml=
2-2.9.14.news">libxml2-2.9.14.news</a></td><td class=3D"size">1.0 KiB</td><=
td class=3D"date">2022-May-02 12:03</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.14.sha256sum" title=3D"l=
ibxml2-2.9.14.sha256sum">libxml2-2.9.14.sha256sum</a></td><td class=3D"size=
">174 B</td><td class=3D"date">2022-May-02 12:03</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.14.tar.xz" title=3D"libx=
ml2-2.9.14.tar.xz">libxml2-2.9.14.tar.xz</a></td><td class=3D"size">3.0 MiB=
</td><td class=3D"date">2022-May-02 12:03</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.2.sha256sum" title=3D"li=
bxml2-2.9.2.sha256sum">libxml2-2.9.2.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:30</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.2.tar.xz" title=3D"libxm=
l2-2.9.2.tar.xz">libxml2-2.9.2.tar.xz</a></td><td class=3D"size">3.2 MiB</t=
d><td class=3D"date">2022-Feb-14 18:30</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.3.sha256sum" title=3D"li=
bxml2-2.9.3.sha256sum">libxml2-2.9.3.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:31</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.3.tar.xz" title=3D"libxm=
l2-2.9.3.tar.xz">libxml2-2.9.3.tar.xz</a></td><td class=3D"size">3.2 MiB</t=
d><td class=3D"date">2022-Feb-14 18:31</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.4.sha256sum" title=3D"li=
bxml2-2.9.4.sha256sum">libxml2-2.9.4.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:33</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.4.tar.xz" title=3D"libxm=
l2-2.9.4.tar.xz">libxml2-2.9.4.tar.xz</a></td><td class=3D"size">2.9 MiB</t=
d><td class=3D"date">2022-Feb-14 18:33</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.5.sha256sum" title=3D"li=
bxml2-2.9.5.sha256sum">libxml2-2.9.5.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:35</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.5.tar.xz" title=3D"libxm=
l2-2.9.5.tar.xz">libxml2-2.9.5.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:35</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.6.sha256sum" title=3D"li=
bxml2-2.9.6.sha256sum">libxml2-2.9.6.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:36</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.6.tar.xz" title=3D"libxm=
l2-2.9.6.tar.xz">libxml2-2.9.6.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:36</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.7.sha256sum" title=3D"li=
bxml2-2.9.7.sha256sum">libxml2-2.9.7.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:37</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.7.tar.xz" title=3D"libxm=
l2-2.9.7.tar.xz">libxml2-2.9.7.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:37</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.8.sha256sum" title=3D"li=
bxml2-2.9.8.sha256sum">libxml2-2.9.8.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:39</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.8.tar.xz" title=3D"libxm=
l2-2.9.8.tar.xz">libxml2-2.9.8.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:39</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.9.sha256sum" title=3D"li=
bxml2-2.9.9.sha256sum">libxml2-2.9.9.sha256sum</a></td><td class=3D"size">8=
7 B</td><td class=3D"date">2022-Feb-14 18:40</td></tr>
> > +<tr><td class=3D"link"><a href=3D"libxml2-2.9.9.tar.xz" title=3D"libxm=
l2-2.9.9.tar.xz">libxml2-2.9.9.tar.xz</a></td><td class=3D"size">3.0 MiB</t=
d><td class=3D"date">2022-Feb-14 18:40</td></tr>
> > +</tbody></table></body></html>
> > diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index=
.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html
> > new file mode 100644
> > index 0000000000..c183e06a55
> > --- /dev/null
> > +++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html
> > @@ -0,0 +1,19 @@
> > +<!DOCTYPE html><html><head><meta http-equiv=3D"content-type" content=
=3D"text/html; charset=3Dutf-8"><meta name=3D"viewport" content=3D"width=3D=
device-width"><style type=3D"text/css">body,html {background:#fff;font-fami=
ly:"Bitstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verd=
ana,Lucida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {paddi=
ng:0.1em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border=
-bottom:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#=
a33;}a:hover {color:#e33;}</style>
> > +
> > +<title>Index of /sources/libxml2/</title>
> > +</head><body><h1>Index of /sources/libxml2/</h1>
> > +<table id=3D"list"><thead><tr><th style=3D"width:55%"><a href=3D"?C=3D=
N&amp;O=3DA">File Name</a>&nbsp;<a href=3D"?C=3DN&amp;O=3DD">&nbsp;&darr;&n=
bsp;</a></th><th style=3D"width:20%"><a href=3D"?C=3DS&amp;O=3DA">File Size=
</a>&nbsp;<a href=3D"?C=3DS&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th><th style=
=3D"width:25%"><a href=3D"?C=3DM&amp;O=3DA">Date</a>&nbsp;<a href=3D"?C=3DM=
&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th></tr></thead>
> > +<tbody><tr><td class=3D"link"><a href=3D"../">Parent directory/</a></t=
d><td class=3D"size">-</td><td class=3D"date">-</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.0/" title=3D"2.0">2.0/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:04</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.1/" title=3D"2.1">2.1/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:04</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.10/" title=3D"2.10">2.10/</a></td>=
<td class=3D"size">-</td><td class=3D"date">2022-Oct-14 12:55</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.2/" title=3D"2.2">2.2/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:04</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.3/" title=3D"2.3">2.3/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.4/" title=3D"2.4">2.4/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.5/" title=3D"2.5">2.5/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.6/" title=3D"2.6">2.6/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.7/" title=3D"2.7">2.7/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2022-Feb-14 18:24</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.8/" title=3D"2.8">2.8/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2022-Feb-14 18:26</td></tr>
> > +<tr><td class=3D"link"><a href=3D"2.9/" title=3D"2.9">2.9/</a></td><td=
 class=3D"size">-</td><td class=3D"date">2022-May-02 12:04</td></tr>
> > +<tr><td class=3D"link"><a href=3D"cache.json" title=3D"cache.json">cac=
he.json</a></td><td class=3D"size">22.8 KiB</td><td class=3D"date">2022-Oct=
-14 12:55</td></tr>
> > +</tbody></table></body></html>
> > diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch=
.py
> > index 0af06e46e5..ad3d4dea7d 100644
> > --- a/bitbake/lib/bb/tests/fetch.py
> > +++ b/bitbake/lib/bb/tests/fetch.py
> > @@ -1401,6 +1401,9 @@ class FetchLatestVersionTest(FetcherTest):
> >          # http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
> >          ("cmake", "/files/v2.8/cmake-2.8.12.1.tar.gz", "", "")
> >              : "2.8.12.1",
> > +        # https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.1=
4.tar.xz
> > +        ("libxml2", "/software/libxml2/2.9/libxml2-2.9.14.tar.xz", "",=
 "")
> > +            : "2.10.3",
> >          #
> >          # packages with versions only in current directory
> >          #
> > --
> > 2.30.2
> >
>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14158): https://lists.openembedded.org/g/bitbake-de=
vel/message/14158
> > Mute This Topic: https://lists.openembedded.org/mt/95556940/3617179
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex=
andre.belloni@bootlin.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

