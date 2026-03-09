Return-Path: <michael.siebold@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467EAF3C24D
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:15:00 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28197.1773098096178990673
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 16:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nE2arEdT;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: michael.siebold@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-661568ce781so7200705a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 16:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773098094; cv=none;
        d=google.com; s=arc-20240605;
        b=P7V2WjT78WNd5+694BA6LJczY2UvGARTs1zV+STuHjYN2FXF0SZwppP7Zlgc01hk99
         h17eD8EbfH1FHsSIEXBvjKW88E0YwkUpsi6WIuQsYmYIppz5f0O7xGEEJqp+3aUHPduw
         YAKjO71NmxEC+7DkSPXbyo/ju8MKNekhrn7gvJXmhmCmmvzKwPE4wOSUT6FvJ96dt+tQ
         Bq/ld9AQ6cRsxdKqsX8pZbtsrgPL+/11jM8MbapdTOwuRgx2X6Jrr2K/8zWU8Rjr5vBF
         ZLVdPEwrmFAoiVPBK6zUsrOFe7YEzdml/UrvdUD6JuiJeeSfW6DcNALJuRv3IhXNf2sV
         uR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sqcP++UQdZsx44hiNE1Od9RLHyqH/XiBcXIuAnqsPPY=;
        fh=Ie0MqLH9rclC8vATaTwwCgA5Df2HZpMkbLmMULwRNBQ=;
        b=I3OYPd1bjFvmlRdFDKq4ZsvzoikebutvqoDWieWNAlHgT/bqVtx+YlunaZ4A3nNKOL
         uMmQM286SyW5c6IOE7jagaOJOjE7t7+mr/8cnLYy7RTq1JfhPW+5x+qnlEMAnM8tyzzk
         HCieO6nGLNRco6Tcrv7GgLVVOiyZmXPSfHVuayjI9MFKM4hhrllxU/EJGGwd8fETeBHx
         NkjmFlc+NwSIEWz0lNAZApeL70vfM465lAipEWuM1ea/pAlSF/jBsGY2yidiMISojSCR
         kgE0OKA9lEz4+jjPkWT5VfZUFZiO5TIS+kFQntIjckwHVzpoKHyAb+6RWjMwLyNQXDbT
         dNVA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773098094; x=1773702894; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sqcP++UQdZsx44hiNE1Od9RLHyqH/XiBcXIuAnqsPPY=;
        b=nE2arEdTBkxxlBEXD7YmixopMS2XKceQJRByzsxgS6ng/34wHfVm3xknJTgYep1KIg
         0ja94p5AwlHCfXytMzpainqMQhLRp1GmL81d0NsRZ8rOW6lAZPCACb1B1J1j1vbtETAV
         1UG4ozNMO0PhfOI+qwN0vvpgBgYMOPWZN5KoA3VPcBYlBttP7tyosSR6Cbr0JVe5vqeb
         nxFFrY8Se90Hg7VuWyvdW9vXz1TDhNMF0H7xepeXD5oZAEKPu8i2Nc9lkVS+NAe+ylFS
         wKhwhRgSvGhpnXg38qFZXknO3xZcG5ZnhR1EQuB7VI+PhcpAqcWHHFnzu3bSEuqZX3HZ
         2RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773098094; x=1773702894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqcP++UQdZsx44hiNE1Od9RLHyqH/XiBcXIuAnqsPPY=;
        b=LnZ1hFd2bgro3YWvSWjvzd9lS4Mc67cDDDtjEdHfI/IHYYRn3hGyJvjrdu/fD0FrTg
         XbG8VHnMy/iwQ4wkLKNpiL5P1nPn1rEIAjGdsrA9Xqy4vxX+GU+nyS3nwcUoFTBgC3At
         uEM4GksbtHKdn+zj5djePVK7IlWMY696AwHbJw5ecNe2D3lOEKbQpz2Sv+NptvPh5BBm
         pvVuUzrX32V9RrgCWbu73NODx8s7VqdpVc5uxdhZ9N5TirWUVEL3sfnP+D8shmWmtxLe
         8fUS7OoVqcJ32mlEi9eiSY1aPlrai3n3dTG1E7p0KMyDwUxMMjjBlZwJDxexZ6HVma8L
         upAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6acl02hSGPu2PgQwvviwydY/LAB8d7436cU90eTHcVRiwGu9/zo1iZDQPJubR+kOeLQM7HxxRpzPcLeiR@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw5KMxuPzr3CeBI111WCLbK7p4LIqoiJk8NHpAuwoBEoC7aDYGn
	jv3RqHkLAH1Hhqlgh5/2218nfj5ntqR7B54VtM7bbHGhfwrDDngcv1mi7Il1YwcOnZYU4mMwKDq
	tT+47+29yuLGQwcOiSzQai9JVGyGFAkU=
