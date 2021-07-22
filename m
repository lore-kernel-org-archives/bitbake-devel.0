Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web08.7680.1626960487997826790
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 06:28:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=uZ7bFkD9;
 spf=pass (domain: gmail.com, ip: 209.85.219.177, mailfrom: mayank77fromindia@gmail.com)
Received: by mail-yb1-f177.google.com with SMTP id k184so8259306ybf.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jul 2021 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6+H4lAOxBGDFn60LGUXrdyFd4k4NEg0Omaebbad32RA=;
        b=uZ7bFkD90yCGQ19kABS+7jzIhxK30MBdHoUToMXsHQnwVGu2KixiCZ2xt9OI19zbws
         N7i0yNP0iIVTadVZK/JpY8o3ZlrpVzrxuEcTtCU9YPwhfuCCr3IDnWMRpVxiYgWRj0ky
         Tr33Y6jGWa/Z6hQ+Na9HRQqqJNahzk/+jtkON+Yof6WZyMJ+DgNLqFxl/JbJ45jYZAZQ
         JWq7eCKoC4C7m7ad6HZcRm0C45UUKoMjpYnoM7Br6omKdKLBtHg5JaRZbs34WGPKUz5k
         0AL9QxtzeK52ThP1clzSMQNTxeGbIVTwlhjcBATVh2zvEyyCOQciuqBcW4uHg5+dFLe2
         vyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6+H4lAOxBGDFn60LGUXrdyFd4k4NEg0Omaebbad32RA=;
        b=awLYC0/MbAsuLONgO3nQCpepIAOk2PIvj5rTf0bE3ApLzBjxzKZgSQUZrePvLLjlAT
         OFXm6ffxUV7mnXtU0B2Iohi4WJOsIVIF1XJahWwILKbCnI/m0un0N05lqjzXIoeH3P8G
         DGFleyVI8eX42Qp28XLAU4dtGXLhpGTYIFGjWM7LbMtPrI2w8NRERDPWucG0S7TEqJdR
         D2UhpZ5B5D2CPykPwGPpLQYLmlQ5bdalQwfWwOMWNSYH9xg9h4Hl+udFIpnqRiyF6S9r
         9Ps1G94Aoejp+YSZeav16tm6UU/j5/gRXKGkuXgKTr/Bh3TU7/5/Y1AnJQFiajPC23Z3
         +tVg==
X-Gm-Message-State: AOAM5338mqsbP9P686es24juWKH1H8rvGBUrx6CMY9X2pInt90hZBw93
	kQy5UKX6IOyx/CfBQuRtthW1p2tQ6T2KZw8QU3nHBKAatqg=
X-Google-Smtp-Source: ABdhPJwWLDyPlXtLMl2q/KCjZlg7dPawRFqYHQ7uYPYj1zC0JPuaMwdKd/UKi7xvSmy7lmaTbi6OLkXc06Ytozx28EM=
X-Received: by 2002:a5b:d4a:: with SMTP id f10mr51162028ybr.413.1626960487011;
 Thu, 22 Jul 2021 06:28:07 -0700 (PDT)
MIME-Version: 1.0
From: "Mayank Agarwal" <mayank77fromindia@gmail.com>
Date: Thu, 22 Jul 2021 18:57:55 +0530
Message-ID: <CAKjpqyKE2teAWB5wc=6RU5_CASExfA2oXpyHNWJ5TRw2kxwntQ@mail.gmail.com>
Subject: disable do_fetch
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e45b9205c7b641a9"

--000000000000e45b9205c7b641a9
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am compiling simple c file given in file folder using simple recipe that
has do_compil() and do_install functions.
But i am getting fetcher failure error:

I don't want to execute do_fetch(),for that i am giving
do_fetch[noexec] = "1"

but it is not taking affect.

Best Regards
Mayank

--000000000000e45b9205c7b641a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am compiling simple c file gi=
ven in file folder using simple recipe that</div><div>has do_compil() and d=
o_install functions.</div><div>But i am getting fetcher failure error:</div=
><div><br></div><div>I don&#39;t want to execute do_fetch(),for that i am g=
iving=C2=A0</div><div>do_fetch[noexec] =3D &quot;1&quot;</div><div><br></di=
v><div>but it is not taking affect.</div><div><br></div><div>Best Regards</=
div><div>Mayank</div><div><br></div></div>

--000000000000e45b9205c7b641a9--
