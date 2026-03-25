Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F081093163
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 01:28:36 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12932.1774402116182969751
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Mar 2026 18:28:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MLQ7ZUsm;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79495b1aaa7so53227027b3.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 18:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774402115; cv=none;
        d=google.com; s=arc-20240605;
        b=MFY3OI8+yFha2TSI9DY9L6TN902CZUnCL5Vj+3AWcVoADUm8b8CJ1aIMTQMAs3R3AW
         QE1/P4y4zPcSJxn30kdnBBQhjr2vvptA4QqZ0D0peMJxJMlYtKsPSjv81bPvEcUhYZGV
         +4mKXKr2L2Eb74DlzU94cxT9UO4Cj2OmC1xnf+AXHrjzj3wthLVsNMuDiz92FvsJ+kl9
         srKhAl/Kpv2Z/Di/CZ7DH0u6Uhzyp5GHZeseUqzhwD5hXjXECah4dj6ZgKC7uvg5OCGH
         HKIuXVrqHJXz4+gdL2e+UMvjmTbv9z4V7nZcnCmRGb+BE33T6fUJK+ELWORkM+keryZp
         HjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qM18NBw3gz7FgQFQA+Ugj3RDhEWZVbf0vN2siqghXYc=;
        fh=dGhMZmBQcdDlInfqMh/AGf4gkCSnr037ETBnNt2bW84=;
        b=AX+0kGG+2OdKH2Mz3/af2bc642oQs0XEQDpyF+usU6kcNQ356sctq1a8GEOf66AtEA
         UciCTpW4/G4YtzAVXxO7KQFTfm0+IqUqyYr20RjuAa1H2zhGisUlE71b2Ur06cde1u1l
         z32SQKwrvETDvpjlr6BNsO3cw5ecj6oGBCthvlRREwWoORECa9wOmZ1C+dXe9pon0fUI
         79ZraxLHsRfZn7w5xPsjPbzdcB+XKorSqNmD31dJ6/j62URpliEQ/y0A4fAEd/4OUy2J
         T5d87ZE1BLuVgGuY7CQXS2yU1y5sNmwMC6xnC1NdVIcoQgU6bH8d1gBNjhhXVF6yOOz7
         XGpQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774402115; x=1775006915; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qM18NBw3gz7FgQFQA+Ugj3RDhEWZVbf0vN2siqghXYc=;
        b=MLQ7ZUsmL6uvKraayaBBXqsx6jtyUK47rVa6QMWK2rcMvSdmY2cTcxdcJt5OYlNiXw
         qz8gWITZjiu20g4wD2WxJzXPb2PVDq8r1J1p2JELVcPuhYkVOLO0q99iLEp/MXISJgfW
         9Czy2aRS+3lCQSI1SLvPRvLK9Worf4fC3OthHWjjEnDrIefsef2x57sPvcWSMWnKcHGr
         4Qwa/xwcB/Mlb1AngevNyapzMuL4YL72m2iV5xAfhN/0wt6HWJ73QhmDufEMCX2hMh6j
         t+LLhtvrYlIwnbOFgVxVQWYkd/5ZH94Xl53BGWz+Gpcx/frHyIruEl+9KIjMhgVmC05v
         63IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402115; x=1775006915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM18NBw3gz7FgQFQA+Ugj3RDhEWZVbf0vN2siqghXYc=;
        b=EShu3IqGkKTa2m84MT3pnxQKSp+LBJw5c24mpqKY7b2gLjA5VkNfD2FlP6Jk71IdAQ
         ZpPBfVYUHYT2g1qn46scPc8tpN5t0uPYnwlEQ7iEeSRL4FRbYfZzk2EA4qa1CgOXV7Ip
         gLoCwdNUIa44SRp644feDWUghDZmYxQmKjCmKAjAWKzURTnQJW8Q6BK9MN9nI0kkYdlp
         wyPr1pu2daGCgAqSxzoG4107L5RpjCA5MHhrPy//LZXk/l8ipmjqc/1qIS2iFxUvg3OA
         tBM4Rd3vUk+G7sSwhjORyFF/Z7OAuA/cm8zA1nL6l1rX1MoTv21T41CHWPsjyTo/bP3m
         VcQQ==
X-Gm-Message-State: AOJu0YwO878p3MCt73SnqtCdLJ/Bt/JkrpbsZL2W7l3cmJ23GPTMaytl
	82mnen4PWCgH9t4d1JD1DujwWXLOUZHL4ojJxu6BuFmpIMrVcOKSA0Jy3K1YPDDz9t0oO0JUe+L
	nt7O3AH+F3z5y1oT08LDa8cqYRkgOOn4=
