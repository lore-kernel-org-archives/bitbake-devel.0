Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D211061B34
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 11:36:30 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18341.1774956984307243641
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 04:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pP33K1v1;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a0323830beso24953156d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 04:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774956983; cv=none;
        d=google.com; s=arc-20240605;
        b=V4MPMmPpI+3qWFLqIInRqsB4VlTNuymWQCsx80wPbDJY6b+3fB3SJLDXdjXy/ljGFd
         P2Steso+DEaR/V7N5QEM4LG+LZiRJzqb2pNqyvSruzJpnn/Le8s9SCXcM/GFc/JCsiV2
         QQ0e6Jfpo8LHppdKuemJBRKm9CbimPtN6GvcZbjtqHVc9TKXtcYZcxbKqjqGNOIt/qA/
         9v2Bos2gepg5qOVnJmsO23BOOixCzmaJ/9Y3bF6aTmnd+KLgKnMq4ss0ihqQaMOaTmjl
         Bfu+0iP/mFcWyVEeQH1wFxfwYeIPWGmQgARIAn0kFr+N80q38AfNMTPu7Woi+Zo5KkLL
         xSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h4sX3sfpRkPwhRvXB0shIqboIZjnXH4OsSAG1Uxbs04=;
        fh=nr1x9r1O+Yzb4Ho6BL9E8XWqGFZ72Kh+GRK6bv/zW2k=;
        b=P3hmuIcOV2AaIUbeewMe9Tt9KnxulLvjNAZGknyo90XeCmx/V6wu5toVzwhyjcEIwH
         AdCDj9hBEPmnAcidQBCVxbpZpWJUSsIM8WNIC8GzAaUbcJ7N2M6LKNr2VmvobJOLNjNx
         s5sbRml7PpMSik3PbhQGxifXPG6cD0WgBQOuXFGBMol2GKrEvCjJ27MJunHMrqCbofOw
         1e1eD++/eYI8bXRBLTBpis/IgWS5NBjBqa/7KADhfHhTim4/9ukjNNxzz0nmk4MsAYEc
         zBkbBKS/olF8sTB3XMc9SaEy2rkN64UK4miAK5IbOkdSM2MTFriOI7NZyOQUEthJxrFp
         tobA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774956983; x=1775561783; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h4sX3sfpRkPwhRvXB0shIqboIZjnXH4OsSAG1Uxbs04=;
        b=pP33K1v13b5kTzFAdKeUVJGIZmj3L0em1LR/ieXywL2iPeSZSc3vtbtEjBWT0ohMHj
         P9rVgFfmT1+Io2CYc7YQITeHHg4IGpl8YoPfYtPtjLZbiJgFbpJNb7GDd5PB/pDT0VZh
         T6zE+Bb3W1V02WQyR1z+ZQa0MHlrVhH+puMoBl8q5Ux2QT3hk8PWPENohSnLPAcNgJo2
         lQAB7Jt6qWAfS+ykXi10+DAZBkW+7Ik/uMUNEn7Sacci6p/CoFdqj0zYutXQU5SVsKXW
         TWBR92AIfzvgVNSmN1iNmK+Yan8t/b3hc6xCQ2JmA+smfkJf7AVbomzIvjRRx3y/nIA1
         lU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774956983; x=1775561783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4sX3sfpRkPwhRvXB0shIqboIZjnXH4OsSAG1Uxbs04=;
        b=lOlyy9kdnprc4O9TyVUjljElL2FrHDeur+KPnnlRHSpWxL/5+x1b0lw/olTc7PjFoQ
         MekRsq1OTWGOk0HIHHZL+0Ysze8Wt5boYn/UCw/X77D6ffPb+mtG3oZuON1d+vvGC8Ie
         uvV4/1Rjh26Sybei7U6f/7lN42n6D5n9CktY6H/CA1VksCxZJF0k7no+34HyNpMXxBmF
         vCL6eDHf0npkLfUoZQSwkpbDcbbCKx7/HbT22c+AtC7+Dt+0XA3rvP4msf59T/cF+T0S
         c0JAU7SQ/c3hthR8cS9riHnLGhUnLRA+dI2ni2nSyhV3i57zYCy4f9763Fj+bLdzbHd1
         SAzw==
X-Forwarded-Encrypted: i=1; AJvYcCXWZV4xFQeh0uHtyDA1RwUaFIuEVAJXgWb6N3BF2U7rJ9/l4XANEpseJNVlkdTlZvd53jEUFKJE2UH2GjZj@lists.openembedded.org
X-Gm-Message-State: AOJu0YwJBpD80gllneghS7nJw7XDv9UnX1dF4NNfjX72raW6HtuqH1Hc
	dh81fYhk5gb4BluSX8rze06hOmnx9KOtc6c+o+Hnpz2jOZeYBBneZVJYjdYnpOzOC9QrnLinWjn
	M1qeeGea1By/WcXBmo7J6THeWJ+pb8WQ=
