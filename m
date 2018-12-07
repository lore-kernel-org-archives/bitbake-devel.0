Return-Path: <aaron@assonance.org>
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
	[209.85.167.178])
	by mail.openembedded.org (Postfix) with ESMTP id EA5DA79CBF
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 14:03:02 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id x23so3439070oix.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=assonance-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eas3Zz6XhkpWXQ2u/k7ZguL0F3fUosY7SvMRKOJrfQU=;
	b=qqMPjovGC0vhrdRntIabHgMlRaNWnidzg8PUf4YfnvUlKlS6piXy5M6cA+AjRg3+UN
	LXq88lid8+GXoc5ZH3iTu2BvZOTnvZ5ZKLypGU3Q2lfxWJsB5kaIgn6bAO7PHjP3g87S
	tEFp/U5G1CBijRTP4iEh7hk1zbX9RpWdbT7eLtKtvwQBLlOBwDb8vStri/6EdZkp2eDH
	4WuzjjjHmCCjdSjRlplUPvF/8/ZOEhCrit0J/BX+0N0FZzfkEC5G3c1j9QUSB/FCubul
	e3EzDvYF72CCT/hx6YxpGphtVLtaSSevBJpwHtoeVJjfx2g3Y2gsh2c4Ex96pu35gwm5
	G0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eas3Zz6XhkpWXQ2u/k7ZguL0F3fUosY7SvMRKOJrfQU=;
	b=CIxpDgl8GjcVSp9U6MpjqNY+JD2+EN7bDtvN36rXYGd9CHCw6rJ+bkgbUCHkT9c7a4
	YQPqcCP0GWis81LnZHezio03aefqnJsTokQbM4rPq7Qr6TxMkKqx/VTJKyBMCqwU3b0q
	RzyLi60UFv/6nvlZgITSM2JsHWPIO46PU+eDLISR8bSWYq20TapWYhwXVNvNnqawTiWN
	duZ5NGaL95EPVaZ8bLac/rtdxPRjEhU/lEGFi1nksnnLEJwkm24c7f2eoaXcZZIF+jUS
	OQAwxuZwpDTN5SRjK6U7WEXxKO+5/wTRXDbmA68dLQMIgTAElwcBGwX05sHr+sxwKFkQ
	M2NA==
X-Gm-Message-State: AA+aEWYts0Wt0V3uiM81Kqv5KR+AxlQWpH1vTNWWd8scA21CVR4S1ec7
	StI1KLzufVJScj1awImSf13dQhzIIzgdUplgbvRHew==
X-Google-Smtp-Source: AFSGD/V1ExvM3YzS8N+oKArdI6JsQtrqNSZ4vQqKwEmfcj1yjF/sGAOpn0K18z6BB7GC0zBrxB4BA9/0iGVmJnLIR1g=
X-Received: by 2002:a54:440d:: with SMTP id k13mr1354425oiw.263.1544191379071; 
	Fri, 07 Dec 2018 06:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20181206185535.12523-1-JPEWhacker@gmail.com>
	<76873c27c0f7da4f8339b25f009150d7b38d1e72.camel@linuxfoundation.org>
	<CAJdd5GbfV4vm9eoCPYxme7s31vvoK-M_jbCPKfzkLWxNH=BT-w@mail.gmail.com>
	<eb636ddb0503dd0c271d51b3f7de32b23096fe51.camel@linuxfoundation.org>
In-Reply-To: <eb636ddb0503dd0c271d51b3f7de32b23096fe51.camel@linuxfoundation.org>
From: Aaron Cohen <aaron@assonance.org>
Date: Fri, 7 Dec 2018 09:02:48 -0500
Message-ID: <CAFSZm+h7PdKf0+V=CdBQthJHD-fDW4ysWOH3y8Frr5esF3oqSQ@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Add a variable to pass flags to fakeroot (pseudo)
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
X-List-Received-Date: Fri, 07 Dec 2018 14:03:03 -0000
Content-Type: multipart/alternative; boundary="0000000000009d9132057c6f1283"

