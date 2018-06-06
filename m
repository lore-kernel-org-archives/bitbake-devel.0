Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f196.google.com (mail-yb0-f196.google.com
	[209.85.213.196])
	by mail.openembedded.org (Postfix) with ESMTP id 85C03770E3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 17:01:16 +0000 (UTC)
Received: by mail-yb0-f196.google.com with SMTP id w3-v6so2214735ybq.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jun 2018 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iNMWvU2dPLfLLPJWzyk0+OH2RypvHVFCOu8Yn2YiROk=;
	b=SHPliomE1eHywDsopZhZQcStL5q1OcsnHhyTbXC2hq6co5+H7WAh2al/DAT/VR0J3y
	RGesDG+rhmoesO8e63QEf3ZJI01niUV+ZbZSV+uFEgFBUyrqur8btsJLNEIXI4Mm1ICn
	xEBTlRkPhpriUvfRCD4hSLfE7ylvVg8N8crMWkXDi2H5DaBHwQsxfIoybqVgZ88tO2ZL
	0L/JaXGvLTbdIj6qI+c8TJ0MwRj+4JZDbCOigf3Itqqlz7/2JNaLOzQNqrY0C1oS3Ado
	Yklo7sJtc+IVYCIZeGtHW6xZBDb7L5ppo9Hvv36hDniDQpKCHh9mS7pqaOhC6RagChDR
	Op6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iNMWvU2dPLfLLPJWzyk0+OH2RypvHVFCOu8Yn2YiROk=;
	b=R0HL5woWDuKzXzu6LOV1zb3V6EGkyfOGPtypu+f1oTMdhI/MIgDlN8MCgrSswvzVNU
	ztOO8pXUfiZIAs86IKly7hPZYIgic8TkZfRa92+mtfYDG6djyZSP2CT3mi11TdYQimfq
	2jMbAU4ep4O0hbuVZIYqxCA+R7P1Pe2y4xMnCqFKFHBZYhJhqKHiRZVI1tzH/FNOehWV
	zD5vwsBuBL46+WdjSVD5+pLLnt09rWtVm3CvpL7fZqDULGx2DrpGkKZdDdNkMxcr6qZZ
	8pErSJkVMOPi5ZO67MpkU+S40EdekUHY169/W+EBlJe9w42Al046m60uRGxjAXs2CunD
	VyAA==
X-Gm-Message-State: APt69E0tffqR/MsrdzapuGFKfUcg2NPtzQoki9YEtyiILs9gksnthCuu
	7uB9xU4wU4AMUs4kabgd1OMmh9iwELWx8SLCA60=
X-Google-Smtp-Source: ADUXVKLXCw7YUvB/ZsjknBj1vdfFHoYXju6OwuQCFOsRUpNmGCmeJbDgbggNRvX9sKtvvn3b5PQnjiIxTCZf39SKX1c=
X-Received: by 2002:a25:bad2:: with SMTP id
	a18-v6mr1864481ybk.181.1528304477221; 
	Wed, 06 Jun 2018 10:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
	<f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
In-Reply-To: <f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Wed, 6 Jun 2018 12:00:40 -0500
Message-ID: <CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
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
X-List-Received-Date: Wed, 06 Jun 2018 17:01:16 -0000
Content-Type: multipart/alternative; boundary="000000000000793a57056dfc1dd9"

--000000000000793a57056dfc1dd9
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 6, 2018 at 9:03 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2018-06-06 at 08:36 -0500, Matt Hoosier wrote:
> > Okay, I'll see what's going on with that.


I've posted an updated copy at
http://lists.openembedded.org/pipermail/bitbake-devel/2018-June/009365.html
that address the usage of the submodule commands that were too new for
CentOS. Fortunately, their usage was basically unnecessary -- I just
deleted them outright.


