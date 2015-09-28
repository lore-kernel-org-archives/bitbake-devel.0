Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id B1C3D73D13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 15:13:00 +0000 (UTC)
Received: by ioiz6 with SMTP id z6so177891826ioi.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=sd27JYBec3qMVXD4zhJh42xtUb2rHs8UdTvHrJKDpvI=;
	b=Qq6G/2YcnMRtwfpchBblpO8CTkSitq+f74HbflbMZkE2isAQZsnr2Xai6juQGrcFyQ
	Bvw/IH6fz4eYFqBtw+aefhuA+FhG8aU2zDsSh2HzkmBLFDvfzj10hmPKcAly5DD5SbpC
	Z0amfW86rZ1gk6N85Aabn6oGU0L0o68RHTbVI3mNPPcX6qeuxZZuJ4jzo1ywRUl35f1+
	AasgMargYftDSYbIMkrR/EshagB8DaQNwOIZ49ok/cjSicJd1WCRF6uSYkusy2ZraPqG
	XZIilAmcafM6hNZpskteBscaBJ22kCb/P9suNoiMBbK3OdyQnoOzN1PHF933+R88+URr
	IYuQ==
X-Received: by 10.107.38.210 with SMTP id m201mr22653094iom.98.1443453180328; 
	Mon, 28 Sep 2015 08:13:00 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Mon, 28 Sep 2015 08:12:40 -0700 (PDT)
In-Reply-To: <32EA6B79577EEF4C84CB32305D45A059289EB14B@SRV24.hamburg.garz-fricke.de>
References: <32EA6B79577EEF4C84CB32305D45A059289EB14B@SRV24.hamburg.garz-fricke.de>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 28 Sep 2015 08:12:40 -0700
X-Google-Sender-Auth: cnGJRylrclz7KhRBZ7VMhNvQCNw
Message-ID: <CABcZANkw6MZm4HnQKQErPdbtXZ1ZZt3+vyEOmyBucTiHDgJkSg@mail.gmail.com>
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
X-List-Received-Date: Mon, 28 Sep 2015 15:13:02 -0000
Content-Type: multipart/alternative; boundary=001a114028181046380520d022af

--001a114028181046380520d022af
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 28, 2015 at 1:53 AM, Tim Jaacks <tim.jaacks@garz-fricke.com>
wrote:

> Hello Otavio & Paul,
>
> thanks for your replies.
>
> > It seems you are intending to use mesa for i.MX5 SoC, the way I would do
> it
> > would be removing the mx5 from the overrides completely.
>
> Yes, that is exactly what I want to do. We do not want to move to master,
> as we use the 3.0.35 kernel and have tested our systems on this version,
> and changing this would result in a lot of new work.
> You mean, I should remove "mx5" from SOC_FAMILY? Well, that would work of
> course, haven't thought of that. However, I would have to rewrite lots of
> other variable assignments with overrides for my specific hardware. And
> this wouldn't be very intuitive at all, because my hardware IS based on an
> mx5, and thus looking into the recipes I would assume that _mx5 overrides
> are applied on my hardware.
>
> > We went back and forth on the way it was implemented, but the conclusion
> we
> > reached was that what most people want is a remove operator that removes
> the
> > value no matter how it comes in. If we start getting into ordering of
> > operators then it's harder for the user to understand what's going on,
> > particularly as _append, _prepend and _remove are deferred operations
> (unlike
> > += or =+ which are immediate).
> >
> > What this does mean is that _remove should be used sparingly and really
> ought
> > to be used only where it's very unlikely that anyone would want to
> override it.
>
> Well, I would say that this is somewhat counter-intuitive. The layers are
> one of the main concepts of Bitbake. If I create a layer and assign the
> highest priority to it, it is hard to understand that changes I make to a
> variable in my layer are not applied because of a lower priority layer
> being processed after my layer. How can you ever tell that it is "unlikely"
> that someone wants to override a _remove operator? Shouldn't ALL variables
> be changeable in ALL ways? This seems a very strict (and undocumented)
> limitation to me.
>

Remember that _remove is usable in global configuration context as well. We
need the user to be able to remove something from local.conf which added in
a recipe, but if we blindly follow the order of append/prepend/remove
operations, it wouldn't work as expected, as the configuration metadata is
parsed long before the recipes.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114028181046380520d022af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Sep 28, 2015 at 1:53 AM, Tim Jaacks <span dir=3D"ltr">&lt;<a href=
=3D"mailto:tim.jaacks@garz-fricke.com" target=3D"_blank">tim.jaacks@garz-fr=
icke.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=
=3D":22w" class=3D"a3s" style=3D"overflow:hidden">Hello Otavio &amp; Paul,<=
br>
<br>
thanks for your replies.<br>
<span class=3D""><br>
&gt; It seems you are intending to use mesa for i.MX5 SoC, the way I would =
do it<br>
&gt; would be removing the mx5 from the overrides completely.<br>
<br>
</span>Yes, that is exactly what I want to do. We do not want to move to ma=
ster, as we use the 3.0.35 kernel and have tested our systems on this versi=
on, and changing this would result in a lot of new work.<br>
You mean, I should remove &quot;mx5&quot; from SOC_FAMILY? Well, that would=
 work of course, haven&#39;t thought of that. However, I would have to rewr=
ite lots of other variable assignments with overrides for my specific hardw=
are. And this wouldn&#39;t be very intuitive at all, because my hardware IS=
 based on an mx5, and thus looking into the recipes I would assume that _mx=
5 overrides are applied on my hardware.<br>
<span class=3D""><br>
&gt; We went back and forth on the way it was implemented, but the conclusi=
on we<br>
&gt; reached was that what most people want is a remove operator that remov=
es the<br>
&gt; value no matter how it comes in. If we start getting into ordering of<=
br>
&gt; operators then it&#39;s harder for the user to understand what&#39;s g=
oing on,<br>
&gt; particularly as _append, _prepend and _remove are deferred operations =
(unlike<br>
&gt; +=3D or =3D+ which are immediate).<br>
&gt;<br>
&gt; What this does mean is that _remove should be used sparingly and reall=
y ought<br>
&gt; to be used only where it&#39;s very unlikely that anyone would want to=
 override it.<br>
<br>
</span>Well, I would say that this is somewhat counter-intuitive. The layer=
s are one of the main concepts of Bitbake. If I create a layer and assign t=
he highest priority to it, it is hard to understand that changes I make to =
a variable in my layer are not applied because of a lower priority layer be=
ing processed after my layer. How can you ever tell that it is &quot;unlike=
ly&quot; that someone wants to override a _remove operator? Shouldn&#39;t A=
LL variables be changeable in ALL ways? This seems a very strict (and undoc=
umented) limitation to me.<br></div></blockquote></div><br>Remember that _r=
emove is usable in global configuration context as well. We need the user t=
o be able to remove something from local.conf which added in a recipe, but =
if we blindly follow the order of append/prepend/remove operations, it woul=
dn&#39;t work as expected, as the configuration metadata is parsed long bef=
ore the recipes.<br>-- <br><div class=3D"gmail_signature">Christopher Larso=
n<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZau=
rus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div=
>
</div></div>

--001a114028181046380520d022af--