--0000000000009d9132057c6f1283
Content-Type: text/plain; charset="UTF-8"

Using split() will break if the path contains a space if that is a concern.

On Fri, Dec 7, 2018 at 8:04 AM <richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2018-12-06 at 21:27 -0600, Joshua Watt wrote:
> > On Thu, Dec 6, 2018 at 4:05 PM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > On Thu, 2018-12-06 at 12:55 -0600, Joshua Watt wrote:
> > > > It is occasionally useful to pass additional flags to fakeroot
> > > > (pseudo)
> > > > either for debugging or for behavioral system changes. Add a
> > > > variable
> > > > called "FAKEROOTARGS" that can be used for this purpose.
> > >
> > > Why wouldn't you just append to FAKEROOT/FAKEROOTCMD ?
> >
> > You can't currently add arguments to FAKEROOTCMD because it is passed
> > as an array member to subprocess.Popen sort of like:
> >
> >  subprocess.Popen([d.getVar('FAKEROOTCMD'), 'blah', 'blah', ...
> >
> > In order to pass arguments, it would probably have to have split into
> > an array i.e. :
> >
> >  subprocess.Popen(d.getVar('FAKEROOTCMD').split() + ['blah', 'blah',
> > ...
> >
> > I wasn't sure if that was desirable or if it would break anything, so
> > I went with the lower risk approach of adding a new variables. I can
> > certainly make a change to modify the usage of FAKEROOTCMD as
> > described above and simply append the flags to it if that is
> > preferred.
>
> I'd prefer to fix this to work than add more variables...
>
> Cheers,
>
> Richard
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--0000000000009d9132057c6f1283
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Using split() will break if the path contains a space if that is a con=
cern.<br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri,=
 Dec 7, 2018 at 8:04 AM &lt;<a href=3D"mailto:richard.purdie@linuxfoundatio=
n.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Thu, 2018-12-06 at 21:27 -0600, Joshua Watt wrote:=
<br>
&gt; On Thu, Dec 6, 2018 at 4:05 PM Richard Purdie<br>
&gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_b=
lank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt; On Thu, 2018-12-06 at 12:55 -0600, Joshua Watt wrote:<br>
&gt; &gt; &gt; It is occasionally useful to pass additional flags to fakero=
ot<br>
&gt; &gt; &gt; (pseudo)<br>
&gt; &gt; &gt; either for debugging or for behavioral system changes. Add a=
<br>
&gt; &gt; &gt; variable<br>
&gt; &gt; &gt; called &quot;FAKEROOTARGS&quot; that can be used for this pu=
rpose.<br>
&gt; &gt; <br>
&gt; &gt; Why wouldn&#39;t you just append to FAKEROOT/FAKEROOTCMD ?<br>
&gt; <br>
&gt; You can&#39;t currently add arguments to FAKEROOTCMD because it is pas=
sed<br>
&gt; as an array member to subprocess.Popen sort of like:<br>
&gt; <br>
&gt;=C2=A0 subprocess.Popen([d.getVar(&#39;FAKEROOTCMD&#39;), &#39;blah&#39=
;, &#39;blah&#39;, ...<br>
&gt; <br>
&gt; In order to pass arguments, it would probably have to have split into<=
br>
&gt; an array i.e. :<br>
&gt; <br>
&gt;=C2=A0 subprocess.Popen(d.getVar(&#39;FAKEROOTCMD&#39;).split() + [&#39=
;blah&#39;, &#39;blah&#39;,<br>
&gt; ...<br>
&gt; <br>
&gt; I wasn&#39;t sure if that was desirable or if it would break anything,=
 so<br>
&gt; I went with the lower risk approach of adding a new variables. I can<b=
r>
&gt; certainly make a change to modify the usage of FAKEROOTCMD as<br>
&gt; described above and simply append the flags to it if that is<br>
&gt; preferred.<br>
<br>
I&#39;d prefer to fix this to work than add more variables...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div></div>

--0000000000009d9132057c6f1283--
