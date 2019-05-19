Return-Path: <andrew.featherstone@gmail.com>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	by mail.openembedded.org (Postfix) with ESMTP id 81C5F7DDA7
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 May 2019 08:41:24 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id r7so11147481wrr.13
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 May 2019 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=FqKBpA6fRTMG7/PEYHDkh/4sycc+N0NsvoHQyMCn62A=;
	b=f+LWlj0KNz275/LtzLvGIY5Wv+jUgEV/rJX6CZ3tbBz2c43vtBVLrN5XtRTqgyIqyQ
	QkTifqzzn/rQTojhCXEvkYjpctvjarLe9cOvpksScucnUYT0sAJYJ1IKjHC9imsqJhrS
	LjJ7vQK6VrevbIHhSF6uOoHz0DaULypFQakLXq8HcYnLO28hwh4lE88FCNwqnK4H4A/E
	c4nulJOTWYRDikzz7hgo/EPj2e0O9/agZJAF7L+QRe6/+wOSvyyYyNzqHtFO1YL1uVia
	vKB7o4QF1rZgV/qCqRenkaYa2SAJKsnv3E6otHIj8tnzinpWuLyHzkaEjAcZEfb+7rMn
	qW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=FqKBpA6fRTMG7/PEYHDkh/4sycc+N0NsvoHQyMCn62A=;
	b=WNVUm6lfeLLTsjP/AeqIdSdDjS1wa9w8h5YgrziV3SRkiDTPeOgL2RVoVoH8+42MZH
	CInwaP2M8+rTKIeAEDGizHsRhf8vmiyftMeDDKPJx2U+375GZ7iGA7cpaVFbLrQdSBsq
	RkGjLFVtfUnMDQO/ADguAdo7B7WQmDwjFoyQcppcCYwqWmdAyRxDmdvfg5uHVvwmO6Lc
	/TLx5pNk19DxHiX9c3IYT/gjSFYV76VVXGrDfOWbhMA+6W9+YrKsjjfL1cbr/Erl5c2m
	sFwMHTWvabysv63sPgghsgl56XsH3Wb2tFtwU2EvaG14MUZPVlmvofblfIe6j/sTdJZ5
	0H0g==
X-Gm-Message-State: APjAAAXBo/fDd3AzUhDdAPsDZP1KMjPFV8PD2I0LO7oAknwJ9zN/MkDk
	HFMRh2ZBxB6mi6lvpxOaixEtFAQlKVKtCf4B9vCNuk3p
X-Google-Smtp-Source: APXvYqyednTxF6FhboTJ20e7Wc2Eaq/8pzZ1Z9XKkHZicccg7JUSeatAQWNLjIQKjMUh8TCkBBMDw/icwAZNSkPcnpI=
X-Received: by 2002:adf:fa03:: with SMTP id m3mr40089919wrr.323.1558255285243; 
	Sun, 19 May 2019 01:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGW41X4-eci5jLF=is4zXyZ_S-09KAm3u6zRY7bZRm5-ZOBoNg@mail.gmail.com>
	<CD049A4B-65EC-4837-AF9B-9664647B6C8B@gmail.com>
In-Reply-To: <CD049A4B-65EC-4837-AF9B-9664647B6C8B@gmail.com>
From: Andrew Featherstone <andrew.featherstone@gmail.com>
Date: Sun, 19 May 2019 09:41:11 +0100
Message-ID: <CAGW41X6aTxVpjg+Q5twwyHZgVevw03dJNRFgkOzhH4dNJpKEuA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: BitBake release notes
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
X-List-Received-Date: Sun, 19 May 2019 08:41:25 -0000
Content-Type: multipart/alternative; boundary="000000000000bf167b05893994ce"

--000000000000bf167b05893994ce
Content-Type: text/plain; charset="UTF-8"

Thanks, Alex. Are the Yocto Project release notes the de-facto release
notes? From version 1.16 onwards it seems that releases go up by 2 at a
time in the minor version; why is this? The current version of the BitBake
User Manual [1] offers little insight here.

Andrew

[1]
https://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.html#obtaining-bitbake