X-Gm-Gg: ATEYQzxVpdkRUyhYFwWToG8KPXuWp3hpf+DGweecw16ZVSHqwew7faa72mPwBdVGNrU
	Upa6GFFN37kE+7XVhACZb1W7230lvUcdCWh7z/G2jws74QvKf/9TB/HcD4ZKosK5hpYuBq6svKL
	UihinlZBPDDqK9Z/Z3fhZMgcS7nnRPpenzpVbEwNKx4siVYdbkn4gmK58BRgu9NN4DRecrY0dTm
	TApMHyhqZgcEgMCdYcEtagF3g0ZZYmg5IziBM1Ff8jZ1Ba8qQgslNCisxksg4Fn3OF8Yi1rE6ES
	4qyssvwUzYXZEN7+FZkRw/Rvl/grA6m7WHkZwVc=
X-Received: by 2002:a05:6214:762:b0:89c:da2b:4903 with SMTP id
 6a1803df08f44-89ce8f073ebmr235849606d6.46.1774956983142; Tue, 31 Mar 2026
 04:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
 <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com> <6f743774-fe4b-4e9e-ba99-6ffe1d76a51b@cherry.de>
 <57bb4e5300a4be34f4cfddcf41d9a21b5b7bc579.camel@linuxfoundation.org>
In-Reply-To: <57bb4e5300a4be34f4cfddcf41d9a21b5b7bc579.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 31 Mar 2026 13:36:11 +0200
X-Gm-Features: AQROBzD7BDdp8nZW0GcSg9rSVctMZdWCHJRw1HyNjDT33VuDjC52_mM0psJlRMI
Message-ID: <CANNYZj9U3BYUv-cvQvmu7d=8O82Gdg-2GSon6vNJ71BMi6bKsg@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] bitbake-setup: rename "abort"
 rebase conflict stragegy to "halt"
To: richard.purdie@linuxfoundation.org
Cc: quentin.schulz@cherry.de, antonin.godard@bootlin.com, 
	bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000078ce23064e50601a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 11:36:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19291

--00000000000078ce23064e50601a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There=E2=80=99s a simpler rationale too: this follows =E2=80=98git rebase =
=E2=80=94abort=E2=80=99. If git
upstream finds a better word, we will follow. And I agree that all of the
proposed alternatives are less accurate.

Alex

On Tue 31. Mar 2026 at 12.43, Richard Purdie via lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:

