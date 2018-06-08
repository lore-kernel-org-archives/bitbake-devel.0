Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f195.google.com (mail-yb0-f195.google.com
	[209.85.213.195])
	by mail.openembedded.org (Postfix) with ESMTP id 7FAD5745B7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jun 2018 13:28:27 +0000 (UTC)
Received: by mail-yb0-f195.google.com with SMTP id x128-v6so4143786ybg.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jun 2018 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jhyWJhj8BTRyXudsJkmng2wloZE1huadMoPfBzt5OtE=;
	b=kUvXD32NbihmedosNz93DeKZ8HdyMyg21eRFNC0j3xfrD2VdqN7hWaN6g/yzmUUyGx
	6w8z5ptrlJbq2OdZm9zLkjwrPFDaCBANWJ/6a0faj3wJFm/wHuKsdINyRQQG/wlT3TiV
	cgsyIu88mNcKn6g5eglcgqnSHCzIHe6jF5Il2ufO4qSkbr6j8aInrzj+KQrBoBdDqIpd
	jKRQYnUT+88EDyLdL2JJVsrFeOi1D7RF80Y/HRPxzKSplPn79QyznkBcDVzTBrd2bJfJ
	tCgb46bcwSWS1DBVLcl25lQIa2lyJW4K6br8GZ4vz4cfC1NLKjUCARLkj2HRyVuUkTUQ
	lGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jhyWJhj8BTRyXudsJkmng2wloZE1huadMoPfBzt5OtE=;
	b=RI70KSS5IeyEkaCR1GD+0ESP7qBhDNf9bgzQje4R98taRy6mKJJRg3deZI9SM8/d3V
	AJvdFvW6sjyk8pBPCRomrnNnywETDD+c975xmYeurlyXnPSRqRx3v2EKp4YDIG/BtKoQ
	Q7F7lxDG8H6a//ruKRgg+Ass39quDpud9l0V6XhimJe8OpsRCkLjmNHs+dJlcuMVeDJD
	N2ta8bseJoTt0xzkTynrLgZ7ijOFUrQDs6/C8LTXi5sy7ng1DyUy1WTWnyur2bni5Ke8
	3TXBt3hE0uucUs68ErFXuh8GjBzvEG+HirH9gbV5sQIu1XXEwtsJnHIlCTTU5yagLxAt
	jHHQ==
X-Gm-Message-State: APt69E1NFOpySNG63d2PpNTePhwTig7uFznb6c5gOlW8AEGEacz3pAtf
	PgF7iTBbnE8v63x3e7Ntv/cYzzIY+esIzJBsdP8=
X-Google-Smtp-Source: ADUXVKKfM3dbYKeC7l3fDtB5iTXwCin+mm1Co1XZH6zykzPYjAn0WAsjv40rNUJhSXcb+6N5O/REc41WgF2CtQSFMhk=
X-Received: by 2002:a25:ced0:: with SMTP id
	x199-v6mr3767835ybe.100.1528464508401; 
	Fri, 08 Jun 2018 06:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
	<f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
	<CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
	<CAJgxT3__308KPPC9MS+xOA9ExnUgYAx6bS82RLfG41A8vk=pBg@mail.gmail.com>
	<65e369d383320a651429a9b59a8eb71c862b1d95.camel@linuxfoundation.org>
	<CAJgxT3_UDioHqCadrXKBqJYw1GE54mgcK5DM_RB68_kCCfTdDA@mail.gmail.com>
	<687733779e6ea63ae93d800e0f04c02bbd55d4d4.camel@gmail.com>
In-Reply-To: <687733779e6ea63ae93d800e0f04c02bbd55d4d4.camel@gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 8 Jun 2018 08:27:52 -0500
Message-ID: <CAJgxT39s318W9ov7oQEd70gbRE_YFyj7RAk4Vz7s8WDBfmJitg@mail.gmail.com>
To: Josh Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 08 Jun 2018 13:28:27 -0000
Content-Type: multipart/alternative; boundary="000000000000133d40056e21608f"

--000000000000133d40056e21608f
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 8, 2018 at 8:17 AM Joshua Watt <jpewhacker@gmail.com> wrote:

> On Fri, 2018-06-08 at 07:36 -0500, Matt Hoosier wrote:
>
> On Fri, Jun 8, 2018 at 5:20 AM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2018-06-07 at 08:47 -0500, Matt Hoosier wrote:
> > Thanks for the help getting this landed. With this change being part
> > of Bitbake, what's the procedure for attempting to get it backported
> > to the final MR of Yocto 2.2? Do I just backport it to a certain
> > maintenance branch of Bitbake (announced somehow with a prefix on the
> > git-send-email subject) and it would magically pop up out the
> > corresponding branch of poky if accepted to Bitbake?
>
> With bitbake its a case of requesting backports to the appropriate
> stable release branches, either in the form of a patch with [1.3X] in
> the subject, or just mention which revision to cherry-pick to which
> branch if it cherry-picks cleanly.
>
> I think to get back to 2.2, we'd have to backport to 1.38, 1.36, 1.34
> and 1.32. I do get nervous about patches which land in master and then
> immediately get backported across so many releases. I'm less nervous if
> the patches cleanly cherry-pick as at least the code is the same. How
> cleanly does it backport?
>
> Cheers,
>
> Richard
>
>
> It's not a completely clean back-port; some of the context lines don't
> match because of changes to the logic that detect when a repository uses
> gitsubmodules to begin with. The actual logic changes lift pretty-much
> straight in though.
>
> I appreciate your point about being cautious when putting unproven code
> straight into a branch that gets used for maintenance releases though. So I
> could understand wanting to let it prove out on master for a while.
> Conversely, there are no recipes in Poky that use gitsm to begin with, so I
> don't know how much additional confidence would really be gained just
> through time. Is that also an argument that the potential impact to the
> stable branch of poky's own metadata is small?
>
>
> It might be worth looking through meta-oe also, at least as a reference
> point.
>
>
I don't think there are any recipes using gitsm:// protocol in git://
git.openembedded.org/meta-openembedded either (at least, on the 2.2 branch).

--000000000000133d40056e21608f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Jun 8,=
 2018 at 8:17 AM Joshua Watt &lt;<a href=3D"mailto:jpewhacker@gmail.com">jp=
ewhacker@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div><div>On Fri, 2018-06-08 at 07:36 -0500, Matt Hoosier wrote:</div><block=
quote type=3D"cite" style=3D"margin:0 0 0 .8ex;border-left:2px #729fcf soli=
d;padding-left:1ex"><div dir=3D"ltr">On Fri, Jun 8, 2018 at 5:20 AM Richard=
 Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D=
"_blank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br><div class=3D=
"gmail_quote"><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex;border-l=
eft:2px #729fcf solid;padding-left:1ex">On Thu, 2018-06-07 at 08:47 -0500, =
Matt Hoosier wrote:<br>
&gt; Thanks for the help getting this landed. With this change being part<b=
r>
&gt; of Bitbake, what&#39;s the procedure for attempting to get it backport=
ed<br>
&gt; to the final MR of Yocto 2.2? Do I just backport it to a certain<br>
&gt; maintenance branch of Bitbake (announced somehow with a prefix on the<=
br>
&gt; git-send-email subject) and it would magically pop up out the<br>
&gt; corresponding branch of poky if accepted to Bitbake?<br>
<br>
With bitbake its a case of requesting backports to the appropriate<br>
stable release branches, either in the form of a patch with [1.3X] in<br>
the subject, or just mention which revision to cherry-pick to which<br>
branch if it cherry-picks cleanly.<br>
<br>
I think to get back to 2.2, we&#39;d have to backport to 1.38, 1.36, 1.34<b=
r>
and 1.32. I do get nervous about patches which land in master and then <br>
immediately get backported across so many releases. I&#39;m less nervous if=
<br>
the patches cleanly cherry-pick as at least the code is the same. How<br>
cleanly does it backport?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br></blockquote><div><br></div><div>It&#39;s not a completely clean back-p=
ort; some of the context lines don&#39;t match because of changes to the lo=
gic that detect when a repository uses gitsubmodules to begin with. The act=
ual logic changes lift pretty-much straight in though.</div><div><br></div>=
<div>I appreciate your point about being cautious when putting unproven cod=
e straight into a branch that gets used for maintenance releases though. So=
 I could understand wanting to let it prove out on master for a while. Conv=
ersely, there are no recipes in Poky that use gitsm to begin with, so I don=
&#39;t know how much additional confidence would really be gained just thro=
ugh time. Is that also an argument that the potential impact to the stable =
branch of poky&#39;s own metadata is small?</div></div></div>
</blockquote><div><br></div><div>It might be worth looking through meta-oe =
also, at least as a reference point.</div><div><br></div></div></blockquote=
><div><br></div><div>

<span style=3D"background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline">I don&#39;t th=
ink there are any recipes using gitsm:// protocol in git://<a href=3D"http:=
//git.openembedded.org/meta-openembedded">git.openembedded.org/meta-openemb=
edded</a> either (at least, on the 2.2 branch).</span>=C2=A0</div></div></d=
iv>

--000000000000133d40056e21608f--
