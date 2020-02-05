Return-Path: <jpewhacker@gmail.com>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id 9273260C97
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Feb 2020 13:54:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id c84so2888807wme.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Feb 2020 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=WUYW17DBldmgsBGUk4jN/nnbsqPjhasHo1b7cacBwG4=;
	b=VhBNUIqHk0c6HqiSjQdDEEN75TaOJCz2xlN2GsIoHxm2YO+BBkNhXJo0yV+zg6DLgT
	8d0u31coHIYSX2DW7W2d9Kknhjn2toLbtwfdG+z3oZBSd01h1ayeKJR5IjoUGLlNNASI
	uL57KKLvkDRf06wpwHoTQDEW5ikCcQ0DViAUl63QXAelPjBr0iVufc1hHEG/nuhCW6UR
	FUU0tm35liEOk0n/RX8DamVEZW2oSYh3tlO86uHnbyleHriYPSukFAoJ2Sd/Im5ahvr5
	jSG57aRkkQBpCS8HpJG40cetwm2UcXfHHRqe0/5wRmRJSLtghwqefex81uOYrEVzqL06
	x04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=WUYW17DBldmgsBGUk4jN/nnbsqPjhasHo1b7cacBwG4=;
	b=OK54tGZ0+2SKLy5LBKo2Juj4dszdrba10Luwi39IQpZntoHS50hVeWWEUw61xhYv57
	6QORuvXxR0o2TDE46H5Ne6I9Vp/vxChD45k8STFFn5GOaZ62IGXtjQufvTurkgDAybid
	x7VSeEWKz1iS8//7NyB8UgWzeadeAOraAWDPLwLw2JMiZdU48x8+bN25/wdH/5jJqiHq
	CqybpHwzkv+tmVnVMsFX+IIE0/wOjar4J6F2HHlcHr/xZyTzGoICat5Gv3rif4H4kFkB
	FMkuEF07xQ5xHXaIItLJsO6ieXBmGUBZ0qzEVGGyCPAvHpzex3KdaA8tL1A8LhO0PiLt
	Vl8g==
X-Gm-Message-State: APjAAAXeAsuSutXeaGofupJnjeg33dCiScLMjE5rXPxGKRIf/xSlhelB
	5D+appBthiZka6sRe3nWOW/Q919+aBusAW97A6mKIg==
X-Google-Smtp-Source: APXvYqxXeRHwdXQeCWRxDDDV2lOP+ndKtQKOSfqlXL94ByGjw793J84mFefUVK6i/x0vbvBv2FDKmQp/Fv+92taBY9g=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr6147676wmi.31.1580910868332; 
	Wed, 05 Feb 2020 05:54:28 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.2002050523360.1950893@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2002050523360.1950893@localhost.localdomain>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 5 Feb 2020 07:54:15 -0600
Message-ID: <CAJdd5GaxuOnQ_aWgn_tZABXs4LK+fOFMfpYN2jLCAohzO3f-KA@mail.gmail.com>
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
X-List-Received-Date: Wed, 05 Feb 2020 13:54:27 -0000
Content-Type: multipart/alternative; boundary="000000000000ba82f2059dd47eb1"

--000000000000ba82f2059dd47eb1
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 5, 2020, 4:26 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:

>
>   i've never defined a multiconfig build, but this section explaining
> it in the BB user manual seems confusing:
>
> ///// start
>
> The following statement in the local.conf file both enables BitBake to
> perform multiple configuration builds and specifies the two extra
> multiconfigs:
>
>      BBMULTICONFIG = "target1 target2"
>
> Once the target configuration files are in place and BitBake has been
> enabled to perform multiple configuration builds, use the following
> command form to start the builds:
>
>      $ bitbake [mc:multiconfigname:]target [[[mc:multiconfigname:]target]
> ... ]
>
> Here is an example for two extra multiconfigs: target1 and target2:
>
>      $ bitbake mc::target mc:target1:target mc:target2:target
>
> ///// end
>
>   i don't understand the "mc::target" part of that last command, as it
> does not seem to be compatible with the definition of the general form
> of the command just above that, specifically:
>
>       $ bitbake [mc:multiconfigname:]target ...
>
> can someone clarify this?
>

"target" is the recipe you want to build, just as you would have specified
if you were not using a "mc:multiconfig:" prefix. For examples:

 # build core-image-minimal
 bitbake mc:my-mulitconfig:core-image-minimal

 # build BusyBox
 bitbake mc:my-mulitconfig:busybox



> rday
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--000000000000ba82f2059dd47eb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Feb 5, 2020, 4:26 AM Robert P. J. Day &lt;<a h=
ref=3D"mailto:rpjday@crashcourse.ca">rpjday@crashcourse.ca</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><br>
=C2=A0 i&#39;ve never defined a multiconfig build, but this section explain=
ing<br>
it in the BB user manual seems confusing:<br>
<br>
///// start<br>
<br>
The following statement in the local.conf file both enables BitBake to<br>
perform multiple configuration builds and specifies the two extra<br>
multiconfigs:<br>
<br>
=C2=A0 =C2=A0 =C2=A0BBMULTICONFIG =3D &quot;target1 target2&quot;<br>
<br>
Once the target configuration files are in place and BitBake has been<br>
enabled to perform multiple configuration builds, use the following<br>
command form to start the builds:<br>
<br>
=C2=A0 =C2=A0 =C2=A0$ bitbake [mc:multiconfigname:]target [[[mc:multiconfig=
name:]target] ... ]<br>
<br>
Here is an example for two extra multiconfigs: target1 and target2:<br>
<br>
=C2=A0 =C2=A0 =C2=A0$ bitbake mc::target mc:target1:target mc:target2:targe=
t<br>
<br>
///// end<br>
<br>
=C2=A0 i don&#39;t understand the &quot;mc::target&quot; part of that last =
command, as it<br>
does not seem to be compatible with the definition of the general form<br>
of the command just above that, specifically:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 $ bitbake [mc:multiconfigname:]target ...<br>
<br>
can someone clarify this?<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">&quot;target&quot; is the recipe you want to build=
, just as you would have specified if you were not using a &quot;mc:multico=
nfig:&quot; prefix. For examples:</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">=C2=A0# build core-image-minimal</div><div dir=3D"auto">=C2=A0bit=
bake mc:my-mulitconfig:core-image-minimal</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">=C2=A0# build BusyBox</div><div dir=3D"auto">=C2=A0<span =
style=3D"font-family:sans-serif">bitbake mc:my-mulitconfig:busybox</span></=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
rday<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank" r=
el=3D"noreferrer">bitbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer noreferrer" target=3D"_blank">http://lists.openembedded.org=
/mailman/listinfo/bitbake-devel</a><br>
</blockquote></div></div></div>

--000000000000ba82f2059dd47eb1--
