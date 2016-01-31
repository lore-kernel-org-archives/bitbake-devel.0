Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 78C607720D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 17:03:38 +0000 (UTC)
Received: by mail-ig0-f180.google.com with SMTP id z14so19779367igp.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=euW3o/8AvFwQqJzowejIka9ee5R5sW1xehqSWXkLKls=;
	b=yNHIT7puIffEQcYWpp5GT6xEUvsOwm9HLdL73FZFU51UNlGA5/AfFltA7Aw/qL/rbw
	3x50j3pKrSFhMh9iko/Vlh5wvR1poG/mPJM7uYEO/RCMQBc2Ryc/Z0FSIZQUowCn5nJW
	mmsuZYk0hb+f5uJF4PTjQ6b/6eBMESGasnl0wVwF1HlnTzzdonEKorpmlv8afskY2NTM
	bnwSXRMT3ZFWqaRpXNAHUi8pyar+qqqML74QHdwkZIaj5/mCU59xYK2ujfFGrJ6ea8x1
	EvZq7dvGZPSc0/ITWWH1kYjb4/HNAJydDkoSeP2pHDLsYkB8MVhnSCjXgwIWsvWmB7W7
	0lHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=euW3o/8AvFwQqJzowejIka9ee5R5sW1xehqSWXkLKls=;
	b=fpugtnc2K1gJZnqHMGHMDHNKaEYcLXXX9CqdFcTQOaYoDi4ZK7AvR2NpooOaJqeB/U
	HwmyJS1zCgYgHdxdWgeSS0bd/fT9zqgTOhjM+h9o+duzOWLAUNkothndIrC5aGyFJRZB
	e2gBFo0/xQiI0a9LQzTxRiUVOJfatKWTRCbU9hyluMLJYBOgSLKe/2tKD5O0EJ7vFIcJ
	75GBJoO6CrRAnGyQFlEgPrRrIrp7jYSyJjDai7lNq2L7ADu8AXmo+J0vXBcVBRpDj5sX
	IExltPxX44lUOCq0XoAB2os93ORUNJfZDDPd7HJB89viAcPssXhxjtoJQaLeigJe3jVE
	Ff3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc:content-type;
	bh=euW3o/8AvFwQqJzowejIka9ee5R5sW1xehqSWXkLKls=;
	b=mznHRRBq1c7S/RVgEAvv6/PIf0VS26WwZnGG6S48nxevNrMX4MLPQkc1g1ZO9TjdUa
	CvORxGrni01GodwIuuABtzNri8+uIp005v02M5W35/A0BYZhkyN/z+gLcBZoAn9g6rkb
	GfydH5KAo3WacR3EUkiwqHikQ7ixq13JWAQRce3dhFEe9MG5Zc9jAZonp0QeyU3np6/A
	01wBx76H0JCs6RYOxepfSu7BlruLIqZEzha8ZqC6wBsXZzvjJCN6A05ZcTpc/qgccO65
	3MB8v3cA500aSCRfLoUoBt9PdzuiOddb7EPXPXVQWCqzBysK+MSVbmCOFrgUX+2AI8+7
	h40w==
X-Gm-Message-State: AG10YORi89/0FOrOpaLMT3CKe1J5hxqxPe+BqpINwZJpDUIjS2jq9FJPTDw/f+Dz9vZbkRxRdQ8l8vtYGH7Bog==
X-Received: by 10.50.132.40 with SMTP id or8mr812960igb.47.1454259819192; Sun,
	31 Jan 2016 09:03:39 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.91.133 with HTTP; Sun, 31 Jan 2016 09:03:19 -0800 (PST)
In-Reply-To: <1454065730.10340.64.camel@linuxfoundation.org>
References: <1454065730.10340.64.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Sun, 31 Jan 2016 10:03:19 -0700
X-Google-Sender-Auth: RP5umdt5HHV0Vch6x-pkJ5mIZEs
Message-ID: <CABcZAN=+4HozZSOcHEC0yD_5j3w9C=SEwyz1RpT_W12Htj1OiQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Set process names to be meaninful
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
X-List-Received-Date: Sun, 31 Jan 2016 17:03:38 -0000
Content-Type: multipart/alternative; boundary=047d7b162bfdef2727052aa43fae

