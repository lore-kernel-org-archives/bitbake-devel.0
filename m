Return-Path: <alexandru.damian@intel.com>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
	[209.85.218.51])
	by mail.openembedded.org (Postfix) with ESMTP id 00C6D738FA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2015 12:41:23 +0000 (UTC)
Received: by oifz81 with SMTP id z81so28893515oif.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2015 05:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:content-type;
	bh=/MUvw412Bol0LHbTtaK2cv795Nf632bmF1uY4POgcso=;
	b=ZXvv39EdW7cjptdp7cRX+o0RmqPwb3Ee96iRsp0rUHmQbpIEjH9ZhPa4RzQHw0iGCv
	qI5P6Vj6Q6rpOhyM3Vr5U7+0DA8IUSp7JXgQqIQD90xVIUf+cmIodV4tAnOZlf3D8uf2
	SGg0+vH72F1+d1a+3h/FW+p2ZVXMJe92+dASywhbyPymf+UYwjXXICZpmRxd+MWYb0Tb
	gP3DD7uzPIkZZmqW9TDiHvIoz2LrxTxg3ZN4p5kHFpXQcMc/bOZHFA9bVOF+DzQ+Evk7
	Z2FsU17O0PUwFaiP0HTLhKjHjg6UKAe4WgWJQHsYnuxtMuBZ241NrMc20QOHDzLJyEiP
	FqGQ==
X-Gm-Message-State: ALoCoQmtzig1SlrMFMSZhzX34y900DbDLyZ1EallQjNDzvdcX0SXVNuoK+Pno/2ey9ILxTAncSmC
X-Received: by 10.60.63.139 with SMTP id g11mr21235487oes.42.1425904884774;
	Mon, 09 Mar 2015 05:41:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.131.135 with HTTP; Mon, 9 Mar 2015 05:41:04 -0700 (PDT)
In-Reply-To: <CAJ2CSBuBpV9ZAei94pT2=oqxnA2J4tfAkvatwDRpzjxaxTOZgQ@mail.gmail.com>
References: <CAJ2CSBuBpV9ZAei94pT2=oqxnA2J4tfAkvatwDRpzjxaxTOZgQ@mail.gmail.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 9 Mar 2015 12:41:04 +0000
Message-ID: <CAJ2CSBu0WdR1FEFkkRJV5jFD0PyyoiaSS+eWUyVXkQhmE40Ssg@mail.gmail.com>
To: "toaster@yoctoproject.org" <toaster@yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [review-request] bitbake patches for improving handling with toaster
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
X-List-Received-Date: Mon, 09 Mar 2015 12:41:24 -0000
Content-Type: multipart/alternative; boundary=001a11c1dab22432570510da5a86

--001a11c1dab22432570510da5a86
Content-Type: text/plain; charset=UTF-8

This was taken for submission on the toaster patch set,

Thank you,
Alex

On Fri, Mar 6, 2015 at 3:56 PM, Damian, Alexandru <
alexandru.damian@intel.com> wrote:

> Hello,
>
> I've pushed a set of bitbake patches that improve toaster operations.
>
> The changes are:
>
> * fix for https://bugzilla.yoctoproject.org/show_bug.cgi?id=7316  - log
> all file change notifications that happen during a build in an idle
> function, and update the cache during initial build setup for all changed
> files; this allows bitbake to process a large number of notifications
>
> * fix for https://bugzilla.yoctoproject.org/show_bug.cgi?id=7398 - the
> "xmlrpc" server should delete offending idle functions that raise errors
> instead of ignoring errors; the "process" server already does this
>
> * deleted old GUI test data and render tests in-operable due to changes in
> the database structure that were not followed by updating tests/database
> fixtures; it's better to have no data than to have bad data
>
> * improved handling of client connection processing, reducing the number
> of situation where a server is rendered in-accessible by a client
>
>
>
> The patch set is here:
>
>
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/20150305_review
>
> Can you please review, and pull if ok ?
>
>
>
> --
> Alex Damian
> Yocto Project
> SSG / OTC
>



-- 
Alex Damian
Yocto Project
SSG / OTC

--001a11c1dab22432570510da5a86
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">This was taken for submission on the toaster patch set,<br><br><=
/div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">T=
hank you,<br></div><div class=3D"gmail_default" style=3D"font-family:tahoma=
,sans-serif">Alex<br></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, Mar 6, 2015 at 3:56 PM, Damian, Alexandru <span di=
r=3D"ltr">&lt;<a href=3D"mailto:alexandru.damian@intel.com" target=3D"_blan=
k">alexandru.damian@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-fami=
ly:tahoma,sans-serif">Hello,<br><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:tahoma,sans-serif">I&#39;ve pushed a set of bitbake patche=
s that improve toaster operations.<br><br></div><div class=3D"gmail_default=
" style=3D"font-family:tahoma,sans-serif">The changes are:<br><br></div><di=
v class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">* fix for=
 <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D7316" targe=
t=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D7316</a>=
=C2=A0 - log all file change notifications that happen during a build in an=
 idle function, and update the cache during initial build setup for all cha=
nged files; this allows bitbake to process a large number of notifications<=
br><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-=
serif">* fix for <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?=
id=3D7398" target=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi=
?id=3D7398</a> - the &quot;xmlrpc&quot; server should delete offending idle=
 functions that raise errors instead of ignoring errors; the &quot;process&=
quot; server already does this<br><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:tahoma,sans-serif">* deleted old GUI test data and rende=
r tests in-operable due to changes in the database structure that were not =
followed by updating tests/database fixtures; it&#39;s better to have no da=
ta than to have bad data<br><br></div><div class=3D"gmail_default" style=3D=
"font-family:tahoma,sans-serif">* improved handling of client connection pr=
ocessing, reducing the number of situation where a server is rendered in-ac=
cessible by a client<br><br><br></div><div class=3D"gmail_default" style=3D=
"font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:tahoma,sans-serif">The patch set is here:<br><br><a href=
=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dadamian=
/20150305_review" target=3D"_blank">http://git.yoctoproject.org/cgit/cgit.c=
gi/poky-contrib/log/?h=3Dadamian/20150305_review</a><br><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Can you please =
review, and pull if ok ?<span class=3D"HOEnZb"><font color=3D"#888888"><br>=
<br><br clear=3D"all"></font></span></div><span class=3D"HOEnZb"><font colo=
r=3D"#888888"><br>-- <br><div><div dir=3D"ltr">Alex Damian<div>Yocto Projec=
t<br></div><div>SSG / OTC=C2=A0</div></div></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / =
OTC=C2=A0</div></div></div>
</div>

--001a11c1dab22432570510da5a86--
