Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
	[209.85.215.51])
	by mail.openembedded.org (Postfix) with ESMTP id 2FBA86B2BC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 16:29:58 +0000 (UTC)
Received: by mail-la0-f51.google.com with SMTP id ec20so5551107lab.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Z9m4xAKZ2u7vwYgt5dXIQbVSvJOiTGDOp39YuBfYN2k=;
	b=UnUGxw+p05VtspINX3b2UBTooTE3KgNxV2BtsZSfUg6nfwboEEN7NvPjbR0v5Ba1wi
	3Lw0zGs4xQN0KMKL3G3JZVae3khMjJ/0MFwnKXnSomM+l+Hkz74rmfi3Xz2ix/+CyrCw
	9WZlHkwOJdyHN4p+cDMJ1Vy/QD+U43rv4t3E7Q3nq//0t90M9w7+L0a9ddcNARqWisa+
	9N09cIDYfc3z2dXjHnHsKRYEkLakjkxj/n93L9qDgpTjO2NU7kHIJHlYDPj00Hf4RIov
	u2t9PhrBGxgoj/w+s8yJhZ4meC9iBDV/wvC9dqvetv2TNtFpdd+2Qkel5RRbEKakdfhZ
	+yCQ==
X-Received: by 10.112.167.228 with SMTP id zr4mr9947870lbb.56.1388420998574;
	Mon, 30 Dec 2013 08:29:58 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.22.167 with HTTP; Mon, 30 Dec 2013 08:29:38 -0800 (PST)
In-Reply-To: <CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 30 Dec 2013 09:29:38 -0700
X-Google-Sender-Auth: 9YlRcoiJHC6x-nU6PjE1IuDHrfk
Message-ID: <CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Mon, 30 Dec 2013 16:29:59 -0000
Content-Type: multipart/alternative; boundary=001a11c2432a6b36cc04eec2f441

--001a11c2432a6b36cc04eec2f441
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2013 at 9:18 AM, Chris Larson <clarson@kergoth.com> wrote:

> On Sat, Dec 28, 2013 at 6:24 AM, Martin Jansa <martin.jansa@gmail.com>wro=
te:
>
>> On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie wrote:
>> > Its useful to understand where the delta starts against an existing
>> sstate cache
>> > for a given target. Adding this to the output of the -S option seems
>> like a
>> > natural fit.
>> >
>> > We use the hashvalidate function to figure this out and assume it can
>> find siginfo
>> > files for more than just the setscene tasks.
>>
>> I haven't tried to find smaller reproducer or exact part of code where
>> it happends, but in bigger builds I have it fails with
>>
>> I'll try to reproduce and narrow it a bit, but if you have tip where
>> to look first..
>>
>> IndexError: list index out of range:
>
>
> I=E2=80=99m hitting this now as well.


To clarify further, I=E2=80=99m hitting this with stock poky master, qemux8=
6,
bitbake -S core-image-base.

Actually, this is getting in my way trying to do something I don=E2=80=99t =
want it
doing anyway. I want to dump the signature data from one config, and use
bitbake-whatchanged from another build. If I wanted to compare something
right here, I=E2=80=99d have run bitbake-whatchanged. This change confuses =
me a
bit. -S emits signature data, according to the bitbake help and the
semantics of the command. Are we trying to kill bitbake-whatchanged in
favor of making -S do both jobs, emit and compare?
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c2432a6b36cc04eec2f441
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Dec 30, 2013 at 9:18 AM, Chris Larson <span dir=3D"ltr">&lt;<a href=
=3D"mailto:clarson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Sat, Dec 28, 2013 at 6:=
24 AM, Martin Jansa <span dir=3D"ltr">&lt;<a href=3D"mailto:martin.jansa@gm=
ail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt;</span> wrote:<br>

<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Wed, Dec 18, 2013 at 04:21:27PM +000=
0, Richard Purdie wrote:<br>
&gt; Its useful to understand where the delta starts against an existing ss=
tate cache<br>
&gt; for a given target. Adding this to the output of the -S option seems l=
ike a<br>
&gt; natural fit.<br>
&gt;<br>
&gt; We use the hashvalidate function to figure this <span><span class=3D"i=
l">out</span></span> and assume it can find siginfo<br>
&gt; files for more than just the setscene tasks.<br>
<br>
</div>I haven&#39;t tried to find smaller reproducer or exact part of code =
where<br>
it happends, but in bigger builds I have it fails with<br>
<br>
I&#39;ll try to reproduce and narrow it a bit, but if you have tip where<br=
>
to look first..<br>
<br>
<span><span class=3D"il">IndexError</span></span>: <span><span class=3D"il"=
>list</span></span> <span><span class=3D"il">index</span></span> <span><spa=
n class=3D"il">out</span></span> of <span><span class=3D"il">range</span></=
span>:</blockquote>

</div><br></div>I=E2=80=99m hitting this now as well.</blockquote></div><br=
>To clarify further, I=E2=80=99m hitting this with stock poky master, qemux=
86, bitbake -S core-image-base.</div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">

Actually, this is getting in my way trying to do something I don=E2=80=99t =
want it doing anyway. I want to dump the signature data from one config, an=
d use bitbake-whatchanged from another build. If I wanted to compare someth=
ing right here, I=E2=80=99d have run bitbake-whatchanged. This change confu=
ses me a bit. -S emits signature data, according to the bitbake help and th=
e semantics of the command. Are we trying to kill bitbake-whatchanged in fa=
vor of making -S do both jobs, emit and compare?<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a11c2432a6b36cc04eec2f441--
