Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
	[209.85.213.170])
	by mail.openembedded.org (Postfix) with ESMTP id 920E87731F;
	Wed,  3 Feb 2016 16:52:23 +0000 (UTC)
Received: by mail-ig0-f170.google.com with SMTP id rs20so6658814igc.0;
	Wed, 03 Feb 2016 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=UNKJHDnAwTFUFaAwbXC8VJGJ9EsFWVMwPhZBTJCBRN0=;
	b=MW5WWoUsmutuGibhzS7SpE51w/sNnt5wFAi52QftfEthqCXO3tcj4mpB3Ezkfb16GB
	87PGmqOv2kvqOVAEUGYJhfeK3hH7D6Uxo+JVaXUt/DCq5wMDWRLr062StogfKjemxplh
	lA0RQMBhdwM+/5TWLxLyuAvsOSJjPmoVOsUpcurG6grHaj9Oxn92olO3BJyuKxBPGv5j
	0weiNRmRLkUjf/+onxdSrD5Bg45b+bzqLl6r2IFX25DMYusACsYCU979aWE8OCzERlvP
	L3XaLWfe7f5N0iW3TsF0jJhRIVRdvjrjy8wD4NPsX1dSuVkxkmZrRW7lWzjiIcvubnMX
	7WDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=UNKJHDnAwTFUFaAwbXC8VJGJ9EsFWVMwPhZBTJCBRN0=;
	b=ae1e8w1L2i+XYIOwF8ZhP/BVB9JRdldi8NCkhLuxuhN6CUhyly/I3+FXtlRtY1tWnD
	sv1bnxj3eY89FentjGPHL6Pai8Nsryw1abIGgo1wdOrkRsd1b12/0lmC7s3trkyFMxBp
	8oFIRrX05gjLgjJi6x6nBTYVQwP/ftGpp5k3geD8rcTuA6c6MAukqY6ALQ+ReY6nZyjB
	O/nbpENmXkei8y5Vjmy0NqPGY2lWr17Yv18G3Gm74h7Wf9YO6BhnwvddGuSZstEG/V1E
	bSjsHAWs709jFy0REZ6pMPO7tBXIP6hUWZDT89ezN4SKtCaQ9OMf5Ze0V1LnnJwXPSB5
	ZRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc:content-type;
	bh=UNKJHDnAwTFUFaAwbXC8VJGJ9EsFWVMwPhZBTJCBRN0=;
	b=F4kvqNAAMxDKh6AcXZiEWi6/p0WojgZFojGjNDIpdy7rX9erQS6qcShVS0IKPs2rjj
	X4gY0XdUxYk/o1xrz0Z8T/QRWWX1DrW90yI2S8zcTSsaB2N2r8SrecSzz4wnTe4+drG0
	i8Ij8Aet6PtHZ00h6Yu35dUXORN3I8xAw6SjrpDockceTG2SsWthNByansdesGjClqX1
	n0z9AXmuhEIRwDNWZRqrwogeCSv9tFTkDUuT4o3zUhkQOHKD9i5vXrWRe+SvdvC6wS8v
	QpzcWq0kH3P31tOKgW1DqhmYmIoAk0nWkxTerFhag/shIYPxGL2tFbcxjbMPDIvp4YkS
	1G5w==
X-Gm-Message-State: AG10YOQY3jebx12ta2ZLim2olyTPrs350d9M9KxNo7LdZ4fg+11GZx+pkD4DDPP8SYC6ceyRZzJDLo17tIfZoA==
X-Received: by 10.50.132.40 with SMTP id or8mr4681732igb.47.1454518343057;
	Wed, 03 Feb 2016 08:52:23 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.91.133 with HTTP; Wed, 3 Feb 2016 08:52:03 -0800 (PST)
In-Reply-To: <1454517490.27087.199.camel@linuxfoundation.org>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
	<1454498556.27087.180.camel@linuxfoundation.org>
	<20160203150638.GB2567@jama>
	<1454516552.27087.197.camel@linuxfoundation.org>
	<CABcZANkuuQRW7ab_ai=KpoL2030H__kyFszZpkvgkxurmu63_w@mail.gmail.com>
	<1454517490.27087.199.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 3 Feb 2016 09:52:03 -0700
