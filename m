Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id D832077E8A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 13:42:42 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id f206so2085734oig.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Jun 2017 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=a5WaROob4Ia+68Xliq4RJuR+OXa+0iQmQ4JZ/yhYOTc=;
	b=HCLxbePiL5s4TegAae75Rh70oS8NH7OqSSfRJWgWTayjGiNrXcWMnRbvPr5gOr0j+H
	BFqf/VT1AZFN2z63D9bjqhWrru60voXoBlSOpfV3GtHXKr5IVnB4RKtx45ysERFcwCAX
	CeQDba7RLwqcoB1MqyEzZGqO+iM8hKfFtpZP8163ETk+4TuvG61TDCKJ+orTV0bxX4Ax
	ykd4AzcNghUGsYoKORCy8luh/U5JsJEsuCemCEfnhz3X9D1KuysLcqwo7TutQYrGwc4h
	nZIFx4wu+b4Peev/z7iTnMOX6UylFxPw7yNkBmxB8aNOI3I7kqUdneQUaNWVm2/ClvpE
	hTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=a5WaROob4Ia+68Xliq4RJuR+OXa+0iQmQ4JZ/yhYOTc=;
	b=rrjTSnE95Z0rrYsbZ5G02hMUzUlu31n6QRAB0WmNtvgnBq8rNJF1CtBngEGpQjdmCe
	ALWiOfwZ+uzDxw3HwG/++0KF7pAclNVdfVmQnQRFhz801hMDxJkfvvEhHvKdRhsUO09U
	7zY7LZ0RWCaLYfQ864tYDA3wGu09w8qgmKLDgDucVEWZCxcgU55wjuLowNFsc90YO/Er
	0cEZxnkxFyUclv/xEl9gJX29BG2qVwCtQ1SYWy5l851hYRNPiivy9rRP0p36SzNeqsQY
	kQCcG1Z8K0Vf0MrVR1y4LjOjJ/EDEfMWe1PFPxx60caIt+CBKEu2pw9Xj/RzBqTNgQqE
	OwCg==
X-Gm-Message-State: AODbwcD/2tn0iA55Nv2zD4ks6zfp3N8d6pqypw5qexyleQq4gpPJQ3ER
	lvQ0yGXF/nP4ghjK4VKCTn/PD/Y1mg==
X-Received: by 10.202.62.70 with SMTP id l67mr4404794oia.46.1496410963594;
	Fri, 02 Jun 2017 06:42:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.226 with HTTP; Fri, 2 Jun 2017 06:42:23 -0700 (PDT)
In-Reply-To: <3febe667-f723-9497-2797-8421a58997ae@windriver.com>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<1496408295.6630.95.camel@linuxfoundation.org>
	<3febe667-f723-9497-2797-8421a58997ae@windriver.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 2 Jun 2017 06:42:23 -0700
Message-ID: <CABcZANn5cdC7aGJSJt_Q9ExLYk+PDLT1kn+esSdSHeUrM0LdwQ@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Fri, 02 Jun 2017 13:42:43 -0000
Content-Type: multipart/alternative; boundary="001a113ce09aec55510550fa5328"

--001a113ce09aec55510550fa5328
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 2, 2017 at 6:26 AM, Mark Hatle <mark.hatle@windriver.com> wrote:

