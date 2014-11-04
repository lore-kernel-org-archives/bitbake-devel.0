Return-Path: <ross.burton@intel.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id 6305D65D4F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 13:10:58 +0000 (UTC)
Received: by mail-la0-f53.google.com with SMTP id mc6so804079lab.40
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Nov 2014 05:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=ST2wZ7qetGXqivPHScbjuznBar7OliKdftlbV9+8hxQ=;
	b=WfG4kugpTtBSFlsiGNGzP0GcHtMoS+jqezLAfrFTnXN+wu2ogKYODzIClOn7IBzQSt
	1gts67xbP/QcrodiXw3EZi5leuXUr7W/FmqjZnUI5mChIV1RU2ss1DT8CkvW012GQLNA
	aCDZD/A5Xj51zeeuPNRuXToBXxcpCuhYraIkrk621XefxDGOaotYWLMT5dwTpMcM4a/U
	jIAR7HODy1q6Kv0p+l7gMk3yEdo/B2nzfjCcV///oNWiMnMAgq0LWK7vZj7v5sSX/JmW
	Esaea599OnFM1YTju8IWDVK/FsNVmh1Z0OM72BGKRNIbVv9sORMS+7o9j/RX8E8G8NpD
	Yz8Q==
X-Gm-Message-State: ALoCoQnkjhlEEP2NjRJtvuteYnwy9D9t0PTOw22V0M0DJCLmePd85+cKcRF3AvCQZqTyoBF4g8hr
X-Received: by 10.152.7.71 with SMTP id h7mr3699422laa.68.1415106658578; Tue,
	04 Nov 2014 05:10:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.112.65.103 with HTTP; Tue, 4 Nov 2014 05:10:38 -0800 (PST)
In-Reply-To: <1415098299.23396.16.camel@ted>
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
	<CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
	<20141103154726.GA9716@bshelton-desktop> <1415035858.5111.45.camel@ted>
	<5457C903.2030703@mlbassoc.com> <1415090528.23396.4.camel@ted>
	<1415098299.23396.16.camel@ted>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 4 Nov 2014 13:10:38 +0000
Message-ID: <CAJTo0LZHhBzScE4a4Ok1JQPtHxTtgkBJmeYk0YX4u_6XoyNsbQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Gary Thomas <gary@mlbassoc.com>
Subject: Re: [PATCH] prserv: don't wait until exit to sync
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
X-List-Received-Date: Tue, 04 Nov 2014 13:11:04 -0000
Content-Type: multipart/alternative; boundary=001a11c28fa0b44340050708311b

--001a11c28fa0b44340050708311b
Content-Type: text/plain; charset=UTF-8

On 4 November 2014 10:51, Richard Purdie <richard.purdie@linuxfoundation.org
> wrote:

> FWIW,
>
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/t222&id=df0dabbf90f3da7153295adb83e51c41ae4d9375
>
> is a patch Ross is kindly testing for me...
>

This patch appears to be causing the error less frequently, but I'm still
hitting it.

Ross

--001a11c28fa0b44340050708311b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 4 November 2014 10:51, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@=
linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div id=3D":2jk" class=3D"a3s" style=3D"overflow:hidden">FWIW,<br>
<br>
<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drp=
urdie/t222&amp;id=3Ddf0dabbf90f3da7153295adb83e51c41ae4d9375" target=3D"_bl=
ank">http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurdie/=
t222&amp;id=3Ddf0dabbf90f3da7153295adb83e51c41ae4d9375</a><br>
<br>
is a patch Ross is kindly testing for me...</div></blockquote></div><br>Thi=
s patch appears to be causing the error less frequently, but I&#39;m still =
hitting it.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_e=
xtra">Ross</div></div>

--001a11c28fa0b44340050708311b--
