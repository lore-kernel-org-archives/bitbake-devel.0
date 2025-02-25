Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4489C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 03:49:08 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.269.1740455346535983168
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 19:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DlbUzd/u;
 spf=pass (domain: gmail.com, ip: 209.85.166.170, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso44909715ab.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 19:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455346; x=1741060146; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNIal+MaS9oqRJhsEuRjDutxplonNy+I/3cnLZhO+dc=;
        b=DlbUzd/u9IbYO1hZing8d/KrYk5aASgSZ9Z87kXA1DNpTmmVajK/xvFZmLpjEQfBx5
         5I0VbZnYSfiKbW3EESUpVOEVHRQELeUWP85ZlyYoMHrIeZagclsIxogQonAFDaDg0CKD
         b9CZqUUtWtcFop1RLqRE0RkyRfb5wSyi0jZEDEzeYo6DW4sjyUkkvL6wiHzf2HYGfT4D
         xNTU9QtlxIBy2iwMkhJNiCBE76uSWunWzYdSXOrd/42Vt/padqqxE8Dk/XL2tldX9q/X
         ECzqgGDIzocinOz3loqL/LteOVwQMuCCEviWpwd8e1YlTHmohqZG6i8Xm/9iF7MKfT9l
         cQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455346; x=1741060146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNIal+MaS9oqRJhsEuRjDutxplonNy+I/3cnLZhO+dc=;
        b=GcNtwXwpXEAn9XdROS8m1U/Dtbc2Ur6GG2y5j02cBknIm6r0Kd6/AgWz55XmxS6YCj
         J7y9g0mZmk04gzQeTB84G4Wq/jQrqeGAzU4xGyvgnh2RF+jBPYI51vyKtWSnJIH9w0j3
         KmjL8kTFwojYb+QiqOx9dJz+H+e3a45TU3jpETwzYHXbsPkmUt49Zk0zFSZasEK8SIEi
         A2wX4VomDNT4mX8ftxgGXM8/KBiCKVDfOvl2lNACP17TEq8ETqScs0obN9RqL2z9dsNl
         874tXl9YXg7p7LSUiMAiXKHVGcTNz6Y+TLygbty4I15qmw/500oDpefNsj0Fd6ot+p9t
         HuZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmI6lcl33F9hCq4aN2Kt0ssO2/t5BMTNawwvbBz+XAsh77I+YA6cov5fTWAutQKW2lOdiMBx68WaZdGU5Q@lists.openembedded.org
X-Gm-Message-State: AOJu0YzkwIZlFo3bHCNG5aGVjrBbX/r4ZKfJgYB2j/VYNmm29Gu/MR5K
	DStybvzt51dXd85b3E+nMwQ2XyTarj4TOI9yoYLwlawLphVub+ISPgbhy0AmZ04U45y6IO5FUsu
	mHTdiifYkfYdB3MoiGbXyzsGlEzI=
X-Gm-Gg: ASbGncsLZj0R3dVb5mA0p7jdNuP+kB0Yz1g0twPcY2Fnts4s/MmOlFrXhuVZnSqcOmg
	ltA73xVNX3Ux5uIH20hhfMFDd10R4iv9bqjAdI+cYNMrzyR0gm9Pp7kIKylxOmKBaH4OYNmBmyT
	aCoXNKa+FQrLqqAW2HeWOTufZC2Lp/RbJNy3lKDFD4
X-Google-Smtp-Source: AGHT+IH/RF2NTA/Kb05t/cJIkN1NsFhObzB4qBJgbkmPggStzM2FHgjhPC0Eho7MSOo9USjViOt6FWDCnhTgh6RoVto=
X-Received: by 2002:a05:6e02:16cb:b0:3d0:137a:8ca2 with SMTP id
 e9e14a558f8ab-3d2caf0dbeamr180945045ab.22.1740455345740; Mon, 24 Feb 2025
 19:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20250220143030.12982-1-eric.meyers@arthrex.com>
 <20250220143030.12982-2-eric.meyers@arthrex.com> <CANNYZj_d1vuPc9M6+6WBnrQ-RRDRArngsDxSi_8ghjeK=pDO4A@mail.gmail.com>
 <CA+cKJ+Gvb8FjFwTnjT4EFDhU-c-gQYA8G34-wAEmcYMYSyBQMA@mail.gmail.com>
 <CAB=6tBSOFHMAja1JyhiXW2jMctsLfNFjA_1kXXDe2PTh4a5u5w@mail.gmail.com> <CA+cKJ+FCC4bsam7GpSfOaF-zz=suyzb+No4VxTMwDWFti5hDfQ@mail.gmail.com>
In-Reply-To: <CA+cKJ+FCC4bsam7GpSfOaF-zz=suyzb+No4VxTMwDWFti5hDfQ@mail.gmail.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Mon, 24 Feb 2025 19:48:48 -0800
X-Gm-Features: AWEUYZmp4StXQ8nNnEhYR4IjShVLUthC_b_vznVRTi5rqt5HCmg9DLwqrUdoVRw
Message-ID: <CAB=6tBTK7=ZrKpx7V6okr_7ht1SG=tBOFXHqFLQg5LtbE+ssEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: multipart/alternative; boundary="000000000000a1633a062eef5616"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 03:49:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17297

--000000000000a1633a062eef5616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:29=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

$< Snip $<


> And while theoretically I can create an extractor that will pull out
> various fields from the npmrc file, I think the nature of scoped packages
> coupled with variations in how to specify authentication strings in npm
> will make this easier said than done.
>

That makes sense. Until we find a clean way to extract the authentication
elements, locking it up behind a variable should avoid surprises.

I will submit a v3 patch within the coming days that adds support for a
> bitbake variable (defaults to off and allows the user to turn this
> functionality on/off), along with a bb.warn log to let the user know
> they're using this functionality. Thanks for the insights Chuck!
>

Thanks, that seems like a reasonable middle ground.

..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--000000000000a1633a062eef5616
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">On Mon, Feb 24, 2025 at 4:29=E2=80=AFAM Eric Meyers &lt=
;<a href=3D"mailto:eric.meyers15310@gmail.com">eric.meyers15310@gmail.com</=
a>&gt; wrote:</div></div><div class=3D"gmail_quote gmail_quote_container"><=
div><br></div><div><div style=3D"font-family:monospace" class=3D"gmail_defa=
ult">$&lt; Snip $&lt;</div></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:monospace" cla=
ss=3D"gmail_default"><div>And while theoretically I can create an extractor=
 that will pull out various fields from the npmrc file, I think the nature =
of scoped packages coupled with variations in how to specify authentication=
 strings in npm will make this easier said than done.=C2=A0</div></div></di=
v></div></div></div></div></blockquote><div><br></div><div><div style=3D"fo=
nt-family:monospace" class=3D"gmail_default">That makes sense. Until we fin=
d a clean way to extract the authentication</div><div style=3D"font-family:=
monospace" class=3D"gmail_default">elements, locking it up behind a variabl=
e should avoid surprises.</div></div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:monospace" c=
lass=3D"gmail_default"><div>I will submit a v3 patch within the coming days=
 that adds support for a bitbake variable (defaults to off and allows the u=
ser to turn this functionality on/off), along with a bb.warn log to let the=
 user know they&#39;re using this functionality. Thanks for the insights Ch=
uck!</div></div></div></div></div></div></div></blockquote><div><br></div><=
div><div style=3D"font-family:monospace" class=3D"gmail_default">Thanks, th=
at seems like a reasonable middle ground.</div><br></div><div><div style=3D=
"font-family:monospace" class=3D"gmail_default">..Ch:W..</div><br></div><di=
v>=C2=A0</div></div><span class=3D"gmail_signature_prefix">-- </span><br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><b><span sty=
le=3D"font-family:monospace">=C2=A0 Opinions expressed are my own. |<br>=C2=
=A0--------------------------------|------ &quot;Perfection must be reached=
 by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 she requires the slow hand of time.&quot;<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Vo=
ltaire</span></b></div></div></div></div>

--000000000000a1633a062eef5616--