--047d7b162bfdef2727052aa43fae
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 4:08 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> This means that when you view the process tree, the processes
> have meaningful names, aiding debugging:
>
> $ pstree -p 30021
> bash(30021)=E2=94=80=E2=94=80=E2=94=80KnottyUI(115579)=E2=94=80=E2=94=80=
=E2=94=80Cooker(115590)=E2=94=80=E2=94=AC=E2=94=80PRServ(115592)=E2=94=80=
=E2=94=80=E2=94=80{PRServ
> Handler}(115593)
>
> =E2=94=9C=E2=94=80Worker(115630)=E2=94=80=E2=94=80=E2=94=80bash:sleep(115=
631)=E2=94=80=E2=94=80=E2=94=80run.do_sleep.11(115633)=E2=94=80=E2=94=80=E2=
=94=80sleep(115634)
>                                                 =E2=94=94=E2=94=80{Proces=
sEQueue}(115591)
>
> $ pstree -p 30021
> bash(30021)=E2=94=80=E2=94=80=E2=94=80KnottyUI(117319)=E2=94=80=E2=94=80=
=E2=94=80Cooker(117330)=E2=94=80=E2=94=AC=E2=94=80Cooker(117335)
>                                                 =E2=94=9C=E2=94=80PRServ(=
117332)=E2=94=80=E2=94=80=E2=94=80{PRServ
> Handler}(117333)
>                                                 =E2=94=9C=E2=94=80Parser-=
1:2(117336)
>                                                 =E2=94=94=E2=94=80{Proces=
sEQueue}(117331)
>
> Applies to parse threads, PR Server, cooker, the workers and execution
> threads, working within the 16 character limit as best we can.
>
> Needed to tweak the bitbake-worker magic values to tell the
> workers apart.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

This is nice, but shouldn't we at least include 'bitbake' somewhere in the
process names? Will this interfere with the ability to use pkill/killall to
kill bitbake processes in cases where it's necessary?
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b162bfdef2727052aa43fae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jan 29, 2016 at 4:08 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":sf" class=3D"a3s" style=3D"overflow:hidden">This means =
that when you view the process tree, the processes<br>
have meaningful names, aiding debugging:<br>
<br>
$ pstree -p 30021<br>
bash(30021)=E2=94=80=E2=94=80=E2=94=80KnottyUI(115579)=E2=94=80=E2=94=80=E2=
=94=80Cooker(115590)=E2=94=80=E2=94=AC=E2=94=80PRServ(115592)=E2=94=80=E2=
=94=80=E2=94=80{PRServ Handler}(115593)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80Worker(115630)=E2=94=80=E2=94=80=E2=
=94=80bash:sleep(115631)=E2=94=80=E2=94=80=E2=94=80run.do_sleep.11(115633)=
=E2=94=80=E2=94=80=E2=94=80sleep(115634)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80{ProcessEQueue}(115591)<br>
<br>
$ pstree -p 30021<br>
bash(30021)=E2=94=80=E2=94=80=E2=94=80KnottyUI(117319)=E2=94=80=E2=94=80=E2=
=94=80Cooker(117330)=E2=94=80=E2=94=AC=E2=94=80Cooker(117335)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80PRServ(117332)=E2=94=80=E2=94=80=E2=
=94=80{PRServ Handler}(117333)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80Parser-1:2(117336)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80{ProcessEQueue}(117331)<br>
<br>
Applies to parse threads, PR Server, cooker, the workers and execution<br>
threads, working within the 16 character limit as best we can.<br>
<br>
Needed to tweak the <span class=3D"il">bitbake</span>-worker magic values t=
o tell the<br>
workers apart.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>This is nice, but shouldn&#39;t we at least include &#39;bitbake&#=
39; somewhere in the process names? Will this interfere with the ability to=
 use pkill/killall to kill bitbake processes in cases where it&#39;s necess=
ary?<br>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson=
 at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maint=
ainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--047d7b162bfdef2727052aa43fae--
