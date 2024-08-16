Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A2C531DC
	for <webhook@archiver.kernel.org>; Fri, 16 Aug 2024 19:12:36 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web11.155859.1723835552568637061
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Aug 2024 12:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FeavgnIF;
 spf=pass (domain: gmail.com, ip: 209.85.166.172, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39b3cae5675so6727455ab.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Aug 2024 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835552; x=1724440352; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dmCEpoFPLbC7CyJo274Ys8zxoDQcnbzCXetd2PvwRvE=;
        b=FeavgnIFM24CqL7sXulejpZIWZNUKxsFWxeij0k4M8GEy+nzNZmKVmNMkG4aEmxQfe
         CVu/i481tZ2LA9lvgdu72EnSpq3LseGwnhBOPPZe5w5H4lw5fj34CjAeGSgj2ffAAoJK
         KP/r5OKQrgPRnRsLIiqpzC8GuevAZlM+2F2J/f3i6zSWKeb1Igi42rUiqk1kj9sD0OJI
         Hd2FPCUhpUugm6Teev4osf30a9cUrjKFFMIHEOz5Y/CzDnUAzl+mCeLoXhhJ3OCsD8Zw
         2GA8kFxivgDpjOu06zAORr9Q10hkTePaM/FsVpEy8Sk3Z1xwCwMx8OGLrWV6t3efe8SX
         bmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835552; x=1724440352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmCEpoFPLbC7CyJo274Ys8zxoDQcnbzCXetd2PvwRvE=;
        b=AKM1/HJgmrK+Hnte68nhtISjhk5T8rv99/kALeC1vdV1QP7A3Y6bGN1xjxQItV4NTA
         snwttA4kcSHgwohE0JIe0Zj+N38eEn7A/DroueZ2mrlgjwf35ylTDzQDoYmgDi/7OyDH
         K6Kjd1NAV1Hf8X0U4nnyzBv/QTcqOUA77V0AXoXY20dQC5X/eoJH+5N1UwBIllLV3/BN
         uQSSdaQ/+jYC5Gje03Boj3/0Wm6ZgRmutuDz9CKON1CWvudKt0vgPadnHY8JFR0pCW5E
         Sxx0KAa4/vZC/Jnvag0nRR5Jv93HnuioTvWo7ttBzUg2q1Sgp9t5phfNiv1IMFHwy6IP
         00mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHJFzky8te5Z1ZdgMnjnbbJXjXzCrD2PUcMvGwA8eZHSNkCLRf9/zt3cMZjmJQ8gHNCu+flNquAmMTRgsZpkjM7B5FWY4N+ajXT8T7nSr9NzJe3bA=
X-Gm-Message-State: AOJu0YxJmcTE2NfP5yNR+GoIecbbfXy2h6f3PPFmwPnT8bGOu3cM+DrU
	D6hDOJYMK+pkQHErrBjU0yAYEDEhIztiGRIexEpLr9/kFRctqvlKNTNxdePO4bflYVvAHM39ndw
	aoOLN2YFuIm3pZXEpnCUthIIG6rI=
X-Google-Smtp-Source: AGHT+IHPH0LEYWqwO9+j/uIRdOT24U9ZvvREjPeNgiA1QsYt3//fa6VczxbZm/0SbdkE70A8A4DUFcxtrT9ohavZsMc=
X-Received: by 2002:a05:6e02:1567:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-39d27b4fe7cmr35201585ab.12.1723835551699; Fri, 16 Aug 2024
 12:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com> <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
In-Reply-To: <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Fri, 16 Aug 2024 12:12:20 -0700
Message-ID: <CAB=6tBRL7iJ5w3dFibTMwnw28qfcijA72unf5Gp=S=qD1zHOyQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified versions
 in package.json
To: richard.purdie@linuxfoundation.org
Cc: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org, tanguy.raufflet@savoirfairelinux.com, 
	alexandre.belloni@bootlin.com, stefan.herbrechtsmeier@weidmueller.com
Content-Type: multipart/alternative; boundary="000000000000b5dcc1061fd1bd2e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Aug 2024 19:12:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16492

--000000000000b5dcc1061fd1bd2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 7:12=E2=80=AFAM Richard Purdie via lists.openembedd=
ed.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:

%< snip %<


> I'm not convinced by this reasoning. The whole point of our SRC_URI is
> to precisely define something that is being built. I think this allows
> floating versions of dependencies and hence makes this non-
> reproducible?
>
> We should probably error if a version cannot be found and force the
> user to add one?
>

Strong agreement with this point.

YOLO'ing dependency information is probably a nice way to do rapid
development
and prototyping, especially if safety and security is not a concern.
Otherwise
I simply cannot wrap my mind around the idea of intentionally changing
things
to make them less traceable and less reproducible.

..Ch:W..

--=20
*"Perfection must be reached by degrees; she requires the slow hand of
time." - Voltaire*

--000000000000b5dcc1061fd1bd2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr"><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 15, 2024 at 7:12=E2=
=80=AFAM Richard Purdie via <a href=3D"http://lists.openembedded.org">lists=
.openembedded.org</a> &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundatio=
n.org@lists.openembedded.org">linuxfoundation.org@lists.openembedded.org</a=
>&gt; wrote:</div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div clas=
s=3D"gmail_attr">%&lt; snip %&lt;<br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
I&#39;m not convinced by this reasoning. The whole point of our SRC_URI is<=
br>
to precisely define something that is being built. I think this allows<br>
floating versions of dependencies and hence makes this non-<br>
reproducible?<br>
<br>
We should probably error if a version cannot be found and force the<br>
user to add one?<br clear=3D"all"></blockquote></div><div><br></div>Strong =
agreement with this point.<br><br>YOLO&#39;ing dependency information is pr=
obably a nice way to do rapid development<br>and prototyping, especially if=
 safety and security is not a concern. Otherwise<br>I simply cannot wrap my=
 mind around the idea of intentionally changing things<br>to make them less=
 traceable and less reproducible.<br><br></div>..Ch:W..<br><div><div><br></=
div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><div><b><span style=3D"font-famil=
y:monospace">&quot;Perfection must be reached by degrees; she requires the =
slow hand of time.&quot; - Voltaire</span></b></div></div></div></div></div=
>

--000000000000b5dcc1061fd1bd2e--

