Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA4BE9E319
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 14:41:17 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20492.1770820870500047815
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 06:41:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BFbyPphG;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-796d68083cdso2218067b3.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 06:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770820869; cv=none;
        d=google.com; s=arc-20240605;
        b=cc6WJsSuIa3oRWIEb9A193/EwQgQAs0ylTdA/1R1gb2fK2icojocUINVCqdLwpfXam
         caYL5okLIfsLm0+ec+ynFSVcHA7c25iFcS7zlHyDgrapxrN6Frw0Ro9cvitePhQtnfpb
         54PzCuyCRo3FDrWwCHeW9xLDm6eh/kdD0o6gZrUqU+3Jgw+JkHmzEuVlJ0OLKFHc9GMh
         HCsJWJnZz2hys+z1TZYP+IPK/2pYXZD/rU6eRPU8AH628w9s994Z3GJX5haD78XMH5ud
         O72ZstsBSECV7vTIJD02/C6s+a5ZE+RmBjZWSOqS15e9af/Awj8BjNdSWVHQ+ZXJUgx0
         PzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SfCt/rndakUiRV1oOLQc3dmI+uEneKXV42bHBPgEDLQ=;
        fh=3FlVth+z46QzO0jAwDbW6GkJvIqn5V+aKfHt69JRUJI=;
        b=PDBbrRTfaHxnT8YL3WTHh8LqQBl/w07y19EOII6VU8x3/7zFNPKi6i924YjTW9be5J
         p52fcHIYb8MTvS8bNrRMvNQkBzY4e7WZGxZHA/sxnRMyQjuBtPBYriEBC/qBzSCZ/4AT
         1OkUEhDKNabEBNLPw0Sy1UTsKpvTNxzGXP+joM3npgIPnfWAHpf8oINzLXVqqCI0g/8i
         JEBOZEEehaZKDNCfH1GvLHuPI49xmVm+C2Jx5qD+1Jzmg8sikcGl4knmGSyMLgB0pDw/
         HNhbazLeKeS+fmzx2kGFrHqdO0xkqhhCkpptl1GoIvwI94oTX9Qc7S2q8nzvddyIU5vX
         vF5Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820869; x=1771425669; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SfCt/rndakUiRV1oOLQc3dmI+uEneKXV42bHBPgEDLQ=;
        b=BFbyPphGV0pSMIn+ZfTphycwqKLXUmzA8GKeQMfYA7tPl1GZXwb5WkyCLSWMaScOCe
         cuNijY3DjI2zrKop9XcfNaQ7HfCsOf879Tem381Gbodf5LggWPADlUtn3sdsBcSWOWtz
         yU5tlTncbbOeuTqOoTg5LPayDw+dOS6JCrlpOpqHM2+EdJq8uWpqMMOX9wREfL3QuivR
         UxpSAydFgwLKCqeIrZC2d6SziABozoy1Ybrp4mWbhK6P9grUvQXZgIqnkMq51JSZ2oEp
         0fz8j8b2W2QFeqVrQ43JdmQFs52FNRP+d5qNEkA4vhhUkIYMaBMS39kSuy/kfSasVpts
         rmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820869; x=1771425669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfCt/rndakUiRV1oOLQc3dmI+uEneKXV42bHBPgEDLQ=;
        b=oUEgWEVm+RlS0lhkFTH1tCN1U1J4LFCPRk3QVPAUX69lCOg5rGugQYPQjVClrC7y4B
         29PuKNB+y/h2jLzm2pdvhsDjwfEMI+YEoG6ez1BFUjTV7nAfTIFaMXEG46xuzgh/hLN8
         5QM7wOrwagEqYtxC8wk676dk9jp41rPqAC5HPxl45ybvnmdCj8ni6PK6kgu0QuuAbdu/
         x6+3gh0a0ylbg0C7hrB1uypx9NpUQQKhiVtYZpLWYNP4hlLG0TThuV5JFC46LiUJ1ltK
         UleZmrOKplp9Nr6Y+GOo5mpLBY3uddtf7pBZHGpX6noTvnc8z9rX1nM620oplD+fWLa8
         wRnA==
