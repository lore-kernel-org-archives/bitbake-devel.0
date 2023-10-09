Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EFDE95A9B
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 15:28:10 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.65090.1696865288897585074
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 08:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dyDZNUP3;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: bhstalel@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9936b3d0286so843744566b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865287; x=1697470087; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gCX+UFY8f/ESTYytEm14Vt91IfBJDcUg9X3w3TWNOoo=;
        b=dyDZNUP3gWQcF1MFYOoQ9gpfvdava7SdCF4mIl7ZozTUThc+EwEEwQL/L3zOa9BVTM
         Gl8Z8y1pYl4ERwE3t2bv2H6++NU5B4XKpzw1fkdktKS5V4zbtPZlM8cFeMQhfywVJSRQ
         Mz+jrbwKf6vgrFCLhu7ea7t8BhMg5mWZ9sirJLF0UjZ07vpXhibSHQpVNnUj9oZoiYNx
         ppP/JxlQ1Ph+VbwjVVx2DQ9+2CugNwIoGoyaD05sl68JHlFrSFvQwPMZ2J9gPsDL1RL0
         /g31qVbruIYkpliwNKNvjm/RE8Iubouap3uYWV/ZnGSGEYdi6B6He3Cov+88VeH/FVCu
         NSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865287; x=1697470087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCX+UFY8f/ESTYytEm14Vt91IfBJDcUg9X3w3TWNOoo=;
        b=UNao93XmFCbdeQkYFKwZaI0un3IUZ15OTy9fayWtHUzR2jacu8qeKZmh+Yp5X7pT22
         h3VXpDj4TxeSuAomhBfpYMRLxXfKk+JKATBX38NgCNPyFese9COdkqniXbmXEHxrzUq2
         EufkTYuSfCwIE6yyJUgDhngSoYewuTWghDP2KqZFow49tRy+lmxdR1pf/Qm10mHqEJ1Q
         6TcJvQgifxFGNhW8nql0txzyaBnlt2VuI4GvWZeATG3HN9XbZJQWnCP80AXAvtR8Ts6U
         nwA75SArjg7Abq52ooKl+AnzQ+IpAxR3N3r8g5szQy7nbK/rPICu4ERkUc8H3GODnywi
         EVPg==
X-Gm-Message-State: AOJu0YyiXF04OiN+xjSBA05H00LxbOjSqHeRMxj8z6LCs8537xBUDxoU
	DhaTp9279z+raQM7H5HEp/vjc5V+gD9WozLcOpo=
X-Google-Smtp-Source: AGHT+IGqFyPVrqk4O2m/9NLZ0ofnUwneBNFK4Y4HRLsoZb8MlBVAtqkyBfc17vo+RiSiajMyBm0Op8JrzMrvvi1mo64=
X-Received: by 2002:a17:907:c205:b0:9a5:c54f:da1c with SMTP id
 ti5-20020a170907c20500b009a5c54fda1cmr14375642ejc.47.1696865286950; Mon, 09
 Oct 2023 08:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231009145918.900167-1-bhstalel@gmail.com> <bae7df5d-fbf2-48e1-b11a-dd0bf326f15c@theobroma-systems.com>
In-Reply-To: <bae7df5d-fbf2-48e1-b11a-dd0bf326f15c@theobroma-systems.com>
From: Talel BELHADJ SALEM <bhstalel@gmail.com>
Date: Mon, 9 Oct 2023 16:27:55 +0100
Message-ID: <CAOgG7m3ghptCHf10G3b8yhK=w8xe1t2r6VYk6-R1euPaNCfPxw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Fix find_bbfiles when BBFILES contains directory
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000a914fc06074a3c9b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 15:28:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15196

--000000000000a914fc06074a3c9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

I am stress testing and analysing the source code to see how Bitbake
behaves on different cases of layer.conf content.
I am doing this to get familiar with the large code base quickly.

I found `find_bbfiles` which clearly intended to find .bb files in a layer
if no BBFILE_PATTERN is provided.

I also noted this behavior:
1. When layer.conf is empty, it gets added to bblayers.conf but show-layers
will not show it (Logic as there is no BBFILE_COLLECTION) but why add it in
the first place ?
2. When only BBFILES is provided, bitbake will find the recipe, also will
find the .bbclass even if the doc says that it needs BBPATH to find conf
and classes ?
3. This leads me to find_bbfiles, if BBFILES should not contain
directories, I think this should be checked when adding the layer, or
something like that.

Is this all normal behavior ? Or am I missing something?
What do you think?

