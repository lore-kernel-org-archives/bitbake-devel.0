Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182])
	by mail.openembedded.org (Postfix) with ESMTP id E4E636EE4D
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Mar 2014 04:50:36 +0000 (UTC)
Received: by mail-lb0-f182.google.com with SMTP id n15so3725651lbi.41
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 01 Mar 2014 20:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=K/UH7D5vuS4+JLNY1tNClIPhlb84PRgBVt/Y89BtTl0=;
	b=zzXOxugPc0KtyQmRbJXzODLNakg6tKj1iiVoEQcGzG4S0Iy/FV3e7ZqlSbU7lfNOcs
	IIqDeYfwC/x7ykajJv7i3a9GUrEc3TV6NjMgsiz73XVZ/A2VN7UEl1lp1OAzfGBbgUur
	yoT2Pv6zYgM6dudOvR65aUQ3q3oKgSaK76sz64eHZaaO/t+k1xf5IWiiBXGsF3r/8F8T
	AlhKzfEjWGkFwfJ242ybHa7FwYodsFe7JimLnM5tRrc2348XI9WUP2JAFYliJ5awdDn5
	btW6mLHooz+HwjiqVR6KbA6+Zj6q8+VcRB/te68R1uXTzWIfAFvoMjIIlytN3G1XhZNt
	sS1w==
X-Received: by 10.152.25.193 with SMTP id e1mr1554204lag.13.1393735836323;
	Sat, 01 Mar 2014 20:50:36 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.35.200 with HTTP; Sat, 1 Mar 2014 20:50:16 -0800 (PST)
In-Reply-To: <1393608174.31769.199.camel@ted>
References: <1393608174.31769.199.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 1 Mar 2014 21:50:16 -0700
X-Google-Sender-Auth: OvjfSPQCwoIAxRT8YF9ta1Q4j4M
Message-ID: <CABcZANnkVHatSbYqJAL3ZR6uKORYB=1hdBiwZOUXfCad4S2T8w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Separate out an ls-remote function
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
X-List-Received-Date: Sun, 02 Mar 2014 04:50:37 -0000
Content-Type: multipart/alternative; boundary=089e0158c5846f539004f39869ce

--089e0158c5846f539004f39869ce
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 28, 2014 at 10:22 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> -    def _latest_revision(self, ud, d, name):
> +    def __lsremote(self, ud, d, search):
>

Are we sure we want to use __ here? Double-underscore will trigger python
internal name mangling. While using it doesn't break anything, it doesn't
really buy us much either vs _, and makes inspection of the class/object
rather ugly, IMO :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0158c5846f539004f39869ce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 28, 2014 at 10:22 AM, Richard Purdie <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard=
.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1de" class=3D"a3s" style=3D"over=
flow:hidden">- =C2=A0 =C2=A0def _latest_revision(self, ud, d, name):<br>
+ =C2=A0 =C2=A0def __lsremote(self, ud, d, search):</div></blockquote></div=
><br></div><div class=3D"gmail_extra">Are we sure we want to use __ here? D=
ouble-underscore will trigger python internal name mangling. While using it=
 doesn&#39;t break anything, it doesn&#39;t really buy us much either vs _,=
 and makes inspection of the class/object rather ugly, IMO :)<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--089e0158c5846f539004f39869ce--