> On Tue, 2026-03-31 at 11:00 +0200, Quentin Schulz via
> lists.yoctoproject.org wrote:
> > Hi Antonin,
> >
> > On 3/31/26 10:14 AM, Antonin Godard via lists.yoctoproject.org wrote:
> > > As per [1], do not use the word "abort" and replace it with "halt" fo=
r
> > > the rebase conflicts strategy. This is something we try to follow in
> our
> > > documentation.
> > >
> > > [1]: https://inclusivenaming.org/word-lists/tier-1/abort/
> > >
> > > Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> > > ---
> > >   bin/bitbake-setup                                                 |
> 8 ++++----
> > >   doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst |
> 6 +++---
> > >   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst          |
> 2 +-
> > >   lib/bb/tests/setup.py                                             |
> 8 ++++----
> > >   4 files changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> > > index b02cbc2b1c4..33cbefb4914 100755
> > > --- a/bin/bitbake-setup
> > > +++ b/bin/bitbake-setup
> > > @@ -167,7 +167,7 @@ def _get_remotes(r_remote):
> > >
> > >       return remotes
> > >
> > > -def checkout_layers(layers, confdir, layerdir, d,
> rebase_conflicts_strategy=3D'abort'):
> > > +def checkout_layers(layers, confdir, layerdir, d,
> rebase_conflicts_strategy=3D'halt'):
> > >       def _checkout_git_remote(r_remote, repodir,
> layers_fixed_revisions):
> > >           rev =3D r_remote['rev']
> > >           branch =3D r_remote.get('branch', None)
> > > @@ -458,7 +458,7 @@ def merge_overrides_into_sources(sources,
> overrides):
> > >               layers[k] =3D v
> > >       return layers
> > >
> > > -def update_build(config, confdir, setupdir, layerdir, d,
> update_bb_conf=3D"prompt", init_vscode=3DFalse,
> rebase_conflicts_strategy=3D'abort'):
> > > +def update_build(config, confdir, setupdir, layerdir, d,
> update_bb_conf=3D"prompt", init_vscode=3DFalse,
> rebase_conflicts_strategy=3D'halt'):
> > >       layer_config =3D
> merge_overrides_into_sources(config["data"]["sources"],
> config["source-overrides"]["sources"])
> > >       sources_fixed_revisions =3D checkout_layers(layer_config, confd=
ir,
> layerdir, d, rebase_conflicts_strategy=3Drebase_conflicts_strategy)
> > >       bitbake_config =3D config["bitbake-config"]
> > > @@ -1273,9 +1273,9 @@ def main():
> > >       parser_update =3D subparsers.add_parser('update', help=3D'Updat=
e a
> setup to be in sync with configuration')
> > >       add_setup_dir_arg(parser_update)
> > >       parser_update.add_argument('--update-bb-conf',
> choices=3D['prompt', 'yes', 'no'], default=3D'prompt', help=3D'Update bit=
bake
> configuration files (bblayers.conf, local.conf) (default: prompt)')
> > > -    parser_update.add_argument('--rebase-conflicts-strategy',
> choices=3D['abort', 'backup'], default=3D'abort',
> > > +    parser_update.add_argument('--rebase-conflicts-strategy',
> choices=3D['halt', 'backup'], default=3D'halt',
> > >                           help=3D"What to do when a layer repository =
has
> local modifications that prevent "
> > > -                             "an in-place update: 'abort' (default)
> aborts with an error message; "
> > > +                             "an in-place update: 'halt' (default)
> halts with an error message; "
> > >                                "'backup' renames the directory to a
> timestamped backup and re-clones from upstream.")
> > >       parser_update.set_defaults(func=3Dbuild_update)
> > >
> > > diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > > index c22e19bd665..c7b73001404 100644
> > > --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.r=
st
> > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.r=
st
> > > @@ -458,9 +458,9 @@ In addition, the command can take the following
> arguments:
> > >      local modifications or commits that prevent an in-place update.
> Accepted
> > >      values are:
> > >
> > > -   -  ``abort`` (default): stop with an error message describing the
> problem.
> > > +   -  ``halt`` (default): stop with an error message describing the
> problem.
> > >         The repository is left in its previous state (the failed
> rebase is
> > > -      automatically aborted). The error message includes a hint to
> re-run with
> > > +      automatically halted). The error message includes a hint to
> re-run with
> >
> > This is not what halt means. Maybe 'reset' would be a better choice? Or
> > if you really want to follow the recommendations from that website, I
> > guess "cancel"?
>
> The trouble is none of these alternatives really match what abort
> means, reset and cancel do mean something different. "abandon" might be
> closer but still isn't right. "attempt" maybe? If we get too creative
> with this, users just won't understand what it means :(
>
> Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19290):
> https://lists.openembedded.org/g/bitbake-devel/message/19290
> Mute This Topic: https://lists.openembedded.org/mt/118593422/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000078ce23064e50601a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">There=E2=80=99s a simpler rationale too: this follows =E2=
=80=98git rebase =E2=80=94abort=E2=80=99. If git upstream finds a better wo=
rd, we will follow. And I agree that all of the proposed alternatives are l=
ess accurate.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div>=
<div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue 31. Mar 2026 at 12.43, Richard Purdie via <a hr=
ef=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;richard=
.purdie=3D<a href=3D"mailto:linuxfoundation.org@lists.openembedded.org">lin=
uxfoundation.org@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,=
204)">On Tue, 2026-03-31 at 11:00 +0200, Quentin Schulz via <a href=3D"http=
://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yocto=
project.org</a> wrote:<br>
&gt; Hi Antonin,<br>
&gt; <br>
&gt; On 3/31/26 10:14 AM, Antonin Godard via <a href=3D"http://lists.yoctop=
roject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a>=
 wrote:<br>
&gt; &gt; As per [1], do not use the word &quot;abort&quot; and replace it =
with &quot;halt&quot; for<br>
&gt; &gt; the rebase conflicts strategy. This is something we try to follow=
 in our<br>
&gt; &gt; documentation.<br>
&gt; &gt; <br>
&gt; &gt; [1]: <a href=3D"https://inclusivenaming.org/word-lists/tier-1/abo=
rt/" rel=3D"noreferrer" target=3D"_blank">https://inclusivenaming.org/word-=
lists/tier-1/abort/</a><br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Antonin Godard &lt;<a href=3D"mailto:antonin.godar=
d@bootlin.com" target=3D"_blank">antonin.godard@bootlin.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =C2=A0 bin/bitbake-setup=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----<br>
&gt; &gt; =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-environment-se=
tup.rst | 6 +++---<br>
&gt; &gt; =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-<br>
&gt; &gt; =C2=A0 lib/bb/tests/setup.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 8 ++++----<br>
&gt; &gt; =C2=A0 4 files changed, 12 insertions(+), 12 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
&gt; &gt; index b02cbc2b1c4..33cbefb4914 100755<br>
&gt; &gt; --- a/bin/bitbake-setup<br>
&gt; &gt; +++ b/bin/bitbake-setup<br>
&gt; &gt; @@ -167,7 +167,7 @@ def _get_remotes(r_remote):<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return remotes<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; -def checkout_layers(layers, confdir, layerdir, d, rebase_conflic=
ts_strategy=3D&#39;abort&#39;):<br>
&gt; &gt; +def checkout_layers(layers, confdir, layerdir, d, rebase_conflic=
ts_strategy=3D&#39;halt&#39;):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _checkout_git_remote(r_remote,=
 repodir, layers_fixed_revisions):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rev =3D r_=
remote[&#39;rev&#39;]<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branch =3D=
 r_remote.get(&#39;branch&#39;, None)<br>
&gt; &gt; @@ -458,7 +458,7 @@ def merge_overrides_into_sources(sources, ove=
rrides):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 layers[k] =3D v<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return layers<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; -def update_build(config, confdir, setupdir, layerdir, d, update_=
bb_conf=3D&quot;prompt&quot;, init_vscode=3DFalse, rebase_conflicts_strateg=
y=3D&#39;abort&#39;):<br>
&gt; &gt; +def update_build(config, confdir, setupdir, layerdir, d, update_=
bb_conf=3D&quot;prompt&quot;, init_vscode=3DFalse, rebase_conflicts_strateg=
y=3D&#39;halt&#39;):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer_config =3D merge_overrides_i=
nto_sources(config[&quot;data&quot;][&quot;sources&quot;], config[&quot;sou=
rce-overrides&quot;][&quot;sources&quot;])<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sources_fixed_revisions =3D checko=
ut_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=3Dr=
ebase_conflicts_strategy)<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitbake_config =3D config[&quot;bi=
tbake-config&quot;]<br>
&gt; &gt; @@ -1273,9 +1273,9 @@ def main():<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser_update =3D subparsers.add_p=
arser(&#39;update&#39;, help=3D&#39;Update a setup to be in sync with confi=
guration&#39;)<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add_setup_dir_arg(parser_update)<b=
r>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser_update.add_argument(&#39;--=
update-bb-conf&#39;, choices=3D[&#39;prompt&#39;, &#39;yes&#39;, &#39;no&#3=
9;], default=3D&#39;prompt&#39;, help=3D&#39;Update bitbake configuration f=
iles (bblayers.conf, local.conf) (default: prompt)&#39;)<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 parser_update.add_argument(&#39;--rebase-conf=
licts-strategy&#39;, choices=3D[&#39;abort&#39;, &#39;backup&#39;], default=
=3D&#39;abort&#39;,<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 parser_update.add_argument(&#39;--rebase-conf=
licts-strategy&#39;, choices=3D[&#39;halt&#39;, &#39;backup&#39;], default=
=3D&#39;halt&#39;,<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 help=3D&quot;What to do when a layer repository has local modi=
fications that prevent &quot;<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;an in-place update: &#39;abort&#39; (d=
efault) aborts with an error message; &quot;<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;an in-place update: &#39;halt&#39; (de=
fault) halts with an error message; &quot;<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;&#39;backup&#39; renames t=
he directory to a timestamped backup and re-clones from upstream.&quot;)<br=
>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser_update.set_defaults(func=3D=
build_update)<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environm=
ent-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-set=
up.rst<br>
&gt; &gt; index c22e19bd665..c7b73001404 100644<br>
&gt; &gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-set=
up.rst<br>
&gt; &gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-set=
up.rst<br>
&gt; &gt; @@ -458,9 +458,9 @@ In addition, the command can take the followi=
ng arguments:<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 local modifications or commits that prev=
ent an in-place update. Accepted<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 values are:<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; -=C2=A0=C2=A0 -=C2=A0 ``abort`` (default): stop with an error mes=
sage describing the problem.<br>
&gt; &gt; +=C2=A0=C2=A0 -=C2=A0 ``halt`` (default): stop with an error mess=
age describing the problem.<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The repository is left=
 in its previous state (the failed rebase is<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 automatically aborted). The error=
 message includes a hint to re-run with<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 automatically halted). The error =
message includes a hint to re-run with<br>
&gt; <br>
&gt; This is not what halt means. Maybe &#39;reset&#39; would be a better c=
hoice? Or <br>
&gt; if you really want to follow the recommendations from that website, I<=
br>
&gt; guess &quot;cancel&quot;?<br>
<br>
The trouble is none of these alternatives really match what abort<br>
means, reset and cancel do mean something different. &quot;abandon&quot; mi=
ght be<br>
closer but still isn&#39;t right. &quot;attempt&quot; maybe? If we get too =
creative<br>
with this, users just won&#39;t understand what it means :(<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19290): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19290" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19290</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/118593422/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/118593422/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000078ce23064e50601a--