X-Gm-Gg: ATEYQzxQ2KWXW4FeuSTt8UgX2m5bWNuu0NQbNDSMquiMN2O6gykDlmU8yBALahyKXMf
	+JUHO6sQ/pcrnoj8ZQgL0Spr5E0Zx/qCD6Fok2TycTPb4KSFMHCn36jruhzzLZHRvtkicfbdC6Y
	hCUUL4evrcCpYm82AsT8uElxFMvR/4JPPFY3x16fDFWDFA8IugYkRGrVtpIalTPRCNvizhz5UHj
	NSCOSRDjGGeUa4Pf1d8zQ1GHc5b/oCGVndCcjtGKSZic1u5ehRWmtEdM/z2QLylsOi3O8sikydW
	UhdFGSpiYfB+YecxTuYKWqN1RxXsK9CO6VlyFfp6
X-Received: by 2002:a53:d013:0:b0:64e:a0e7:2e34 with SMTP id
 956f58d0204a3-64ee606dfb2mr1582285d50.9.1774402115067; Tue, 24 Mar 2026
 18:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com> <CANNYZj8X=o=dPMAfcSC+pNytN12-d7=y7R8W5qJCO=2RL0V3Vg@mail.gmail.com>
In-Reply-To: <CANNYZj8X=o=dPMAfcSC+pNytN12-d7=y7R8W5qJCO=2RL0V3Vg@mail.gmail.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Tue, 24 Mar 2026 21:28:23 -0400
X-Gm-Features: AQROBzDMhVR_OsAuJQIeV9PxxcgkI7NemYvhlIue5fPInpVPJRcgit1mKG94_xc
Message-ID: <CAGAhMBzq+L0J3Tz0WdF7mbg=reoJWeGAwgP5M5kvSkvseG_f-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 00/10] Package bitbake-setup for PyPI
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000c1e24a064dcf2fd4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 01:28:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19218

--000000000000c1e24a064dcf2fd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for reaching out.  Just wanted to acknowledge that I saw your
request.

I have my latest changes here:
https://github.com/robwoolley/bitbake/tree/pypi-version-six

I am still fighting with one last bug related to differences in relative
imports in scripts versus modules.  Hope to resolve that soon and send out
the latest patchset.

Regards,
Rob

On Mon, Mar 23, 2026 at 9:24=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> Hello Rob,
>
> can you send the latest patchset for bitbake-setup in pypi please?
>
> Alex
>
> On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org
> <rob.woolley=3Dwindriver.com@lists.openembedded.org> wrote:
> >
> > Thanks for the feedback from the 1st series.  I included all requested
> > changes:
> >    * Moved packaging files from top-level to contrib/pypi
> >    * Created package-bitbake-setup.py to create a new workspace to
> >      build the package and be compliant with PEP 517
> >    * Changed the title of patch #4 to start with bitbake-setup:
> >    * Converted setup.cfg to pyproject.toml
> >    * Remove old license classifiers
> >    * Made AND operator uppercase for license entry
> >    * Set the minimum Python requirement to 3.9
> >    * Created a custom README.md and BUILD.md for bitbake-setup
> >    * Changed the URL to https://git.openembedded.org/bitbake/
> >    * Added support for nox to automate the packaging including
> >      linting, building, and testing
> >
> > There was a question about the wildcards in the includes section.
> > In this context they are not used for filename globbing and instead
> > denote to include any Python sub-modules as well.  See the Python
> > documentation for details:
> > https://setupttools.pypa.io/en/latest/userguide/package_discovery.html
> >
> > The bitbake-setup script is no longer being turned into a module in
> > the git repository.  Instead it is being done by the script.  The
> > rationale for doing this is that it:
> >    * ensures the module works reliably on all platforms
> >    * avoids shebang and path issues
> >    * places nicely with wheels, venvs, and zipapps
> >    * easier to test
> >
> > I did make an attempt to ensure that pyproject.toml and noxfile.py
> > are compatible with older tools.  Building the wheel using the
> > pyprojet.toml should be supported with pip >=3D19.
> >
> > Wheels built newer versions of pip should remain backwards
> > compatible with pip when installing on older systems.
> >
> > Outstanding:
> >    * Determine a release strategy and version scheme
> >    * Document steps for publishing the module to PyPI
> >
> > To run the automated tests all that should be required is to
> > install the python3-nox package or nox Python module.  Then run
> >
> > nox -s lint
> > nox -s build
> > nox -s tests
> >
> > Rob Woolley (10):
> >   bitbake-setup: Add the conditional script stanza
> >   bitbake-setup: Add pypi packaging
> >   bitbake-setup: Remove extraneous variable from str.format()
> >   bitbake-setup: Sort and format imports
> >   bitbake-setup: Resolve unused loop control variables
> >   bitbake-setup: Fix ambiguous variable names
> >   bitbake-setup: Remove unused stdout variable
> >   bitbake-setup: Replace f-string without placeholders
> >   bitbake-setup: Remove unused Namespace import
> >   bitbake-setup: Remove unused parser_settings_list
> >
> >  .gitignore                            |  1 +
> >  bin/bitbake-setup                     | 76 ++++++++++-----------
> >  contrib/pypi/BUILD.md                 | 57 ++++++++++++++++
> >  contrib/pypi/LICENSE                  |  9 +++
> >  contrib/pypi/README.md                | 42 ++++++++++++
> >  contrib/pypi/noxfile.py               | 30 +++++++++
> >  contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++++++
> >  contrib/pypi/pyproject.toml           | 97 +++++++++++++++++++++++++++
> >  contrib/pypi/tests/test_install.py    | 17 +++++
> >  9 files changed, 383 insertions(+), 39 deletions(-)
> >  create mode 100644 contrib/pypi/BUILD.md
> >  create mode 100644 contrib/pypi/LICENSE
> >  create mode 100644 contrib/pypi/README.md
> >  create mode 100644 contrib/pypi/noxfile.py
> >  create mode 100755 contrib/pypi/package-bitbake-setup.py
> >  create mode 100644 contrib/pypi/pyproject.toml
> >  create mode 100644 contrib/pypi/tests/test_install.py
> >
> > --
> > 2.49.0
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#18889):
> https://lists.openembedded.org/g/bitbake-devel/message/18889
> > Mute This Topic: https://lists.openembedded.org/mt/117490844/1686489
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>

