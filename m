Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
	[209.85.215.172])
	by mail.openembedded.org (Postfix) with ESMTP id 52E957F143
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:57:16 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id u17so4586823pgi.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=aTz7rmeukLOEzZJkMHqUp3yMekoa/MxsoyAtOPrY/xE=;
	b=xosdpUeNp+GEvTGdCe19fziEIkqh/R2aOhvBzwh5G0OgH+wXaXnurfgzg3e9Ma4Tvx
	S2NAAIkAq7ZyzaAH5S2/wRexE352NHaa4zS244uLNh+C5P5LhbeBLXeROaAgrw42E3xy
	nbhaTP8+mbdzujtPcwLJ3fkpkK9wJLUFNGf3cn1MX7moMOaym49nfIOK0fR1vRgbrikk
	Fjh2Si60O2tdCphpUHNsVM+fUNnsaj7L7ib3ZsuclR2p8v2enQBuGp1a+m/vANMQLTcw
	pmoDxdagazjg2eihhSjBSNK0uXwfvXuc+BxN6HoQEvIvHX3TpBrRXCwzDcUTYa3Hif0F
	INfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=aTz7rmeukLOEzZJkMHqUp3yMekoa/MxsoyAtOPrY/xE=;
	b=O9Zl1U/SA8ok/TrcWH0fcwArhKh25Co9Yf1pZ+bkKSZfniMqzWUecFecTEakfuP/LH
	7hWIgIj/0xJqCaynKvu6fcTySg64PUkJUmIeqie4usx0630ynJfn3II9F3Hu/rPxGcNa
	1sszcOHMHGmoXT7qdvFoWXKVLCH/tyTHs+TUwTxHdqkHoy2hDw7di4EmSEIIi47L/SIF
	UTvAvCm00I9dsaGVn6/AwzCD1KmDKijhyHjgI6AMwnSijPez9GimQZGaknspUd1zZ/4y
	jD8wqsSTMz/BhZD6BrJU/jjsFZRO6Y+b1RZKM+C11zGcqiPZ5eWtdfAoE7f4dOKeXcUt
	GEfg==
X-Gm-Message-State: APjAAAUwcAuSrfcNjQJhQKuVmtTUW7HCpxm24zyPZUNBwzyMSuK3N8VO
	v5G6zDriuSscHku9HeMyIUMpmFwDO7/Xm4xt9pT7TA==
X-Google-Smtp-Source: APXvYqwPHwMd4yH2k346HvarEQXN6ERvHREAkQs/lnPhnuJrgLd0KrFAd/jl4mxniPHE0F0rRBoQuH40PCilFHX5p5o=
X-Received: by 2002:a17:90a:d14a:: with SMTP id
	t10mr12064236pjw.85.1562939837401; 
	Fri, 12 Jul 2019 06:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
	<CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
	<a29ff39b8e26b1c9dd7d1f24e8991e93097225ec.camel@linuxfoundation.org>
	<CAJE9sGk59TaZiijPx5GqsJ7KVEeq3yW3ywTC7Z6phihCjua4mg@mail.gmail.com>
	<a964c86b9ef3301b22f75c2cc79af35cfa1ed598.camel@linuxfoundation.org>
	<CAJE9sGmMNHgT_N1VQo7Qi+=M+7vxBiMeA0eMsiFE8KS37hUH3g@mail.gmail.com>
In-Reply-To: <CAJE9sGmMNHgT_N1VQo7Qi+=M+7vxBiMeA0eMsiFE8KS37hUH3g@mail.gmail.com>
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Fri, 12 Jul 2019 09:56:41 -0400
Message-ID: <CAJE9sG==Zop5SKhyGsZqk13Sm+eyYjieXDLkgnSy7YedAzdMzg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Fri, 12 Jul 2019 13:57:16 -0000
Content-Type: multipart/alternative; boundary="000000000000d05c3a058d7c49f2"

--000000000000d05c3a058d7c49f2
Content-Type: text/plain; charset="UTF-8"

Richard,

