Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
	[209.85.217.181])
	by mail.openembedded.org (Postfix) with ESMTP id 4CD656B368;
	Wed, 21 Aug 2013 15:56:35 +0000 (UTC)
Received: by mail-lb0-f181.google.com with SMTP id u12so507249lbd.26
	for <multiple recipients>; Wed, 21 Aug 2013 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=DkMcp2ar0DIFS5oS1xgFDlGLDjHkPj61L9awaLS+MwU=;
	b=rZr1FJzAFRtzcCFP305M0OSJGRZIo3pJUtZys+ZPZH5FS0t/pexwC0Ugly9w7vn0E8
	j1XrFi8r0km8vjfadm7wizs6IpnbcWB6ouVA3Ua4yLzTQHMaw/7sv2ki+U2Grv9RYOII
	p0GN/bsriuDE1qgL+Bx8t9CFQ4rcgTcy6HO0LF9uMfjVmdm19t5mC9s5MaUDRkWiFTwj
	zfzA0pSM7Fvc+dJ0RwqCXfk7xh5eDH0LANbZDn1aoUiVyLEZ6RuhsWf+ta9T+USFle8Z
	+uTksdoaw8IosOMHSDhoO54+kRPpoNydunwHyfhJH4lgg9ohK5zGVGD6CZRZz3BvKZep
	gCaQ==
X-Received: by 10.112.64.36 with SMTP id l4mr7626317lbs.15.1377100595031; Wed,
	21 Aug 2013 08:56:35 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.53.197 with HTTP; Wed, 21 Aug 2013 08:56:14 -0700 (PDT)
In-Reply-To: <1377095185.25999.116.camel@ted>
References: <1377095185.25999.116.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 21 Aug 2013 08:56:14 -0700
X-Google-Sender-Auth: XXV7DF0MaCGiGNfXMl_6bTDNHIU
Message-ID: <CABcZANnt4v4LoM+HnK_=6VMDgSCFR7qGfciMdpXxSQ+Gc4HBEA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	poky <poky@lists.yoctoproject.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Bitbake in server mode
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
X-List-Received-Date: Wed, 21 Aug 2013 15:56:36 -0000
Content-Type: multipart/alternative; boundary=001a11c3eee4c978f004e47737e7

--001a11c3eee4c978f004e47737e7
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 21, 2013 at 7:26 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Known issues:
>
> a) Parsing is slower. Probably due to all the debug messages going over
> the IPC/xmlrpc. UI event filtering should fix it.
> b) Something is causing a cache reparse initially. Need to figure out
> what. Maybe the BBSERVER variable itself?
>
> This is still development so I'd not recommend everyone use this for
> production just yet but it gives some nice insight into what the future
> holds!
>
> We should be able to make bitbake in this mode much more responsive to
> commands since there is no cache overhead.
>

I expect the obvious question to be, what happens if a recipe is altered
between starting the server and running a command :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c3eee4c978f004e47737e7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Aug 21, 2013 at 7:26 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":4k" style=3D"overflow:hidden">Kn=
own issues:<br>
<br>
a) Parsing is slower. Probably due to all the debug messages going over<br>
the IPC/xmlrpc. UI event filtering should fix it.<br>
b) Something is causing a cache reparse initially. Need to figure out<br>
what. Maybe the BBSERVER variable itself?<br>
<br>
This is still development so I&#39;d not recommend everyone use this for<br=
>
production just yet but it gives some nice insight into what the future<br>
holds!<br>
<br>
We should be able to make bitbake in this mode much more responsive to<br>
commands since there is no cache overhead.</div></blockquote></div><br>I ex=
pect the obvious question to be, what happens if a recipe is altered betwee=
n starting the server and running a command :)<br>-- <br>Christopher Larson=
<br>

clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<b=
r>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a11c3eee4c978f004e47737e7--
