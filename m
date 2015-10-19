Return-Path: <elliot.smith@intel.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175])
	by mail.openembedded.org (Postfix) with ESMTP id 48F24770DF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Oct 2015 12:27:15 +0000 (UTC)
Received: by igbni9 with SMTP id ni9so53099471igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Oct 2015 05:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=7PV53/l1WL6MP30hK4Ch6lhyg5kF2oGULUBUwvdYkQI=;
	b=E0zI61SWSu64J0LcFrpRjiya90GUSN3qcKrSOcqpbta0V5DbyKEEv0j24XavCuUHut
	v1vsDeYxZ+jlYkR2TO9NnYzqAlTirpxlTaFRQL+8/Tsc4FBR08PyVL4NweWD6HLQQvNh
	8we5K4XuUcHhTxb8P2e+kO1FHowhDi05ZYQxQ5TnKozuh1GfE3U/y5gvizYjFoPASnOO
	SkXI0+Mcg2K/Vo8M5kh790e9KFMgjQJgegsx3f+NPU0ZjDNkaR4i46Ew8a8D/dJDPWT9
	6oYtL1lyZrXoQl39uhAuAEael5VTYc0KAxQJddyaRTyoRN/zvj/O2+zBAjkeYJGnzq3R
	r9jA==
X-Gm-Message-State: ALoCoQlBtt20UC4M3v6mgzcQEF84+y9HjG/QGqtsRD+8EhQRMqrcgSAvgC7sWF511zVnMEwr2/7S
MIME-Version: 1.0
X-Received: by 10.50.13.33 with SMTP id e1mr18138048igc.72.1445257635287; Mon,
	19 Oct 2015 05:27:15 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Mon, 19 Oct 2015 05:27:15 -0700 (PDT)
In-Reply-To: <1445011191.17974.34.camel@linuxfoundation.org>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
Date: Mon, 19 Oct 2015 13:27:15 +0100
Message-ID: <CA+1hgUg7=OhPXV=fHrXzLpSeWKZekx0BkYpu1BC8zaA1H7gG2w@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Mon, 19 Oct 2015 12:27:17 -0000
Content-Type: multipart/alternative; boundary=089e0112ccf0f5fb9b05227443fa

--089e0112ccf0f5fb9b05227443fa
Content-Type: text/plain; charset=UTF-8

On 16 October 2015 at 16:59, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2015-10-16 at 16:57 +0100, Smith, Elliot wrote:
> > On 11 October 2015 at 10:22, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> >         The console log data is written to is created at console
> >         initialisation
> >         time and does not change over reset events. This ensures the
> >         BB_CONSOLELOG value is correct over such resets by preserving
> >         it.
> >
> > I've put your three patches on top of master and ran a few builds. The
> > result is that all of the logs for those builds are going into a
> > single timestamped file. Before, they went to separate files. Is this
> > intentional, or was the old behaviour incorrect? (Ideally, toaster
> > needs a separate log file for each build.)
> >
> It should generate one log file for each "session". A session would be
> one logfile for all bitbake memory resident transactions and a log file
> for each commandline transaction.
>
> It is a "console log", not an individual build log.
>

Thanks for clarifying.

Will these patches be in 2.0? From the toaster point of view, it would be
better if the current behaviour remained for now, even though it is broken.

We are working on a solution which will write separate build logs from
within Toaster itself, which will mean we can keep our log download working
when your patches do go in.

However, we may not get this finished for 2.0, and it would be good if we
could keep the Toaster log download feature working in the meantime.

Thanks.
Elliot

-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--089e0112ccf0f5fb9b05227443fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 1=
6 October 2015 at 16:59, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@l=
inuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<span class=3D"">On Fri, 2015-10-16 at 16:57 +0100, Smith, Elliot wrote:<br=
>&gt; On 11 October 2015 at 10:22, Richard Purdie<br>
&gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purd=
ie@linuxfoundation.org</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The console log data is written to is=
 created at console<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0initialisation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time and does not change over reset e=
vents. This ensures the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BB_CONSOLELOG value is correct over s=
uch resets by preserving<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it.<br>
&gt;<br>
&gt; I&#39;ve put your three patches on top of master and ran a few builds.=
 The<br>
&gt; result is that all of the logs for those builds are going into a<br>
&gt; single timestamped file. Before, they went to separate files. Is this<=
br>
&gt; intentional, or was the old behaviour incorrect? (Ideally, toaster<br>
&gt; needs a separate log file for each build.)<br>
&gt;<br>
</span>It should generate one log file for each &quot;session&quot;. A sess=
ion would be<br>
one logfile for all bitbake memory resident transactions and a log file<br>
for each commandline transaction.<br>
<br>
It is a &quot;console log&quot;, not an individual build log.<br></blockquo=
te><div><br></div><div>Thanks for clarifying.</div><div><br></div><div>Will=
 these patches be in 2.0? From the toaster point of view, it would be bette=
r if the current behaviour remained for now, even though it is broken.</div=
><div><br></div><div>We are working on a solution which will write separate=
 build logs from within Toaster itself, which will mean we can keep our log=
 download working when your patches do go in.</div><div><br></div><div>Howe=
ver, we may not get this finished for 2.0, and it would be good if we could=
 keep the Toaster log download feature working in the meantime.</div><div><=
br></div><div>Thanks.</div><div>Elliot</div></div><div><br></div>-- <br><di=
v class=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software =
Engineer<br>Intel Open Source Technology Centre</div></div></div>
</div></div>

--089e0112ccf0f5fb9b05227443fa--
