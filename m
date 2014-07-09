Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
	[209.85.215.45])
	by mail.openembedded.org (Postfix) with ESMTP id 297AE7042B
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 15:00:03 +0000 (UTC)
Received: by mail-la0-f45.google.com with SMTP id hr17so5145493lab.18
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=IMzCM/zE4sb1GxAOIWlDI1kbj7I6uz8x/OWPE8XhZ3M=;
	b=MJ+TEW83mn3wdB1jlJsAPtMZGlx0G+DqKTwjAa7GQiMYc5c/M0DzWj+/2Pa5d9m6HV
	KQc7DG9iu9mSo2OcsMHSSPdFvGtiYlBTL3yqzX5SVm9qZWJ+2gxyHfQLdRqe9x9iOHz/
	VEr4xu/45BAYd7R3LoC8vnL84NjdqZICHbFiEuG0C1PekbwdZE12jIy1Hidd2avBfw0G
	1w3uM7uoKd+Ari4/h0BUqEwxyKpe1xDHlia9oHLhaYFwWuvyPC5LeNj8dAmabzeao03c
	2fsjtS2no/8x3EfbTgXtWTusUOBWtgm6iyEEPauGfBKfdqDPNR4rwNEntsHa0h28aSzV
	9QjQ==
X-Received: by 10.152.19.164 with SMTP id g4mr32739033lae.47.1404918003421;
	Wed, 09 Jul 2014 08:00:03 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.168.66 with HTTP; Wed, 9 Jul 2014 07:59:43 -0700 (PDT)
In-Reply-To: <CAMCLREqp5Yy5zNx9TPbvUjnQ4qo2o5cG6z3RQmaEsqecU+r5LA@mail.gmail.com>
References: <1404832184-16471-1-git-send-email-vitaliy.kharin@lge.com>
	<CABcZANmdpjjGExdJktZUz0owXynDmqhmLVWZnZMqq0GqWx6YRQ@mail.gmail.com>
	<CAMCLREqp5Yy5zNx9TPbvUjnQ4qo2o5cG6z3RQmaEsqecU+r5LA@mail.gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 9 Jul 2014 07:59:43 -0700
X-Google-Sender-Auth: p6b825xFUl1NzY4wH-ryxJL2_GU
Message-ID: <CABcZANn8wEF=NhW8n6Mtsh8yWkZmPbCE69qDim-tkfMLLwSNSQ@mail.gmail.com>
To: Vitaliy Kharin <kvserr@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bb.utils.which is intend to locate regular file only as it is written in comment
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
X-List-Received-Date: Wed, 09 Jul 2014 15:00:13 -0000
Content-Type: multipart/alternative; boundary=089e014942308858ea04fdc3f615

--089e014942308858ea04fdc3f615
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 9, 2014 at 3:43 AM, Vitaliy Kharin <kvserr@gmail.com> wrote:

> Actually it would return true if path will be a symlink. I checked it.
> Also please look at
> https://docs.python.org/2/library/os.path.html#os.path.isfile
> "...This follows symbolic links, so both islink()
> <https://docs.python.org/2/library/os.path.html#os.path.islink> and
> isfile() <https://docs.python.org/2/library/os.path.html#os.path.isfile> can
> be true for the same path."
>

Ah, good, I stand corrected. Thanks for the clarification.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e014942308858ea04fdc3f615
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jul 9, 2014 at 3:43 AM, Vitaliy Kharin <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:kvserr@gmail.com" target=3D"_blank">kvserr@gmail.com</a>&gt;</s=
pan> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"gmail_default"><span style=3D"=
font-size:large">Actually it would return true if path will be a symlink. I=
 checked it.</span></div>

<div class=3D"gmail_default"><span style=3D"font-size:large">Also please lo=
ok at <a href=3D"https://docs.python.org/2/library/os.path.html#os.path.isf=
ile" target=3D"_blank">https://docs.python.org/2/library/os.path.html#os.pa=
th.isfile</a></span></div>



<div class=3D"gmail_default"><span style=3D"font-size:large">&quot;...</spa=
n><span style=3D"color:rgb(0,0,0);font-family:sans-serif;font-size:16px;lin=
e-height:20.799999237060547px;text-align:justify">This follows symbolic lin=
ks, so both=C2=A0</span><a href=3D"https://docs.python.org/2/library/os.pat=
h.html#os.path.islink" title=3D"os.path.islink" style=3D"color:rgb(53,95,12=
4);text-decoration:none;font-family:sans-serif;font-size:16px;line-height:2=
0.799999237060547px;text-align:justify" target=3D"_blank"><tt style=3D"padd=
ing:0px 1px;font-size:0.95em;font-weight:bold;background-color:transparent"=
><span>islink()</span></tt></a><span style=3D"color:rgb(0,0,0);font-family:=
sans-serif;font-size:16px;line-height:20.799999237060547px;text-align:justi=
fy">=C2=A0and=C2=A0</span><a href=3D"https://docs.python.org/2/library/os.p=
ath.html#os.path.isfile" title=3D"os.path.isfile" style=3D"color:rgb(53,95,=
124);text-decoration:none;font-family:sans-serif;font-size:16px;line-height=
:20.799999237060547px;text-align:justify" target=3D"_blank"><tt style=3D"pa=
dding:0px 1px;font-size:0.95em;font-weight:bold;background-color:transparen=
t"><span>isfile()</span></tt></a><span style=3D"color:rgb(0,0,0);font-famil=
y:sans-serif;font-size:16px;line-height:20.799999237060547px;text-align:jus=
tify">=C2=A0can be true for the same path.</span><span style=3D"font-size:l=
arge">&quot;</span></div>

</blockquote></div><br></div><div class=3D"gmail_extra">Ah, good, I stand c=
orrected. Thanks for the clarification.<br>-- <br>Christopher Larson<br>cla=
rson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>

Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--089e014942308858ea04fdc3f615--
