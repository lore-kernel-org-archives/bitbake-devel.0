Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
	[209.85.213.196])
	by mail.openembedded.org (Postfix) with ESMTP id DEB70601D3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 23:22:34 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id jn6so202404igb.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=x7h8cxPlMSO0nFFbDnFOuB+/uaZGs7zP6MbPvX4LWm0=;
	b=Pi2fASNnguKaQD5VCnuFWan4UW4rmT/b8HuESZh2Xa5/EuhlO4mMnW54fefO4A0K0q
	eE0DwQE9xqtz0jM5BT9HmDteeIVcAr1515nVTrFvB2EsaxmpODLy33qeQmX3kg7lDM1q
	hp9hcmJaYLyKNg5qnGutZGacIPyoaDNrgX1DGPchZDhBQhpOBFiR0RC8V/xdcOTnEMqe
	poWTe8mkdaZm4+JnD1TKg8YDMU0wvWXoWDRdNeTRDYpG6HzYnAiEt18OIcMhjMCbGA/i
	BZ9O/irjVLjKKQnue6LrkcSGu2vgCf9Fc4M1LKsvP4kL6luS465ePGeKk6xEo2lb6NeQ
	gsWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mentor-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=x7h8cxPlMSO0nFFbDnFOuB+/uaZGs7zP6MbPvX4LWm0=;
	b=EXIm3BGP28et1afOjLJEt/oNFQ3hySprSOxFu2pOIO75d5uQZC42VkYRqrWAFYWnO8
	PQPn8BqQJIGYM9DPUIaXosa7BT5T0PJ0S9spxAjO8TGTPIt1IA9VgpLm6itDGHhO8Lpi
	nLQ6ubq+mNIBIuhhN3YHOpkOaqbFf0i6fv5DKqBp3MbhKpEXhid4J8NlEAXEi7naay8F
	6YghgMwt7DgEp24cdNuT6SkAwpaXXQoS6qBNs1vdKQvhpVCaWHZONA04N8EoxsLjAVe9
	25jCJxIuEFdb6Q6EaCr5RHcuTZJdNrdzCsVmdDeIlzvPQa2uLa4R18S2Odsr7sEs+ADn
	YyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=x7h8cxPlMSO0nFFbDnFOuB+/uaZGs7zP6MbPvX4LWm0=;
	b=WCN8FcOuyojzoy3QL4hBNy9UYqjVNP4InXDItptcZEes7OXq3ICo50x1iwc4xW3FgY
	Ju4FPu6ZiX7EYdEDKJ3LB6Qr+8uVgPWLJDDcNgYEU/HJgSxbZBb7X4MsaCQK3V2nMPlO
	Vw1giDDMz/WJo5XwMVh+4XTw/xL1YhGLaT41T9aUqIWXNyotg919Dy5E86RM/p/lXf8I
	Bo77hfpES6z+rEvlXG3eYAWyKu+IcbxQlATgcr5y4TAW+rGkEGnYY3hHVsPn8A2T0Mu1
	TFf59vBX1rG2JoGNIGZuDCvdyoRZbshj0s3igYLfNnXqnLW72IRWGXPaKN78Tt1cPAyl
	6orw==
X-Gm-Message-State: AOPr4FUvFPzh/gO4XS6JNeYGk64PXB2P+8XOr/WPEWsOzmiFVVp7XTjRxSNDkqqFsst7qlyv4EERj0hoU4wrUA==
X-Received: by 10.50.29.76 with SMTP id i12mr247560igh.87.1463095355236; Thu,
	12 May 2016 16:22:35 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Thu, 12 May 2016 16:22:15 -0700 (PDT)
In-Reply-To: <1463095254.9746.61.camel@linuxfoundation.org>
References: <cover.1462041562.git.chris_larson@mentor.com>
	<4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
	<b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
	<CABcZAN=Fmp0rTvVy9sEifLqHRtR0dDnsPox5xvmksww7aPop3Q@mail.gmail.com>
	<1463095254.9746.61.camel@linuxfoundation.org>
From: Christopher Larson <chris_larson@mentor.com>
Date: Thu, 12 May 2016 16:22:15 -0700
X-Google-Sender-Auth: LNVMOXnsY1m-Ou10YucaDsQSr0g
Message-ID: <CABcZANkgjQRgahkKd+GoLw4h-8dXs=b9+sVTPHn0Ep3ZFTQw3A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Eggleton,
	Paul" <paul.eggleton@intel.com>
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
X-List-Received-Date: Thu, 12 May 2016 23:22:35 -0000
Content-Type: multipart/alternative; boundary=047d7bd75984ebe9d80532ad6e39