X-Gm-Gg: ATEYQzwjZaJAykW+TRh3tLVjdRVZpUWsI4axzQ5nm48clsqMCabavQmR9FrQagfErMB
	TQ+0qitSw7Dv31EhTTRJzbKtZklKCBaV4bmxO1DTjSdB1aj+iNbRWqgqw/Js+O1STEYx+cU7wHr
	GB/8PE8YWtvKcfcxvegf7o1c5j35PR0GgcNh8NCcJyB1vlg9E85PP7EH44gmilQug3RzY9g/A6U
	T80UYpE/n1EWH2pBSmCNc23tokIdhFOe7iywfDc1Nx2DRAF2XU4BeCnmmEd/K8EUGAcT5VwzUHS
	9TtdZdlx
X-Received: by 2002:a17:907:c05:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b942dbdc5ecmr768434566b.18.1773098093673; Mon, 09 Mar 2026
 16:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260309212125.3172717-1-michael.siebold@gmail.com>
 <20260309212125.3172717-4-michael.siebold@gmail.com> <69ad2307918818d02c42eba53787f404f8fc0fc6.camel@linuxfoundation.org>
In-Reply-To: <69ad2307918818d02c42eba53787f404f8fc0fc6.camel@linuxfoundation.org>
From: Michael Siebold <michael.siebold@gmail.com>
Date: Mon, 9 Mar 2026 16:14:41 -0700
X-Gm-Features: AaiRm526nzJ6cxsi2YFCkAVb3HgV3u-2T0M2Am8u9aO6HSPjEJWPHwY380009ls
Message-ID: <CAMC_76XcwwBEtrvmbBbJPW-Bt9u3JVTVc8w7kkboX0S3GNFsnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] bitbake: fetch2: Fix LFS object checkout in submodules
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org, 
	Philip Lorenz <philip.lorenz@bmw.de>
Content-Type: multipart/alternative; boundary="000000000000067ef4064c9f92c8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 23:15:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19133

--000000000000067ef4064c9f92c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I apologize in advance, I'm far from being an expert in this area myself.
These patches are cherry-picking a fix from master into Scarthgap.

And I see that the [Scarthgap] tag made it into the cover letter but not in
the subsequent patches, sorry about that!

I thought about simply requesting this fix be backported into Scarthgap,
but my hope is this makes things easier.

Best,

Michael