On Sat, 18 May 2019 at 15:42, Alexander Kanavin <alex.kanavin@gmail.com>
wrote:

> The short answer is no. Bitbake releases are actually tightly coupled to
> matching versions of layer metadata, so while you can try to use newer
> bitbake with older metadata, you are on your own with any issues.
>
> Alex
>
> On 18 May 2019, at 11.04, Andrew Featherstone <
> andrew.featherstone@gmail.com> wrote:
>
> Hi There,
>
> First apologies in advance if this is the wrong mailing list. If there's a
> bitbake-users list, please let me know.
>
> I'm looking for some release notes for BitBake to help understand
> compatibility of recipes and when new features were added. The changelog at
> https://git.openembedded.org/bitbake/tree/ChangeLog hasn't been touched
> in quite a few years, Yocto Project release notes include details of
> changes https://wiki.yoctoproject.org/wiki/Releases, but nothing about
> compatibility. Are all 1.x releases of BitBake backwards compatible?
>
> Regards,
> Andrew
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--000000000000bf167b05893994ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thanks, Alex. Are the Yocto Project =
release notes the de-facto release notes? From version=20
1.16 onwards it seems that releases go up by 2 at a time in the minor versi=
on; why is this? The current version of the BitBake User Manual [1] offers =
little insight here.</div><div><br></div><div>Andrew<br></div><div><br></di=
v><div>[1] <a href=3D"https://www.yoctoproject.org/docs/current/bitbake-use=
r-manual/bitbake-user-manual.html#obtaining-bitbake">https://www.yoctoproje=
ct.org/docs/current/bitbake-user-manual/bitbake-user-manual.html#obtaining-=
bitbake</a><br> </div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, 18 May 2019 at 15:42, Alexander Kanav=
in &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"auto">The short answer is no. Bitbake releases are actually tightly=
 coupled to matching versions of layer metadata, so while you can try to us=
e newer bitbake with older metadata, you are on your own with any issues.<b=
r><br><div id=3D"gmail-m_2309157763238776965AppleMailSignature" dir=3D"ltr"=
>Alex</div><div dir=3D"ltr"><br>On 18 May 2019, at 11.04, Andrew Feathersto=
ne &lt;<a href=3D"mailto:andrew.featherstone@gmail.com" target=3D"_blank">a=
ndrew.featherstone@gmail.com</a>&gt; wrote:<br><br></div><blockquote type=
=3D"cite"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div>Hi There,</div><div><br></div><div>First apologies in advance if th=
is is the wrong mailing list. If there&#39;s a bitbake-users list, please l=
et me know.</div><div><br></div><div>I&#39;m looking for some release notes=
 for BitBake to help understand compatibility of recipes and when new featu=
res were added. The changelog at <a href=3D"https://git.openembedded.org/bi=
tbake/tree/ChangeLog" target=3D"_blank">https://git.openembedded.org/bitbak=
e/tree/ChangeLog</a> hasn&#39;t been touched in quite a few years, Yocto Pr=
oject release notes include details of changes <a href=3D"https://wiki.yoct=
oproject.org/wiki/Releases" target=3D"_blank">https://wiki.yoctoproject.org=
/wiki/Releases</a>, but nothing about compatibility. Are all 1.x releases o=
f BitBake backwards compatible?</div><div><br></div><div>Regards,</div><div=
>Andrew<br></div></div></div></div>
</div></blockquote><blockquote type=3D"cite"><div dir=3D"ltr"><span>-- </sp=
an><br><span>_______________________________________________</span><br><spa=
n>bitbake-devel mailing list</span><br><span><a href=3D"mailto:bitbake-deve=
l@lists.openembedded.org" target=3D"_blank">bitbake-devel@lists.openembedde=
d.org</a></span><br><span><a href=3D"http://lists.openembedded.org/mailman/=
listinfo/bitbake-devel" target=3D"_blank">http://lists.openembedded.org/mai=
lman/listinfo/bitbake-devel</a></span><br></div></blockquote></div></blockq=
uote></div>

--000000000000bf167b05893994ce--
