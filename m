Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6499AD44C66
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 15:06:44 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37874.1768489601543866797
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 07:06:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gSywC0x/;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78c66bdf675so9392437b3.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 07:06:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768489601; cv=none;
        d=google.com; s=arc-20240605;
        b=X8qyTSHu2Gp/TVPz9H2F9ltP8G1VL8XxOaI7HGqIkeVnPYo6ZdQKaqkk+aaVgCT6CG
         Psb0wm0S193R3YFhJ1sEC9oTMDfOzw94YW5jh9T04DKOy7ll3MZA4GgYBPHlqy3NIM/G
         c8kZKL+VQHl6Pw/ivUBTpqSdknP/SnRmxxW9miyG2+WXefRh5cUCN0ofA+5YOIinLD1H
         JbE39eKWteDtQWFQr9JXklXS72qzfmnmo25xy0Z0OhoynK/s0LYF5zZc69KEv3zsf+29
         E9DZxBx+YSL9O4h8ZIN27yGNTddq9hm99h0y6KW9QGmfbGWyJw+fKD+24YBmnCnubsax
         qcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KCm80VZeYRJeiBvVpVZZ/ii5SZaKRhPfOqfwmOERxDc=;
        fh=EZI2tsxG+lO4qBI+kdtpIEjXrPfT/BQV4vAyxcJAEfI=;
        b=ZBi5ycmrBtCOn9ioiy8hOHFASmCc0xG3z8GPyDoNK7Vn2AQSnTk6IDYg8Y2UBEn7CB
         NmbjUAgc3P+Ity5smhS24WCZqQdPu1SmucNtJeNizDDDAkv3y2nFhEyhCpIwWwEIMaPR
         QjRuF/HQyAhVndRXrrYYTmiZhzEaKkL5b75BO2V+cj9zvb3pdsjO+92OEezHbwzJeeP8
         GyK3Er3ZXciqUQROzgX5NHcJaxFtX81xNXmewdKYf9Cuv5avFBLTgW3qUMORVU78CyLz
         M0MCIKxBpojCzmbZBTV2oMpPTxg2D+Ity15rI8Wz53gsO2/3uorLbXkol6IuGVRsG3Vs
         GUSQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489601; x=1769094401; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCm80VZeYRJeiBvVpVZZ/ii5SZaKRhPfOqfwmOERxDc=;
        b=gSywC0x/bO2Yyg6MG7FPopCpUOvUDFsqGkRovaNBQCXvTWmihq2l6T4g0k70+pCuHA
         nKzYgqZL7VqqZak88g3cBpi6jGnW6AJz6zRGTHizpbEjsN6zwYyXiVCicm6+Oc7Vb2j4
         vMIzLLsHzUKYpuNy9KVY3ek1RsxWNzRVCs0WYsgNsTbm/f+i0A7D4TZlpbIYIkcUuPnr
         CGvnur1+oEa58srbOR8WF44JuoiIrp6Otf8dY0i3K4yJEI4n/5eBz4U+gEf4s339KPyR
         /WMmuq9VQJoNt6YFMOOA0uKNnzdBCDNQOmxPE5RAZXePAZZAiAmZRTnOR1fG+EbN/slk
         J4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489601; x=1769094401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCm80VZeYRJeiBvVpVZZ/ii5SZaKRhPfOqfwmOERxDc=;
        b=X3zD84kcH7UuJ9NwCyMicZWm5zrCjVglzOvmzKDOsJLBGsJq9PJ0nkMKl39IMD7ni7
         CID6XoU21y/mz0mhzLy2qc5tzNn+AJQ8pOl8x5o8ar5ofQzNwwEa6O4D4aTCd7QPWbdv
         WHd+z69/yBfuIR4NJvoU8Qch22yLvTp/Gm3YB8Ej5z+SN9sQdQWtBEmkCDcQH0m5hxmJ
         irXRgvZVbnzoGtF63JEN5DR2LR8AfT/LEEHTisbuQikclfDLlaA0CW0pVdHMDEF4xD+E
         rw9wcyLDB5MKIjUko4BlRf3M6C59olh/kQwxTBMPSw0m2mQJesCHUxXLTJMmyQWTvckl
         RelA==
X-Gm-Message-State: AOJu0YxYRK8d4GQxSzVGDUEpnJS//n1BYPpIZGtKC1ndZMfai6Qk9KSF
	pfESjUGMzA/qhd7JZiidrF2yLH0e94ktoGXx5vsdwWPvGyipUaw3QwcqS8dRHnJAMUQuLjPLKYS
	WBEiMecaw4M/D4VPkbb8Mc/goYdYz+V4=
X-Gm-Gg: AY/fxX716LCmQSGcbziZsBX4rslkPTQotObCU14v/9FwZM6NzqqcVV6qyz/KWwiVlD8
	Hk3IduQblIxep6Zw1NHHzbkVmqIjO74D+fOUbNh5BvZ5ZCt7NORuPEHFAKEA32K4bwunnpkptpE
	KTL3qlB964dQ6AdIiL/RxeYP6htlETUNNk0hz47UvopJsnfwvJ+gDPZXf9Qz26lmw5SDh0YRDJp
	kCIvy1Cmvw+eTtwRo/ziemC/Dk5pDKQhmUHSe6WkLWr7QgINEenaj5FJiHVbFqtAVhe1DS08WKo
	O/bmZ5YsTBeByFqdoyg/pGtcziY=
