Return-Path: <avery.brian@gmail.com>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
	[209.85.213.46])
	by mail.openembedded.org (Postfix) with ESMTP id 01DD370034
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 21:19:26 +0000 (UTC)
Received: by mail-vk0-f46.google.com with SMTP id w194so23370570vkw.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=1L2HDhHJrdKgE0YFaKiqvOwemelz7McVqsKjluMYUMM=;
	b=LsvFL/enw1oAF6CfxjaXxWwejF14dQVJxLbodHWuce9FHaa2raFVo6W0IzuwGsuAbK
	he3cgnr9g9OquJh/2hQ/jCLJvnG27huTz3HD03iSnuMrQ6rr1sOfiWHJQogbrd6c3qUG
	xk19Led/UnBpM5DcIQbPl2SuQrLkjOhzQ5/t5YuvdclL/HrxPPY5OL+8RLjOUW7QMlEA
	D1i2nWrTPcCK9JifsgnxqySLvJzp1EpxuS2RG11g6QJ2XEsu964w5elJVfwubJaXtzzG
	12TBvwTrn4zQUyjGe+ct0ht7820ify46AoI8KDhiiEJq0RJPa4QJfyxRXueiiHzAkdUa
	giaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=1L2HDhHJrdKgE0YFaKiqvOwemelz7McVqsKjluMYUMM=;
	b=UufjzxgXMyBsFPEgbCH7IWbWiEjEAaVepnqdZeouoyD5pkXvIcA70LUgWw/9Aq1pvi
	x4O2NBDbIGEwqMWIRCeKBnkv8k+8HkteuUTwIiEuxSFd2+6+uMNoLBpz0YdqXVn1vP6Z
	X37xK4ETQxarosRQUlQXjy0qqKGJyfQNLNzsfNgMJCUnvCNdE6RqaOKNK5hkkcggyCpq
	3E+FZiHz1g1EUoamvE+GyoomZkwSk50G34s8TEgz+1O3qR+yLiCk40ASEpS0pX7K10lv
	hm4w5BxwOOaOYs9gS6xVaVaXylzILaNMr+gZjRcpyzU7Zf0PIV/14+l27N5b9FXfIGp1
	uJ4A==
X-Gm-Message-State: AKaTC01Cu8dPLdOiWjIiYwGnV3WUTnON8VllYgMlLRyTNdtreuZ0g5A9H8IS+UzwL1FdTMKWZszZbtvqb6flyg==
X-Received: by 10.31.236.7 with SMTP id k7mr11570231vkh.96.1479849567746; Tue,
	22 Nov 2016 13:19:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.67.72 with HTTP; Tue, 22 Nov 2016 13:19:27 -0800 (PST)
In-Reply-To: <cover.1478749786.git.brian.avery@intel.com>
References: <cover.1478749786.git.brian.avery@intel.com>
From: Brian Avery <avery.brian@gmail.com>
Date: Tue, 22 Nov 2016 13:19:27 -0800
Message-ID: <CAKV_0ejdeTDQ6qvujS=8WC_nCCfgvoxVdwva12r_E1k+uRoTtg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: brian avery <brian.avery@intel.com>
Subject: Re: [PATCH 0/3] toaster: add master branch back into new project options
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
X-List-Received-Date: Tue, 22 Nov 2016 21:19:27 -0000
Content-Type: multipart/alternative; boundary=94eb2c09617cce7f010541ea5340

--94eb2c09617cce7f010541ea5340
Content-Type: text/plain; charset=UTF-8

ohana.  Did this get left behind or forgotten?  It would be nice for
toaster to be able to build from master again :),
-brian
an intel employee



On Wed, Nov 9, 2016 at 7:52 PM, brian avery <avery.brian@gmail.com> wrote:

> This patch adds master to the oe and poky fixtures so that a new project
> can be
> based on morty or the master branch.
>
> It also has an fix for lsupdates to support the layers in fixtures
> definition.
>
> -Brian
> an intel employee
>
> The following changes since commit 065310e77ab4c8c914c53ff43d5e60
> 1ebf9468b5:
>
>   toaster: settings set ALLOWED_HOSTS to * in debug mode (2016-11-09
> 16:28:17 -0800)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib bavery/submit/toaster/mw-
> masterproj-11-2016
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
> bavery/submit/toaster/mw-masterproj-11-2016
>
> Michael Wood (3):
>   toaster: settings fixture Set default release to master
>   toaster: orm/fixtures Add the master release and correct morty release
>   toaster: layerindex updater Take into account layers being predefined
>
>  lib/toaster/orm/fixtures/oe-core.xml             | 23 ++++++-
>  lib/toaster/orm/fixtures/poky.xml                | 82
> ++++++++++++++++++++++--
>  lib/toaster/orm/fixtures/settings.xml            |  2 +-
>  lib/toaster/orm/management/commands/lsupdates.py | 60 ++++++-----------
>  4 files changed, 116 insertions(+), 51 deletions(-)
>
> --
> 1.9.1
>

--94eb2c09617cce7f010541ea5340
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ohana.=C2=A0 Did this get left behind or forgotten?=C2=A0 =
It would be nice for toaster to be able to build from master again :),<div>=
-brian</div><div>an intel employee</div><div><br></div><div><br></div></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Nov 9, 2=
016 at 7:52 PM, brian avery <span dir=3D"ltr">&lt;<a href=3D"mailto:avery.b=
rian@gmail.com" target=3D"_blank">avery.brian@gmail.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">This patch adds master to the oe and p=
oky fixtures so that a new project can be<br>
based on morty or the master branch.<br>
<br>
It also has an fix for lsupdates to support the layers in fixtures definiti=
on.<br>
<br>
-Brian<br>
an intel employee<br>
<br>
The following changes since commit 065310e77ab4c8c914c53ff43d5e60<wbr>1ebf9=
468b5:<br>
<br>
=C2=A0 toaster: settings set ALLOWED_HOSTS to * in debug mode (2016-11-09 1=
6:28:17 -0800)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" rel=3D"no=
referrer" target=3D"_blank">git.yoctoproject.org/<wbr>poky-contrib</a> bave=
ry/submit/toaster/mw-<wbr>masterproj-11-2016<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dbavery/submit/toaster/mw-masterproj-11-2016" rel=3D"noreferrer" target=
=3D"_blank">http://git.yoctoproject.org/<wbr>cgit.cgi/poky-contrib/log/?h=
=3D<wbr>bavery/submit/toaster/mw-<wbr>masterproj-11-2016</a><br>
<br>
Michael Wood (3):<br>
=C2=A0 toaster: settings fixture Set default release to master<br>
=C2=A0 toaster: orm/fixtures Add the master release and correct morty relea=
se<br>
=C2=A0 toaster: layerindex updater Take into account layers being predefine=
d<br>
<br>
=C2=A0lib/toaster/orm/fixtures/oe-<wbr>core.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 23 ++++++-<br>
=C2=A0lib/toaster/orm/fixtures/poky.<wbr>xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 82 ++++++++++++++++++++++--<br>
=C2=A0lib/toaster/orm/fixtures/<wbr>settings.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0lib/toaster/orm/management/<wbr>commands/lsupdates.py | 60 ++++++----=
-------<br>
=C2=A04 files changed, 116 insertions(+), 51 deletions(-)<br>
<br>
--<br>
1.9.1<br>
</blockquote></div><br></div>

--94eb2c09617cce7f010541ea5340--