X-Forwarded-Encrypted: i=1; AJvYcCXHan6VRKPTc1a4RdHe0Gui/VUDMFiavv8gwWsfg/QwfaIqeiPF94hycLIUROpbi187B6qhiVgYDjzyh6UW@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywm/jUkWfZ+5Ja1SBn99vPQqZIzpVOME80yfKcywCBTIp/IMrZM
	3Xqan/Zzqs6/oTmjLnmce0gD7cdr60pghOaDBbq0cMroX8eICLOLpwAS/JSMm2cnkay/lCOozU/
	1KG0pjpL4fQYAS2IJDskheRvmuYfc0wY=
X-Gm-Gg: AZuq6aKt+dx4Gmd31wuA6ZV6CjhFn5R7GhFdh9MoJ5mwJ2V7gjlqNKGflXNp8kBPnj9
	+28XRz/sgCS+0pFGcDp4RdX/vYbrk245RhDJJfjX/4vVT0YcFRr9emCM/SIt15GtfRtkJne9f7v
	LcJQYg19luLM64y3846Gd0cTBVu4bRozTYkztVXuhLp85Z85QtZOcOR8Xb7t137oq9OfDp8jxv1
	czreMbWdfdvjQBMSg0GP/VNZM4MlwfMVuPAGwLy0YL+kd14zAcjoh8FLnQkWaw05HMCat2jn//7
	pfkpEM18fv9TTmpyrgWYLBZoiQgIzvkzbCPgyXB6
X-Received: by 2002:a05:690c:6505:b0:795:e46:4eef with SMTP id
 00721157ae682-7965dfe7095mr53008157b3.0.1770820869498; Wed, 11 Feb 2026
 06:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com> <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
 <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de>
In-Reply-To: <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Wed, 11 Feb 2026 09:40:57 -0500
X-Gm-Features: AZwV_Qi7H_oZPABU0PgOufrD_uGg5MtAkkFEeYVyWHalK8nOSn9HqIY7hJMqvaw
Message-ID: <CAGAhMBwAGcAqT+m0+XOC=KCEgxXAj=86Lqt35wD4f5JmozXJMQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: quentin.schulz@cherry.de
Cc: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000e32ced064a8d5c23"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 14:41:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19003

--000000000000e32ced064a8d5c23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 5:02=E2=80=AFAM Quentin Schulz via lists.openembedd=
ed.org
<quentin.schulz=3Dcherry.de@lists.openembedded.org> wrote:

> On 1/21/26 10:41 AM, Alexander Kanavin via lists.openembedded.org wrote:
> > On Wed, 21 Jan 2026 at 03:47, Rob Woolley via lists.openembedded.org
> > <rob.woolley=3Dwindriver.com@lists.openembedded.org> wrote:
> >> +version =3D 2.16.0a1
> >
> > There are other issues in setup.cfg, and the commit title should be:
> > 'bitbake-setup: add pypi packaging', but before that I think we need
> > to consider the release strategy and version scheme for it, and get
> > RP's blessing :)
> >
> > Here's what there is in terms of tags and branches, and from what I've
> > heard it is not easy to change:
> > https://git.openembedded.org/bitbake/
> >
> > I guess, bitbake-setup would only be released from the master branch,
> > at least once when a new yocto release happens, at the point where
> > stable and master branches diverge. Those releases should match the
> > stable version, e.g. whinlatter release would have been 2.16.
> >
> > Then the question I can't quite answer is, how to version something
> > from the master trunk? E.g. if we want to release from master right
> > now, what version would it have? Note that ideally it needs to contain
> > the short commit id, for traceability.
> >
>
> setuptools_scm should be able to handle that, see
>
> https://setuptools-scm.readthedocs.io/en/stable/usage/#default-versioning=
-scheme.
>
> I've yet to play with it (will try with
> https://github.com/yoctoproject/bmaptool/ in the next few weeks).
>
> Note that as far as I could tell this means all versioned files in the
> repo are part of the sdist by default (but you can exclude them via
> MANIFEST.in).
>
> The next question is whether we're planning to upload bitbake itself to
> PyPI in the future? If so, we need to be careful about the layout.
> Building two packages from the same git repo isn't that straightforward
> if I remember correctly so if we're moving things around, better
> anticipate this possibility so we don't have to move everything around
> again once we want to publish bitbake itself.
>
> Cheers,
> Quentin
>

