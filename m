Return-Path: <patrickvacek@gmail.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id C10AB7C3A2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 12:07:39 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id m1so9179050wml.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 04:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=GyaIMk+zKgHqSlOxW/TtcXIIcQy5py3HCtwxetFXdTw=;
	b=GU0zUEraSomPt1Va/3SPEDhxrJaaK9KCvuhzsH5/pwZ/ObasXTvVxvWdvLarCm451H
	1m/ukR89I30q8OAmFLft4j6P23h/2y2PWed5UB4TfF/kcDkiog4wEjoK5T+VqRtopQjb
	Ze4xfvrwDZOFZmt8Zh0sOPnZd+0WOcvvqOmKtrK1tE/IuVIq0wSr4NvcoDOjWwE6dsJw
	vVcyrvMfsOIUl90rIPv+RieyP/6RUr5ebex5jghHSRdGz1zVgl26UdYgxzbMdFaQqs/C
	B6C3OeL4fQ9z7G3viBxoBu1BiiqiCSn/pcdGwFX98gkMHAWAfSvFw4x9myD1tJSGsUKW
	gYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=GyaIMk+zKgHqSlOxW/TtcXIIcQy5py3HCtwxetFXdTw=;
	b=OhW67TdhE3D7/fYAzsc5yyGlec/O9+Pp7VBMW97InwsAVwuttrwbmuUSLlucHP5Dc1
	v6hyUrVftBJ73/puj0EEuV+z6/fKZj6NJQHeh2xRuknCnOC2xcRz3nhfOVU0/1jK9+IR
	T1/dY2SEBGzvIcYuv2VEQj0tqvGO8Vg11JS+Z13WLX3ETWBzicwPVHt9SF9Q4ff9N8WU
	wEbvxpjhQp/5Y1trVX2wKZhxJWO5vWYdwNqd28/SXOhAvaVszdwPyEfze9h0YZULo+sA
	N1Wg5ahu2otBRagL1J1JWgtT3O76ElXqWHUC++5atZuJ2Db2lOcoEJ0LARxSU5ioY0kf
	AF6A==
X-Gm-Message-State: AJcUukeYeOcAPknz+94IRVQjH1cY9u+3L0OuEElFLZnXVyGxo0fBI02Y
	prhZaBonoNiw2zDV3CEvTYfuGVhQdZ5PrXOJOIY=
X-Google-Smtp-Source: ALg8bN4iUHNmdg/tOhFs9rHCsdZvK/vL1/oKvB7zuAKzc3Yxsg+9GRk1elciY6JMH+88ixLou7F29JFW+2SMvxeJPOs=
X-Received: by 2002:a1c:d00d:: with SMTP id h13mr10021768wmg.13.1548504460291; 
	Sat, 26 Jan 2019 04:07:40 -0800 (PST)
MIME-Version: 1.0
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
In-Reply-To: <3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
From: Patrick Vacek <patrickvacek@gmail.com>
Date: Sat, 26 Jan 2019 13:07:29 +0100
Message-ID: <CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
To: Stefan Agner <stefan@agner.ch>
X-Mailman-Approved-At: Sat, 26 Jan 2019 13:45:59 +0000
Cc: stefan.agner@toradex.com, luka.pivk@toradex.com, liu.ming50@gmail.com,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Sat, 26 Jan 2019 12:07:40 -0000
Content-Type: multipart/alternative; boundary="00000000000049f99305805b4a2f"

--00000000000049f99305805b4a2f
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner <stefan@agner.ch> wrote:

> > So it seems to be that something in the recipe was expecting semi-broken
> > behavior.. and its actually a recipe problem.
>
> Agreed, in this case we need to fix the recipe.
>
Sorry, I must be missing something. What might be wrong with the recipe? Is
there more that needs to be specified than a SRCREV and a branch? As far as
I understand git, it keeps track of the submodules, so I don't know what
other information there would be to provide. The reason this particular
case is difficult is because there are recursive submodules. When we build
aktualizr, we have to be careful to specify that. See
https://github.com/advancedtelematic/aktualizr#building:

git submodule update --init --recursive

Thanks,
Patrick

--00000000000049f99305805b4a2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Sat,=
 Jan 26, 2019 at 11:15 AM Stefan Agner &lt;<a href=3D"mailto:stefan@agner.c=
h">stefan@agner.ch</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt; So it seems to be that something in the recipe was expecting semi-brok=
en<br>
&gt; behavior.. and its actually a recipe problem.<br>
<br>
Agreed, in this case we need to fix the recipe.<br></blockquote><div>Sorry,=
 I must be missing something. What might be wrong with the recipe? Is there=
 more that needs to be specified than a SRCREV and a branch? As far as I un=
derstand git, it keeps track of the submodules, so I don&#39;t know what ot=
her information there would be to provide. The reason this particular case =
is difficult is because there are recursive submodules. When we build aktua=
lizr, we have to be careful to specify that. See=C2=A0<a href=3D"https://gi=
thub.com/advancedtelematic/aktualizr#building">https://github.com/advancedt=
elematic/aktualizr#building</a>:</div><div><br></div><div><div>git submodul=
e update --init --recursive</div></div><div><br></div><div>Thanks,</div><di=
v>Patrick</div></div></div></div></div>

--00000000000049f99305805b4a2f--
