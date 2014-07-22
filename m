Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com
	[209.85.215.52])
	by mail.openembedded.org (Postfix) with ESMTP id D1ABF706AE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 15:13:51 +0000 (UTC)
Received: by mail-la0-f52.google.com with SMTP id e16so6036191lan.25
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=x+ajUOBCnqpinn9URm8xH87Ayugx1o4uV73N7j+YDlA=;
	b=dhCpjmRfySvq5b1Q8RwcNs4sa5B00uZH24geAGw+3kG4vorz3omN/AA5FZdXjJdehE
	LoCQWLIQ1ninAz7i0KWWoBulESaa9IaCJ8Xkb0SB1GpyJ05CJsfvPwonrpsnbklLtut6
	bSN2hfeBBlQQhRL9SbnmUfH+DBZf2eNfQ8Nqr9gApdwrMUnyOBkWCU3V917uzlcjp4Ha
	/ncOEiOnpRNzTs2zNj5uvqoDIV7ZPDV9KPtfz5AoNnW0PcBLxAiYgMnrwrA5DhTF1sVU
	2Eyt9qk3rw3KFslcHAcc8zRgsYxzgZuAn0VYU/tF2UUNRFSAa5jFx6Rpy81dziAxNNmJ
	ulKg==
X-Received: by 10.153.4.6 with SMTP id ca6mr4382061lad.32.1406042031753; Tue,
	22 Jul 2014 08:13:51 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.63.72 with HTTP; Tue, 22 Jul 2014 08:13:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1407220618060.25977@localhost>
References: <alpine.LFD.2.11.1407220618060.25977@localhost>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 22 Jul 2014 08:13:31 -0700
X-Google-Sender-Auth: csysHs9ovNpzVSZ2mUAXB_0NHQA
Message-ID: <CABcZAN=nRqo7sYm9=MkAT0r0uAnR_oVBMEnMYGJz_=h-mZ6p2Q@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: should "bitbake -e" refer to per-recipe, not per-package?
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
X-List-Received-Date: Tue, 22 Jul 2014 15:13:52 -0000
Content-Type: multipart/alternative; boundary=001a1133ee5ad790e304fec9abf8

--001a1133ee5ad790e304fec9abf8
Content-Type: text/plain; charset=UTF-8

On Tue, Jul 22, 2014 at 3:19 AM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:

>   i notice that, in "bitbake -h", the explanation of "bibake -e" is
> that it potentially allows the display of "per-package" environment
> info. should that not more accurately say "per-recipe"?
>

Yep.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1133ee5ad790e304fec9abf8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Tue, Jul 22, 2014 at 3:19 AM=
, Robert P. J. Day <span dir=3D"ltr">&lt;<a href=3D"mailto:rpjday@crashcour=
se.ca" target=3D"_blank">rpjday@crashcourse.ca</a>&gt;</span> wrote:<br><di=
v class=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":18j" class=3D"a3s" style=3D"over=
flow:hidden">=C2=A0 i notice that, in &quot;bitbake -h&quot;, the explanati=
on of &quot;bibake -e&quot; is<br>


that it potentially allows the display of &quot;per-package&quot; environme=
nt<br>
info. should that not more accurately say &quot;per-recipe&quot;?</div></bl=
ockquote></div><br></div><div class=3D"gmail_extra">Yep.<br>-- <br>Christop=
her Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded=
, OpenZaurus<br>

Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a1133ee5ad790e304fec9abf8--
