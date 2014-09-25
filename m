Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
	[209.85.217.177])
	by mail.openembedded.org (Postfix) with ESMTP id 20E44609B2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 23:47:09 +0000 (UTC)
Received: by mail-lb0-f177.google.com with SMTP id z12so13344897lbi.22
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 16:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=hEbjsdbgLQRf8rshtUmkJXld3MS4m9Y5yP1UYNcdUmA=;
	b=La76tsVx289zNzS92SqRvvM+VJUNtXvVN5pg6EevQ6bSxXjDHo5LkhFBfHqWHxIddi
	aVqVeee50gvfGpxFACNNW++IOX94HtHFojEvxAH1Fo4TnLXll+5XwZx3yqpc2FUbSseC
	f0pVJKSxhCON8rAXk1jOBxIxJ08n7vRRJCQtL7wHaq8rbj4yfbJ9jJykLS77dZ5SyOnq
	3Jk2taoSz08RYwPXacoxI9R1niYgzMLh5t+PAFmsnAhOOuvJis/oXQ6It1VBI1eXCP+l
	NjMHWQ13ZV5lLOsBHSvkBHFVaZ9j7nY4jtFd3hLYC8AJ3417qekSlO3ZkkEKAF80063O
	X+XQ==
X-Received: by 10.152.21.6 with SMTP id r6mr16705784lae.6.1411688829994; Thu,
	25 Sep 2014 16:47:09 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.97.194 with HTTP; Thu, 25 Sep 2014 16:46:49 -0700 (PDT)
In-Reply-To: <1411686885-8169-1-git-send-email-alejandro.hernandez@linux.intel.com>
References: <1411686885-8169-1-git-send-email-alejandro.hernandez@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 25 Sep 2014 16:46:49 -0700
X-Google-Sender-Auth: MZ3ib5AED7P1YJAmXiwvZ83JmdY
Message-ID: <CABcZANkxTDWv2AQU=0WD9p27EF-4RT5iWTvj_S8bBcu6MASQ_A@mail.gmail.com>
To: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Thu, 25 Sep 2014 23:47:13 -0000
Content-Type: multipart/alternative; boundary=089e014941ec3ecdf20503ec6bce

--089e014941ec3ecdf20503ec6bce
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 25, 2014 at 4:14 PM, Alejandro Hernandez <
alejandro.hernandez@linux.intel.com> wrote:

> -        if strict and not (ud.md5_expected or ud.sha256_expected):
> +        if (strict == 1) and not (ud.md5_expected or ud.sha256_expected):
>

I realize python allows it, but I think it's pretty amusing that the
subject line mentions correcting the data type, and then you compare a
string to an integer ;)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e014941ec3ecdf20503ec6bce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Sep 25, 2014 at 4:14 PM, Alejandro Hernandez <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:alejandro.hernandez@linux.intel.com" target=3D"_blank">alejan=
dro.hernandez@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div id=3D":sc" class=3D"a3s" style=3D"overflow:hidden">-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if strict and not (ud.md5_expected or ud.sha256_expect=
ed):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strict =3D=3D 1) and not (ud.md5_expected =
or ud.sha256_expected):</div></blockquote></div><br>I realize python allows=
 it, but I think it&#39;s pretty amusing that the subject line mentions cor=
recting the data type, and then you compare a string to an integer ;)<br>--=
 <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake,=
 OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer=
, Mentor Graphics
</div></div>

--089e014941ec3ecdf20503ec6bce--
