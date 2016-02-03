Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
	[209.85.213.182])
	by mail.openembedded.org (Postfix) with ESMTP id D659A77309;
	Wed,  3 Feb 2016 16:30:13 +0000 (UTC)
Received: by mail-ig0-f182.google.com with SMTP id rs20so6091719igc.0;
	Wed, 03 Feb 2016 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=JCrhMEFr8ccPqOPG5zau+wqxJTl2f6GSM4E1ueDlCGY=;
	b=SBY/FoqhvIissBnHLrMN96UzGePwwry/eq0H0Ke9zt9Sm7ExI31DuWJOz/LawfZ2IG
	5LvK21NITZ5jnD5c7Kbh3GuVXnUyqPoPVLLWNZwH4Ko91a35XD7MEPY9RgQMwPZGnO5d
	bz8b6l0snCDZ7l8ffeKa2zQub30bsAAZHXPphjRFE6nkzjrixA77x6ugpACmdd6+iMvV
	jhxGtPYUsoVs+x1rWxm2a9I9h54AFDjXWxLRH6fZkM50i91G6flbF2Mi1CcSQRhecIC8
	JmLJqoctcVP2Nnp+FkvmCD1f1nCgICuAIYvSDKDkcqDTH4hSAvNCT3mzFVpo2pG+HbdY
	wftw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=JCrhMEFr8ccPqOPG5zau+wqxJTl2f6GSM4E1ueDlCGY=;
	b=H2DcOp+K+XwbKr8r8t0oJYD5H1emQ+Hz3KCWgFOwbBx68gYCdhfK/MnZxJZYZc2OYX
	0MZPVF6gmDJA4d90/yWQLKDE9MoAqXu51oLa4neX+SAll4gwTRT2X0pIYEMXW71mn48G
	PjL5Q69BkdWmtbNeFb2cISKZ0yf7RjX2Tuvc6uRFAl3aJrK5CiVVHc6kjKaAT9XjZrrW
	06NAGnjxjApkkiFhSQXiYUllNz6DMtcZXXNslLC5IPIYmRZMZRAg1DDFje1CuZj2BHGh
	smwIxG0Jyneo7QKDUJlbDzDuOJhwcubML+mFv5UwD7zosG80zCOC/9VFoFJIgnawPra1
	xyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc:content-type;
	bh=JCrhMEFr8ccPqOPG5zau+wqxJTl2f6GSM4E1ueDlCGY=;
	b=hU+XRDvnAbm4k9KhTinh+dOKtFMq85ctW15ZHWRiedK2FEmwN5Zx7Aq+Ke+aNNykoK
	ls0vlz1WMcqqGuhV8ObD+RsB1E5yeCk9mlfptlY3SMQ04mHmqwaxAwbwE5gYVdf22tQ2
	pSP9fAzf789wwlRff3X0NEa7t4Zcgu/DytsHjQ0wv1ZIeUv+QXj7KrO72y4EPbw38AYD
	dGgvOvBM4cGu/naYgzpPnoSghei0FUJ+M38g+Lxtl0okQ6wdBdQmbzMX9nqvm3dn1kO2
	eUeWu9fA1n6dk0VOnM9boXqYHFnpwaTLK0JSqtzyaYiTS6ROEULM8OVNcm57itl7U3V+
	6cwA==
X-Gm-Message-State: AG10YOT4VSYq2atP/yVLr3LB5tChevkiBrOQtzf55D+fV+8yrJjqRQ/6+HBAukmgr1v6of18OaR6HP7U0g590g==
X-Received: by 10.50.26.5 with SMTP id h5mr4339193igg.25.1454517013838; Wed,
	03 Feb 2016 08:30:13 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.91.133 with HTTP; Wed, 3 Feb 2016 08:29:54 -0800 (PST)
In-Reply-To: <1454516552.27087.197.camel@linuxfoundation.org>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
	<1454498556.27087.180.camel@linuxfoundation.org>
	<20160203150638.GB2567@jama>
	<1454516552.27087.197.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 3 Feb 2016 09:29:54 -0700
X-Google-Sender-Auth: XKLDoa-4-euNJkIA9eXMmTjSZeg
Message-ID: <CABcZANkuuQRW7ab_ai=KpoL2030H__kyFszZpkvgkxurmu63_w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio.salvador@ossystems.com.br>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 16:30:14 -0000
Content-Type: multipart/alternative; boundary=047d7bd7598cee0195052ae0212c

--047d7bd7598cee0195052ae0212c
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 3, 2016 at 9:22 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2016-02-03 at 16:06 +0100, Martin Jansa wrote:
> > On Wed, Feb 03, 2016 at 11:22:36AM +0000, Richard Purdie wrote:
> > > On Wed, 2016-02-03 at 08:11 -0200, Otavio Salvador wrote:
> > > > I am in favor of making it mandatory but I fail to see what we
> > > > gain
> > > > in making it expand by default in future.
> > >
> > > Less ugly syntax, in 99.9% of usages, you would want expand=True
> > > and
> > > getVar("X") is neater than getVar("X", True).
> >
> > Consistent indentation is also neater than mixing tabs and spaces,
> > but
> > you were refusing to take such cosmetic change and now you're
> > proposing
> > neater getVar syntax which is (in some cases silently) breaking
> > existing
> > metadata and make backporting changes more difficult?
> >
> > I'm not opposing the change, just don't understand why the same
> > arguments work here and not for indentation.
>
> If we go through the full transition, its possible something might
> silently break, if they skip the release where we require a value. We
> haven't reached that point yet and I'm honestly not sure how long we
> should wait, I'm open to suggestions. The aim is to minimise any silent
> failures though.
>
> I'd also add that in many cases, it likely won't break at all, it might
> potentially fix something. If there are concerns about this, there are
> extra things we could consider such as requiring layers to mark they've
> been validated for the change. That adds extra complexity, I'm less
> sure about whether we need to do that.
>
> As for your other point, whitespace in shell functions doesn't seem to
> cause real world usability issues in that most people can read a tab
> indented or space indented function equally well. OE-Core is pretty
> consistent about what it uses and always has been, you personally just
> don't like the particular choice made and meta-oe deciding to do
> something else, contra to the TSC doesn't exactly help consistency. You
> could argue meta-oe is more of the problem here.
>

