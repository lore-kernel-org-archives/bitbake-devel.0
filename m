Return-Path: <dburns@seegrid.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB86C07545
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 16:30:19 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.48300.1698251415251090432
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Oct 2023 09:30:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@seegrid.com header.s=google header.b=QzPm14N4;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks.google.com}: limit exceeded (domain: seegrid.com, ip: 209.85.219.45, mailfrom: dburns@seegrid.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-66d00415a92so8576426d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Oct 2023 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seegrid.com; s=google; t=1698251414; x=1698856214; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8qUMG4uTVz+4DdOag+5YsKzZeVOdUA+SPg1wnmT7iI=;
        b=QzPm14N4YBpdzflenuWL7PmJN0lAyfxOS3innQu05jjoXJyBghw0cKUvrv8J9x3BEZ
         IMYMPTGbZkzUtT6iQOWchI4UoaTbHEdIkpFeJleP0Zl+MlvXlAyAeQMBUhssG4slka40
         6aR3oNY92gpFw7KHFa44E9oYk8YDLttnVZBzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698251414; x=1698856214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8qUMG4uTVz+4DdOag+5YsKzZeVOdUA+SPg1wnmT7iI=;
        b=lVhA7AIl2YNLB9WufObMG067Km+Qj4FIHjBmoDq1dQPQaUd7vk1KkbB3vd5buzbGJm
         klg0uVtgjfA5s+HgXelHUtkgTBqa7jyEOtv0v6g8jv+z8+aD0btIqxyDb54noGJKcqnU
         +/V7WSDYbmwrPtk0flxEr/h1++Mmleae7ATCTtTYi6YDS2eGVwqjco3sBm54Mxf89l7Y
         b7wA2S9B7j5l7cYf+OnivsF6O6UoUr7JyqL09zuB4ox72yTd7Tdh+wa66FPQyBNi+fMJ
         +6ijWfuE+WleoD3Aa/l5NIsdWpMijcgijwm6rCorFSVmlBnGJDcVL1Ak8NsBM/jwEfLJ
         Myqg==
X-Gm-Message-State: AOJu0YwxGk2d80/f7kVqe53WHLtRKJh5sk3ILUOOXaDoOcl9SuPJpAzl
	gVC95k6MaXVAW7fuxVhARGf8Wcalgaxh/VXZT1kecg==
X-Google-Smtp-Source: AGHT+IF3YouZyRKzd/BrRrDs7975sq+PJphkdwtiLwvzNuJ/JmuwPEB28BlD0Arsq2lESK+K3e3bykEVUg8utWk3CIw=
X-Received: by 2002:a05:6214:4115:b0:66d:4c92:1609 with SMTP id
 kc21-20020a056214411500b0066d4c921609mr15963412qvb.5.1698251414197; Wed, 25
 Oct 2023 09:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZje+vcoFiS5rHFn1rvUzmSo-++8VchDzTktSgxKLwD7F0Acg@mail.gmail.com>
 <CAJZje+tdOZPp73THMk6pZNLyzncLQcqTRcdyN=v99dJL_=430g@mail.gmail.com> <b8e4f99865416ec0f1a08e2dbade7a57863af4dd.camel@linuxfoundation.org>
In-Reply-To: <b8e4f99865416ec0f1a08e2dbade7a57863af4dd.camel@linuxfoundation.org>
From: Desone Burns <dburns@seegrid.com>
Date: Wed, 25 Oct 2023 12:30:03 -0400
Message-ID: <CAJZje+uRHeKzj7z-6QYhr9BEEZs7ybAyJQSiVxDK3r7jxnHYgA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: Add git-lfs install step
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Joseph Chafin <jchafin@seegrid.com>
Content-Type: multipart/alternative; boundary="00000000000048729c06088cf88a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Oct 2023 16:30:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15285

--00000000000048729c06088cf88a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My mistake regarding the format of the patch, I can reupload as a v2 with
the formatting corrected.

With regards to this patch, I was having issues pulling a git repo
containing an LFS, the smaller files would come through but the files
actually stored under the LFS did not make it across. In my case, I was
attempting to pull images stored in an LFS for a plymouth splash screen.
The `git lfs install`, as far as I understand, sets up the cloned repo to
also download the large files. Namely, it sets up the git hooks to allow
the download to take place. When cloning the repo without running this
install step, the files populate the `git` directory in the following
format:

version https://git-lfs.github.com/spec/v1
oid sha256:<File SHA>
size 1442

This instructs the LFS application to download the large file, but without
installing the LFS download step into the git hooks, the file remains in
this format. This is all running under the assumption that the user does
already have git-lfs installed on their system, although it may be worth
investigating what minimum version of the application is required for this
to work.

I would be more than willing to write a test to cover this functionality,
is there an available Yocto repo that contains an LFS I could test against?

On Wed, Oct 25, 2023 at 5:27=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2023-10-24 at 16:27 -0400, Desone Burns wrote:
> > When pulling a Git repo that included LFS, it was possible that
> > the LFS download would fail with a message regarding the LFS being
> > installed in the repo. This change runs the LFS install step prior
> > to checkout, to ensure the download step is included in the Git
> > hooks.
> >
> > Signed-off-by: Desone Burns II <dburnsii@live.com>
> > ---
> >  bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
>
> Firstly, the patch didn't come through correctly and has line wrapping
> and whitespace issues which would prevent it being applied.
>
> I'm also very unclear which lfs issues this patch fixes. There have
> been a few changes around lfs recently and I can't tell if this is a
> new issue, a regression with one of the recent changes or something
> else. Which branch/revision was the original issue seen against?
>
> In general we'd expect a user to have git-lfs available in advance of
> the builds and not to download and create a local install in the repo
> during the fetch. I'm unclear what an "lfs install" does though so
> perhaps I don't understand that.
>
> The patch also doesn't change any of our tests which ideally need
> updating to include whatever issue this patch is fixing.
>
> Cheers,
>
> Richard
>
>

--=20
Desone Burns II
Software Engineer III
seegrid.com <https://www.seegrid.com/>  *=E2=80=A2*  412-379-4500
m: 623-258-7361

--00000000000048729c06088cf88a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">My mistake regarding the format of the patch, I can reuplo=
ad as a v2 with the formatting corrected.<div><br></div><div>With regards t=
o this patch, I was having issues pulling a git repo containing an LFS, the=
 smaller files would come through but the files actually stored under the L=
FS did not make it across. In my case, I was attempting to pull images stor=
ed in an LFS for a plymouth splash screen. The `git lfs install`, as far as=
 I understand, sets up the cloned repo to also download the large files. Na=
mely, it sets up the git hooks to allow the download to take place. When cl=
oning the repo without running this install step, the files populate the `g=
it` directory in the following format:</div><div><br></div><div>version <a =
href=3D"https://git-lfs.github.com/spec/v1">https://git-lfs.github.com/spec=
/v1</a><br>oid sha256:&lt;File SHA&gt;<br>size 1442<br></div><div><br></div=
><div>This instructs the LFS application to download the large file, but wi=
thout installing the LFS download step into the git hooks, the file remains=
 in this format. This is all running under the assumption that the user doe=
s already have git-lfs installed on their system, although it may be worth =
investigating what minimum version of the application is required for this =
to work.=C2=A0</div><div><br></div><div>I would be more than willing to wri=
te a test to cover this functionality, is there an available Yocto repo tha=
t contains an LFS I could test against?</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 2023 at 5:27=
=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfounda=
tion.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Tue, 2023-10-24 at 16:27 -04=
00, Desone Burns wrote:<br>
&gt; When pulling a Git repo that included LFS, it was possible that<br>
&gt; the LFS download would fail with a message regarding the LFS being<br>
&gt; installed in the repo. This change runs the LFS install step prior<br>
&gt; to checkout, to ensure the download step is included in the Git<br>
&gt; hooks.<br>
&gt; <br>
&gt; Signed-off-by: Desone Burns II &lt;<a href=3D"mailto:dburnsii@live.com=
" target=3D"_blank">dburnsii@live.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---<br>
&gt; =C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
<br>
Firstly, the patch didn&#39;t come through correctly and has line wrapping<=
br>
and whitespace issues which would prevent it being applied.<br>
<br>
I&#39;m also very unclear which lfs issues this patch fixes. There have<br>
been a few changes around lfs recently and I can&#39;t tell if this is a<br=
>
new issue, a regression with one of the recent changes or something<br>
else. Which branch/revision was the original issue seen against?<br>
<br>
In general we&#39;d expect a user to have git-lfs available in advance of<b=
r>
the builds and not to download and create a local install in the repo<br>
during the fetch. I&#39;m unclear what an &quot;lfs install&quot; does thou=
gh so<br>
perhaps I don&#39;t understand that.<br>
<br>
The patch also doesn&#39;t change any of our tests which ideally need<br>
updating to include whatever issue this patch is fixing.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<div style=3D"height:64px">
<div style=3D"max-width:510px;max-height:64px">
<table width=3D"510" height=3D"64" style=3D"width:510px;height:64px">
<tbody>
<tr>
<td width=3D"1" style=3D"padding:8px 12px 0px 4px;vertical-align:top;width:=
1px"><img src=3D"https://hub.seegrid.com/hubfs/Brand/SeegridLogo_vert.png" =
width=3D"59.0" height=3D"62.0" style=3D"width: 59px; height: 62px;"></td>
<td width=3D"1" style=3D"border-right:2px solid rgb(0,130,210);width:2px"><=
/td>
<td style=3D"padding:4px 0px 0px 20px;vertical-align:top;line-height:22px">=
<span style=3D"color:rgb(0,130,210);font-family:Helvetica,sans-serif;font-w=
eight:bold">Desone Burns II</span><br>
<span style=3D"color:rgb(0,19,33);margin-bottom:8px;font-weight:bold;font-f=
amily:Helvetica,Arial,sans-serif;font-size:14px">Software Engineer III</spa=
n><br>
<table>
<tbody>
<tr>
<td style=3D"padding:8px 0px;margin:0px"><a href=3D"https://www.seegrid.com=
/" style=3D"color:rgb(110,110,108);font-family:Helvetica,Arial,sans-serif;f=
ont-weight:bold;font-size:13px" target=3D"_blank">seegrid.com</a> =C2=A0<b =
style=3D"color:rgb(0,130,205);font-family:Arial,Helvetica,sans-serif;font-s=
ize:10px">=E2=80=A2</b>=C2=A0
<span style=3D"color:rgb(110,110,108);font-family:Helvetica,Arial,sans-seri=
f;font-weight:bold;font-size:13px">
412-379-4500</span><br>
<span style=3D"color:rgb(0,130,205);font-family:Helvetica,Arial,sans-serif;=
font-size:11px;font-weight:bolder">m:</span>
<span style=3D"color:rgb(110,110,108);font-family:Helvetica,Arial,sans-seri=
f;font-weight:bold;font-size:13px">
623-258-7361</span></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<br>
</div>
</div>

</div></div>

--00000000000048729c06088cf88a--