On Mon, Mar 9, 2026 at 2:33=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2026-03-09 at 14:21 -0700, Michael Siebold wrote:
> > From: Philip Lorenz <philip.lorenz@bmw.de>
> >
> > Skipping smudging prevents the LFS objects from replacing their
> > placeholder files when `git submodule update` actually checks out the
> > target revision in the submodule. Smudging cannot happen earlier as the
> > clone stored in `.git/modules` is bare.
> >
> > This should be fine as long as all LFS objects are available in the
> > download cache (which they are after the other fixes are applied).
> >
> > (Bitbake rev: d270e33a07c50bb9c08861cf9a6dc51e1fd2d874)
> >
> > Upstream-Status: Backport [from commit 3eeac69385]
> >
> > Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (cherry picked from commit 3eeac69385e8f29a08d022a17b28b5d504deed66)
> > Signed-off-by: Michael Siebold <michael.siebold@gmail.com>
> > ---
> >  bitbake/lib/bb/fetch2/gitsm.py | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/fetch2/gitsm.py
> b/bitbake/lib/bb/fetch2/gitsm.py
> > index 5c98991480..ef19053330 100644
> > --- a/bitbake/lib/bb/fetch2/gitsm.py
> > +++ b/bitbake/lib/bb/fetch2/gitsm.py
> > @@ -243,12 +243,11 @@ class GitSM(Git):
> >          ret =3D self.process_submodules(ud, ud.destdir,
> unpack_submodules, d)
> >
> >          if not ud.bareclone and ret:
> > -            # All submodules should already be downloaded and
> configured in the tree.  This simply
> > -            # sets up the configuration and checks out the files.  The
> main project config should
> > -            # remain unmodified, and no download from the internet
> should occur. As such, lfs smudge
> > -            # should also be skipped as these files were already
> smudged in the fetch stage if lfs
> > -            # was enabled.
> > -            runfetchcmd("GIT_LFS_SKIP_SMUDGE=3D1 %s submodule update
> --recursive --no-fetch" % (ud.basecmd), d, quiet=3DTrue, workdir=3Dud.des=
tdir)
> > +            cmdprefix =3D ""
> > +            # Avoid LFS smudging (replacing the LFS pointers with the
> actual content) when LFS shouldn't be used but git-lfs is installed.
> > +            if not self._need_lfs(ud):
> > +                cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
> > +            runfetchcmd("%s%s submodule update --recursive --no-fetch"
> % (cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dud.destdir)
> >      def clean(self, ud, d):
> >          def clean_submodule(ud, url, module, modpath, workdir, d):
> >              url +=3D ";bareclone=3D1;nobranch=3D1"
>
>
> We've had a lot of churn on this code and it isn't something I use and
> fully understand myself so I need to ask some questions to make sure we
> get this right this time.
>
> Is "git submodule update --recursive --no-fetch" going to access the
> network?
>
> If I understand correctly, you say it shouldn't as things should
> already be in DL_DIR. What happens if they're not? Where are the large
> files stored in DL_DIR?
>
> From the older comments in the code, it sounds like the smudging was
> meant to happen at do_fetch time and this is now being changed to
> happen at do_unpack.
>
> Put differently, the fetcher code needs to:
>
> * ensure software manifests are correct and only specifically
> referenced things are fetched, no random revisions or accesses outside
> of what is listed
> * ensure mirroring works correctly and all artefacts needed (including
> lfs ones) can be handled by a mirror setting
> * be reproducible, the same thing will always be fetched for a given
> url/revision
>
> I'd like to be certain this change allows for that and the smudging
> doesn't bypass things.
>
> Also, do we have tests covering this from bitbake-selftest?
>
> Cheers,
>
> Richard
>
>
>
>

--000000000000067ef4064c9f92c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br><br>I apologize in advance, I&#39;m far fro=
m being an expert in this area myself.=C2=A0 These patches are cherry-picki=
ng a fix from master into Scarthgap.<br><br>

And=C2=A0I see that the [Scarthgap] tag made it into the cover letter but n=
ot in the subsequent patches, sorry about that!

<br><br><div>I thought about simply requesting this fix be backported into =
Scarthgap, but my hope is this makes things easier.</div><div><br>Best,<br>=
<br>Michael</div></div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2026 at 2:33=E2=80=AF=
PM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org"=
>richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Mon, 2026-03-09 at 14:21 -0700, Micha=
el Siebold wrote:<br>
&gt; From: Philip Lorenz &lt;<a href=3D"mailto:philip.lorenz@bmw.de" target=
=3D"_blank">philip.lorenz@bmw.de</a>&gt;<br>
&gt; <br>
&gt; Skipping smudging prevents the LFS objects from replacing their<br>
&gt; placeholder files when `git submodule update` actually checks out the<=
br>
&gt; target revision in the submodule. Smudging cannot happen earlier as th=
e<br>
&gt; clone stored in `.git/modules` is bare.<br>
&gt; <br>
&gt; This should be fine as long as all LFS objects are available in the<br=
>
&gt; download cache (which they are after the other fixes are applied).<br>
&gt; <br>
&gt; (Bitbake rev: d270e33a07c50bb9c08861cf9a6dc51e1fd2d874)<br>
&gt; <br>
&gt; Upstream-Status: Backport [from commit 3eeac69385]<br>
&gt; <br>
&gt; Signed-off-by: Philip Lorenz &lt;<a href=3D"mailto:philip.lorenz@bmw.d=
e" target=3D"_blank">philip.lorenz@bmw.de</a>&gt;<br>
&gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&=
gt;<br>
&gt; (cherry picked from commit 3eeac69385e8f29a08d022a17b28b5d504deed66)<b=
r>
&gt; Signed-off-by: Michael Siebold &lt;<a href=3D"mailto:michael.siebold@g=
mail.com" target=3D"_blank">michael.siebold@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bitbake/lib/bb/fetch2/gitsm.py | 11 +++++------<br>
&gt; =C2=A01 file changed, 5 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gi=
tsm.py<br>
&gt; index 5c98991480..ef19053330 100644<br>
&gt; --- a/bitbake/lib/bb/fetch2/gitsm.py<br>
&gt; +++ b/bitbake/lib/bb/fetch2/gitsm.py<br>
&gt; @@ -243,12 +243,11 @@ class GitSM(Git):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D self.process_=
submodules(ud, ud.destdir, unpack_submodules, d)<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not ud.bareclone a=
nd ret:<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
All submodules should already be downloaded and configured in the tree.=C2=
=A0 This simply<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
sets up the configuration and checks out the files.=C2=A0 The main project =
config should<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
remain unmodified, and no download from the internet should occur. As such,=
 lfs smudge<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
should also be skipped as these files were already smudged in the fetch sta=
ge if lfs<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
was enabled.<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ru=
nfetchcmd(&quot;GIT_LFS_SKIP_SMUDGE=3D1 %s submodule update --recursive --n=
o-fetch&quot; % (ud.basecmd), d, quiet=3DTrue, workdir=3Dud.destdir)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cm=
dprefix =3D &quot;&quot;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
Avoid LFS smudging (replacing the LFS pointers with the actual content) whe=
n LFS shouldn&#39;t be used but git-lfs is installed.<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 not self._need_lfs(ud):<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cmdprefix =3D &quot;GIT_LFS_SKIP_SMUDGE=3D1 &quot;<br=
>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ru=
nfetchcmd(&quot;%s%s submodule update --recursive --no-fetch&quot; % (cmdpr=
efix, ud.basecmd), d, quiet=3DTrue, workdir=3Dud.destdir)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 def clean(self, ud, d):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def clean_submodule(u=
d, url, module, modpath, workdir, d):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 url +=3D &quot;;bareclone=3D1;nobranch=3D1&quot;<br>
<br>
<br>
We&#39;ve had a lot of churn on this code and it isn&#39;t something I use =
and<br>
fully understand myself so I need to ask some questions to make sure we<br>
get this right this time.<br>
<br>
Is &quot;git submodule update --recursive --no-fetch&quot; going to access =
the<br>
network?=C2=A0<br>
<br>
If I understand correctly, you say it shouldn&#39;t as things should<br>
already be in DL_DIR. What happens if they&#39;re not? Where are the large<=
br>
files stored in DL_DIR?<br>
<br>
From the older comments in the code, it sounds like the smudging was<br>
meant to happen at do_fetch time and this is now being changed to<br>
happen at do_unpack.<br>
<br>
Put differently, the fetcher code needs to:<br>
<br>
* ensure software manifests are correct and only specifically<br>
referenced things are fetched, no random revisions or accesses outside<br>
of what is listed<br>
* ensure mirroring works correctly and all artefacts needed (including<br>
lfs ones) can be handled by a mirror setting<br>
* be reproducible, the same thing will always be fetched for a given<br>
url/revision<br>
<br>
I&#39;d like to be certain this change allows for that and the smudging<br>
doesn&#39;t bypass things.<br>
<br>
Also, do we have tests covering this from bitbake-selftest?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000067ef4064c9f92c8--