--047d7bd75984ebe9d80532ad6e39
Content-Type: text/plain; charset=UTF-8

On Thu, May 12, 2016 at 4:20 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2016-05-12 at 16:12 -0700, Christopher Larson wrote:
> > On Sat, Apr 30, 2016 at 12:41 PM, Christopher Larson <
> > kergoth@gmail.com> wrote:
> > > From: Christopher Larson <chris_larson@mentor.com>
> > >
> > > This uses bb.utils.load_plugins, based on the plugin handling in
> > > recipetool
> > > and devtool in oe-core.
> > >
> > > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > > ---
> > >  bin/bitbake-layers                 | 1065 ++----------------------
> > > ------------
> > >  bitbake/lib/bblayers/__init__.py   |    2 +
> > >  bitbake/lib/bblayers/action.py     |  233 ++++++++
> > >  bitbake/lib/bblayers/common.py     |   33 ++
> > >  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
> > >  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
> > >  6 files changed, 1097 insertions(+), 1005 deletions(-)
> > >  create mode 100644 bitbake/lib/bblayers/__init__.py
> > >  create mode 100644 bitbake/lib/bblayers/action.py
> > >  create mode 100644 bitbake/lib/bblayers/common.py
> > >  create mode 100644 bitbake/lib/bblayers/layerindex.py
> > >  create mode 100644 bitbake/lib/bblayers/query.py
> > >
> > Was this patch not applied for a specific reason, or just needs more
> > time for review, or waiting until after python3 is merged?
>
> The other pieces were straightforward so I merged them. I meant to ask
> Paul for an Acked-by on this piece as he'd done more work on the plugin
> based tools than I have but then I got distracted, sorry. Paul is
> cc'd...
>

Not a problem, just wanted to make sure it didn't slip through the cracks :)
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bd75984ebe9d80532ad6e39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, May 12, 2016 at 4:20 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span class=3D"">On Thu, 2016-05-12 at 16:12 -0700, Christopher Lar=
son wrote:<br>
&gt; On Sat, Apr 30, 2016 at 12:41 PM, Christopher Larson &lt;<br>
&gt; <a href=3D"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&gt; wrote:<=
br>
&gt; &gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mento=
r.com">chris_larson@mentor.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; This uses bb.utils.load_plugins, based on the plugin handling in<=
br>
&gt; &gt; recipetool<br>
&gt; &gt; and devtool in oe-core.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_lar=
son@mentor.com">chris_larson@mentor.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 bin/bitbake-layers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 1065 ++----------------------<br>
&gt; &gt; ------------<br>
&gt; &gt;=C2=A0 bitbake/lib/bblayers/__init__.py=C2=A0 =C2=A0|=C2=A0 =C2=A0=
 2 +<br>
&gt; &gt;=C2=A0 bitbake/lib/bblayers/action.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
33 ++++++++<br>
&gt; &gt;=C2=A0 bitbake/lib/bblayers/common.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A033 ++<br>
&gt; &gt;=C2=A0 bitbake/lib/bblayers/layerindex.py |=C2=A0 270 +++++++++<br=
>
&gt; &gt;=C2=A0 bitbake/lib/bblayers/query.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4=
99 +++++++++++++++++<br>
&gt; &gt;=C2=A0 6 files changed, 1097 insertions(+), 1005 deletions(-)<br>
&gt; &gt;=C2=A0 create mode 100644 bitbake/lib/bblayers/__init__.py<br>
&gt; &gt;=C2=A0 create mode 100644 bitbake/lib/bblayers/action.py<br>
&gt; &gt;=C2=A0 create mode 100644 bitbake/lib/bblayers/common.py<br>
&gt; &gt;=C2=A0 create mode 100644 bitbake/lib/bblayers/layerindex.py<br>
&gt; &gt;=C2=A0 create mode 100644 bitbake/lib/bblayers/query.py<br>
&gt; &gt;<br>
&gt; Was this patch not applied for a specific reason, or just needs more<b=
r>
&gt; time for review, or waiting until after python3 is merged?<br>
<br>
</span>The other pieces were straightforward so I merged them. I meant to a=
sk<br>
Paul for an Acked-by on this piece as he&#39;d done more work on the plugin=
<br>
based tools than I have but then I got distracted, sorry. Paul is<br>
cc&#39;d...<br></blockquote></div><br>Not a problem, just wanted to make su=
re it didn&#39;t slip through the cracks :)<br>-- <br><div class=3D"gmail_s=
ignature"><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<b=
r>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Seni=
or Software Engineer, Mentor Graphics</div></div>
</div></div>

--047d7bd75984ebe9d80532ad6e39--
