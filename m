Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail.openembedded.org (Postfix) with ESMTP id 07FCF6BD08
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Feb 2019 16:36:17 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id p6so550055wmc.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2019 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MTB1jt1htnW4mDSV8MSBikDPwJ7e4d4FFCbZb3TnRdQ=;
	b=SAsjievhXCMbos6jMqKPZyhCDz9rDWsFchBjJGg3DqvI+rYA3sMhgAw6FUlj4ZszdR
	yjFFmIPtwVppcnSA8V3qeGD4WyIbNdlE7yIFyoO+lpm5E1j0DBwfKOW/KmLDKH+39jWP
	we8gqOQbGRPZYwb+svvGHl697fe9SA9wPDEUJveiCXkUGSKN278XIdO19FMhJZiXQREF
	BTS6mXYCh5vxsEl77IJbSLVuN+wXG3V1UMh225xk3ZbiUtZa4HtQiYjy2eGI9KYDdJHN
	8pPXaDQ9JftaGm2fjyEYShFxR/jVWGT0iIYC3gSQvxahddD7nlFLe9pUp3p7O7Wr1RW+
	0k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MTB1jt1htnW4mDSV8MSBikDPwJ7e4d4FFCbZb3TnRdQ=;
	b=FrwRlRwDzUQHno5vSXTZibmAlQ5dzLZhBi1DxHtZowKOmoMAKHI7zz5ro830FHGhXa
	2X7hyiaS1Zs0j5UEHcnLK0cRJFBbOK31G97NzBcmsOyZwWdtkMXOvRtSYA4qrYoeDc7s
	zdwwuhvsd/5ueJax46BQD4rGeTyRfhUiawuHCC/BwaxvK+9HOUAC1cgBxV1cbN68q8f5
	wLkpDRtKHbQQLbfXX/EH9Pu81jP1iQ0mr918FLrryTqVZzbwScIVwRbYQl3RMnAEqe5e
	mMQoq3g6ib9Gc/W+074o0xWxZ6SrwtrQ+V6GDhNLv8rawnuSzKvGcd9ClG8cjzQbBBzZ
	gmow==
X-Gm-Message-State: AHQUAuZea/gtmUf91xp8hXaZvObGO8DMVZfzG4kAiEVkCaSrrQ9EalJw
	Kf6luZ25mZoLM2re3qc46hIOa9Oszqntor0K9G8=
X-Google-Smtp-Source: AHgI3IY/5is56utV0xSkXm9P0WIPBG6Su6kUWqBCAPmVtsalnn+7dA9H+G6buGma0gmby1gt1bvMo4xdNikzQUr7a/Y=
X-Received: by 2002:a1c:4301:: with SMTP id q1mr7608650wma.44.1549557378503;
	Thu, 07 Feb 2019 08:36:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHWfWz=EQrrUXBeSUqu6mxCd5A-Yw+yLWJxETfwW+D1AdNFPoQ@mail.gmail.com>
	<80f9feccb12a5ebc9b9e76620a5399abee3897e1.camel@linuxfoundation.org>
In-Reply-To: <80f9feccb12a5ebc9b9e76620a5399abee3897e1.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 7 Feb 2019 17:36:05 +0100
Message-ID: <CA+chaQdGJAPTGU=R7z4-gjtxEOzydRc-oTWrOk+qQM7-K03tSg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbaking recipe with patchdir in SRC_URI creates parse error
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
X-List-Received-Date: Thu, 07 Feb 2019 16:36:18 -0000
Content-Type: multipart/alternative; boundary="0000000000001adb3d058150713f"

--0000000000001adb3d058150713f
Content-Type: text/plain; charset="UTF-8"

Or just set patchdir value relative to ${S} to remove the WORKDIR reference.

On Thu, Feb 7, 2019 at 5:30 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2019-02-06 at 11:13 -0800, Cameron Kellough wrote:
> > Hi bitbake developers,
> > I'm working in a Rocko based bsp.  I've used the patchdir construct
> > in SRC_URI to apply patches in the tree where the build is expecting
> > them.  When I set PV="1.0+git${SRCPV}", I get the following error and
> > traceback if any of the patchdir directives are present in SRC_URI:
>
> The error is annoying but understandable as you've created a circular
> variable reference.
>
> In order to calculate PV which includes the git revision, it needs to
> expand SRC_URI. SRC_URI contains WORKDIR which includes PV.
>
> You could try defining a WORKDIR without PV in it, or a subset of PV?
>
> Cheers,
>
> Richard
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--0000000000001adb3d058150713f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Or just set patchdir value relative to ${S} to remove the =
WORKDIR reference.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Feb 7, 2019 at 5:30 PM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Wed, 2019-02-06 at 11:13 -0800, Cameron Kellough wrote:<br>
&gt; Hi bitbake developers,<br>
&gt; I&#39;m working in a Rocko based bsp.=C2=A0 I&#39;ve used the patchdir=
 construct<br>
&gt; in SRC_URI to apply patches in the tree where the build is expecting<b=
r>
&gt; them.=C2=A0 When I set PV=3D&quot;1.0+git${SRCPV}&quot;, I get the fol=
lowing error and<br>
&gt; traceback if any of the patchdir directives are present in SRC_URI:<br=
>
<br>
The error is annoying but understandable as you&#39;ve created a circular<b=
r>
variable reference.<br>
<br>
In order to calculate PV which includes the git revision, it needs to<br>
expand SRC_URI. SRC_URI contains WORKDIR which includes PV.<br>
<br>
You could try defining a WORKDIR without PV in it, or a subset of PV?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--0000000000001adb3d058150713f--