Kind regards
Talel

On Mon, Oct 9, 2023 at 4:16=E2=80=AFPM Quentin Schulz <
quentin.schulz@theobroma-systems.com> wrote:

> Hi Talel,
>
> On 10/9/23 16:59, BELHADJ SALEM Talel via lists.openembedded.org wrote:
> >
> > When BBFILES in layer.conf contains a directory, this triggers
> find_bbfiles function
> 1) BBFILES docs clearly specifies:
>
> A space-separated list of recipe files BitBake uses to build software.
>
> So I would say that giving it a directory is incorrect. If it is
> supposed to be supported, then we need to fix the documentation.
>
> What are you trying to do?
>
> > which will fail on endswith that does not expect a list.
> >
> > Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> > ---
> >   bitbake/lib/bb/cooker.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index 2adf4d297d..a354f2f0ab 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
> >               for ignored in ('SCCS', 'CVS', '.svn'):
> >                   if ignored in dirs:
> >                       dirs.remove(ignored)
> > -            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(['.bb', '.bbappend']))]
> > +            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(tuple(['.bb', '.bbappend'])))]
>
> 2) Just replace the square brackets with parenthesis instead to save an
> unnecessary array creation.
>
> Cheers,
> Quentin
>

--000000000000a914fc06074a3c9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Quentin,<div><br></div><div>I am stress testing an=
d analysing the source code to see how Bitbake behaves=C2=A0on different ca=
ses of layer.conf content.</div><div>I am doing this to get familiar with t=
he large code base quickly.</div><div><br></div><div>I found `find_bbfiles`=
 which clearly intended to find .bb files in a layer if no BBFILE_PATTERN i=
s provided.</div><div><br></div><div>I also noted this behavior:</div><div>=
1. When layer.conf is empty, it gets added to bblayers.conf but show-layers=
 will not show it (Logic as there is no BBFILE_COLLECTION) but why add it i=
n the first place ?</div><div>2. When only BBFILES=C2=A0is provided, bitbak=
e will find the recipe, also will find the .bbclass even if the doc says th=
at it needs BBPATH to find conf and classes ?</div><div>3. This leads me to=
 find_bbfiles, if BBFILES should not contain directories, I think this shou=
ld be checked when adding the layer, or something=C2=A0like that.</div><div=
><br></div><div>Is this all normal behavior ? Or am I=C2=A0missing somethin=
g?</div><div><div>What do=C2=A0you think?</div><div><br></div></div><div>Ki=
nd=C2=A0regards</div><div>Talel</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 9, 2023 at 4:16=E2=80=AFPM=
 Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@theobroma-systems.com"=
>quentin.schulz@theobroma-systems.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Talel,<br>
<br>
On 10/9/23 16:59, BELHADJ SALEM Talel via <a href=3D"http://lists.openembed=
ded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a> wr=
ote:<br>
&gt; <br>
&gt; When BBFILES in layer.conf contains a directory, this triggers find_bb=
files function<br>
1) BBFILES docs clearly specifies:<br>
<br>
A space-separated list of recipe files BitBake uses to build software.<br>
<br>
So I would say that giving it a directory is incorrect. If it is <br>
supposed to be supported, then we need to fix the documentation.<br>
<br>
What are you trying to do?<br>
<br>
&gt; which will fail on endswith that does not expect a list.<br>
&gt; <br>
&gt; Signed-off-by: Talel BELHAJSALEM &lt;<a href=3D"mailto:bhstalel@gmail.=
com" target=3D"_blank">bhstalel@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bitbake/lib/bb/cooker.py | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br>
&gt; index 2adf4d297d..a354f2f0ab 100644<br>
&gt; --- a/bitbake/lib/bb/cooker.py<br>
&gt; +++ b/bitbake/lib/bb/cooker.py<br>
&gt; @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for ignored in (=
&#39;SCCS&#39;, &#39;CVS&#39;, &#39;.svn&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 ignored in dirs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dirs.remove(ignored)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found +=3D [os.path.join(di=
r, f) for f in files if (f.endswith([&#39;.bb&#39;, &#39;.bbappend&#39;]))]=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found +=3D [os.path.join(di=
r, f) for f in files if (f.endswith(tuple([&#39;.bb&#39;, &#39;.bbappend&#3=
9;])))]<br>
<br>
2) Just replace the square brackets with parenthesis instead to save an <br=
>
unnecessary array creation.<br>
<br>
Cheers,<br>
Quentin<br>
</blockquote></div>

--000000000000a914fc06074a3c9b--

