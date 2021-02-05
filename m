Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web11.8809.1612535120603970122
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 06:25:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=le216Ilc;
 spf=pass (domain: gmail.com, ip: 209.85.166.45, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-io1-f45.google.com with SMTP id j5so7184056iog.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5Es/kcNsV8zxd5zYQdOZYcNDpkQpyJpSyA/Cu7TmPM=;
        b=le216IlcQaRiqlHcfLGaPY+3maNag4dhVyOxBvP9vScKRxn0hAhngEVWtEULzUHJG2
         WgCeRX/tQjZasnV0YZa75rsoJYvWvBOqyXlfPtGz3gYMGs7UwXZbl7mf1nFMY+BCWteW
         uJ7zhcaGceMJfpK84t+tWrt6pm7IdxBX3lM+WR26Py172A5Z4bdvE3nC4I+gTCzUnlSc
         7/rsxcmQIOXxTlx410uDrVU8K7f3t4N96Q5JAm2l1rMV1C9PymxlZiEfcJjysyaOL1ek
         7joDY4uhdLvyoaE3iOz4XTcYcVUPoj4CqXKdDrmiqgtqXwb7VIV08jSKYGXp6W+xD3/W
         5NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5Es/kcNsV8zxd5zYQdOZYcNDpkQpyJpSyA/Cu7TmPM=;
        b=rQsvtIhk11pe62c+VXYE3X0z3RIWLmGfugHUn1R+cyXLObVJgR3RerQECSdGkz7mqb
         09O/YFNVi8MRaw7WKcZkr8fd38twNNsZaExgsJsR8yVihzD0cG2e9e4qECphKCz9mmbF
         KJD5+t9aAHAsJGOMO3L0EOrJYdTg/06XwuGwFuM8mQR52XKHBdnSgDKCMfdcl982lxKf
         NnSlzk7n7gEhfOCySW6gQoM6tC62jO0LXkYG3EfhMxItmE+BeFZeXJq1bvDPktUL4Dbk
         rMAlmLIccAPZviCs1czQ+UCDt8oDnyiDjhFR0gog5l2oc/w4Q3y6ygRRcuqK/i/2OIFp
         G1yA==
X-Gm-Message-State: AOAM532EkabMlEVbqAg1wF882zNzUUcr+ab2n4NbcqD3RH4rg/OP65rY
	1n9k4Eq5AU18Gu14eP9LX3DdRFbCP5GGnIlkWx4=
X-Google-Smtp-Source: ABdhPJxViDOQEXH4kBRWf5h1HfIrZLxBoXMCBlWllukGTyg/fVTuHYIcoV7H5kMOk9VYm7LKIcXNkhQJWkrZzw2ocf0=
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr4054849ioe.190.1612535120097;
 Fri, 05 Feb 2021 06:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20210204221422.16042-1-tomasz.dziendzielski@gmail.com> <1e3bfe4059efd60bf6ee4b31c1b81355f6657586.camel@linuxfoundation.org>
In-Reply-To: <1e3bfe4059efd60bf6ee4b31c1b81355f6657586.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Fri, 5 Feb 2021 15:26:42 +0100
Message-ID: <CAJkqNs2S2_JVZRpDgj_62zGmyqrLUyybDNy3z5wutn7RH_pWvA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] event: Prevent bitbake from executing event handler for wrong multiconfig target
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000575a205ba979705"

--0000000000000575a205ba979705
Content-Type: text/plain; charset="UTF-8"

I can already see the bitbake test failed, after adding "if d" it passed.
Sorry that I forgot to run tests before submitting a patch. Another thing,
I ran locally oe-selftest -r multiconfig and build fails with "When
reparsing %s, the basehash value changed from %s to %s. The metadata is not
deterministic and this needs to be fixed". During the build it appeared
only if I made changes to the code during the build. Here it's most
probably caused because of events' handlers renaming.
Do you think there is some way to handle this issue or I should just add:
         ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH") or '') ==
'1')
+        if d.getVar("__BBMULTICONFIG", False):
+            ignore_mismatch = True
to bitbake/lib/bb/siggen.py?

Best regards,
Tomasz Dziendzielski

--0000000000000575a205ba979705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I can already see the bitbake test f=
ailed, after adding &quot;if d&quot; it passed. Sorry that I forgot to run =
tests before submitting a patch. Another thing, I ran locally oe-selftest -=
r multiconfig and build fails with &quot;When reparsing %s, the basehash va=
lue changed from %s to %s. The metadata is not deterministic and this needs=
 to be fixed&quot;. During the build it appeared only if I made changes to =
the code during the build. Here it&#39;s most probably caused because of ev=
ents&#39; handlers renaming.</div><div>Do you think there is some way to ha=
ndle this issue or I should just add:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 ignore_mismatch =3D ((d.getVar(&quot;BB_HASH_IGNORE_MISMATCH&quot;) =
or &#39;&#39;) =3D=3D &#39;1&#39;)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if d.get=
Var(&quot;__BBMULTICONFIG&quot;, False):<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ignore_mismatch =3D True</div><div>to bitbake/lib/bb/siggen.py=
?</div></div><br><div class=3D"gmail_quote">Best regards,</div><div class=
=3D"gmail_quote">Tomasz Dziendzielski<br></div></div>

--0000000000000575a205ba979705--