I was already planning on doing some build time testing, over the weekend.
l plan to add your patches and see how it goes.  I'll let you know what I
find out.

Thanks for working on it.

-Alan

On Fri, Jul 12, 2019 at 9:03 AM Alan Kozlay <alan.kozlay@ves-solutions.com>
wrote:

> Cool, thanks!
>
> Alan Kozlay
> 443-752-0323
> Software Engineer
> VES Solutions, LLC
> Sent from my Android phone
>
> On Thu, Jul 11, 2019, 12:14 PM <richard.purdie@linuxfoundation.org> wrote:
>
>> On Wed, 2019-07-10 at 11:58 -0400, Alan Kozlay wrote:
>> > Thanks for the feedback.
>>
>> Good news is that with the basics of the work done, optimising the
>> multiconfig case turned out not to be too bad.
>>
>> I've shared some further patches on the mailing list (also in master-
>> next) and you could give those a try if you're feeling adventurous.
>>
>> I've shown they do the right thing in the test I wrote for it. Its had
>> no real world testing as yet, you're at the edge of development here.
>>
>> Cheers,
>>
>> Richard
>>
>>

-- 
Alan Kozlay
VES Solutions, LLC
Alan Kozlay <alan.kozlay@ves.solutions>
DESK 443-595-7734
CELL 443-752-0323

--000000000000d05c3a058d7c49f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Richard,<input name=3D"virtru-metadata" t=
ype=3D"hidden" value=3D"{&quot;email-policy&quot;:{&quot;state&quot;:&quot;=
closed&quot;,&quot;expirationUnit&quot;:&quot;days&quot;,&quot;disableCopyP=
aste&quot;:false,&quot;disablePrint&quot;:false,&quot;disableForwarding&quo=
t;:false,&quot;enableNoauth&quot;:false,&quot;persistentProtection&quot;:fa=
lse,&quot;expandedWatermarking&quot;:false,&quot;expires&quot;:false,&quot;=
isManaged&quot;:false},&quot;attachments&quot;:{},&quot;compose-id&quot;:&q=
uot;21&quot;,&quot;compose-window&quot;:{&quot;secure&quot;:false}}"><div><=
br></div><div>I was already planning on doing some build time testing, over=
 the weekend.</div><div>l plan to add your patches and see how it goes.=C2=
=A0 I&#39;ll let you know what I find out.</div><div><br></div><div>Thanks =
for working on it.</div><div><br></div><div>-Alan</div></div><br><div class=
=3D"gmail_quote" style=3D""><div dir=3D"ltr" class=3D"gmail_attr">On Fri, J=
ul 12, 2019 at 9:03 AM Alan Kozlay &lt;<a href=3D"mailto:alan.kozlay@ves-so=
lutions.com">alan.kozlay@ves-solutions.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto">Cool, thanks!<b=
r><br><div>Alan Kozlay<br>443-752-0323<br>Software Engineer<br>VES Solution=
s, LLC<br>Sent from my Android phone</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 11, 2019, 12:14 PM  &=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">=
richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Wed, 2019-07-10 at 11:58 -0400, Alan K=
ozlay wrote:<br>
&gt; Thanks for the feedback. <br>
<br>
Good news is that with the basics of the work done, optimising the<br>
multiconfig case turned out not to be too bad.<br>
<br>
I&#39;ve shared some further patches on the mailing list (also in master-<b=
r>
next) and you could give those a try if you&#39;re feeling adventurous.<br>
<br>
I&#39;ve shown they do the right thing in the test I wrote for it. Its had<=
br>
no real world testing as yet, you&#39;re at the edge of development here.<b=
r>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><di=
v><div dir=3D"ltr"><div><div>Alan Kozlay<br></div><div dir=3D"ltr">VES Solu=
tions, LLC<br><span>Alan Kozlay &lt;alan.kozlay@ves.solutions&gt;</span><di=
v>DESK 443-595-7734<br></div><div>CELL 443-752-0323</div></div></div></div>=
</div></span></div></div></div></div></div>

--000000000000d05c3a058d7c49f2--
