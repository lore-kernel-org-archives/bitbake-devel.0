Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
	[209.85.213.196])
	by mail.openembedded.org (Postfix) with ESMTP id 9F1636018C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 23:12:31 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id c3so182944igl.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=wbutUEHiDnY+1UOL5egi53DpmgVeyPItuw68KzhACSo=;
	b=LdDlrH4hmtmCrmh5HO14l9SovPLJEJUP39w3s3V6yjDk0Njoh98I19ek8IwP7RRDTX
	8ZuzCoZ3pW08jVSIjkNOC1prTXajm7MuGMlFiakhQMmLH84GmPkzohnmrdDvojWJUSbb
	KIG5+O7dmBcZUWNmmlxK+fFCxL+ImqwfR7PEvyHVwB5o8eK5ykNwZnSq4fBrFn/ZBaqJ
	vAGyr2ogWqXAzVUSOr7dFovjoP2HGEZVkh+23JQrunngVv5R/cpvS70woBOmvgcXFuV/
	grxZjlhpDqeE8encObSCCCGVreNZjwHnyRrJVke6GCBdKSIBN1Bb/IOr83xhDnzIdoLj
	Wr4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mentor-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=wbutUEHiDnY+1UOL5egi53DpmgVeyPItuw68KzhACSo=;
	b=ThQGbEKS60Rey8gUpa4ebXcYCq6LtNQykabiZzRzF0CLhxVbrOXhVOxeu2RciZey+j
	q5CaC9qArtoM/opXHOrXzXF131wPw6pi+DtlaXUNghYtFTEdhOCIs6LA+EcxJUXtcSM8
	g2S0k7iwKC2RVyAPVsilL8M/l33Q9EO/10ci50fYrN1omfg48zlQ+twPC1EAIA5QYl2v
	/rySSjDF7vc2IQdP39gpKA3d0HHOUsVrqtuUFpfTdla4dxo/jdmY8Se5qKkbV9a7chfq
	2w2Fw0OlAOMH0p9OYL1PrM3dVOQth/Z26CQWncU/gpBioo32GPrGnQJ3OlyyagsMn+0L
	DRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=wbutUEHiDnY+1UOL5egi53DpmgVeyPItuw68KzhACSo=;
	b=I9V+V1pke8UBWoY7VhhILjLSlwZDeUXIKGSYG659O3ZRQsKxSxlwUFVn528DNf5bDN
	XNrG6TV+yHNlVN9t3a4GFkrYc9NDjJj4ehcznOh2tU7IaYXERZet3s4m0MERFvNIiwbb
	auebaWnW2pJzQtYEcfnVpp4g7UGkYty0K9QEhPUikqI/11kxrqVTAXgpJn+MvMh7XnMQ
	JwUX2JxnNM8zT6w8+3vD+AzJ7VJRPWPhOMJ1g9fQsSt5I7EAASTb1SXJRuZpVGe6gQYA
	Xfrcp4X9tLh8DNJEHfHI32mCzbr1KDHw9vCbZ7CoVaYE0JOqWZyVyAS52YPYZtjNS5iU
	oSDw==
X-Gm-Message-State: AOPr4FUSOLH4ilObEaXN2NEBcMxdnNI+XwC+VI4W5IDLLJQsXi+n2Ut/Q6BLzERMHgViiU6q1rLSSYe84ZA+zw==
X-Received: by 10.50.58.166 with SMTP id s6mr261729igq.13.1463094751902; Thu,
	12 May 2016 16:12:31 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Thu, 12 May 2016 16:12:12 -0700 (PDT)
In-Reply-To: <b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
	<4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
	<b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Thu, 12 May 2016 16:12:12 -0700
X-Google-Sender-Auth: y908b8q8zJjZoq5w5WlF4l4dBRY
Message-ID: <CABcZAN=Fmp0rTvVy9sEifLqHRtR0dDnsPox5xvmksww7aPop3Q@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [RFC master][PATCH 4/4] bitbake-layers: convert to plugin-based
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 12 May 2016 23:12:31 -0000
Content-Type: multipart/alternative; boundary=089e0103e870f5c3690532ad4a73

--089e0103e870f5c3690532ad4a73
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 12:41 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This uses bb.utils.load_plugins, based on the plugin handling in recipetool
> and devtool in oe-core.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  bin/bitbake-layers                 | 1065
> ++----------------------------------
>  bitbake/lib/bblayers/__init__.py   |    2 +
>  bitbake/lib/bblayers/action.py     |  233 ++++++++
>  bitbake/lib/bblayers/common.py     |   33 ++
>  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
>  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
>  6 files changed, 1097 insertions(+), 1005 deletions(-)
>  create mode 100644 bitbake/lib/bblayers/__init__.py
>  create mode 100644 bitbake/lib/bblayers/action.py
>  create mode 100644 bitbake/lib/bblayers/common.py
>  create mode 100644 bitbake/lib/bblayers/layerindex.py
>  create mode 100644 bitbake/lib/bblayers/query.py
>

Was this patch not applied for a specific reason, or just needs more time
for review, or waiting until after python3 is merged?
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0103e870f5c3690532ad4a73
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Apr 30, 2016 at 12:41 PM, Christopher Larson <span dir=3D"ltr">&lt;=
<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1pe" clas=
s=3D"a3s aXjCH m15468b0655a69309">From: Christopher Larson &lt;<a href=3D"m=
ailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
This uses bb.utils.load_plugins, based on the plugin handling in recipetool=
<br>
and devtool in oe-core.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;<br>
---<br>
=C2=A0bin/<span class=3D"il">bitbake</span>-<span class=3D"il">layers</span=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1065 ++---=
-------------------------------<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/bblayers/__init__.py=C2=A0 =C2=
=A0|=C2=A0 =C2=A0 2 +<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/bblayers/action.py=C2=A0 =C2=A0=
 =C2=A0|=C2=A0 233 ++++++++<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/bblayers/common.py=C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A033 ++<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/bblayers/layerindex.py |=C2=A0 =
270 +++++++++<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/bblayers/query.py=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 499 +++++++++++++++++<br>
=C2=A06 files changed, 1097 insertions(+), 1005 deletions(-)<br>
=C2=A0create mode 100644 <span class=3D"il">bitbake</span>/lib/bblayers/__i=
nit__.py<br>
=C2=A0create mode 100644 <span class=3D"il">bitbake</span>/lib/bblayers/act=
ion.py<br>
=C2=A0create mode 100644 <span class=3D"il">bitbake</span>/lib/bblayers/com=
mon.py<br>
=C2=A0create mode 100644 <span class=3D"il">bitbake</span>/lib/bblayers/lay=
erindex.py<br>
=C2=A0create mode 100644 <span class=3D"il">bitbake</span>/lib/bblayers/que=
ry.py</div></blockquote></div><br>Was this patch not applied for a specific=
 reason, or just needs more time for review, or waiting until after python3=
 is merged?<br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Chris=
topher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedde=
d, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Gra=
phics</div></div>
</div></div>

--089e0103e870f5c3690532ad4a73--
