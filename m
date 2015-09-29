Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169])
	by mail.openembedded.org (Postfix) with ESMTP id 6EDE176FD7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 14:30:18 +0000 (UTC)
Received: by igcpb10 with SMTP id pb10so81342002igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=VfJa0uDtPj5cl8xH7loAFdoBFFgNa2TXI/DemfUAKcQ=;
	b=c7U7DqMlLwunQYtmmPnWdksLusurJHkFpkbqWw4ChboNdjgvD2dQHeKMaE/pNSrQ/8
	BfyhhX6qBAm7+4Ffw0t0Bl5XJIy0z6NYsFGt7pOzEkWXZUiqaOWn4k2MuD6g6TG8Z2zW
	U0aHhseBJwDYq3XY+Htwf70HdI9jBC4e0XBL0vd5GoDCNZHBkUTjlkKXdPHyMcatPRi8
	ccZkWo0DLpY4PMPWDSHjPBS7tlawpYGkQ46zuyifB7sGhjxWU5ti+zGsFPrhN/8rhs8b
	HypQ5ehXN8LuTOQLyW3Wr2KxSb61BviJXOaI/BsVodQK96moDufe+uDfLSzYxJZgRyAG
	xuoQ==
X-Received: by 10.50.43.170 with SMTP id x10mr22306403igl.68.1443537017922;
	Tue, 29 Sep 2015 07:30:17 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Tue, 29 Sep 2015 07:29:58 -0700 (PDT)
In-Reply-To: <32EA6B79577EEF4C84CB32305D45A059289F5066@SRV24.hamburg.garz-fricke.de>
References: <32EA6B79577EEF4C84CB32305D45A059289F5066@SRV24.hamburg.garz-fricke.de>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 29 Sep 2015 07:29:58 -0700
X-Google-Sender-Auth: WEEZIagwAM7RsSEnbOkTpw1gTeE
Message-ID: <CABcZAN=Osf2OHbx_VCmQapEjP+OqfNQGqYU9zXAnrbecNL+5=A@mail.gmail.com>
To: Tim Jaacks <tim.jaacks@garz-fricke.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Tue, 29 Sep 2015 14:30:18 -0000
Content-Type: multipart/alternative; boundary=089e01176cad2c72290520e3a7a4

--089e01176cad2c72290520e3a7a4
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 29, 2015 at 2:21 AM, Tim Jaacks <tim.jaacks@garz-fricke.com>
wrote:

> > Remember that _remove is usable in global configuration context as well.
> We
> > need the user to be able to remove something from local.conf which added
> in
> > a recipe, but if we blindly follow the order of append/prepend/remove
> > operations, it wouldn't work as expected, as the configuration metadata
> is
> > parsed long before the recipes.
>
> Why would that be a problem? Of course the global configuration in
> local.conf should have a higher priority than all the layers. What I would
> expect is a chain of _append and _remove operations, ordered by layer
> priority, and with the overrides in local.conf being applied at the very
> end.


That's not how the bitbake metadata works. Hardcoding an assumption that
local.conf is magic is not how we do things. local.conf is *not* special.
It's a config file that happens to be included by bitbake.conf, among many
other .confs it also includes.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e01176cad2c72290520e3a7a4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Sep 29, 2015 at 2:21 AM, Tim Jaacks <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:tim.jaacks@garz-fricke.com" target=3D"_blank">tim.jaacks@garz-fricke.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""=
>&gt; Remember that _remove is usable in global configuration context as we=
ll. We<br>
&gt; need the user to be able to remove something from local.conf which add=
ed in<br>
&gt; a recipe, but if we blindly follow the order of append/prepend/remove<=
br>
&gt; operations, it wouldn&#39;t work as expected, as the configuration met=
adata is<br>
&gt; parsed long before the recipes.<br>
<br>
</span>Why would that be a problem? Of course the global configuration in l=
ocal.conf should have a higher priority than all the layers. What I would e=
xpect is a chain of _append and _remove operations, ordered by layer priori=
ty, and with the overrides in local.conf being applied at the very end.</bl=
ockquote></div><br>That&#39;s not how the bitbake metadata works. Hardcodin=
g an assumption that local.conf is magic is not how we do things. local.con=
f is *not* special. It&#39;s a config file that happens to be included by b=
itbake.conf, among many other .confs it also includes.<br>-- <br><div class=
=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br>Fo=
under - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior S=
oftware Engineer, Mentor Graphics</div>
</div></div>

--089e01176cad2c72290520e3a7a4--
