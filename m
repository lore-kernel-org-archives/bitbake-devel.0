Return-Path: <kergoth@gmail.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.161.181])
	by mail.openembedded.org (Postfix) with ESMTP id 6BFFA6078D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 20:02:21 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id a10so136776758ywa.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 12:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=kdSbEklAajPNz5lFK9H1oMLYQJaJQfEv7DAYnYll2pY=;
	b=UsDATtep3sbbs8z0uAJJaeddun0tgc8KFYvXHNU4vtdPLXzxRTpERh7CmOEaRXSuKr
	vMjjyWWP5VvGYg4+xuceGHVaFDI6FsdCcAHUzxNsbXGWjlKXuQ/lcgUVAveFynjKNPCw
	Vuvpfe2KXOg7FG34rWx6HKmBbg1pKMLV3TKh8hvpVp63VopbUL+YQ37p7Jm5sR5s0NPZ
	p6ZQw+a4VshC5lrVvCK87C6rtsoY6BlVs0IklQGKpC1Caszj8N1KNIs8Yu0f0yqWUnTp
	3ZijINqVuWPqfgDBjF/MBJaMQErKSE5akr7mmOoycfONxkx29gtLTiMDEHTImIWclAXz
	qhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=kdSbEklAajPNz5lFK9H1oMLYQJaJQfEv7DAYnYll2pY=;
	b=hl5BFM6ScryMN7ek23ywfuNPvPMzgsTkYPN9YVEeDg9rmQO2oskWapCVP0hYSs9TaF
	uatk7/SwU2kNYADZLisF86fCYLyDlz1KJG4k2LtuaTF0eoJaXNCFigmPmm7erPnS6AzD
	abCo5JN0BVVw3EKQBnnNGuBukgkRyZbkIE9Y5z9G2qLdu7fbq9S/at/90isSC/Ke7HDr
	SonJKfPWIL+mkM7cdF6Gd6oUzktt2XdckxJgdMnL/nOhV78VAdT4BqLYWP7QyvFEVxK/
	5KQOdKD61zW7xUX7HFYO5hZvjUHQI9MB44EnhPkkFY/9wwfEFPAL7eBnO7uvdGo35N1u
	Bbkg==
X-Gm-Message-State: AKaTC03qW//3QELQCecG/Aq1Gnf0KM2GOEy0H1ESdefnXBx2dsk5TP69e6r10OJgAzJ1HA3WB8aoaWIU1PKN9w==
X-Received: by 10.157.3.143 with SMTP id f15mr3574059otf.150.1479326543193;
	Wed, 16 Nov 2016 12:02:23 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.35.65 with HTTP; Wed, 16 Nov 2016 12:02:02 -0800 (PST)
In-Reply-To: <1479316925-22066-1-git-send-email-ross.burton@intel.com>
References: <1479316925-22066-1-git-send-email-ross.burton@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 16 Nov 2016 13:02:02 -0700
X-Google-Sender-Auth: o0H5ckPo1TB7ZLLclrWOp9OYIZQ
Message-ID: <CABcZANn58cYVzNBma_hWbQLJF4C7qtf46UuS8zhXGJA9acGdvA@mail.gmail.com>
To: Ross Burton <ross.burton@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] ast: remove BBVERSIONS support
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
X-List-Received-Date: Wed, 16 Nov 2016 20:02:22 -0000
Content-Type: multipart/alternative; boundary=94eb2c03b0221d2c0a0541708d41

--94eb2c03b0221d2c0a0541708d41
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 16, 2016 at 10:22 AM, Ross Burton <ross.burton@intel.com> wrote:

> BBVERSIONS is moderately horrible and it doesn't appear to be actually
> used by
> anyone, so remove it to simplify the finalise codepaths.
>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
>

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c03b0221d2c0a0541708d41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 16, 2016 at 10:22 AM, Ross Burton <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1kx" cla=
ss=3D"a3s aXjCH m1586e34217c71d8e">BBVERSIONS is moderately horrible and it=
 doesn&#39;t appear to be actually used by<br>
anyone, so remove it to simplify the finalise codepaths.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@intel.com">ros=
s.burton@intel.com</a>&gt;</div></blockquote></div><br>Acked-by: Christophe=
r Larson &lt;<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor=
.com</a>&gt;<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gma=
il_signature">Christopher Larson<br>clarson at kergoth dot com<br>Founder -=
 BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software=
 Engineer, Mentor Graphics</div>
</div></div>

--94eb2c03b0221d2c0a0541708d41--
