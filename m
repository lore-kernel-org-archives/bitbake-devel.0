Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web10.1926.1629485174234797886
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Aug 2021 11:46:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=LzFQ77Nn;
 spf=pass (domain: gmail.com, ip: 209.85.219.173, mailfrom: mayank77fromindia@gmail.com)
Received: by mail-yb1-f173.google.com with SMTP id a9so17003660ybr.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Aug 2021 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UICqbFrxEs7mk2d4zaXHvwtiufaqDMETRxW4pHO26NM=;
        b=LzFQ77NnS88S1V5nuOJaR6vEXK0IMfH85KwBkp9nNb70POOqRQ7Tm4nVxt5HqK3nQp
         G+8znkbVwSsAe7ROjCWaLtYz8A1mN3I5eEz5fGsvTX1Msu6rCRQTfwPJAmsnpMdt7ZiH
         Lsj2UyTqmEV/+JCkeU4ITUqqp70rX9GnLLz9KyPuU8Q5xRQZeWchfYwcVauZeoqHb4a2
         Tm6K11aMJV9a+tJZmkg3a+ZZjbaSSkR51+SRTEJs2ZiYtJWpXXpwYiAAerIvaZLOrZKr
         Wy8Z/jA1uKwUyuksLYLbRJtVf/SJIf30Gt8SxYfD/SUeU0hN5JpXyFk4ll6qD7E2TdXF
         iuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UICqbFrxEs7mk2d4zaXHvwtiufaqDMETRxW4pHO26NM=;
        b=rCZ4sTbFzaDeIQQS4Oodhf4JugrPba06IdaGW5f8jOC0x+phAMoBXFjsvOsg4docAk
         0ITwXQod7vNXOcdcI+wP/2XSWS5okusPC860U315TpUNTZUGvHS0kABAzcUkX1kT1Asr
         K585x7rOETRo2nYkp5W9bUeJX4ewIMOPJp6CXiamuf5Rmi96PmlGJVcmTYrfDTz4tYBv
         J+i0hTuGSpcw4uXOhQYC9srzZrqg1LpYsHd/CiPyfl3BexwjN0E5g/YEW6OovKFyccTs
         BwnihKAjz125mIPSofogFB8h4V/cJTE/7+4JmA8cfAY6VqyiiwsgI5D8bAQ1A2OGbRk+
         QxPA==
X-Gm-Message-State: AOAM532WQyshcKPn9bca9OIynoY1MDeQz1jH5Uvmw/az28ceIN4ddZ3D
	wcRLkBZrHYrncdDfjvJj/ThmQ2HDv7t+t/noMOsEORLFib79rg==
X-Google-Smtp-Source: ABdhPJwVFZXVeIx8iqqSu/m6BGSvxERFfUmuDRpYiuFE3Fu97suRty013B7iW6uAEmoeQiSOVJ8eg5/7KbpwsDZ0jpo=
X-Received: by 2002:a25:68c4:: with SMTP id d187mr1470101ybc.457.1629485173224;
 Fri, 20 Aug 2021 11:46:13 -0700 (PDT)
MIME-Version: 1.0
From: "Mayank Agarwal" <mayank77fromindia@gmail.com>
Date: Sat, 21 Aug 2021 00:16:02 +0530
Message-ID: <CAKjpqyJdF4O_RBURr5Nb+GDJCzLk5=oni9yHBk09vVsaYsXgNg@mail.gmail.com>
Subject: how to give toolchain path in recipe
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000eab82005ca0214f3"

--000000000000eab82005ca0214f3
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am compiling the module in multilib
defaulttune is aarch64 and the usermode 32 bit.
how can i give toolchain path in .bb file.Is it with

EXTRA_OEMAKE += "${TARGET_SYS}"

or

EXTRA_OEMAKE   += "${TARGET_PREFIX}"

I am getting arm-rdkmllib32-linux-gnueabi-gcc not found error.


Best Regards,

--000000000000eab82005ca0214f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am compiling the module in mu=
ltilib</div><div>defaulttune is aarch64 and the usermode 32 bit.</div><div>=
how can i give toolchain path in .bb file.Is it with=C2=A0</div><div><br></=
div><div>EXTRA_OEMAKE +=3D &quot;${TARGET_SYS}&quot;</div><div><br></div><d=
iv>or</div><div><br class=3D"gmail-Apple-interchange-newline">EXTRA_OEMAKE=
=C2=A0=C2=A0 +=3D &quot;${TARGET_PREFIX}&quot;<br></div><div><br></div><div=
>I am getting arm-rdkmllib32-linux-gnueabi-gcc not found error.<br></div><d=
iv><br></div><div><br></div><div>Best Regards,</div><div><br></div><div><br=
></div><div><br></div><div><br></div></div>

--000000000000eab82005ca0214f3--
