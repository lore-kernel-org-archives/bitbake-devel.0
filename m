Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B82BC43334
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 07:20:05 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com
 [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web12.4098.1657351196543532542
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Jul 2022 00:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pOqNFFW/;
 spf=pass (domain: gmail.com, ip: 209.85.219.179,
 mailfrom: ptsneves@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id l11so1092220ybu.13
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Jul 2022 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oL8rMsA43hGCa0C3dpeWHx253JTdXHFIPE8YARmztY=;
        b=pOqNFFW/c7xJoW8rbtfxERCjd/Z3rWWuO4bIOlIKMp7MJPNVw35aDtpw3GQtU6wnH4
         hBknI9pZFpmghDhW3Wn6S0GblbFjULkPQw30vfwWOh/UvbiMV/r12SLBaWgrRg3deJhL
         k8MoHibMTFqFsGbH0gVEm9zoIaa7LmFF3fnDIwsx/U1zeF2IjVXXLSrWABKiVi4rGSvp
         VpIQa9oE/kMH97eVjNpiYOD5u3TkXHX96dLC2LMZGP+yI3YhPnsV1W6cLdlGFJ6nAeTY
         1EosuVAG4Pg3H70qV6snoQZ61XpOYdhayTlGkKYbxxK+7YJIKq0UYj0XvctLlPI1gd96
         /XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oL8rMsA43hGCa0C3dpeWHx253JTdXHFIPE8YARmztY=;
        b=Rqn8B9GXysh/70mJp4UNF/BVNHPIwVGVdX0oV0Wzpn7KZ3V4lvgm18xTtKz5j1XdHQ
         zD6gAwxsdYpn/e9Hzuslt1fp6aMmzZLZ4iQqx6VXGlEEb12tU9ZDg7vGvBBZCnCe0bP9
         0ZDyvPWd0DRnn0Cc7onMx7hxSs+3HYm9p2hpKl6puhfq7+uYyENWtFRaAQ4P1Kxaq2gP
         70zgAyK27894nF2wEnb11255GmDWzhJBru3qCU/7bN/6yTZQGSWoW+uk1kDQDzwxtsl/
         bayR0T9eAKLdH4/xLZkCp7DN6KWvnhTc3OfjuoDru60JtOyqFJnelxN3h+wyZT5GAg7W
         GoPw==
X-Gm-Message-State: AJIora/KMlqYDG3qI/SQRIEneoCxSeEYcYu1QHl7RNqM354C91HpPUof
	km/4BqaYxFiEL2FLZ80Su2F1DOu5ZilZa4cu0A==
X-Google-Smtp-Source: 
 AGRyM1skrErClVPFWWfJT9BD0yQjo+XK6aoaVEPN7X54NPkTHezeSJP5ArUS3QK8LQ65yzmcy8RG4r+pPNrvzbSbHno=
X-Received: by 2002:a25:312:0:b0:66e:d230:8aa1 with SMTP id
 18-20020a250312000000b0066ed2308aa1mr7506240ybd.264.1657351195475; Sat, 09
 Jul 2022 00:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <c677e1a7cedcd974e9ecd6b0bb4aefdcd240932f.camel@linuxfoundation.org>
In-Reply-To: 
 <c677e1a7cedcd974e9ecd6b0bb4aefdcd240932f.camel@linuxfoundation.org>
From: Paulo Neves <ptsneves@gmail.com>
Date: Sat, 9 Jul 2022 09:19:44 +0200
Message-ID: 
 <CAJO0J4g4cyPLGEQ1s4v8cMk0RTgGKGtoh3GME=9Sx+D0KQLX3A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: local files only in DL_DIR
 becomes fatal error
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004643a105e35a256e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Jul 2022 07:20:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13815

--0000000000004643a105e35a256e
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 9, 2022, 08:52 Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2022-07-08 at 22:54 +0200, Paulo Neves wrote:
> > When trying to checksum local files, if a given file is not found
> > anywhere else than the DL_DIR then this means that the the build is
> > inconsistent, and unreproducible.
> >
> > This also means that if the DL_DIR is removed or not available the
> > build does not know how to fetch the file and will fail. With this
> > commit we fail earlier and consistently on this condition.
> >
> > Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> > ---
> >  lib/bb/fetch2/__init__.py | 4 +++-
> >  lib/bb/tests/fetch.py     | 7 +++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index ac557176..5f05278a 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1233,7 +1233,9 @@ def get_checksum_file_list(d):
> >                  if f.startswith(dl_dir):
> >                      # The local fetcher's behaviour is to return a path
> under DL_DIR if it couldn't find the file anywhere else
> >                      if os.path.exists(f):
> > -                        bb.warn("Getting checksum for %s SRC_URI entry
> %s: file not found except in DL_DIR" % (d.getVar('PN'),
> os.path.basename(f)))
> > +                        bb.fatal(("Getting checksum for %s SRC_URI
> entry %s: file not found except in DL_DIR."
> > +                            " This means there is no way to get the
> file except for an orphaned copy"
> > +                            " in DL_DIR.") % (d.getVar('PN'),
> os.path.basename(f)))
> >                      else:
> >                          bb.warn("Unable to get checksum for %s SRC_URI
> entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
> >                  filelist.append(f + ":" + str(os.path.exists(f)))
>
> Did you manage to trigger that error in a real world use case?
>
> I've just been looking at this code and it is horribly old and
> outdated. I can't help wonder if we shouldn't do something a bit more
> invasive to clean it up a bit more. I suspect it does some of these
> things for old/obsolete reasons...
>
> I ask since I'm wondering if anyone ever hits these code paths in a
> valid usecase.
>
> Thanks for working on it, we do need to improve some of these things.
>
> Cheers,
>
> Richard
>

Hey Richard,

I think these codepaths are hit on mostly on bugs(bad uri parsing) or bad
files(bad permissions).

The use case i added on the tests is also clearly bad, but I have seen
builds going on for very long in the state of warning, which becomes fatal
with the patch, because the dl_dir was stable and used by all users. So
expect this patch to increase the reports of latent issues people just
ignored.

Yesterday I also hit this warning organically exactly on the situation of
the test: a directory mentioned on the SRC_URI which did not exist in any
FILESPATHS but somehow existed on the dl_dir. So it is real.

I will investigate the whole default to dl_dir if not found and remove it
if I cannot find a good reason.

Paulo Neves

>

--0000000000004643a105e35a256e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Jul 9, 2022, 08:52 Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 2022-=
07-08 at 22:54 +0200, Paulo Neves wrote:<br>
&gt; When trying to checksum local files, if a given file is not found<br>
&gt; anywhere else than the DL_DIR then this means that the the build is<br=
>
&gt; inconsistent, and unreproducible.<br>
&gt; <br>
&gt; This also means that if the DL_DIR is removed or not available the<br>
&gt; build does not know how to fetch the file and will fail. With this<br>
&gt; commit we fail earlier and consistently on this condition.<br>
&gt; <br>
&gt; Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">ptsneves@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/__init__.py | 4 +++-<br>
&gt;=C2=A0 lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 7 +++++++<br>
&gt;=C2=A0 2 files changed, 10 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index ac557176..5f05278a 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -1233,7 +1233,9 @@ def get_checksum_file_list(d):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f.sta=
rtswith(dl_dir):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # The local fetcher&#39;s behaviour is to return a path under DL_DIR=
 if it couldn&#39;t find the file anywhere else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if os.path.exists(f):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 bb.warn(&quot;Getting checksum for %s SRC_URI entry %s: file=
 not found except in DL_DIR&quot; % (d.getVar(&#39;PN&#39;), os.path.basena=
me(f)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 bb.fatal((&quot;Getting checksum for %s SRC_URI entry %s: fi=
le not found except in DL_DIR.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; This means there is no way to get the f=
ile except for an orphaned copy&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; in DL_DIR.&quot;) % (d.getVar(&#39;PN&#=
39;), os.path.basename(f)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to get checksum for %s SRC_URI en=
try %s: file could not be found&quot; % (d.getVar(&#39;PN&#39;), os.path.ba=
sename(f)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filelist=
.append(f + &quot;:&quot; + str(os.path.exists(f)))<br>
<br>
Did you manage to trigger that error in a real world use case?<br>
<br>
I&#39;ve just been looking at this code and it is horribly old and<br>
outdated. I can&#39;t help wonder if we shouldn&#39;t do something a bit mo=
re<br>
invasive to clean it up a bit more. I suspect it does some of these<br>
things for old/obsolete reasons...<br>
<br>
I ask since I&#39;m wondering if anyone ever hits these code paths in a<br>
valid usecase.<br>
<br>
Thanks for working on it, we do need to improve some of these things.<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Hey Richard,=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I think these codepaths are hit on mostly on bugs(bad uri parsing) or bad=
 files(bad permissions).</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>The use case i added on the tests is also clearly bad, but I have seen bui=
lds going on for very long in the state of warning, which becomes fatal wit=
h the patch, because the dl_dir was stable and used by all users. So expect=
 this patch to increase the reports of latent issues people just ignored.=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Yesterday I also =
hit this warning organically exactly on the situation of the test: a direct=
ory mentioned on the SRC_URI which did not exist in any FILESPATHS but some=
how existed on the dl_dir. So it is real.=C2=A0</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I will investigate the whole default to dl_dir if n=
ot found and remove it if I cannot find a good reason.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paulo Neves=C2=A0</div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div><=
/div></div>

--0000000000004643a105e35a256e--

