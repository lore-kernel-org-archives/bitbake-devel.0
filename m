Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B898E94602
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 20:19:29 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4157.1770668364184065578
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 12:19:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aj+dKVwO;
 spf=pass (domain: gmail.com, ip: 209.85.128.175, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-795176156b1so36365467b3.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 12:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770668363; cv=none;
        d=google.com; s=arc-20240605;
        b=bwcIWko5XOQuItQMZm3aGtt9fxoiSBmcNDlUiiyqjzM/Sn2VKDDvdNserFwW+ohTpA
         qBCDD7I3BjqnJ9rOvC0HRBtb1i6abxmgSaDzpn6yx+jV4lpMwZ8N5lt1RKoEtxAJctSm
         UBEWhNJsi124iyD1XuAqwhCFzluerzH0mk5YGYC2+bxyEs5+p20KbaEcBNk8R1tFI0hB
         21+Uj3bf1f7Gs+RIm9NULnQIXeZgUWeK8BxKuQoBUAhhsgPsrRNhlax4iDKzZ/owsMVa
         DLp8DOMW0YG7NlZAPGdWYVzHh1wn3t8Hq/MQzVz/rN3msq4wHyihesLbKBKkQJe2uiDa
         Oa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AbG4gM7igmDKIoYKgkmFYSa71b95iwet+MY2+rhjUR8=;
        fh=2Fc2MjnUbnor9hTifUVYigmoKe1X/8gSaM040/O9XKY=;
        b=YIqBxXDiIg3nAfEVq60C88aFlJ8lj6m1qY3W2Krd0OYfaGTkkKKya2eP0ly2CqJhra
         oyoXCMqUcaI618+BKZVRbXNygU5HmjB5TwOB+JM+VewgibrnjMZJasEGjZLKFDVADL1u
         MbIBg4woJeQlChz9CyBQtrMP5WROgcqCR6Txypfw6GFvch/c3kv3JWgVY6+zuCQG8QjF
         72y2Vd9vCxAw3ooLNFqiNikSKQQadJCgMS5RJYyKgxODFWFOCO1aYchh5Aj/KIkoLeys
         t2pfcOyJ7PMMHPPWCxB8ZexNA6iJdSw1YPTHZM1qn+PlMzsi7x9oMqEleogFA9v8xjm2
         hgIQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770668363; x=1771273163; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AbG4gM7igmDKIoYKgkmFYSa71b95iwet+MY2+rhjUR8=;
        b=aj+dKVwOITwmU1tfK4sx5BNEE/5jqUealt+vPguZs3mqdwD/nDAqxa3ao5f6c+o7uX
         QD7UqEjSU+8qDYg6Q7NKLMM+yiolTt+xoG0YJ7T3sMhym7arQ6EIWq12BKI1mvzLcUlF
         IcD6dpzlJ+9FeY1zMuJ3eq+K73Dmtzs898Q2pEJJ4tBr2wRSjYDc57ZwKfnfhKEJlgC/
         pWtSJCl0JPU8NZT6a0/1H1QqBeELh08XvDvB0ZBWwEANcknPc3hibexPv3qmqo2SP/KU
         +P6dAPXmQ4HuuivRe9sxMhvg9W9k4dgQFT5p9sgpjpc2xNEsbWJ6GT+UIjpo8QTTherL
         2Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668363; x=1771273163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbG4gM7igmDKIoYKgkmFYSa71b95iwet+MY2+rhjUR8=;
        b=Px7E4UWFq+ReIbGYUyyAKJvl3ttSiA1Wj7Z6A+VUGUfwfOprkeW563jCL95x2FI+kb
         yMS+WOC5fWWSDGC7wbDg5Zxi5xhszTLklNnvh0u7cO9eXYaAO61zac30MHopNaFfmoPs
         3v8UixuokA0hKuIgJHlw6xdUV/7R017clpAhUSLKs5Eq+4w775YvdsyucONNTARplt3B
         GIlfN3WUuiHqc1nxvVflPObPYUNUWvB2fvS7+1UdzCzukS4BouJjreQc9p2GVGKYMFdv
         hDrKWZ4e5+egmEePG+YmwPx9GV2JZmn7NYo8i6HvXMqzC6ageImQx0QWVKMdQBHO05fy
         UWhQ==
X-Gm-Message-State: AOJu0Ywesq8WXspzvlZKXATlX0BXYVtgfN9ErE4e4XMTZE84PWRpg8bm
	APkCXyaqWKWOroJsbt3j5wr7b62JHj2AFxZ+wynNwqCmdOsGxybOITPxwkluduIokuhMSR6qJTx
	721MPreb6Qfl39rdnKgNIduxDFtuJDKE=
X-Gm-Gg: AZuq6aKHn3Mqi5Pik2401CvtSK9lo0Uil807LEG7SpKkZg3+sDdt+QoLn9wsisgYQDs
	KuHlaxLhFk/X3uUE+CuakswmeVpBf2JU4H6Dkv6vpYvbeaNqcW560Nw39YlfRHZWIuwI3fcdADp
	qUHM301MCB1SdghEFEoiBY242Asp2QI3YAjNV6mKBU9SBAH0i9cghzapqIWpZSbZ9kcmLBGddxN
	2WOzmfDn3axJRd191GSosboxtFXnORdbXwi5Q9UNw3RseFLga/+EZPmPw8UICDqJIKx5kiPzD+N
	jH5xONi4baxTqbVj4i7FUkHdAsUJoeUJbfXHLw==
X-Received: by 2002:a05:690c:7402:b0:796:3d5f:a2be with SMTP id
 00721157ae682-7963d5fa8d5mr56046257b3.64.1770668363024; Mon, 09 Feb 2026
 12:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-3-rob.woolley@windriver.com> <DG0C8LN6ZUK1.3ACK0646PJ6FP@bootlin.com>
In-Reply-To: <DG0C8LN6ZUK1.3ACK0646PJ6FP@bootlin.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Mon, 9 Feb 2026 15:19:11 -0500
X-Gm-Features: AZwV_Qhctjb6pNowwBv4kYdiLAek5OsUl5UZoZJkO4T-8tmbccBtrmdXBtY2owg
Message-ID: <CAGAhMByPhay1XoWjj3DwSk0gOq7VinrQvprA2=h=uvJcJrE_4w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi packaging
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000cb0e26064a69dab2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 20:19:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18994

--000000000000cb0e26064a69dab2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonin,

Thanks for the feedback.  Sorry for the delay.  I am about to push the
changes Alex asked for so I am revisiing your comments.

On Wed, Jan 28, 2026 at 10:47=E2=80=AFAM Antonin Godard via lists.openembed=
ded.org
<antonin.godard=3Dbootlin.com@lists.openembedded.org> wrote:

> Hi,
>
> On Tue Jan 27, 2026 at 5:04 PM CET, Rob Woolley via lists.openembedded.or=
g
> wrote:
> [...]
> > diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md
> > new file mode 100644
> > index 00000000..a6dd99e0
> > --- /dev/null
> > +++ b/contrib/pypi/README.md
> > @@ -0,0 +1,42 @@
> > +# bitbake-setup
> > +
> > +This package provides the `bitbake-setup` command and the Python modul=
es
> > +required to support BitBake setup and configuration.
>
> s/BitBake setup/`bitbake-setup`/
>

I don't believe this change is correct as the bitbake-setup module supports
the setup and configuration of BitBake.

Otherwise we are saying that bitbake-setup supports setting up and
configuring bitbake-setup.


> > +
> > +## Usage
> > +
> > +Instructions on uses of bitbake-setup can be found in
> > +[Setting Up the Environment With bitbake-setup](
> https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-use=
r-manual-environment-setup.html)
> from the Yocto Project manual.
>
> s/Yocto Project Manual/BitBake Manual/
>

Thanks for pointing this out.


>
> > +
> > +List the available configurations;
> > +```bash
> > +bitbake-setup list
> > +```
> > +
> > +Show the help for the bitbake-setup init subcommand:
>
> s/bitbake-setup/`bitbake-setup`/
>

Thanks.


>
> > +```bash
> > +bitbake-setup init --help
> > +usage: bitbake-setup init [-h] [--non-interactive] [--source-overrides
> SOURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection
> SKIP_SELECTION] [-L SOURCE_NAME PATH]
> > +                          [config ...]
> > +
> > +positional arguments:
> > +  config                path/URL/id to a configuration file (use 'list=
'
> command to get available ids), followed by configuration options.
> Bitbake-setup will ask to choose from available
> > +                        choices if command line doesn't completely
> specify them.
> > +
> > +options:
> > +  -h, --help            show this help message and exit
> > +  --non-interactive     Do not ask to interactively choose from
> available options; if bitbake-setup cannot make a decision it will stop
> with a failure.
> > +  --source-overrides SOURCE_OVERRIDES
> > +                        Override sources information
> (repositories/revisions) with values from a local json file.
> > +  --setup-dir-name SETUP_DIR_NAME
> > +                        A custom setup directory name under the top
> directory.
> > +  --skip-selection SKIP_SELECTION
> > +                        Do not select and set an option/fragment from
> available choices; the resulting bitbake configuration may be incomplete.
> > +  -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH
> > +                        Symlink local source into a build, instead of
> getting it as prescribed by a configuration (useful for local development=
).
> > +```
>
> I would avoid pasting a command output here, it's hard to maintain
> properly.
> Just leave `bitbake-setup init --help` is enough.
>

Thanks.


>
> [...]
> > diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml
> > new file mode 100644
> > index 00000000..53d5ffc1
> > --- /dev/null
> > +++ b/contrib/pypi/pyproject.toml
> > @@ -0,0 +1,97 @@
> > +[build-system]
> > +requires =3D [
> > +    "setuptools>=3D64",
> > +    "setuptools_scm[toml]>=3D8",
> > +]
> > +build-backend =3D "setuptools.build_meta"
> > +
> > +[project]
> > +name =3D "bitbake-setup"
> > +dynamic =3D ["version"]
> > +description =3D "bitbake-setup"
> > +readme =3D "README.md"
>
> Wondering if it would be possible to include the
> doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst file he=
re
> instead of a custom README?
>
> We will likely forget about the above README.md file, and that's one more
> file
> to maintain. If the README needs to be next to the other file, maybe
> create a
> symlink to bitbake-user-manual-environment-setup.rst?
>

That is fine by me.  However, we will need to ensure that the .rst is
validated and appropriate for PyPI:
https://packaging.python.org/en/latest/guides/making-a-pypi-friendly-readme=
/


When I look at that page now it doesn't seem tailored for PyPI:
https://github.com/openembedded/bitbake/blob/master/doc/bitbake-user-manual=
/bitbake-user-manual-environment-setup.rst

It seems to be > 25 pages long which seems too long.  Can we create a
condensed version with the basics and a link to the formal documentation?



> > +requires-python =3D ">=3D3.9"
> > +license =3D "GPL-2.0-only AND MIT"
> > +authors =3D [
> > +  { name =3D "OpenEmbedded BitBake Developers", email =3D "
> bitbake-devel@lists.openembedded.org" }
> > +]
> > +classifiers =3D [
> > +  "Programming Language :: Python :: 3",
> > +  "Operating System :: POSIX :: Linux",
> > +]
> > +
> > +dependencies =3D [
> > +  # BitBake is mostly self-contained
> > +]
> > +
> > +[project.optional-dependencies]
> > +test =3D [
> > +  "pytest>=3D7",
> > +]
> > +
> > +lint =3D [
> > +  "ruff>=3D0.3",
> > +  "mypy>=3D1.8",
> > +]
> > +
> > +dev =3D [
> > +  "nox>=3D2022.11.21",
> > +  "pytest>=3D7",
> > +  "ruff>=3D0.3",
> > +  "mypy>=3D1.8",
> > +  "build",
> > +  "twine",
> > +]
> > +
> > +[project.scripts]
> > +bitbake-setup =3D "bitbake_setup.__main__:main"
> > +
> > +[project.urls]
> > +Homepage =3D "https://git.openembedded.org/bitbake/"
> > +Documentation =3D "
> https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/"
>
> Not sure we want to link to the development version of the documentation
> here.
> You could instead link to the latest released documentation:
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/


Thanks, good suggestion.


>
> Antonin
>
> --
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18919):
> https://lists.openembedded.org/g/bitbake-devel/message/18919
> Mute This Topic: https://lists.openembedded.org/mt/117490846/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000cb0e26064a69dab2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Antonin,<br><br>Thanks for the feedbac=
k.=C2=A0 Sorry for the delay.=C2=A0 I am about to push the changes Alex ask=
ed for so I am revisiing=C2=A0your comments.</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, J=
an 28, 2026 at 10:47=E2=80=AFAM Antonin Godard via <a href=3D"http://lists.=
openembedded.org">lists.openembedded.org</a> &lt;antonin.godard=3D<a href=
=3D"mailto:bootlin.com@lists.openembedded.org">bootlin.com@lists.openembedd=
ed.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi,<br>
<br>
On Tue Jan 27, 2026 at 5:04 PM CET, Rob Woolley via <a href=3D"http://lists=
.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.=
org</a> wrote:<br>
[...]<br>
&gt; diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md<br>
&gt; new file mode 100644<br>
&gt; index 00000000..a6dd99e0<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/README.md<br>
&gt; @@ -0,0 +1,42 @@<br>
&gt; +# bitbake-setup<br>
&gt; +<br>
&gt; +This package provides the `bitbake-setup` command and the Python modu=
les<br>
&gt; +required to support BitBake setup and configuration.<br>
<br>
s/BitBake setup/`bitbake-setup`/<br></blockquote><div><br></div><div>I don&=
#39;t believe this change is correct as the bitbake-setup module supports t=
he setup and configuration of BitBake.</div><div><br></div><div>Otherwise w=
e are saying that bitbake-setup supports setting up and configuring bitbake=
-setup.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; +<br>
&gt; +## Usage<br>
&gt; +<br>
&gt; +Instructions on uses of bitbake-setup can be found in <br>
&gt; +[Setting Up the Environment With bitbake-setup](<a href=3D"https://do=
cs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-env=
ironment-setup.html" rel=3D"noreferrer" target=3D"_blank">https://docs.yoct=
oproject.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-environmen=
t-setup.html</a>) from the Yocto Project manual.<br>
<br>
s/Yocto Project Manual/BitBake Manual/<br></blockquote><div><br></div><div>=
Thanks for pointing this out.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +List the available configurations;<br>
&gt; +```bash<br>
&gt; +bitbake-setup list<br>
&gt; +```<br>
&gt; +<br>
&gt; +Show the help for the bitbake-setup init subcommand:<br>
<br>
s/bitbake-setup/`bitbake-setup`/<br></blockquote><div><br></div><div>Thanks=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +```bash<br>
&gt; +bitbake-setup init --help<br>
&gt; +usage: bitbake-setup init [-h] [--non-interactive] [--source-override=
s SOURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection SKI=
P_SELECTION] [-L SOURCE_NAME PATH]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 [config ...]<br>
&gt; +<br>
&gt; +positional arguments:<br>
&gt; +=C2=A0 config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
path/URL/id to a configuration file (use &#39;list&#39; command to get avai=
lable ids), followed by configuration options. Bitbake-setup will ask to ch=
oose from available<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 choices if command line doesn&#39;t completely specify them.=
<br>
&gt; +<br>
&gt; +options:<br>
&gt; +=C2=A0 -h, --help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show this =
help message and exit<br>
&gt; +=C2=A0 --non-interactive=C2=A0 =C2=A0 =C2=A0Do not ask to interactive=
ly choose from available options; if bitbake-setup cannot make a decision i=
t will stop with a failure.<br>
&gt; +=C2=A0 --source-overrides SOURCE_OVERRIDES<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Override sources information (repositories/revisions) with v=
alues from a local json file.<br>
&gt; +=C2=A0 --setup-dir-name SETUP_DIR_NAME<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 A custom setup directory name under the top directory.<br>
&gt; +=C2=A0 --skip-selection SKIP_SELECTION<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Do not select and set an option/fragment from available choi=
ces; the resulting bitbake configuration may be incomplete.<br>
&gt; +=C2=A0 -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Symlink local source into a build, instead of getting it as =
prescribed by a configuration (useful for local development).<br>
&gt; +```<br>
<br>
I would avoid pasting a command output here, it&#39;s hard to maintain prop=
erly.<br>
Just leave `bitbake-setup init --help` is enough.<br></blockquote><div><br>=
</div><div>Thanks.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
[...]<br>
&gt; diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml=
<br>
&gt; new file mode 100644<br>
&gt; index 00000000..53d5ffc1<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/pypi/pyproject.toml<br>
&gt; @@ -0,0 +1,97 @@<br>
&gt; +[build-system]<br>
&gt; +requires =3D [<br>
&gt; +=C2=A0 =C2=A0 &quot;setuptools&gt;=3D64&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;setuptools_scm[toml]&gt;=3D8&quot;,<br>
&gt; +]<br>
&gt; +build-backend =3D &quot;setuptools.build_meta&quot;<br>
&gt; +<br>
&gt; +[project]<br>
&gt; +name =3D &quot;bitbake-setup&quot;<br>
&gt; +dynamic =3D [&quot;version&quot;]<br>
&gt; +description =3D &quot;bitbake-setup&quot;<br>
&gt; +readme =3D &quot;README.md&quot;<br>
<br>
Wondering if it would be possible to include the<br>
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst file here=
<br>
instead of a custom README?<br>
<br>
We will likely forget about the above README.md file, and that&#39;s one mo=
re file<br>
to maintain. If the README needs to be next to the other file, maybe create=
 a<br>
symlink to bitbake-user-manual-environment-setup.rst?<br></blockquote><div>=
<br></div><div>That is fine by me.=C2=A0 However, we will need to ensure th=
at the .rst is validated and appropriate for PyPI:=C2=A0<a href=3D"https://=
packaging.python.org/en/latest/guides/making-a-pypi-friendly-readme/">https=
://packaging.python.org/en/latest/guides/making-a-pypi-friendly-readme/</a>=
=C2=A0</div><div><br></div><div>When I look at that page now it doesn&#39;t=
 seem tailored for PyPI: <a href=3D"https://github.com/openembedded/bitbake=
/blob/master/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.=
rst">https://github.com/openembedded/bitbake/blob/master/doc/bitbake-user-m=
anual/bitbake-user-manual-environment-setup.rst</a></div><div><br></div><di=
v>It seems to be &gt; 25 pages long which seems too long.=C2=A0 Can we crea=
te a condensed version with the basics and a link to the formal documentati=
on?</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
&gt; +requires-python =3D &quot;&gt;=3D3.9&quot;<br>
&gt; +license =3D &quot;GPL-2.0-only AND MIT&quot;<br>
&gt; +authors =3D [<br>
&gt; +=C2=A0 { name =3D &quot;OpenEmbedded BitBake Developers&quot;, email =
=3D &quot;<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D=
"_blank">bitbake-devel@lists.openembedded.org</a>&quot; }<br>
&gt; +]<br>
&gt; +classifiers =3D [<br>
&gt; +=C2=A0 &quot;Programming Language :: Python :: 3&quot;,<br>
&gt; +=C2=A0 &quot;Operating System :: POSIX :: Linux&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +dependencies =3D [<br>
&gt; +=C2=A0 # BitBake is mostly self-contained<br>
&gt; +]<br>
&gt; +<br>
&gt; +[project.optional-dependencies]<br>
&gt; +test =3D [<br>
&gt; +=C2=A0 &quot;pytest&gt;=3D7&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +lint =3D [<br>
&gt; +=C2=A0 &quot;ruff&gt;=3D0.3&quot;,<br>
&gt; +=C2=A0 &quot;mypy&gt;=3D1.8&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +dev =3D [<br>
&gt; +=C2=A0 &quot;nox&gt;=3D2022.11.21&quot;,<br>
&gt; +=C2=A0 &quot;pytest&gt;=3D7&quot;,<br>
&gt; +=C2=A0 &quot;ruff&gt;=3D0.3&quot;,<br>
&gt; +=C2=A0 &quot;mypy&gt;=3D1.8&quot;,<br>
&gt; +=C2=A0 &quot;build&quot;,<br>
&gt; +=C2=A0 &quot;twine&quot;,<br>
&gt; +]<br>
&gt; +<br>
&gt; +[project.scripts]<br>
&gt; +bitbake-setup =3D &quot;bitbake_setup.__main__:main&quot;<br>
&gt; +<br>
&gt; +[project.urls]<br>
&gt; +Homepage =3D &quot;<a href=3D"https://git.openembedded.org/bitbake/" =
rel=3D"noreferrer" target=3D"_blank">https://git.openembedded.org/bitbake/<=
/a>&quot;<br>
&gt; +Documentation =3D &quot;<a href=3D"https://docs.yoctoproject.org/bitb=
ake/dev/bitbake-user-manual/" rel=3D"noreferrer" target=3D"_blank">https://=
docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/</a>&quot;<br>
<br>
Not sure we want to link to the development version of the documentation he=
re.<br>
You could instead link to the latest released documentation:<br>
<a href=3D"https://docs.yoctoproject.org/bitbake/bitbake-user-manual/" rel=
=3D"noreferrer" target=3D"_blank">https://docs.yoctoproject.org/bitbake/bit=
bake-user-manual/</a></blockquote><div><br></div><div>Thanks, good suggesti=
on.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
<br>
Antonin<br>
<br>
-- <br>
Antonin Godard, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18919): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18919" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18919</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117490846/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/117490846/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000cb0e26064a69dab2--

