Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id 8545177109
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:36:35 +0000 (UTC)
Received: by mail-ig0-f177.google.com with SMTP id qe5so58993109igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 15:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=gTGNWltEXIx9W72dgKnAO1FieEBtfHVXrl1aUhgBcoU=;
	b=aA+q7dxAXUrH0ftS67xg2GBCQoo38N1rnOeU2MGbA9vvxLU278qOyBIBVcZJPrEOY6
	IJ9xo8b3LxGZu6bZ2daLrHK3tcmRzu0HORvDg9C1fPD0TbdXULwGhlsDhyDTrdqeZnsI
	JhnBUSnuwl/kCdMH5xliFTTjNzusCnjKspXdmsf1ofb0kj2S67iEPqPKKOYdTZ3GBW/p
	S5XmmFYlSsBMTHbFUeBmRf6U9jLQ8+3nHWJSnnv4y1MZy0R/E0uamfcfEXJX5MaSkyUH
	3dSxCopAVMF0WusP9JTAu/dIdW5ap7THql2GHb2F7YQV1x9bIBlsVuNTSRwOjcohmvXw
	Uz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=gTGNWltEXIx9W72dgKnAO1FieEBtfHVXrl1aUhgBcoU=;
	b=CIiAJsV4HvneFS5E9FJHp1qG+R5PIJebE1whS5eVj1w/k6QttTnGTEZMwdxNUmZAQO
	wEL8nEKUJQhgjSCRQ7tXTHHaEc16xyrSUl3iAxxp3mpKUDD2lmPB0u0c8e/aiFw/2d4Y
	KbN6QPnE1CKv5hCy0W11etMvheUXS+vkYRFZ3YSGy/OshgBSvDkye8eHB4se9i5gcpxY
	LA1REP9kZRqp7Yd/1iHV8wcdnX1rGcC3iE0WOgabL1gkuzoH1A+sRJ2OPuLB6p/i8VU/
	SZdU1xXCN6mmoGrKy+XMQGOCuio98SYc1IUDspXarRrFUKxGgBpTloTVa7FEKlPtP3yz
	dtSw==
X-Gm-Message-State: AOPr4FVmJw/UUUWsWU4gGFcrAXWw052fTflU589MQixo/mwVqkrupniKPR1Gm75RjaX3o/sRVTC+aNOOIY1QOA==
X-Received: by 10.50.140.8 with SMTP id rc8mr11644294igb.20.1463438195630;
	Mon, 16 May 2016 15:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.70 with HTTP; Mon, 16 May 2016 15:36:16 -0700 (PDT)
In-Reply-To: <1463436362.4578.4.camel@linuxfoundation.org>
References: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
	<b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
	<1463436362.4578.4.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 16 May 2016 15:36:16 -0700
Message-ID: <CABcZANmG7O-oM_Ye-T9-A7ELL2GbyNzO82XpbU5cXxfTMD+rFw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 16 May 2016 22:36:35 -0000
Content-Type: multipart/alternative; boundary=e89a8f642ea0cd363f0532fd41d2

--e89a8f642ea0cd363f0532fd41d2
Content-Type: text/plain; charset=UTF-8

On Mon, May 16, 2016 at 3:06 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Sat, 2016-04-30 at 12:41 -0700, Christopher Larson wrote:
> > From: Christopher Larson <chris_larson@mentor.com>
> >
> > This uses bb.utils.load_plugins, based on the plugin handling in
> > recipetool
> > and devtool in oe-core.
> >
> > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > ---
> >  bin/bitbake-layers                 | 1065 ++------------------------
> > ----------
> >  bitbake/lib/bblayers/__init__.py   |    2 +
> >  bitbake/lib/bblayers/action.py     |  233 ++++++++
> >  bitbake/lib/bblayers/common.py     |   33 ++
> >  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
> >  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
>
> Sorry, one other question. Did you mean to create a bitbake/lib within
> the bitbake repo or should this just be lib/ ? I'm guessing the latter
> and have queued it in -next with that.


Yeah, you're right, sorry about that. Clearly I missed a `git am -p` when I
applied the commits I had in poky, so new files kept the old structure. I
didn't notice, since git found the existing files for me, so there were no
conflicts. Thanks.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--e89a8f642ea0cd363f0532fd41d2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, May 16, 2016 at 3:06 PM, Richard Purdie <span dir=3D"ltr">&lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.pu=
rdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><span class=3D"">On Sat, 2016-04-30 at 12:41 -0700, Christopher Larso=
n wrote:<br>
&gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com=
">chris_larson@mentor.com</a>&gt;<br>
&gt;<br>
&gt; This uses bb.utils.load_plugins, based on the plugin handling in<br>
&gt; recipetool<br>
&gt; and devtool in oe-core.<br>
&gt;<br>
&gt; Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@m=
entor.com">chris_larson@mentor.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bin/bitbake-layers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 1065 ++------------------------<br>
&gt; ----------<br>
&gt;=C2=A0 bitbake/lib/bblayers/__init__.py=C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<=
br>
&gt;=C2=A0 bitbake/lib/bblayers/action.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 233 ++=
++++++<br>
&gt;=C2=A0 bitbake/lib/bblayers/common.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
33 ++<br>
&gt;=C2=A0 bitbake/lib/bblayers/layerindex.py |=C2=A0 270 +++++++++<br>
&gt;=C2=A0 bitbake/lib/bblayers/query.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 499 ++=
+++++++++++++++<br>
<br>
</span>Sorry, one other question. Did you mean to create a bitbake/lib with=
in<br>
the bitbake repo or should this just be lib/ ? I&#39;m guessing the latter<=
br>
and have queued it in -next with that.</blockquote></div><br>Yeah, you&#39;=
re right, sorry about that. Clearly I missed a `git am -p` when I applied t=
he commits I had in poky, so new files kept the old structure. I didn&#39;t=
 notice, since git found the existing files for me, so there were no confli=
cts. Thanks.<br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Chri=
stopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedd=
ed, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Gr=
aphics</div></div>
</div></div>

--e89a8f642ea0cd363f0532fd41d2--
