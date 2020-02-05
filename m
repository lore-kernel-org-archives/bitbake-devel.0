Return-Path: <jpewhacker@gmail.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id 34EB860C96
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Feb 2020 14:02:03 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id c9so2853037wrw.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Feb 2020 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RajyAy+4pAQ/ChCmkcwzK5+AQLacHrxPa4TSJPcDip0=;
	b=nfsBhzOoY7EyYnGwGU97ncrYuEA1RXl5Sdnv45TTQi3riuBtysVUzyNBVOzE78ad8F
	ZvFY/oMtEAKzsoZrhgIUnaX1oQqnnQlO4GoX9ItPQa/5Sa1p1o5S9+iiRgMSNRecwvlC
	aJyXRtcMNh1ild+0QOGs7kBT+8Icb2d0bxflxGJbrlBe6KrYCWLmOoqBZrc5Cs0N1MD+
	vMZQgtC0mhhIYG4QzuXYvme9MAhfz2u2JlLf8+a1QcbbxD3Ec8Px0+kd0pDPt75rxD/y
	0f1pfT8fF4J+qq/moxMDz/9lKuHyhQacrp00sMSHKvbfVOyV6OjyDNs46ffXmilolhax
	ar6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RajyAy+4pAQ/ChCmkcwzK5+AQLacHrxPa4TSJPcDip0=;
	b=QAtYk21g3QW7xGMRtsLm5ESYuik53udRA3DQWsgsWjgOJ0x/K/R+uPbRxXl2d41YHl
	oZObS18GzwRzkAYuPfL4EH4EiUEHtxZuA5C1EyVM0rV9EU/v+6OH/Spq6d9m9t1abcmK
	T39iH5thtMZY0AVNTRFQlLVSTF6kPjOJcM6WcS+fXtMahIbkG0bFZWsVYybVBnFC0z8m
	JOTWBmjW4S4Kabw2Q+sHvOggLMU36yUGg5d8Bd+mZ9Jz0kCU81kTDr+QEMuzLJC7w6AA
	HD4NRrFmCwFbcZmoMxrwp7nW/fcc35KVgfILQej3jiexe1Q/Rpy5HNtIlRW5B3T4LDs0
	VFDQ==
X-Gm-Message-State: APjAAAW5bV/JWnhKHR5tlwfUgrHFqtS36kbXDqE0l6GY8OxfuJZ68+go
	1uRST3dsRWu5crOsmswRecSWHvwioxkE2Qz/Ag4kgw==
X-Google-Smtp-Source: APXvYqymEWQbH50XVRtLbkmQS40fetzKIp4xut6+SVlZ1A66kz9hxeVmFNM3lWhW9cbILFbse92OSSoJbdi4d4+SBO0=
X-Received: by 2002:a5d:4481:: with SMTP id j1mr28168045wrq.348.1580911323815; 
	Wed, 05 Feb 2020 06:02:03 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.2002050523360.1950893@localhost.localdomain>
	<CAJdd5GaxuOnQ_aWgn_tZABXs4LK+fOFMfpYN2jLCAohzO3f-KA@mail.gmail.com>
	<alpine.LFD.2.21.2002050856530.1960626@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2002050856530.1960626@localhost.localdomain>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 5 Feb 2020 08:01:50 -0600
Message-ID: <CAJdd5GbE0dzmAWSZagBigRAcEEPtoiUnUmompa-g6_RT2tT_xg@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: confused by multiconfig explanation in bitbake manual
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
X-List-Received-Date: Wed, 05 Feb 2020 14:02:03 -0000
Content-Type: multipart/alternative; boundary="000000000000e0a787059dd499b1"

--000000000000e0a787059dd499b1
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 5, 2020, 7:58 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:

> On Wed, 5 Feb 2020, Joshua Watt wrote:
>
> >
> >
> > On Wed, Feb 5, 2020, 4:26 AM Robert P. J. Day <rpjday@crashcourse.ca>
> wrote:
> >
> >         i've never defined a multiconfig build, but this section
> explaining
> >       it in the BB user manual seems confusing:
> >
> >       ///// start
> >
> >       The following statement in the local.conf file both enables
> BitBake to
> >       perform multiple configuration builds and specifies the two extra
> >       multiconfigs:
> >
> >            BBMULTICONFIG = "target1 target2"
> >
> >       Once the target configuration files are in place and BitBake has
> been
> >       enabled to perform multiple configuration builds, use the following
> >       command form to start the builds:
> >
> >            $ bitbake [mc:multiconfigname:]target
> [[[mc:multiconfigname:]target] ... ]
> >
> >       Here is an example for two extra multiconfigs: target1 and target2:
> >
> >            $ bitbake mc::target mc:target1:target mc:target2:target
> >
> >       ///// end
> >
> >         i don't understand the "mc::target" part of that last command,
> as it
> >       does not seem to be compatible with the definition of the general
> form
> >       of the command just above that, specifically:
> >
> >             $ bitbake [mc:multiconfigname:]target ...
> >
> >       can someone clarify this?
> >
> >
> > "target" is the recipe you want to build, just as you would have
> specified if you were not using a "mc:multiconfig:"
> > prefix. For examples:
> >
> >  # build core-image-minimal
> >  bitbake mc:my-mulitconfig:core-image-minimal
> >
> >  # build BusyBox
> >  bitbake mc:my-mulitconfig:busybox
> >
>   my confusion was with the example that started with the two colons:
>
>   $ bitbake mc::target ...
>
> the manual doesn't seem to explain the meaning of that "::" bit.
>

Ah sorry. I'm not sure. I've not seen that used much, if ever.

Based on the code, I would assume that's equivalent to just " bitbake
target", but I'm not positive.


> rday

--000000000000e0a787059dd499b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Feb 5, 2020, 7:58 AM Robert P. J. Day &lt;<a h=
ref=3D"mailto:rpjday@crashcourse.ca">rpjday@crashcourse.ca</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On Wed, 5 Feb 2020, Joshua Watt wrot=
e:<br>
<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Feb 5, 2020, 4:26 AM Robert P. J. Day &lt;<a href=3D"mailto:rp=
jday@crashcourse.ca" target=3D"_blank" rel=3D"noreferrer">rpjday@crashcours=
e.ca</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 i&#39;ve never defined a multiconfig =
build, but this section explaining<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0it in the BB user manual seems confusing:<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0///// start<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The following statement in the local.conf fi=
le both enables BitBake to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0perform multiple configuration builds and sp=
ecifies the two extra<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0multiconfigs:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0BBMULTICONFIG =3D &quot;=
target1 target2&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Once the target configuration files are in p=
lace and BitBake has been<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enabled to perform multiple configuration bu=
ilds, use the following<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0command form to start the builds:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0$ bitbake [mc:multiconfi=
gname:]target [[[mc:multiconfigname:]target] ... ]<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Here is an example for two extra multiconfig=
s: target1 and target2:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0$ bitbake mc::target mc:=
target1:target mc:target2:target<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0///// end<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 i don&#39;t understand the &quot;mc::=
target&quot; part of that last command, as it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0does not seem to be compatible with the defi=
nition of the general form<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0of the command just above that, specifically=
:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 $ bitbake [mc:multiconf=
igname:]target ...<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0can someone clarify this?<br>
&gt;<br>
&gt;<br>
&gt; &quot;target&quot; is the recipe you want to build, just as you would =
have specified if you were not using a &quot;mc:multiconfig:&quot;<br>
&gt; prefix. For examples:<br>
&gt;<br>
&gt; =C2=A0# build core-image-minimal<br>
&gt; =C2=A0bitbake mc:my-mulitconfig:core-image-minimal<br>
&gt;<br>
&gt; =C2=A0# build BusyBox<br>
&gt; =C2=A0bitbake mc:my-mulitconfig:busybox<br>
&gt;<br>
=C2=A0 my confusion was with the example that started with the two colons:<=
br>
<br>
=C2=A0 $ bitbake mc::target ...<br>
<br>
the manual doesn&#39;t seem to explain the meaning of that &quot;::&quot; b=
it.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Ah sorry. I&#39;m not sure. I&#39;ve not seen that used much, if ever.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Based on the code, I woul=
d assume that&#39;s equivalent to just &quot; bitbake target&quot;, but I&#=
39;m not positive.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
rday</blockquote></div></div></div>

--000000000000e0a787059dd499b1--