X-Google-Sender-Auth: hiV3NTigRQ4hZBnqVbc4RKwIWPg
Message-ID: <CABcZANm03MMuh4k1Lxi=PaXTC+j2uWMiruq=8fsnadKvQBsO0Q@mail.gmail.com>
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
X-List-Received-Date: Wed, 03 Feb 2016 16:52:23 -0000
Content-Type: multipart/alternative; boundary=047d7b162bfd28522e052ae071b1

--047d7b162bfd28522e052ae071b1
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 3, 2016 at 9:38 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2016-02-03 at 09:29 -0700, Christopher Larson wrote:
> > >  The actual getVar syntax on the other handy is more than cosmetic,
> > > people don't understand what this "True" they keep adding means, or
> > > why
> > > they need it. You tend to know when you don't want expansion on the
> > > other hand. So a cleaner syntax which does what the user most
> > > likely
> > > needs is more than cosmetic.
> > I'd agree with that, passing booleans as arguments sucks all around,
> > since it loses context. *If* someone is going to do it, it's best to
> > pass it with the argument name in keyword form in the caller, and
> > obviously we don't want to do that here.
> >
> > That said, I'm rather inclined toward thinking about alternative
> > DataSmart APIs in general, in the long term. For example, it's a
> > MutableMapping, so it acts dict-like, so we should be able to use
> > .get() and get an expanded value, and then the case would line up
> > with PEP8 (CamelCase for functions is frowned upon). I.e. we could
> > have get() and get_unexpanded().
>
> I'm just thinking out loud here, I think the above is worth seriously
> considering. One big advantage "getVar" has is that its pretty unique
> and the python parsing code therefore doesn't get a lot of false
> positives with function names. "get" on the other hand, I can see being
> a nightmare.


That's a good point, I'll admit I didn't think about the codeparsing in
that regard. I wonder how much work it'd be to track what variable(s) hold
DataSmart instances.. we know 'd' starts that way, that's an assumption we
can make, but it wouldn't traverse createCopy().. *Ponders*
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b162bfd28522e052ae071b1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Feb 3, 2016 at 9:38 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">On Wed, 2016-02-03 at 09:29 -0700, Christopher Lars=
on wrote:<br>
&gt; &gt;=C2=A0 The actual getVar syntax on the other handy is more than co=
smetic,<br>
&gt; &gt; people don&#39;t understand what this &quot;True&quot; they keep =
adding means, or<br>
&gt; &gt; why<br>
&gt; &gt; they need it. You tend to know when you don&#39;t want expansion =
on the<br>
&gt; &gt; other hand. So a cleaner syntax which does what the user most<br>
&gt; &gt; likely<br>
&gt; &gt; needs is more than cosmetic.<br>
&gt; I&#39;d agree with that, passing booleans as arguments sucks all aroun=
d,<br>
&gt; since it loses context. *If* someone is going to do it, it&#39;s best =
to<br>
&gt; pass it with the argument name in keyword form in the caller, and<br>
&gt; obviously we don&#39;t want to do that here.<br>
&gt;<br>
&gt; That said, I&#39;m rather inclined toward thinking about alternative<b=
r>
&gt; DataSmart APIs in general, in the long term. For example, it&#39;s a<b=
r>
&gt; MutableMapping, so it acts dict-like, so we should be able to use<br>
&gt; .get() and get an expanded value, and then the case would line up<br>
&gt; with PEP8 (CamelCase for functions is frowned upon). I.e. we could<br>
&gt; have get() and get_unexpanded().<br>
<br>
</span>I&#39;m just thinking out loud here, I think the above is worth seri=
ously<br>
considering. One big advantage &quot;getVar&quot; has is that its pretty un=
ique<br>
and the python parsing code therefore doesn&#39;t get a lot of false<br>
positives with function names. &quot;get&quot; on the other hand, I can see=
 being<br>
a nightmare.</blockquote></div><br></div><div class=3D"gmail_extra">That&#3=
9;s a good point, I&#39;ll admit I didn&#39;t think about the codeparsing i=
n that regard. I wonder how much work it&#39;d be to track what variable(s)=
 hold DataSmart instances.. we know &#39;d&#39; starts that way, that&#39;s=
 an assumption we can make, but it wouldn&#39;t traverse createCopy().. *Po=
nders*<br>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clars=
on at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Mai=
ntainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--047d7b162bfd28522e052ae071b1--