Quick update on progress:

I have replaced nox and pytest with Python unittest so that the tests can
be invoked from bitbake-selftest. The new PyPIPackagingTest still
uses package-bitbake-setup.py to copy the files from contrib/pypi to a
staging directory.  This is needed to reorganize the layout such that
pyproject.toml is at the root with the source code in subdirectories.

I experimented with using setuptools_scm to automatically detect the
version number for creating the Python package.  Using setuptools_scm for
determining the version based on git tags conflicts with creating the
staging directory.  Whether it is outside the git repo (e.g. in TMPDIR) or
in a sub-directory (e.g. <git repo root>/packaging_workspace) it fails to
detect the latest git tag.  In the case of it being in a subdirectory, I
need to set root (e.g. root =3D "..")  in the tool.setuptools_scm section o=
f
pyproject.toml for it to succeed.

If we want to use setuptools_scm with git for automatic versioning then we
will need to use a fixed (temporary) directory in the git repository (eg.
./packaging_workspace).  If a developer chooses another location for
scratch work the version will fallback to 0.0.0, which seems acceptable to
me.  I added a test in PyPIPackagingTest to check for this failure case
when doing "production" builds.

Are we okay with pinning the temporary staging directory inside the git
repository?  If so, do you have a preference as to what that directory is
called and where it is located?

The setuptools_scm uses git tags rather than branches.  We may want to
consider updating our tagging strategy if we want to use it to
automatically describe the commit for packages built on master.  One option
we have is to set tag_regex in pyproject.toml to a custom pattern.  Thus we
could create tags like bitbake-v2.16.0 or bitbake-setup-v2.16.0 to provide
a reference point for results like
bitbake-setup-2.16.1.dev0+gd2e159d85.d20260211 or something simpler like
bitbake-setup-2.16.2.dev1 (see
https://setuptools-scm.readthedocs.io/en/latest/extending/#version-number-c=
onstruction
)

Regards,
Rob

--000000000000e32ced064a8d5c23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 21,=
 2026 at 5:02=E2=80=AFAM Quentin Schulz via <a href=3D"http://lists.openemb=
edded.org">lists.openembedded.org</a> &lt;quentin.schulz=3D<a href=3D"mailt=
o:cherry.de@lists.openembedded.org">cherry.de@lists.openembedded.org</a>&gt=
; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
On 1/21/26 10:41 AM, Alexander Kanavin via <a href=3D"http://lists.openembe=
dded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a> w=
rote:<br>
&gt; On Wed, 21 Jan 2026 at 03:47, Rob Woolley via <a href=3D"http://lists.=
openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.o=
rg</a><br>
&gt; &lt;rob.woolley=3D<a href=3D"mailto:windriver.com@lists.openembedded.o=
rg" target=3D"_blank">windriver.com@lists.openembedded.org</a>&gt; wrote:<b=
r>
&gt;&gt; +version =3D 2.16.0a1<br>
&gt; <br>
&gt; There are other issues in setup.cfg, and the commit title should be:<b=
r>
&gt; &#39;bitbake-setup: add pypi packaging&#39;, but before that I think w=
e need<br>
&gt; to consider the release strategy and version scheme for it, and get<br=
>
&gt; RP&#39;s blessing :)<br>
&gt; <br>
&gt; Here&#39;s what there is in terms of tags and branches, and from what =
I&#39;ve<br>
&gt; heard it is not easy to change:<br>
&gt; <a href=3D"https://git.openembedded.org/bitbake/" rel=3D"noreferrer" t=
arget=3D"_blank">https://git.openembedded.org/bitbake/</a><br>
&gt; <br>
&gt; I guess, bitbake-setup would only be released from the master branch,<=
br>
&gt; at least once when a new yocto release happens, at the point where<br>
&gt; stable and master branches diverge. Those releases should match the<br=
>
&gt; stable version, e.g. whinlatter release would have been 2.16.<br>
&gt; <br>
&gt; Then the question I can&#39;t quite answer is, how to version somethin=
g<br>
&gt; from the master trunk? E.g. if we want to release from master right<br=
>
&gt; now, what version would it have? Note that ideally it needs to contain=
<br>
&gt; the short commit id, for traceability.<br>
&gt; <br>
<br>
setuptools_scm should be able to handle that, see <br>
<a href=3D"https://setuptools-scm.readthedocs.io/en/stable/usage/#default-v=
ersioning-scheme" rel=3D"noreferrer" target=3D"_blank">https://setuptools-s=
cm.readthedocs.io/en/stable/usage/#default-versioning-scheme</a>. <br>
I&#39;ve yet to play with it (will try with <br>
<a href=3D"https://github.com/yoctoproject/bmaptool/" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/yoctoproject/bmaptool/</a> in the next f=
ew weeks).<br>
<br>
Note that as far as I could tell this means all versioned files in the <br>
repo are part of the sdist by default (but you can exclude them via <br>
MANIFEST.in).<br>
<br>
The next question is whether we&#39;re planning to upload bitbake itself to=
 <br>
