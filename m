Return-Path: <sschuberth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F834C04FFE
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 16:01:47 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.134.1714665701097513295
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 May 2024 09:01:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QDUzPohZ;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: sschuberth@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5534506790so151920766b.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714665699; x=1715270499; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ju2XdBa6jur8qLNFaqRrryZPslLK5ZFOdwvnoBNJL1c=;
        b=QDUzPohZeVEU1WS7xq2GYkOecWf8FYNbqIL3aLmLs1GCvgALI8F2bj+yzq7cEQ8T8f
         7kyAQO3N11UA+znDT/r+Y7qlMD/XYY3v0lRuJATv5riHZWfiZRtJTzXRtLiv786iP/Cw
         y5h1LkmUe74EP1JTK14JgeVIDIIkkRv+Q3cFvfux1M8RGDXCKL8ptfkHUb4akdUGxHdV
         A534tYhEfruiuakZpzSNZ+fBXogIfROeTpbkxqkpta7r+EtJpRJHiMv9FpSOrKrUXqjB
         LqhcnSkcm7vc3HaoPdJ8AOWjRcwyXSFItJrGn5kbWvMd6SDMbMSpvj5YEW+sM5Q6nAxl
         RWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665699; x=1715270499;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ju2XdBa6jur8qLNFaqRrryZPslLK5ZFOdwvnoBNJL1c=;
        b=pUSNdJy0rEgjIXdVq2/BQU5tb/4wYKiJm+ERxyydGzmqlbbEvmBoaPx0BpkCIl7UFB
         RF2Gz9iIrYat5faevKtZ1yDWmitjVFGAJcSkLaDUDQd6TMyO87S19Oq6gpj6S48xSUyY
         YBmtXjRBmdZEvFySiKjUa5nUYbjC41QySRD5WGTR73IIHSZ3Z7AwfWEffBseUKPI0hSU
         GovXMNAo88uPDjROqZqCShm1s8BYvp+82D38HsEftpp59lG7I0BC2B9FqkVJxsV0YKkh
         B2Jzn2wPcelKZrS52mWlLq/EwxHV4hXXaDStAD/FoL8r6f2Qc54zdNyrhQHzJ08NaasA
         pb1w==
X-Gm-Message-State: AOJu0Ywd5DxbxhMxv9txe6kQa3uGiFjx+Icnp0Q+XqJ866SX6l5gs6If
	BIayN40tYtbrQgqfxTmqXYxTIt0dCtRBM1OG3jS4cen0ZbM3NPCscI6ZEtsLoDl8XDYxNPdkz3O
	qlktV1uUuwIz7jSihoJ+5CAzFN0Fbsswo
X-Google-Smtp-Source: AGHT+IGrK1I2laG1pnwNgFoKKq4q/reBvga4ptVQkMgi9oOfS/wVoOlxt3erin1hYASlAHsggLbO7kigF7wsaB1+aE8=
X-Received: by 2002:a05:6402:5299:b0:572:9a1c:7ce5 with SMTP id
 en25-20020a056402529900b005729a1c7ce5mr3869775edb.3.1714665698386; Thu, 02
 May 2024 09:01:38 -0700 (PDT)
MIME-Version: 1.0
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Thu, 2 May 2024 18:01:27 +0200
Message-ID: <CAHGBnuOn-i=R0cxfWqGgQUsDnKjcrP3ERhX1jnZhgVRsWz=fhg@mail.gmail.com>
Subject: Generating SPDX documents without actually building
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000dc6a9806177ab737"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 16:01:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16181

--000000000000dc6a9806177ab737
Content-Type: text/plain; charset="UTF-8"

Hi all,

to start with a disclaimer, I'm a total noob when it comes to Open Embedded
/ Embedded Linux / Yocto / BitBake stuff. That said, I'm in need of
creating SPDX documents for Yocto projects in the context of [1]. I'm
already quite far in that I work with Poky and programmatically run
something like

bitbake -r
/home/sebastian/Development/GitHub/doubleopen-project/ort/plugins/package-managers/bitbake/src/main/resources/spdx.conf
-c create_spdx xmlto

However, I continuously run into various build problems on my Fedora 40
machine (one of which has been recently addressed by [2]), let alone the
time it takes to build something from scratch, even something as small as
e.g. the "xmlto" target. So, ideally, I would be able to create SPDX
documents without really building any binaries at all. I probably want all
the source download and patching to happen, in order to archive the patched
code that goes into the binaries, but skip the actual compiler / linker
invocations to save time, and just create the SPDX documents.

Is something like this already possible somehow, maybe by setting from
compiler / linker variables to fake scripts that just do nothing?

Thanks for any insights!

[1]: https://github.com/oss-review-toolkit/ort/issues/722
[2]:
https://github.com/openembedded/bitbake/commit/f10e630fd7561746d835a4378e8777e78f56e44a

-- 
Sebastian Schuberth

--000000000000dc6a9806177ab737
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi all,</div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-=
family:monospace,monospace">to start with a disclaimer, I&#39;m a total noo=
b when it comes to Open Embedded / Embedded Linux / Yocto / BitBake stuff. =
That said, I&#39;m in need of creating SPDX documents for Yocto projects in=
 the context of [1]. I&#39;m already quite far in that I work with Poky and=
 programmatically run something like</div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default=
" style=3D"font-family:monospace,monospace"><span style=3D"font-family:mono=
space"><span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">b=
itbake -r /home/sebastian/Development/GitHub/doubleopen-project/ort/plugins=
/package-manager</span>s/bitbake/src/main/resources/spdx.conf -c create_spd=
x xmlto<br></span></div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><span style=3D"font-family:monospace"><br></span></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><spa=
n class=3D"gmail-Lm gmail-ng">However, I continuously run into various buil=
d problems on my Fedora 40 machine (one of which has been recently addresse=
d by [2]), let alone the time it takes to build something from scratch, eve=
n something as small as e.g. the &quot;xmlto&quot; target. So, ideally, I w=
ould be able to create SPDX documents without really building any binaries =
at all. I probably want all the source download and patching to happen, in =
order to archive the patched code that goes into the binaries, but skip the=
 actual compiler / linker invocations to save time, and just create the SPD=
X documents.</span></div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace"><span class=3D"gmail-Lm gmail-ng"><br></span></div><di=
v class=3D"gmail_default" style=3D"font-family:monospace,monospace"><span c=
lass=3D"gmail-Lm gmail-ng">Is something like this already possible somehow,=
 maybe by setting from compiler / linker variables to fake scripts that jus=
t do nothing?</span></div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace"><span class=3D"gmail-Lm gmail-ng"><br></span></div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace,monospace"><span =
class=3D"gmail-Lm gmail-ng">Thanks for any insights!<br></span></div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace">[1]:=
 <a href=3D"https://github.com/oss-review-toolkit/ort/issues/722">https://g=
ithub.com/oss-review-toolkit/ort/issues/722</a></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace">[2]: <a href=3D"https://gi=
thub.com/openembedded/bitbake/commit/f10e630fd7561746d835a4378e8777e78f56e4=
4a">https://github.com/openembedded/bitbake/commit/f10e630fd7561746d835a437=
8e8777e78f56e44a</a></div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace"><br clear=3D"all"></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv>-- <br></div><div>Sebastian Schuberth</div></div></div></div></div>

--000000000000dc6a9806177ab737--

