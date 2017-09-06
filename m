Return-Path: <kergoth@gmail.com>
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com
	[209.85.217.174])
	by mail.openembedded.org (Postfix) with ESMTP id 9700E77CD8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 15:20:14 +0000 (UTC)
Received: by mail-ua0-f174.google.com with SMTP id l24so14435647uaa.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Sep 2017 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=6LRGrIRhsUP/gsg3B0ZUVChM7MsGI7cutw1VJf+u3uo=;
	b=tNaXRE6b5/YnuXmbJ+qnL2g8QZF/d8tZHgpZyrpoz6r42Qjo4ej/oDybb+tfexJZj/
	GY/PRBtWRu6jde8hFK/cXCg+5QMDTAgUiqjDQHXT1X7RR++PMHC5R9YhF67o4U1wK2QH
	N0JumUSGjV6hjnoWIvCbTqv2sjrATT5WHnpYPIVSzvaRwtwlVBSyftCW4qjD7Q/On2Kk
	10DsRGFoxwlo4tX1tPNATd29z33zVvQAEaNxVE78wQYsADfijfPUr6iiQIetHH9Ue4tR
	4uLebd/ydi7CQXnAXXyMCfytYOsvuay2n5xmtrXNvwR6mX42FawAiQ/qBqdEFtIJRl4w
	Ex9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=6LRGrIRhsUP/gsg3B0ZUVChM7MsGI7cutw1VJf+u3uo=;
	b=K+kInLUfEXMHz4cJ8KBXVwFbE7hRbiDXey7/ET3v3/iF4BmyhnsnnqinHM3EHIaF8F
	pElIJspu9IEuoBziS5KR4eCX91MA/CU3ajre5dELwqpMvJmcs8ZvzjIaGJS4I0ztgyN9
	AZEG/3yM6wZsDadga+kUvoUbj+fHME98QvOb41qpXQowwUidxgXwailaoebxEGoDX7Sb
	d6TqTRKWLY1kfkdRRn5lq8cAEuuh1ImUZifu1dUV+xzappDiDlqZFvs6h/YZ6Jr82ikG
	+F3OzvPikq4rv6m+qiT2wEsI++I1rGIxyJnv1Lpzp14BYEAdjMg4lR/26fKAe5lEszwX
	1gLg==
X-Gm-Message-State: AHPjjUhHF70qVTpMpqlYyW48pyrOffqEfkQziru36qMuLhCZsMGToBsr
	vlxRRX+LrM4lkYEIhNmtZEz+6uPTHA==
X-Google-Smtp-Source: ADKCNb6vn/vlXr6aTzuB2bU2yoNbjWXzEersobCBQ5HrHaV92Wh9zmjkJjCTEAWDw3urRNhLrFGvhqfStIlj01A9eW4=
X-Received: by 10.159.60.9 with SMTP id u9mr1603666uah.122.1504711215824; Wed,
	06 Sep 2017 08:20:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.18.67 with HTTP; Wed, 6 Sep 2017 08:19:55 -0700 (PDT)
In-Reply-To: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 6 Sep 2017 08:19:55 -0700
Message-ID: <CABcZANk9n=tSdGFuWzJRJa8GRWBxLGFvugP_3vFW2HUVC7+=kA@mail.gmail.com>
To: Mikko Rapeli <mikko.rapeli@bmw.de>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 1/2] gitsm.py: use download cache for git submodules too
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
X-List-Received-Date: Wed, 06 Sep 2017 15:20:14 -0000
Content-Type: multipart/alternative; boundary="f403043ee0788249f7055886e159"

--f403043ee0788249f7055886e159
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli <mikko.rapeli@bmw.de> wrote:

> Currently download caches for recipes using gitsm are filled also with
> the submodule repositories but when the git submodule tree is reused from
> cache, only the base repository is cloned. After a source URL rewrite,
> 'git submodule update --init --recursive' is called in the tree
> which downloads the needed submodules from upstream URL's.
> This wastes bandwidth since download cache already had the needed
> commits for the submodule repositories.
>
> With this change, also the submodule repositories are copied to the
> work space from download cache and the download from upstream can
> be avoided. Using plain 'cp -a' since git cloning doesn't work for the
> submodule directories.
>

This behavior is both already tracked by a yocto bug, and blindly copying
will result in breakage when the branch changes in such a way that the
submodules change. I already submitted an equivalent patch a week or two
ago and then decided against its inclusion, as it just runs into other
failures, specifically there was an oe-selftest that fails if you had
previously fetched a different branch of the sources in question, as the
upstream url of one of the submodules changes between branches, and we
don=E2=80=99t re-fetch existing submodules when their urls change. We defin=
itely
need to fix this, but this fixes one problem and introduces others.

See https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11830 and
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11831 for reference.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--f403043ee0788249f7055886e159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli <span dir=3D"=
ltr">&lt;<a href=3D"mailto:mikko.rapeli@bmw.de" target=3D"_blank">mikko.rap=
eli@bmw.de</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex"><span class=3D"gmail-">Currently download=
 caches for recipes using gitsm are filled also with<br>
the submodule repositories but when the git submodule tree is reused from<b=
r>
cache, only the base repository is cloned. After a source URL rewrite,<br>
&#39;git submodule update --init --recursive&#39; is called in the tree<br>
which downloads the needed submodules from upstream URL&#39;s.<br>
This wastes bandwidth since download cache already had the needed<br>
commits for the submodule repositories.<br>
<br>
With this change, also the submodule repositories are copied to the<br>
work space from download cache and the download from upstream can<br>
be avoided. Using plain &#39;cp -a&#39; since git cloning doesn&#39;t work =
for the<br>
submodule directories.<br></span></blockquote><div><br></div><div>This beha=
vior is both already tracked by a yocto bug, and blindly copying will resul=
t in breakage when the branch changes in such a way that the submodules cha=
nge. I already submitted an equivalent patch a week or two ago and then dec=
ided against its inclusion, as it just runs into other failures, specifical=
ly there was an oe-selftest that fails if you had previously fetched a diff=
erent branch of the sources in question, as the upstream url of one of the =
submodules changes between branches, and we don=E2=80=99t re-fetch existing=
 submodules when their urls change. We definitely need to fix this, but thi=
s fixes one problem and introduces others.</div><div><br></div><div>See=C2=
=A0<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11830">ht=
tps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11830</a> and=C2=A0<a hre=
f=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11831">https://bug=
zilla.yoctoproject.org/show_bug.cgi?id=3D11831</a> for reference.</div></di=
v>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"l=
tr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, Op=
enEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></=
div></div></div>
</div></div>

--f403043ee0788249f7055886e159--