For what it's worth, I use consistent indentation deviating from oe-core in
every layer I maintain as well. Anything else is more hassle than its worth.


> The actual getVar syntax on the other handy is more than cosmetic,
> people don't understand what this "True" they keep adding means, or why
> they need it. You tend to know when you don't want expansion on the
> other hand. So a cleaner syntax which does what the user most likely
> needs is more than cosmetic.


I'd agree with that, passing booleans as arguments sucks all around, since
it loses context. *If* someone is going to do it, it's best to pass it with
the argument name in keyword form in the caller, and obviously we don't
want to do that here.

That said, I'm rather inclined toward thinking about alternative DataSmart
APIs in general, in the long term. For example, it's a MutableMapping, so
it acts dict-like, so we should be able to use .get() and get an expanded
value, and then the case would line up with PEP8 (CamelCase for functions
is frowned upon). I.e. we could have get() and get_unexpanded().
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bd7598cee0195052ae0212c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Feb 3, 2016 at 9:22 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">On Wed, 2016-02-03 at 16:06 +0100, Martin Jansa wro=
te:<br>
&gt; On Wed, Feb 03, 2016 at 11:22:36AM +0000, Richard Purdie wrote:<br>
&gt; &gt; On Wed, 2016-02-03 at 08:11 -0200, Otavio Salvador wrote:<br>
</span><span class=3D"">&gt; &gt; &gt; I am in favor of making it mandatory=
 but I fail to see what we<br>
&gt; &gt; &gt; gain<br>
&gt; &gt; &gt; in making it expand by default in future.<br>
&gt; &gt;<br>
&gt; &gt; Less ugly syntax, in 99.9% of usages, you would want expand=3DTru=
e<br>
&gt; &gt; and<br>
&gt; &gt; getVar(&quot;X&quot;) is neater than getVar(&quot;X&quot;, True).=
<br>
&gt;<br>
&gt; Consistent indentation is also neater than mixing tabs and spaces,<br>
&gt; but<br>
&gt; you were refusing to take such cosmetic change and now you&#39;re<br>
&gt; proposing<br>
&gt; neater getVar syntax which is (in some cases silently) breaking<br>
&gt; existing<br>
&gt; metadata and make backporting changes more difficult?<br>
&gt;<br>
&gt; I&#39;m not opposing the change, just don&#39;t understand why the sam=
e<br>
&gt; arguments work here and not for indentation.<br>
<br>
</span>If we go through the full transition, its possible something might<b=
r>
silently break, if they skip the release where we require a value. We<br>
haven&#39;t reached that point yet and I&#39;m honestly not sure how long w=
e<br>
should wait, I&#39;m open to suggestions. The aim is to minimise any silent=
<br>
failures though.<br>
<br>
I&#39;d also add that in many cases, it likely won&#39;t break at all, it m=
ight<br>
potentially fix something. If there are concerns about this, there are<br>
extra things we could consider such as requiring layers to mark they&#39;ve=
<br>
been validated for the change. That adds extra complexity, I&#39;m less<br>
sure about whether we need to do that.<br>
<br>
As for your other point, whitespace in shell functions doesn&#39;t seem to<=
br>
cause real world usability issues in that most people can read a tab<br>
indented or space indented function equally well. OE-Core is pretty<br>
consistent about what it uses and always has been, you personally just<br>
don&#39;t like the particular choice made and meta-oe deciding to do<br>
something else, contra to the TSC doesn&#39;t exactly help consistency. You=
<br>
could argue meta-oe is more of the problem here.<br></blockquote><div><br><=
/div><div>For what it&#39;s worth, I use consistent indentation deviating f=
rom oe-core in every layer I maintain as well. Anything else is more hassle=
 than its worth.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The actual getVar syntax on the other handy is more than cosmetic,<br>
people don&#39;t understand what this &quot;True&quot; they keep adding mea=
ns, or why<br>
they need it. You tend to know when you don&#39;t want expansion on the<br>
other hand. So a cleaner syntax which does what the user most likely<br>
needs is more than cosmetic.</blockquote></div><br></div><div class=3D"gmai=
l_extra">I&#39;d agree with that, passing booleans as arguments sucks all a=
round, since it loses context. *If* someone is going to do it, it&#39;s bes=
t to pass it with the argument name in keyword form in the caller, and obvi=
ously we don&#39;t want to do that here.<br><br>That said, I&#39;m rather i=
nclined toward thinking about alternative DataSmart APIs in general, in the=
 long term. For example, it&#39;s a MutableMapping, so it acts dict-like, s=
o we should be able to use .get() and get an expanded value, and then the c=
ase would line up with PEP8 (CamelCase for functions is frowned upon). I.e.=
 we could have get() and get_unexpanded().<br></div><div class=3D"gmail_ext=
ra">-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at =
kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintaine=
r - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--047d7bd7598cee0195052ae0212c--
