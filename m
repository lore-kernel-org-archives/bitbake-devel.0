Return-Path: <elliot.smith@intel.com>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
	[209.85.161.177])
	by mail.openembedded.org (Postfix) with ESMTP id C13B66FF78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 13:51:04 +0000 (UTC)
Received: by mail-yw0-f177.google.com with SMTP id u134so15717151ywg.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=KG4NTJUAnh4D9IQzZJV/GZUKLYN3iX8m1/ZRXszwfis=;
	b=UCkRuuqCIu3BcdsEEBvXjvXtjEHPF2FZ1q5jUDopWPAmAcFWCm0TdQWRbrFjTMHOK4
	HA5HHZviV+aKGxsxAjbtBwaeV9nEY4InGqPjMjgABD9iqeCZ9qpPGHPEV74nopzh82wE
	v5l1BwVK0ETdUbAn1tYQJvKBgxA5JmI7NspyCOoK7vwHPkDqOhPbkaW3ZtmyA/A57GS3
	fBkJhZ87T9iNhS8URGZ6F1GV0KGO+GXcBBVAHMW1kZiR6XAffdSBKejDaIM+XsGjwMnA
	6hzd0dkS4KsAJAaiZQXWRmYDFy1GX1GmaLH7aVxK0igfxdqdGYRgYidqwojizxYZEj+c
	FG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=KG4NTJUAnh4D9IQzZJV/GZUKLYN3iX8m1/ZRXszwfis=;
	b=RYxc2KtjIdo9WDRaE8cQ1oxt2fdH042+Gd5z1hbIDSvJON8yWIJearu57W9YXQT91d
	QqMQgTvbygdpuxElREl47h1h0tXEt8NwG/F49Sj0MmRD1eItsA5Kf1MQtkzbuQ5LU7Qk
	ZKcEoujE5IbBkP9YNkK4Yp5/ilgl1whWmpsYdjYLpgfElAti8GPLAPpDnBw36blUvOrZ
	RoP3b6FN5HXUILoAx6Ys6XlVpOuw8yZe46DYDEeEJYrGEf+VA6yD+cZWE/j5yAUQk3iU
	b09SHJsCfS1Ex2iQqz2YL9R8poWEVS/mDnN7BPO60XmY8JIZU1Njc7nqZUJViQSDxbm/
	xWjw==
X-Gm-Message-State: ALyK8tKZUD2osOfvn4ugpsXia/hSTmF7viiRSsfz2txw+2sSxv6G6RtVVkbTD+SUywr32574fsmq1PEzYwjQTVde
X-Received: by 10.37.85.139 with SMTP id j133mr25133013ybb.32.1468936265286;
	Tue, 19 Jul 2016 06:51:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.111.5 with HTTP; Tue, 19 Jul 2016 06:51:04 -0700 (PDT)
In-Reply-To: <1468915119.14148.12.camel@linuxfoundation.org>
References: <1468578727-30368-1-git-send-email-elliot.smith@intel.com>
	<1468915119.14148.12.camel@linuxfoundation.org>
From: "Smith, Elliot" <elliot.smith@intel.com>
Date: Tue, 19 Jul 2016 14:51:04 +0100
Message-ID: <CA+1hgUhJBeD=EJWTvFQrJ6g0ziefaRwWRccYMOmxMW9ynDiWyg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] toaster-tests: add class SeleniumTestCaseBase for browser tests
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
X-List-Received-Date: Tue, 19 Jul 2016 13:51:08 -0000
Content-Type: multipart/alternative; boundary=001a113e7eaa4a87c60537fd6092

--001a113e7eaa4a87c60537fd6092
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19 July 2016 at 08:58, Richard Purdie <richard.purdie@linuxfoundation.or=
g
> wrote:

> On Fri, 2016-07-15 at 11:32 +0100, Elliot Smith wrote:
> > From: An=C3=ADbal Lim=C3=B3n <anibal.limon@linux.intel.com>
> >
> > In order to reuse the Selenium helper outside a Django
> > environment (for functional testing), add a new module
> > containing the base class SeleniumTestCaseBase, which only
> > inherits unittest.TestCase
> >
> > Add a class SeleniumTestCase with multiple inheritance of
> > StaticLiveServerTestCase and SeleniumTestCaseBase to prevent
> > existing tests from breaking.
> >
> > Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linux.intel.com>
> > Signed-off-by: Elliot Smith <elliot.smith@intel.com>
>
> Could someone rebase this against master please? I merged Brian/Ed's
> larger series and I think this has conflicts with it.
>

I'll do it.

Cheers.
Elliot


>
> Cheers,
>
> Richard
>



--=20
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a113e7eaa4a87c60537fd6092
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 1=
9 July 2016 at 08:58, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linu=
xfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an class=3D"">On Fri, 2016-07-15 at 11:32 +0100, Elliot Smith wrote:<br>
&gt; From: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal.limon@linux.=
intel.com">anibal.limon@linux.intel.com</a>&gt;<br>
&gt;<br>
&gt; In order to reuse the Selenium helper outside a Django<br>
&gt; environment (for functional testing), add a new module<br>
&gt; containing the base class SeleniumTestCaseBase, which only<br>
&gt; inherits unittest.TestCase<br>
&gt;<br>
&gt; Add a class SeleniumTestCase with multiple inheritance of<br>
&gt; StaticLiveServerTestCase and SeleniumTestCaseBase to prevent<br>
&gt; existing tests from breaking.<br>
&gt;<br>
&gt; Signed-off-by: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal.lim=
on@linux.intel.com">anibal.limon@linux.intel.com</a>&gt;<br>
&gt; Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.c=
om">elliot.smith@intel.com</a>&gt;<br>
<br>
</span>Could someone rebase this against master please? I merged Brian/Ed&#=
39;s<br>
larger series and I think this has conflicts with it.<br></blockquote><div>=
<br></div><div>I&#39;ll do it.</div><div><br></div><div>Cheers.</div><div>E=
lliot</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv>Elliot Smith<br>Software Engineer<br>Intel Open Source Technology Centre=
</div></div></div>
</div></div>

--001a113e7eaa4a87c60537fd6092--
