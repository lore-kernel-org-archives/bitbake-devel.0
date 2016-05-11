Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id 412686E681
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 20:25:58 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id x35so7710800ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=T6cvmIBl6+crZ1qwsORXPCXysxFqTbuwpaXo46l94EA=;
	b=06pqz6YF7gqgghZLGgM6wInn/kzrTye1V/MDyZs9sVTc7phLdABfmR/WjetDB/zuOO
	jYK3myNm+396jy+yECp7KOFu2e8MnYRKXQPZgiwGaX7wYG6f2Laq3lgXillU3Vmyfbo2
	ix7N4I9coe9c/KHSY53ucmqVnKKd7Sa66R0eiNvRlPaEElp/0lAjXT4AScTxQiXt2kix
	VGxtmKcw7XEz75Fihe0oOV2SECVD8dYTsoTCU6oP/s2LmnlLCkVf6mktuj5aLWWyVcor
	8q9ODoEX+u2S6Ec+ydrgCN4E6g8ClFrhKK1TP/HvVtiy55SlsLabC1vGlAlmn4lAFSOS
	ULKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=T6cvmIBl6+crZ1qwsORXPCXysxFqTbuwpaXo46l94EA=;
	b=EBZU1abvBoXanrDO5pmWK9vjNplplj5xqr+M6FHpegkXMl+qQWkvsLyqbCwIql/hGi
	3oe3lfoZAWj4LB/hhh7zOvcqUy0N1UAsQGEwnn5KP5h/URfMHWGkMejt2Tu9A/09cIGy
	bs0LDi5/9kI+OgbpQZAeQwaCjGOXrChQsBmw7U4svjQQtT6L+utcNWJmv8rRvMH0KpT6
	RBhdAqN7LY5612lIQh0OwLUYjSzuCy+thuTlC4m6F0oRfasHPuP3/BYytyG3uUU+/MFZ
	ng649ae5Nj7+5+2A+XsjmdSwzLHPWAWp3ntNZEWeN9ibeVGEJ9U69/TLZipLHi/UWsbQ
	8UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=T6cvmIBl6+crZ1qwsORXPCXysxFqTbuwpaXo46l94EA=;
	b=JE31bCfvvof0V8kGA2HjO3jztwUeTzo82WA8H4uqZDzGcomsB3tWCPxyGqZOi1hbzw
	Sv/I7epWv5ShQP9Mzi+QoLC/2N5Bs+csPiiagjkYtdyiE0xn2TAkBfUlO8YowsFTljo8
	OtiS9jj3rANB3xTtlIBziyEHwHkXM24eZA64n9WXaj1igRYmvHXTwY7H+twatIEJlz0F
	l7DSAFU0eMQpvpIqLfw8ijBe/PLRpr8W9iSMKmuk1zDHi+w5qvRWuDnf2fG05utt42lW
	Oe5KWusLMm93vf9dAw7vGi747nYWk3Mie2U4KnoUc//oLNQZUTdzuUI8/eazbL9fMPEm
	gBhQ==
X-Gm-Message-State: AOPr4FVRJIbbR7zClKjgyCWSS4MkijZ2wUsTLBNUmmmyK/LMpAkns/PdPtA9kCz+YDIWwyBwbLFAj3QPhezUag==
X-Received: by 10.36.41.11 with SMTP id p11mr4132474itp.66.1462998359299; Wed,
	11 May 2016 13:25:59 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Wed, 11 May 2016 13:25:39 -0700 (PDT)
In-Reply-To: <1462996868-10200-1-git-send-email-humberto.ibarra.lopez@intel.com>
References: <1462996868-10200-1-git-send-email-humberto.ibarra.lopez@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 11 May 2016 13:25:39 -0700
X-Google-Sender-Auth: Y0GL5UbvvafIAzHawRgDhhAxb7o
Message-ID: <CABcZANkreWfapeEH0Qr0sRftj6qWbOc-n6V4wCD4=Qt=7tFVHg@mail.gmail.com>
To: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake/lib/bb/cookerdata.py: Check if layer conf files exist before parsing them
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
X-List-Received-Date: Wed, 11 May 2016 20:26:02 -0000
Content-Type: multipart/alternative; boundary=001a1143fd7083643a053296d968

--001a1143fd7083643a053296d968
Content-Type: text/plain; charset=UTF-8

On Wed, May 11, 2016 at 1:01 PM, Humberto Ibarra <
humberto.ibarra.lopez@intel.com> wrote:

> If an invalid layer is added to bblayers.conf, the parsing of said file
> ends with a trace and an "Unable to parse" exception. This is not the
> ideal output, especially considering that we know exactly why this is
> failing.
>
> This patch checks if a layer conf file exists before trying to parse it.
> If it does not, a clear and more concise message is send to the user.
> Otherwise, the parsing continues.
>

This commit message no longer accurately describes the change :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1143fd7083643a053296d968
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 11, 2016 at 1:01 PM, Humberto Ibarra <span dir=3D"ltr">&lt;=
<a href=3D"mailto:humberto.ibarra.lopez@intel.com" target=3D"_blank">humber=
to.ibarra.lopez@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">If an invalid layer is added to bblayers.conf, the parsing of said f=
ile<br>
ends with a trace and an &quot;Unable to parse&quot; exception. This is not=
 the<br>
ideal output, especially considering that we know exactly why this is faili=
ng.<br>
<br>
This patch checks if a layer conf file exists before trying to parse it.<br=
>
If it does not, a clear and more concise message is send to the user.<br>
Otherwise, the parsing continues.<br></blockquote><div><br></div><div>This =
commit message no longer accurately describes the change :)</div></div>-- <=
br><div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth =
dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tsli=
b<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1143fd7083643a053296d968--