--000000000000c1e24a064dcf2fd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div>Thanks for reaching out.=C2=A0=
 Just wanted to acknowledge that I saw your request.<br><br>I have my lates=
t changes here:=C2=A0<a href=3D"https://github.com/robwoolley/bitbake/tree/=
pypi-version-six">https://github.com/robwoolley/bitbake/tree/pypi-version-s=
ix</a><br><br>I am still fighting with one last bug related to differences =
in relative imports in scripts versus modules.=C2=A0 Hope to resolve that s=
oon and send out the latest patchset.<br><br>Regards,</div><div>Rob</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Mar 23, 2026 at 9:24=E2=80=AFAM Alexander Kanav=
in &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hell=
o Rob,<br>
<br>
can you send the latest patchset for bitbake-setup in pypi please?<br>
<br>
Alex<br>
<br>
On Tue, 27 Jan 2026 at 17:05, Rob Woolley via <a href=3D"http://lists.opene=
mbedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a=
><br>
&lt;rob.woolley=3D<a href=3D"mailto:windriver.com@lists.openembedded.org" t=
arget=3D"_blank">windriver.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Thanks for the feedback from the 1st series.=C2=A0 I included all requ=
ested<br>
&gt; changes:<br>
&gt;=C2=A0 =C2=A0 * Moved packaging files from top-level to contrib/pypi<br=
>
&gt;=C2=A0 =C2=A0 * Created package-bitbake-setup.py to create a new worksp=
ace to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 build the package and be compliant with PEP 517<br=
>
&gt;=C2=A0 =C2=A0 * Changed the title of patch #4 to start with bitbake-set=
up:<br>
&gt;=C2=A0 =C2=A0 * Converted setup.cfg to pyproject.toml<br>
&gt;=C2=A0 =C2=A0 * Remove old license classifiers<br>
&gt;=C2=A0 =C2=A0 * Made AND operator uppercase for license entry<br>
&gt;=C2=A0 =C2=A0 * Set the minimum Python requirement to 3.9<br>
&gt;=C2=A0 =C2=A0 * Created a custom README.md and BUILD.md for bitbake-set=
up<br>
&gt;=C2=A0 =C2=A0 * Changed the URL to <a href=3D"https://git.openembedded.=
org/bitbake/" rel=3D"noreferrer" target=3D"_blank">https://git.openembedded=
.org/bitbake/</a><br>
&gt;=C2=A0 =C2=A0 * Added support for nox to automate the packaging includi=
ng<br>
&gt;=C2=A0 =C2=A0 =C2=A0 linting, building, and testing<br>
&gt;<br>
&gt; There was a question about the wildcards in the includes section.<br>
&gt; In this context they are not used for filename globbing and instead<br=
>
&gt; denote to include any Python sub-modules as well.=C2=A0 See the Python=
<br>
&gt; documentation for details:<br>
&gt; <a href=3D"https://setupttools.pypa.io/en/latest/userguide/package_dis=
covery.html" rel=3D"noreferrer" target=3D"_blank">https://setupttools.pypa.=
io/en/latest/userguide/package_discovery.html</a><br>
&gt;<br>
&gt; The bitbake-setup script is no longer being turned into a module in<br=
>
&gt; the git repository.=C2=A0 Instead it is being done by the script.=C2=
=A0 The<br>
&gt; rationale for doing this is that it:<br>
&gt;=C2=A0 =C2=A0 * ensures the module works reliably on all platforms<br>
&gt;=C2=A0 =C2=A0 * avoids shebang and path issues<br>
&gt;=C2=A0 =C2=A0 * places nicely with wheels, venvs, and zipapps<br>
&gt;=C2=A0 =C2=A0 * easier to test<br>
&gt;<br>
&gt; I did make an attempt to ensure that pyproject.toml and noxfile.py<br>
&gt; are compatible with older tools.=C2=A0 Building the wheel using the<br=
>
&gt; pyprojet.toml should be supported with pip &gt;=3D19.<br>
&gt;<br>
&gt; Wheels built newer versions of pip should remain backwards<br>
&gt; compatible with pip when installing on older systems.<br>
&gt;<br>
&gt; Outstanding:<br>
&gt;=C2=A0 =C2=A0 * Determine a release strategy and version scheme<br>
&gt;=C2=A0 =C2=A0 * Document steps for publishing the module to PyPI<br>
&gt;<br>
&gt; To run the automated tests all that should be required is to<br>
&gt; install the python3-nox package or nox Python module.=C2=A0 Then run<b=
r>
&gt;<br>
&gt; nox -s lint<br>
&gt; nox -s build<br>
&gt; nox -s tests<br>
&gt;<br>
&gt; Rob Woolley (10):<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Add the conditional script stanza<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Add pypi packaging<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Remove extraneous variable from str.format(=
)<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Sort and format imports<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Resolve unused loop control variables<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Fix ambiguous variable names<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Remove unused stdout variable<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Replace f-string without placeholders<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Remove unused Namespace import<br>
&gt;=C2=A0 =C2=A0bitbake-setup: Remove unused parser_settings_list<br>
&gt;<br>
&gt;=C2=A0 .gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 bin/bitbake-setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 76 ++++++++++-----------<br>
&gt;=C2=A0 contrib/pypi/BUILD.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 57 ++++++++++++++++<br>
&gt;=C2=A0 contrib/pypi/LICENSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++<br>
&gt;=C2=A0 contrib/pypi/README.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 42 ++++++++++++<br>
&gt;=C2=A0 contrib/pypi/noxfile.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 30 +++++++++<br>
&gt;=C2=A0 contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++=
++++<br>
&gt;=C2=A0 contrib/pypi/pyproject.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 97 +++++++++++++++++++++++++++<br>
&gt;=C2=A0 contrib/pypi/tests/test_install.py=C2=A0 =C2=A0 | 17 +++++<br>
&gt;=C2=A0 9 files changed, 383 insertions(+), 39 deletions(-)<br>
&gt;=C2=A0 create mode 100644 contrib/pypi/BUILD.md<br>
&gt;=C2=A0 create mode 100644 contrib/pypi/LICENSE<br>
&gt;=C2=A0 create mode 100644 contrib/pypi/README.md<br>
&gt;=C2=A0 create mode 100644 contrib/pypi/noxfile.py<br>
&gt;=C2=A0 create mode 100755 contrib/pypi/package-bitbake-setup.py<br>
&gt;=C2=A0 create mode 100644 contrib/pypi/pyproject.toml<br>
&gt;=C2=A0 create mode 100644 contrib/pypi/tests/test_install.py<br>
&gt;<br>
&gt; --<br>
&gt; 2.49.0<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#18889): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/18889" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/18889</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/11749084=
4/1686489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.=
org/mt/117490844/1686489</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" targe=
t=3D"_blank">alex.kanavin@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
</blockquote></div>

--000000000000c1e24a064dcf2fd4--

