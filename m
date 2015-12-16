Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
	[209.85.213.176])
	by mail.openembedded.org (Postfix) with ESMTP id D744370034
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Dec 2015 03:55:12 +0000 (UTC)
Received: by mail-ig0-f176.google.com with SMTP id to4so47819820igc.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 19:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=vUVbZjjYo+xuZuBOA0lSEMPSYf9XZYx+moTikL0MO4E=;
	b=mHoh6S8axdi2LZTV4kIb8t2PlknEE1iP7ebeyet4xWghabvXca05gRflkcRAZ48aZ/
	G5rhLMk6ufUPGby/pUzh2VdJuS1VFUpfnHDl4sQ+MaOOETYmMI6IWZLj5SvPuWrnQMyv
	bAbQw/WNgN5Zk7R53u4NissUI50qK1O58Grpj0oRP6g85fkrAJo9bxpaO0Kv8kiuAY8w
	l6cs3PKoACw9me+8xYxebxSsmx5MyfsO05hyy/jbtCUWsdQe6jQ4kVDqQ4TMy0qpk3Pn
	E6mDtcQCyZdHo2tqbcxfmiXnZQMcfSkJ931LoDwZE6XTz6CtXhR4iDv5RdWQ9zCIAavt
	EYKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=vUVbZjjYo+xuZuBOA0lSEMPSYf9XZYx+moTikL0MO4E=;
	b=cHKgSfbHpAEaro8BYLlJni5xLw9KMCZLHspfkF08QOJ35ALccVFD2Oqd/0esNuesCu
	rBdJbzFVm2JphaN/MtRn3JxLLAhXxU0/byxGEoU8EHon+7hbwcxnGF71mSs7x+PECMi5
	NEjKPdhtigvZOdIrNOocbI1igHBFt0aiE4Iybya+ucrfLkAohFJ4R2yfY0W0L7eNZGpN
	Bd6uyW9Um0YIG04tYER0q1jEcM2Cg5QmwXCtB70aOA1a9ONq2LkD0aYqZvvMOc5bDNpm
	KGYdZkQDqA9MQONALh7hDbYBC39T5qdQLg0hjg7yxDLxtf/JAAPr3Fore0EW9YuiB7KM
	KoUQ==
X-Received: by 10.107.134.78 with SMTP id i75mr11597638iod.74.1450238113164;
	Tue, 15 Dec 2015 19:55:13 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.69.129 with HTTP; Tue, 15 Dec 2015 19:54:53 -0800 (PST)
In-Reply-To: <2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>
References: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
	<2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 15 Dec 2015 20:54:53 -0700
X-Google-Sender-Auth: cSUDs9MEriczfLHbFTLMD5FPzTA
Message-ID: <CABcZANm0FxRqAfJdjLS1nq9JQ3fJeQNBAd3zWYqiWmZKhLR0cw@mail.gmail.com>
To: "Belal, Awais" <Awais_Belal@mentor.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: fetch: use orig localpath when calling orig method
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
X-List-Received-Date: Wed, 16 Dec 2015 03:55:13 -0000
Content-Type: multipart/alternative; boundary=001a113ecbba9379630526fbdf07

--001a113ecbba9379630526fbdf07
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 11, 2015 at 3:56 AM, Belal, Awais <Awais_Belal@mentor.com>
wrote:

> This applies to 1.28 as well and otherwise broken builds are seen where
> the git tarball from source mirror is outdated.


As Awais says, without this applied, if you have an out of date git mirror
tarball, you'll get a do_fetch failure, so I think we really need this
merged.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113ecbba9379630526fbdf07
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 11, 2015 at 3:56 AM, Belal, Awais <span dir=3D"ltr">&lt;<a href=
=3D"mailto:Awais_Belal@mentor.com" target=3D"_blank">Awais_Belal@mentor.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This applies to 1.=
28 as well and otherwise broken builds are seen where the git tarball from =
source mirror is outdated.</blockquote></div><br></div><div class=3D"gmail_=
extra">As Awais says, without this applied, if you have an out of date git =
mirror tarball, you&#39;ll get a do_fetch failure, so I think we really nee=
d this merged.<br>-- <br><div class=3D"gmail_signature">Christopher Larson<=
br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZauru=
s<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113ecbba9379630526fbdf07--
