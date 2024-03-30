Return-Path: <contact@allwright.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613FC6FD1F
	for <webhook@archiver.kernel.org>; Sat, 30 Mar 2024 16:24:09 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.web11.674.1711815846503219192
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Mar 2024 09:24:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@allwright-io.20230601.gappssmtp.com header.s=20230601 header.b=dJSnYkF3;
 spf=pass (domain: allwright.io, ip: 209.85.161.49, mailfrom: contact@allwright.io)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a4d3b82e53so1532355eaf.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Mar 2024 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allwright-io.20230601.gappssmtp.com; s=20230601; t=1711815845; x=1712420645; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KPQ5v0ijZqe8eG0W0+3EdeKdBhs/kcdSpG0Kw2BQb5g=;
        b=dJSnYkF34S2ZNfYXCTb3wuVhTAWodMQZbo0zb8YxXCqeSz23YeRsrri+S28udMacSh
         LsG7TYKAK3/PdE7ZoZKyE2SALppwDndqudV6Ys/kkCIj6109zbhYZ/zMHLNH+RP7Yuj7
         a3U9xSwlN+ux1OxtqozevePuba+hz3ypybilLPv5uDc/Ba5Ob0Znc7yplT2GcxvBCj2r
         qvalcHhtoSuN6bMrVaizNYkzONZ7Ms5x0TQDaPlEPd+BWVNk59ryk/9Wxvn61w+0DxEW
         FS7nrzqH1jtSG9NpsLfdh9eVvy/hRJlauzXrBO26fuGWmuJTkDQFOi7OKJBOikfrfoLv
         JkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711815845; x=1712420645;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPQ5v0ijZqe8eG0W0+3EdeKdBhs/kcdSpG0Kw2BQb5g=;
        b=bPFNlXLEsi+8/FcknK6tmwX13j91qXUYNAjVbXzhnN+0c9SzqHBOKUP+VLIvOs2lRZ
         YaYp2ZLr3LatVf3dEaFhE7M/1E6iELTiwY+xBq3AkalRV8o/Spgsu5UfkJw3LbCu7y1I
         sES9SWGsHN/n0AC2wuOEV1Upo5Z0bo6tOnbGzbSoMsB6g6ghcAyN8jCVX8oelkgNZAvO
         g1hfMaPV9AgeFJ1FJ/ZAX3S5xVmlxuzcgC85wUfVkRy+WfWrRevi1c6WzBqC+SnRWRlC
         BPAfQRg4kPpMGKGwiD36ODmzA5YDDsj3rpzk/VJMtuhUkQHIMoj14vGMu4UfxL3j84FR
         yHSQ==
X-Gm-Message-State: AOJu0YwDbcEAGPqhUCpZbO78EBP26vOtEwHpGubVX58iGLmbAqn3UUzc
	S31GfycneN0ZCHf17skZkbgD/O/GIH1f1jKbZpWSe7ojGTbtyNjLzuPMNJ9RZTN7ZLw2oX6bLOp
	6hYXA8uw2vi2wguvlS23cRGxRWJX851W4cosOdRQ96Tmsl1OjMAY=
X-Google-Smtp-Source: AGHT+IE+grYVDDSchHJm7Tg5M+Ftx1S+g73n3N9vgELrlf9TG74R3Gr5W0nRoxa/HMwvILkmDyffx1OGedwJnh9le98=
X-Received: by 2002:a05:6870:c155:b0:222:8961:43fa with SMTP id
 g21-20020a056870c15500b00222896143famr1777805oad.15.1711815845585; Sat, 30
 Mar 2024 09:24:05 -0700 (PDT)
MIME-Version: 1.0
From: Michael Allwright <contact@allwright.io>
Date: Sat, 30 Mar 2024 17:24:35 +0100
Message-ID: <CAB=oyq5pDsWAsV79tfNagh=AyYiOVhTQPKH-HSbegd5LPNJa6w@mail.gmail.com>
Subject: Change location of pyshtables.py / bitbake-cookerdaemon.log
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000065c80d0614e32fc4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Mar 2024 16:24:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16037

--00000000000065c80d0614e32fc4
Content-Type: text/plain; charset="UTF-8"

Hello,

Is it possible to change the location of pyshtables.py or
bitbake-cookerdaemon.log. I know it is a bit finicky, but too many of these
files start to clog up one's workspace after a while.

Kind regards,


Michael

--00000000000065c80d0614e32fc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Is it possible to change the loc=
ation of pyshtables.py or bitbake-cookerdaemon.log. I know it is a bit fini=
cky, but too many of these files=C2=A0start to clog up one&#39;s workspace =
after a while.</div><div><br></div><div>Kind regards,</div><div><br></div><=
div><br></div><div>Michael</div></div>

--00000000000065c80d0614e32fc4--