> I'm still interested to
> > know if there's a listing of all the various automated regimens that
> > are used as CI before accepting Bitbake/Poky patches -- I don't want
> > to keep wasting the maintainers' time with failures that I could have
> > uncovered independently.
>
> The test matrix is basically encoded into:
>
>
> http://git.yoctoproject.org/cgit.cgi/yocto-autobuilder-helper/tree/config.json
>
> run across the various autobuilder workers on https://autobuilder.yocto
> .io/buildslaves, i.e. centos7, debian8, debian9, fedora26, fedora27,
> opensuse423, opensuse tumbleweed, ubuntu 1604 and ubuntu 1704
>
> I'm not sure its reasonable to expect everyone to test across all those
> combinations!
>

Okay, I agree. :)

I think I've managed to test at the new and old ends of each of the major
distro families there, so I'll be content let the autobuilder sniff out any
more corner cases.


>
> > Any comments on the aims and overall technique of this change? So far
> > all I've really gotten back are copy/pastes of automated builder
> > failures.
>
> I strongly believe we should only have network access in do_fetch and
> that our source mirroring should be functional and I therefore very
> much support what the patch is doing and appreciate this getting fixed.
>
> Sorry for the terse nature of the replies, we're just seeing a lot of
> patches which are breaking the regression tests and its hard to root
> cause them back to the underlying patches and help people debug them.
>
> I do appreciate the help in getting this issue fixed as it will be a
> good improvement to the fetcher.
>
> Cheers,
>
> Richard
>

Sounds great; thanks, Richard.

--000000000000793a57056dfc1dd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Jun 6,=
 2018 at 9:03 AM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxf=
oundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2018-06-06 at 08:3=
6 -0500, Matt Hoosier wrote:<br>
&gt; Okay, I&#39;ll see what&#39;s going on with that.</blockquote><div><br=
></div><div>I&#39;ve posted an updated copy at=C2=A0<a href=3D"http://lists=
.openembedded.org/pipermail/bitbake-devel/2018-June/009365.html">http://lis=
ts.openembedded.org/pipermail/bitbake-devel/2018-June/009365.html</a> that =
address the usage of the submodule commands that were too new for CentOS. F=
ortunately, their usage was basically unnecessary -- I just deleted them ou=
tright.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">I&#39;m still interested to<br>
&gt; know if there&#39;s a listing of all the various automated regimens th=
at<br>
&gt; are used as CI before accepting Bitbake/Poky patches -- I don&#39;t wa=
nt<br>
&gt; to keep wasting the maintainers&#39; time with failures that I could h=
ave<br>
&gt; uncovered independently.<br>
<br>
The test matrix is basically encoded into:<br>
<br>
<a href=3D"http://git.yoctoproject.org/cgit.cgi/yocto-autobuilder-helper/tr=
ee/config.json" rel=3D"noreferrer" target=3D"_blank">http://git.yoctoprojec=
t.org/cgit.cgi/yocto-autobuilder-helper/tree/config.json</a><br>
<br>
run across the various autobuilder workers on <a href=3D"https://autobuilde=
r.yocto" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yocto</a>=
<br>
.io/buildslaves, i.e. centos7, debian8, debian9, fedora26, fedora27,<br>
opensuse423, opensuse tumbleweed, ubuntu 1604 and ubuntu 1704<br>
<br>
I&#39;m not sure its reasonable to expect everyone to test across all those=
<br>
combinations!<br></blockquote><div><br></div><div>Okay, I agree. :)</div><d=
iv><br></div><div>I think I&#39;ve managed to test at the new and old ends =
of each of the major distro families there, so I&#39;ll be content let the =
autobuilder sniff out any more corner cases.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Any comments on the aims and overall technique of this change? So far<=
br>
&gt; all I&#39;ve really gotten back are copy/pastes of automated builder<b=
r>
&gt; failures.<br>
<br>
I strongly believe we should only have network access in do_fetch and<br>
that our source mirroring should be functional and I therefore very<br>
much support what the patch is doing and appreciate this getting fixed.<br>
<br>
Sorry for the terse nature of the replies, we&#39;re just seeing a lot of<b=
r>
patches which are breaking the regression tests and its hard to root<br>
cause them back to the underlying patches and help people debug them.<br>
<br>
I do appreciate the help in getting this issue fixed as it will be a<br>
good improvement to the fetcher.<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote><div><br></div><div>Sounds great; thanks, Richard.<=
/div></div></div>

--000000000000793a57056dfc1dd9--