> On 6/2/17 7:58 AM, Richard Purdie wrote:
> > On Mon, 2017-05-22 at 12:50 +0200, Patrick Ohly wrote:
> >> Having a .bbappend without corresponding .bb file triggers an error
> >> or
> >> at least warning, depending on the global
> >> BB_DANGLINGAPPENDS_WARNONLY.
> >>
> >> Some layers (for example, meta-freescale) avoid that message by only
> >> adding .bbappends to the BBFILES when the layers they apply to are
> >> present. Others (like intel-iot-refkit) avoid such .bbappends by
> >> falling back to global assignments with _pn-<recipe> as override.
> >> Both
> >> is complicated.
> >>
> >> Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
> >> all bbappends which match a file pattern in that list. This is an
> >> easier way to have bbappends which may or may not apply to an
> >> existing recipe.
> >>
> >> Example usage:
> >>
> >>   # We have recipes-* directories, add to BBFILES
> >>   BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
> >>      ${LAYERDIR}/optional-bbappends/recipes-*/*/*.bbappend \
> >>      ${LAYERDIR}/recipes-*/*/*.bbappend"
> >>
> >>   # Several of our *.bbappends might be for layers that are not
> >>   # guaranteed to be present. Don't warn or even error out because
> >>   # of those.
> >>   BBAPPENDS_DANGLING_WHITELIST += "${LAYERDIR}/optional-
> >> bbappends/recipes-*/*/*.bbappend"
> >
> > I've been giving this some thought. The freescale layer approach does
> > have ordering issues which I don't like. Equally, Chris' comment about
> > this is also a valid concern. Experience suggests saying the layer
> > maintainer needs to be careful doesn't work in practise.
> >
> > I'm wondering if there is a hybrid solution if we extend this syntax a
> > little, e.g.:
> >
> > BBFILES_DYNAMIC += "\
> >     XXXX:${LAYERDIR}/optional-bbappends-XXX/recipes-*/*/*.bbappend
> >     YYYY:${LAYERDIR}/optional-bbappends-YYY/recipes-*/*/*.bbappend
> > "
> >
> > so that the code only applies these BBFILES entries if the layer named
> > in the first parameter is present?
> >
> > This would happen at the end of parsing so ordering becomes a moot
> > point. The direction you stack BBFILES_DYANMIC in would determin
> > bbappend application order.
> >
> > How does that sound to people?
>
> That sounds reasonable to me, and has a precedent in the package_dynamic
> as well.


Agreed.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a113ce09aec55510550fa5328
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 2, 2017 at 6:26 AM, Mark Hatle <span dir=3D"ltr">&lt;<a href=3D=
"mailto:mark.hatle@windriver.com" target=3D"_blank">mark.hatle@windriver.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOE=
nZb adM"><div class=3D"">On 6/2/17 7:58 AM, Richard Purdie wrote:<br>
&gt; On Mon, 2017-05-22 at 12:50 +0200, Patrick Ohly wrote:<br>
&gt;&gt; Having a .bbappend without corresponding .bb file triggers an erro=
r<br>
&gt;&gt; or<br>
&gt;&gt; at least warning, depending on the global<br>
&gt;&gt; BB_DANGLINGAPPENDS_WARNONLY.<br>
&gt;&gt;<br>
&gt;&gt; Some layers (for example, meta-freescale) avoid that message by on=
ly<br>
&gt;&gt; adding .bbappends to the BBFILES when the layers they apply to are=
<br>
&gt;&gt; present. Others (like intel-iot-refkit) avoid such .bbappends by<b=
r>
&gt;&gt; falling back to global assignments with _pn-&lt;recipe&gt; as over=
ride.<br>
&gt;&gt; Both<br>
&gt;&gt; is complicated.<br>
&gt;&gt;<br>
&gt;&gt; Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignor=
es<br>
&gt;&gt; all bbappends which match a file pattern in that list. This is an<=
br>
&gt;&gt; easier way to have bbappends which may or may not apply to an<br>
&gt;&gt; existing recipe.<br>
&gt;&gt;<br>
&gt;&gt; Example usage:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0# We have recipes-* directories, add to BBFILES<br>
&gt;&gt;=C2=A0 =C2=A0BBFILES +=3D &quot;${LAYERDIR}/recipes-*/*/*.bb \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 ${LAYERDIR}/optional-<wbr>bbappends/recipes-*/=
*/*.<wbr>bbappend \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 ${LAYERDIR}/recipes-*/*/*.<wbr>bbappend&quot;<=
br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0# Several of our *.bbappends might be for layers that =
are not<br>
&gt;&gt;=C2=A0 =C2=A0# guaranteed to be present. Don&#39;t warn or even err=
or out because<br>
&gt;&gt;=C2=A0 =C2=A0# of those.<br>
&gt;&gt;=C2=A0 =C2=A0BBAPPENDS_DANGLING_WHITELIST +=3D &quot;${LAYERDIR}/op=
tional-<br>
&gt;&gt; bbappends/recipes-*/*/*.<wbr>bbappend&quot;<br>
&gt;<br>
&gt; I&#39;ve been giving this some thought. The freescale layer approach d=
oes<br>
&gt; have ordering issues which I don&#39;t like. Equally, Chris&#39; comme=
nt about<br>
&gt; this is also a valid concern. Experience suggests saying the layer<br>
&gt; maintainer needs to be careful doesn&#39;t work in practise.<br>
&gt;<br>
&gt; I&#39;m wondering if there is a hybrid solution if we extend this synt=
ax a<br>
&gt; little, e.g.:<br>
&gt;<br>
&gt; BBFILES_DYNAMIC +=3D &quot;\<br>
&gt;=C2=A0 =C2=A0 =C2=A0XXXX:${LAYERDIR}/optional-<wbr>bbappends-XXX/recipe=
s-*/*/*.<wbr>bbappend<br>
&gt;=C2=A0 =C2=A0 =C2=A0YYYY:${LAYERDIR}/optional-<wbr>bbappends-YYY/recipe=
s-*/*/*.<wbr>bbappend<br>
&gt; &quot;<br>
&gt;<br>
&gt; so that the code only applies these BBFILES entries if the layer named=
<br>
&gt; in the first parameter is present?<br>
&gt;<br>
&gt; This would happen at the end of parsing so ordering becomes a moot<br>
&gt; point. The direction you stack BBFILES_DYANMIC in would determin<br>
&gt; bbappend application order.<br>
&gt;<br>
&gt; How does that sound to people?<br>
<br>
</div></div>That sounds reasonable to me, and has a precedent in the packag=
e_dynamic as well.</blockquote></div><br>Agreed.<br>-- <br><div class=3D"gm=
ail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><di=
v dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - B=
itBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graphi=
cs</div></div></div></div>
</div></div>

--001a113ce09aec55510550fa5328--
