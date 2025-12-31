Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1771EE57EC
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 09:03:20 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82485.1767171795536430969
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Dec 2025 01:03:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NUyjkQs8;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed66b5abf7so127620651cf.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767171794; x=1767776594; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3KTsAQVgeVd8uqDrtLIG6UcgdfpT5yejXi+e9/mjMI=;
        b=NUyjkQs8UKcqmu3T1u3XXx5FQV69cWF8SKzTZKxCTwpM9V+lq8mT9J/kf1TZ330j8H
         nMmjJtuUiNGcWhkepuMocW9rPsxGhZuYGjVtzfxEuvnWPRMf12UdGCMgNvnq9QclS/3z
         07dN9WUxku7PFEbiMWfggHcnOpcJdlC9VQvIoV+uI7YsCiPOuV8wvQnJCawehsXBBByA
         dCAnZA2i8zSihwNrjUc6XXC+N/F2leW2k1LjnyyaVyFxsbgCIerXihaPjjYrFI2SXSVR
         ux6FA6ZBlX7ntxBGfhoKwiT6wlnueHflRlmNgXiji9IIoCyjdOTzw7UHbCqb/Njl3L+G
         NeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767171794; x=1767776594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3KTsAQVgeVd8uqDrtLIG6UcgdfpT5yejXi+e9/mjMI=;
        b=pxGAzoTij72tjUIR+7J5Rjs1dVEmj6wT87U1GQz2iAzyexWprmh1k4m0KAb6LzOoeh
         zmiDOVgDfBhbpOjHtjEerFcwbn++FdxqP9NkUyFhOC2XMTPxS0Klq0kRPzGCCszRWCKG
         ZiwNLDtLjFR8M7x58bVsuMY5+JNUEeIH1dmyN6OJEsTTjnVOMcRBMsoXBE5e0MGHEJ21
         TG5CcZy5mPyIFb/oJ/Pia0KqrV/EpwwQDaO+VmbvNRaVizCVTRZlW/5XLQBx7SiB4NSB
         nxnUObxYyGvb5rlp6zCdQ78kcdECQSxnF3Ih1Hv84Bv9IJX4JJ2sS+PwRaJ4zN87m90B
         KiHg==
X-Gm-Message-State: AOJu0Yxsam2TXhUI8tQTv0ZU4MWsEyOS+eG3/C8QY+tJau0zJDeqv44f
	HciOBGpCbr0HZDCEV+DnzP6wHCPYLUtIAavZXGS7sHCNh+X0JEAocBIw+7BvP0HpMalv453Xole
	SzSdhE9VQYzXqHngfwQE30+6DZ1g+qGE=
X-Gm-Gg: AY/fxX5DZRCO5IMZAXTpoMGqaCuIO4wFZej2+Z2DQ++PIvqZqc4EYwtYGaGdUs0zkfa
	J1vZUfLYW4J3h9pzlKQ270qOKnMO42LvqbgR+VsaXtSn3khD6wrQp0J7BKXgN85NSl+vOZNsl4B
	x3a3XHWQCgAGX342jE/EYYyfBdOm78BtJjYuFGnLgbb8SwwK/rIjkMRAuo1vCMr2QnXm1XEJz2V
	TGPmtHlHvNBArwoyNpUsOdC5Eyz17Qt9+XVb1ilnAZ8TVZtPLRRopQdwzXKIv7u7gW6/garXd73
	M4K5HmkuY+dMZ83S/UO5AZBS3rdQbQ==
X-Google-Smtp-Source: AGHT+IELyBkRjpPB8J8UsdU2pcoOdZ82yPnR43Iorsuxmnm79bWZRcMMHp7AQxr7aUkjZ0FsXKjdndkSneBAInGxhdk=
X-Received: by 2002:a05:622a:2d2:b0:4ed:a2dc:9e51 with SMTP id
 d75a77b69052e-4f35f43ab71mr587821241cf.21.1767171794543; Wed, 31 Dec 2025
 01:03:14 -0800 (PST)