PyPI in the future? If so, we need to be careful about the layout. <br>
Building two packages from the same git repo isn&#39;t that straightforward=
 <br>
if I remember correctly so if we&#39;re moving things around, better <br>
anticipate this possibility so we don&#39;t have to move everything around =
<br>
again once we want to publish bitbake itself.<br>
<br>
Cheers,<br>
Quentin<br></blockquote><div><br></div><div>Quick update on progress:</div>=
<div><br></div><div>I have replaced nox and pytest with Python unittest so =
that the tests can be invoked from bitbake-selftest. The new=C2=A0PyPIPacka=
gingTest still uses=C2=A0package-bitbake-setup.py to copy the files from co=
ntrib/pypi to a staging directory.=C2=A0 This is needed to reorganize the l=
ayout such that pyproject.toml is at the root with the source code in subdi=
rectories.</div><div><br></div><div>I experimented with using setuptools_sc=
m to automatically detect the version number for creating the Python packag=
e.=C2=A0 Using setuptools_scm for determining the version based on git tags=
 conflicts with creating the staging directory.=C2=A0 Whether it is outside=
 the git repo (e.g. in TMPDIR) or in a sub-directory (e.g. &lt;git repo roo=
t&gt;/packaging_workspace) it fails to detect the latest git tag.=C2=A0 In =
the case of it being in a subdirectory, I need to set root (e.g. root =3D &=
quot;..&quot;)=C2=A0 in the tool.setuptools_scm section of pyproject.toml f=
or it to succeed.</div><div><br></div><div>If we want to use setuptools_scm=
 with git for automatic versioning then we will need to use a fixed (tempor=
ary) directory in the git repository (eg. ./packaging_workspace).=C2=A0 If =
a developer chooses another location for scratch work the version will fall=
back to 0.0.0, which seems acceptable to me.=C2=A0 I added a test in=C2=A0P=
yPIPackagingTest to check for this failure case when doing &quot;production=
&quot; builds.</div><div><br></div><div>Are we okay with pinning the tempor=
ary staging directory inside the git repository?=C2=A0 If so, do you have a=
 preference as to what that directory is called and where it is located?</d=
iv><div><br></div><div>The setuptools_scm uses git tags rather than branche=
s.=C2=A0 We may want to consider updating our tagging strategy if we want t=
o use it to automatically describe the commit for packages built on master.=
=C2=A0 One option we have is to set tag_regex in pyproject.toml to a custom=
 pattern.=C2=A0 Thus we could create tags like bitbake-v2.16.0 or bitbake-s=
etup-v2.16.0 to provide a reference point for results like bitbake-setup-2.=
16.1.dev0+gd2e159d85.d20260211 or something simpler like bitbake-setup-2.16=
.2.dev1 (see=C2=A0<a href=3D"https://setuptools-scm.readthedocs.io/en/lates=
t/extending/#version-number-construction">https://setuptools-scm.readthedoc=
s.io/en/latest/extending/#version-number-construction</a>)</div><div><br></=
div><div>Regards,</div><div>Rob</div></div></div>

--000000000000e32ced064a8d5c23--