X-Received: by 2002:a53:ac81:0:b0:63f:c4f4:e199 with SMTP id
 956f58d0204a3-6491647e5edmr52652d50.15.1768489600390; Thu, 15 Jan 2026
 07:06:40 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKqqWj-_1V4P0o-DhDSXBXy_6aBuAC9r==zud3k-3RZ5dg@mail.gmail.com>
 <ea841ef89441f2d3efd4b81006b93f1695af1e2f.camel@linuxfoundation.org>
 <CANNYZj-vTVM3XMzo2yUWTV+DZPSy_=FMWq-QozcnPiz6SMbysQ@mail.gmail.com>
 <CAP9ODKotNQtqJu5uAiWmyvrAcD5c=0PhbcnhUVjOq=whbrTeWw@mail.gmail.com>
 <CANNYZj_nUe_eGcs3ckZNtubTBHBt6utgO055fDJ2k6rc8oX3gw@mail.gmail.com>
 <DM8PR11MB56556083B2D363FD68788438E18EA@DM8PR11MB5655.namprd11.prod.outlook.com>
 <CANNYZj8nFBDKUtHjXTsdxDJJ2kTOzTRSFhuwr1zt67OSedp2pQ@mail.gmail.com>
In-Reply-To: <CANNYZj8nFBDKUtHjXTsdxDJJ2kTOzTRSFhuwr1zt67OSedp2pQ@mail.gmail.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Thu, 15 Jan 2026 10:06:28 -0500
X-Gm-Features: AZwV_QjVqVgf9Gcxs9CUuZMeoTPCVxJ0YZnbwa93YAhzj0FB-GQUXWG4KuEOqmk
Message-ID: <CAGAhMByoxxcvRKjbDQXNseWOZvwe0ApHuMiLJvpUspL82_v0Jw@mail.gmail.com>
Subject: Re: [bitbake-devel] publishing bitbake-setup on pypi
To: alex.kanavin@gmail.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Tim Orling <tim.orling@konsulko.com>
Content-Type: multipart/alternative; boundary="0000000000006ba4b406486e9249"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 15:06:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18783

--0000000000006ba4b406486e9249
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:01=E2=80=AFAM Alexander Kanavin via lists.openemb=
edded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> On Tue, 13 Jan 2026 at 18:14, Woolley, Rob <Rob.Woolley@windriver.com>
> wrote:
> > I have published a small repo that shows how I packaged PyPI:
> https://github.com/robwoolley/bitbake-setup
> >
> > @Alexander Kanavin let me know how you would like to proceed.
> >
> > I am happy to work to maintain the PyPI workflow and set up tests to
> automate how it is tested and packaged.
>
> Thanks! Let's continue on bitbake-devel.
>
> I would suggest this:
> - we should avoid separate repositories. All three files should find a
> place inside bitbake repo itself.
> - the steps in the readme (e.g. copying files around to created the
> needed tree structure so that pypi packaging can happen) should be a
> script: pypi-bitbake-setup.py
> - there should be a test for making a pypi package that executes all
> of the steps, and produces a .whl file, just short of actually
> publishing it. You can extend lib/bb/tests/setup.py for example. Even
> better if the test would install that package, and run 'bitbake-setup
> list' from it, as a smoke test.
>
> As for making sure pypi packaged bitbake-setup can find standard
> configurations, I thought about this for a bit, and I think we should
> not package them into pypi at all. Rather bitbake-setup should be
> configured to use bitbake repo as a configuration registry. This will
> ensure it will always have latest configurations, without having to
> update the pip package, and will keep the code and packaging simpler.
> I'll propose a patch for this that I would like you to test.
>
> Cheers,
> Alex


I agree with all the points above.

I'll start investigating how to implement those changes.

Regards,
Rob

--0000000000006ba4b406486e9249
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jan 14, 2026 at 2:01=E2=80=AFAM A=
lexander Kanavin via <a href=3D"http://lists.openembedded.org">lists.openem=
bedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.openemb=
edded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:</div><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, 13 Jan 2026 at 18:14, Woolley, Rob &lt;<a href=3D"mai=
lto:Rob.Woolley@windriver.com" target=3D"_blank">Rob.Woolley@windriver.com<=
/a>&gt; wrote:<br>
&gt; I have published a small repo that shows how I packaged PyPI: <a href=
=3D"https://github.com/robwoolley/bitbake-setup" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/robwoolley/bitbake-setup</a><br>
&gt;<br>
&gt; @Alexander Kanavin let me know how you would like to proceed.<br>
&gt;<br>
&gt; I am happy to work to maintain the PyPI workflow and set up tests to a=
utomate how it is tested and packaged.<br>
<br>
Thanks! Let&#39;s continue on bitbake-devel.<br>
<br>
I would suggest this:<br>
- we should avoid separate repositories. All three files should find a<br>
place inside bitbake repo itself.<br>
- the steps in the readme (e.g. copying files around to created the<br>
needed tree structure so that pypi packaging can happen) should be a<br>
script: pypi-bitbake-setup.py<br>
- there should be a test for making a pypi package that executes all<br>
of the steps, and produces a .whl file, just short of actually<br>
publishing it. You can extend lib/bb/tests/setup.py for example. Even<br>
better if the test would install that package, and run &#39;bitbake-setup<b=
r>
list&#39; from it, as a smoke test.<br>
<br>
As for making sure pypi packaged bitbake-setup can find standard<br>
configurations, I thought about this for a bit, and I think we should<br>
not package them into pypi at all. Rather bitbake-setup should be<br>
configured to use bitbake repo as a configuration registry. This will<br>
ensure it will always have latest configurations, without having to<br>
update the pip package, and will keep the code and packaging simpler.<br>
I&#39;ll propose a patch for this that I would like you to test.<br>
<br>
Cheers,<br>
Alex</blockquote><div><br></div><div>I agree with all the points above.<br>=
<br>I&#39;ll start investigating how to implement those changes.<br><br>Reg=
ards,</div><div>Rob</div></div></div>

--0000000000006ba4b406486e9249--

