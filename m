Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id A2730607B3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 11:42:40 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id u134so38859557itb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=WxBle8IGOLuQjjLCrHcNuxDzt9y7A4O5nbJwGYWdwdI=;
	b=GZd9SIPaWy8jUtUzMZZvL1YKcHvUCXejeMXRZEq05VzNaiiRfrGH7TOI0o59hLgfTt
	X3oM2ZXQ+CBrdkvhHiYRKp7mkKLR3KrhXt7azGdAKIFw2+8jeGWk1GJrl9k7CLDpGhqe
	0xy5t+SBohAAyBJ72UCytm4bAXriOaA7KkP1eWE4Nqsr9HDuWogT6eeI+T3nOhuC9Qjp
	Y4lNEjZ63G1IayIXsBO3k+BIwMt/xH+8hQzxLRMd/qCEDUjzRcMZ6GIunU9pnEyouv45
	482sfBjFfLq7kTMQJuegasPzJ/x8WI6Zs1iguH0OwUCd8aO4d7UcJLnYo18v2k5zRKrx
	sk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=WxBle8IGOLuQjjLCrHcNuxDzt9y7A4O5nbJwGYWdwdI=;
	b=ahgOaEu14PP+vci/EYrHpuJjVfkgRPjNkfhmQdlbQJIL3G9HOEeYtj/XL+Vle9VwXA
	CFr/uZKSkdsS6P69JMTrT+pVVXXZOfYtKojule1vGq+nHR9U8W0cQ8bp6JRn8TD1pfMZ
	15YPUd0zvW59GKaKAzKXEanl2vDjD1jfEcj2iSq/1aIEt/xqXCjI1+P7IQ0mY+jFG32C
	ey3DXFrxOsih+uukHo3jh0R07to8eutsatKTQosXib6lDSQ4KwOEkmmbughDwAM0jNgC
	ED7Tf2wHwWmhlF0tRrOlVR0WGiQFwbZCzDayoAJYEgkfe18eLI75F0bvRE2krRHK7EjH
	cp5A==
X-Gm-Message-State: AA6/9RmP9RJqGSTUembDHm03N+HF2yeWxLW73qF5xSKJ+4h5LOFrtgmUCiqIpvZweTCDn6QyPvMbirYEPvjUEqra
X-Received: by 10.36.200.86 with SMTP id w83mr3592266itf.74.1474976562256;
	Tue, 27 Sep 2016 04:42:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.155.66 with HTTP; Tue, 27 Sep 2016 04:42:21 -0700 (PDT)
In-Reply-To: <CAPPN1iEXQ7w__pFUeOhX1Hzunc6hJXmDNLQChfboeV3F+kxMEg@mail.gmail.com>
References: <CAPPN1iEXQ7w__pFUeOhX1Hzunc6hJXmDNLQChfboeV3F+kxMEg@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 27 Sep 2016 12:42:21 +0100
Message-ID: <CAJTo0Lb5OvFSG8ZKmvn1w3G919=4EWVXC=yEwKps0F29RPLuXA@mail.gmail.com>
To: Dishu Sharma <sdishu20@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: do_configure failure in dbus recipe
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
X-List-Received-Date: Tue, 27 Sep 2016 11:42:46 -0000
Content-Type: multipart/alternative; boundary=94eb2c057dd80bbbf8053d7bbe20

--94eb2c057dd80bbbf8053d7bbe20
Content-Type: text/plain; charset=UTF-8

On 26 September 2016 at 05:05, Dishu Sharma <sdishu20@gmail.com> wrote:

> I'm working on yocto and I m getting do_configure failure in
> dbus_1.8.10.bb .
> Could you please help me in debugging the error.
>

Please use the yocto@yoctoproject.org list for user support, this list is
for the development of bitbake.

Also it helps if you include the error messages in your email.

Ross

--94eb2c057dd80bbbf8053d7bbe20
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 26 September 2016 at 05:05, Dishu Sharma <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sdishu20@gmail.com" target=3D"_blank">sdishu20@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"font-size:12=
.8px">I&#39;m working on yocto and I m getting do_configure failure in=C2=
=A0<a href=3D"http://dbus_1.8.10.bb/" target=3D"_blank">dbus_1.8.10.bb</a>=
=C2=A0.<br>Could you please help me in debugging the error.</div></blockquo=
te></div><br></div><div class=3D"gmail_extra">Please use the <a href=3D"mai=
lto:yocto@yoctoproject.org">yocto@yoctoproject.org</a> list for user suppor=
t, this list is for the development of bitbake.</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Also it helps if you include the =
error messages in your email.</div><div class=3D"gmail_extra"><br></div><di=
v class=3D"gmail_extra">Ross</div></div>

--94eb2c057dd80bbbf8053d7bbe20--