MIME-Version: 1.0
References: <CGME20251230234958epcms1p5f6e7ba1c00c63d05a1b71fcdbcb7a18a@epcms1p8>
 <20251230235724epcms1p84d784e88ac7f220b8e1e5a6ee09e83a9@epcms1p8>
In-Reply-To: <20251230235724epcms1p84d784e88ac7f220b8e1e5a6ee09e83a9@epcms1p8>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 31 Dec 2025 10:03:03 +0100
X-Gm-Features: AQt7F2qBTSrCQbg8IVieWcXXRw87xLmKlxlKVWu5mBV8BxOPp_gHZLgbt1uonK4
Message-ID: <CANNYZj_8kRAM0rFdtFyXbfR=NWhBE7RnwRObWesT945tNW_RMg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Enhance shell_trap_code to support custom shebang
To: sangmin5.lee@samsung.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000001226d006473bbfcc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 09:03:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18664

--0000000000001226d006473bbfcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Dec 2025 at 00:57, =EC=9D=B4=EC=83=81=EB=AF=BC via lists.openemb=
edded.org <sangmin5.lee=3D
samsung.com@lists.openembedded.org> wrote:

> This change improves flexibility in script execution environments.
>

Can you illustrate this with examples please? What kind of use cases this
enables?


> @@ -434,7 +444,7 @@ def exec_func_shell(func, d, runfile, cwd=3DNone):
>
>       d.delVarFlag('PWD', 'export')
>
>
>
>       with open(runfile, 'w') as script:
>
> -         script.write(shell_trap_code())
>
> +         script.write(shell_trap_code(d))
>
>
>
>           bb.data.emit_func(func, script, d)
>

My understanding is that shell tasks in recipes are all expected to be
written using POSIX shell. If users set SHELL to something else and try to
execute them with those other shells, all kinds of breakage will happen.

Alex

--0000000000001226d006473bbfcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, 31 Dec 2025 at 00:57, =EC=9D=B4=EC=83=
=81=EB=AF=BC via <a href=3D"http://lists.openembedded.org">lists.openembedd=
ed.org</a> &lt;sangmin5.lee=3D<a href=3D"mailto:samsung.com@lists.openembed=
ded.org">samsung.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div class=3D"msg-34951883556004=
72257"><u></u>





<div><p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:1=
0pt;margin:0px"><span>This change improves flexibility in
script execution environments.</span></p></div></div></blockquote><div><br>=
</div><div>Can you illustrate this with examples please? What kind of use c=
ases this enables?<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div class=3D"msg-3495188355600472257"><div><p styl=
e=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;margin:0=
px"><span>@@ -434,7 +444,7 @@ def
exec_func_shell(func, d, runfile, cwd=3DNone):</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0d.delVarFlag(&#39;PWD&=
#39;, &#39;export&#39;)</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>=C2=A0</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0with open(runfile, &#3=
9;w&#39;) as script:</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scr=
ipt.write(shell_trap_code())</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scr=
ipt.write(shell_trap_code(d))</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>=C2=A0</span></p>
<p style=3D"font-family:&quot;courier new&quot;,sans-serif;font-size:10pt;m=
argin:0px"><span>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0bb.data.emit_func(func, script, d)</span></p></div></div></blockquote></=
div><div class=3D"gmail_quote gmail_quote_container"><br></div><div class=
=3D"gmail_quote gmail_quote_container">My understanding is that shell tasks=
 in recipes are all expected to be written using POSIX shell. If users set =
SHELL to something else and try to execute them with those other shells, al=
l kinds of breakage will happen.</div><div class=3D"gmail_quote gmail_quote=
_container"><br></div><div class=3D"gmail_quote gmail_quote_container">Alex=
<br></div></div>

--0000000000001226d006473bbfcc--

