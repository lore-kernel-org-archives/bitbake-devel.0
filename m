Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id 08B1077592
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 18:35:06 +0000 (UTC)
Received: by mail-io0-f179.google.com with SMTP id o189so72514358ioe.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jun 2016 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=6/biQf9MxHAJvnrBrmNIX1DiPhkbirfQDgiJ6XoHxew=;
	b=jd2qiDqHtpuCl/VuQpr3x1i5dnU5qakMMCT1Es5tef6Qn7tz88Xh70DpxDrMHVQ02j
	QX47livAdH9dqWvUxH+OsE/Rh80zxDf5HTKt4vjOkSTgqnw0wnA+QejZjeXGW6BYrgq8
	jkqfnDnYm9ZvtpvFwIlvZHDQ1jhdZo2qmUGVMmqkWYX8bTmMnn+KcLd1x6oQ7G72cjB6
	vc5yq9NehWWDKZ3DLjgMWRp2X3paNGKVd8wpL18aFu6Nos1kly/gEvwC1nVLmLlzkLz6
	w9hAKZzkOTnruaJi/YEyBrRoGKx815efFm1mom1/zHCPJ2nOeAW/hLP91Fh3xcvGmwou
	Kisg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=6/biQf9MxHAJvnrBrmNIX1DiPhkbirfQDgiJ6XoHxew=;
	b=DhWL1t12qLEODu74BRfXBxluPIAk+NfHfzJLL3je/qf9Hc99cIIwQLnk5RZWawukrd
	5k/U0rYpKM0OObbRwYQ8oT/Y6VYMdsjfM4X9EB8k0Y03MGKebEF4OA/5ZHbkSJbADJhb
	o/Ypjs0nDnYmUK71vZ+/VRlND0tBLwFWHMyHDSwaxZOtFz4XKqA0jQJPkyVE+y9IjLA6
	iZBdKpg+22I8cN/W4IIaZ5uPhtBUnVdqUC44bi6nxiz0wzDoQljR7JMNqhFI2JizGvh4
	Uzsdnt2jo/+3dDq8S9mH7Ngq0j5Kshk9X0qLAH59JfTObZy7/PW11IiesFtyHa50QmMU
	cqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=6/biQf9MxHAJvnrBrmNIX1DiPhkbirfQDgiJ6XoHxew=;
	b=VlZH6cRJ4M5rBDGQuy+3lbgoG8NPbJPSLMoAy+lObKccmkSr/OdYCyFksobH5J9QYq
	z9bHTDvJwi+Lc7XlVe9ld9Bc5VCRyt2dtY1J7IVmUeJhEF0xBVHhxn0V5f38zCudJdon
	uzDUPvOwmxEb1nCclavf0soXHsrxJkxG+x3p5b0S4N9Mo5Mmt2lD8KndeW9H7detvlkP
	2rMqUTvXkCErPFhxQ5aDVPQDt7sl/6br6Lta4LzEjp2DI2u/QENiOwWNYLqGvmIGWzJB
	D1YavwMGabf8i/st3wO/juwWqk1abV+nOh2LvuzPqpnIZKgujgCwykvilACMQQA8YXhN
	U52A==
X-Gm-Message-State: ALyK8tKKyCKcAcYjV2IyaRp8rTKgJq0+4uHkH7PlgjKD/3ajAa9fUQxIvcG/1S5tc2KxSjFSPQwEQ8MRuExXxA==
X-Received: by 10.36.23.206 with SMTP id 197mr1448810ith.15.1464978906554;
	Fri, 03 Jun 2016 11:35:06 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.5 with HTTP; Fri, 3 Jun 2016 11:34:47 -0700 (PDT)
In-Reply-To: <1464957513.13979.16.camel@linuxfoundation.org>
References: <1464957513.13979.16.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 3 Jun 2016 11:34:47 -0700
X-Google-Sender-Auth: 8MWW1tWESa5qQp9uPb8dRXU2wCI
Message-ID: <CABcZANn2ctcqA0hUzw47F_n6n1EQoAS16axALFhUCeaR1p0JSg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Fri, 03 Jun 2016 18:35:07 -0000
Content-Type: multipart/alternative; boundary=001a11437ffa54306b053463fb4f

--001a11437ffa54306b053463fb4f
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 3, 2016 at 5:38 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> "hash() is randomised by default each time you start a new instance of
> recent
> versions (Python3.3+) to prevent dictionary insertion DOS attacks"
>
> which means we need to use hashlib.md5 to get consistent values for
> the codeparser cache under python 3. Prior to this, the codeparser
> cache was effectively useless under python3 as shown by performance
> regressions.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good to me, I was actually wondering about the hashing mechanisms
just yesterday. Are the sstate checksums stable between python 2 and python
3?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11437ffa54306b053463fb4f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 3, 2016 at 5:38 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div class=3D"">&quot;hash() is randomised by default each time you =
start a new instance of<br>
recent<br>
versions (Python3.3+) to prevent dictionary insertion DOS attacks&quot;<br>
<br>
which means we need to use hashlib.md5 to get consistent values for<br>
the codeparser cache under python 3. Prior to this, the codeparser<br>
cache was effectively useless under python3 as shown by performance<br>
regressions.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Looks good to me, I was actually wondering about the hashing mecha=
nisms just yesterday. Are the sstate checksums stable between python 2 and =
python 3?<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - Bi=
tBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software En=
gineer, Mentor Graphics</div>
</div></div>

--001a11437ffa54306b053463fb4f--
