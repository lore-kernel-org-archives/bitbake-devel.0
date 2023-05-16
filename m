Return-Path: <katutxakurra@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966EC77B7F
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 14:09:42 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.22939.1684246179597679494
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 May 2023 07:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=s0Mj8j54;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: katutxakurra@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ac82912a59so150513801fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 May 2023 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684246177; x=1686838177;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dXgBw3m4lW5rPWl7aCouTz0aYin6UbTYbjkGlloEstY=;
        b=s0Mj8j543+mWLeA4GWi/0vKU5/lFviur7ttBV9D3axRe3lyrvLj10ZrjI/UePWMd8r
         CFP3NedJXgvkbmyo3GKH+j+ihoRCjPRPfelD9zLTjvXtlLAu8qcAz3k21Zi/HvbsnZqh
         urd7aPvs00FiDHKxDewSVdAiG10cKgVTyaITf8njAjkGGbGYUVS+EksXULv32p5zQz97
         gojQl2x7qYPWf/9Qjejm6MCfhjOzsG5bApLUhWB4YcFxD2J5ZyM9nVBIoic09wBHosJG
         DMHXwzvuQkeh5QgvFnRVrmle9K3mB9Ya8Bj/+ZGCyf4lqMdjJmRskT4zp0c317wCC7Ck
         51ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246177; x=1686838177;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXgBw3m4lW5rPWl7aCouTz0aYin6UbTYbjkGlloEstY=;
        b=f//9JWbMANEgYQ5fq6uXR0iHCEM6MJgjLQeDXsJELULJGhyu13DFAAR7Ph6C6KlvkC
         Ya6jJoeJmn7Rg+9N13b6fZkRsiNItVjQupsruEdRZ7BnNP3rFjNJ2eDv3pQPTrBe3Nuc
         nujZ1VZl1M1btGI9XDusbShd76tIR97bYr8IWFrZENf8M504QtcMfNPY+qnl4PcQTm7H
         Pwd/ul1fLW+LbWizMIPxeuXZ5jTTHLHGqv4UUqaHm0D1e5o+pJdHFl+2RKR6IAJhhUoY
         tMN/d39uvKsrCpGNf4Yh1kHtNMRI/DvLHFP0AqVlmS7yrX0bXxT/leU/cS2RRrUTePue
         UlqA==
X-Gm-Message-State: AC+VfDzCjeGoww32kLoWH1pv/4GXXNe6+acOsB3eNad6KeAzuXTOCbrJ
	WXrdfKzhLz3Ml59rErss1OcZZtWLOWggiTpVQfH4ubCTzDM=
X-Google-Smtp-Source: ACHHUZ54PWXIk/kO6X4ZJX1Ct5lkPiEnEz1LKB+FqVFWZD45DkZGuUdEYwK+m8eujDa5maVMm42iylWug2GrbPEFzMo=
X-Received: by 2002:a2e:800a:0:b0:2a7:96bd:9eb3 with SMTP id
 j10-20020a2e800a000000b002a796bd9eb3mr9092317ljg.3.1684246177029; Tue, 16 May
 2023 07:09:37 -0700 (PDT)
MIME-Version: 1.0
From: Katu Txakur <katutxakurra@gmail.com>
Date: Tue, 16 May 2023 16:09:27 +0200
Message-ID: <CAM1ZcoWMhqeta8uu1rKPyWVC6m2tFjuHcTTqHzV3DiVPVdOpyA@mail.gmail.com>
Subject: [bitbake-devel] Modify extlinux.conf from my layer
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000018a26805fbd01fac"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 May 2023 14:09:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14788

--00000000000018a26805fbd01fac
Content-Type: text/plain; charset="UTF-8"

Hi,

My image has a /boot/extlinux/extlinux.conf file with:

default Yocto
label Yocto
   kernel /zImage
   fdtdir /
append root=PARTUUID=a60cf838-02 rootwait console=ttyS0,115200

If I manually add the DEVICETREE, it works and my selected dtb gets loaded
at boot:
default Yocto
label Yocto
   kernel /zImage
   fdtdir /
   DEVICETREE /am335x-bonegreen.dtb
append root=PARTUUID=a60cf838-02 rootwait console=ttyS0,115200

How do I add this as part of my build? I've tried setting
UBOOT_EXTLINUX_FDT in local.conf but it did not work.
How do I add a custom dtb? Ideally without having to patch u-boot or
kernel. I'm pretty sure there must be a simple way to achieve this. Any
pointers or documentation I can read, I'd appreciate it.

Thank you,
Katu

--00000000000018a26805fbd01fac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>My image has a /boot/ext=
linux/extlinux.conf file with:</div><div><br></div><div>default Yocto<br>la=
bel Yocto<br>=C2=A0 =C2=A0kernel /zImage<br>=C2=A0 =C2=A0fdtdir /<br>append=
 root=3DPARTUUID=3Da60cf838-02 rootwait console=3DttyS0,115200</div><div><b=
r></div><div>If I manually add the DEVICETREE, it works and my selected dtb=
 gets loaded at boot:</div><div>default Yocto<br>label Yocto<br>=C2=A0 =C2=
=A0kernel /zImage<br>=C2=A0 =C2=A0fdtdir /<br>=C2=A0 =C2=A0DEVICETREE /am33=
5x-bonegreen.dtb<br>append root=3DPARTUUID=3Da60cf838-02 rootwait console=
=3DttyS0,115200</div><div><br></div><div>How do I add this as part of my bu=
ild? I&#39;ve tried setting</div><div>UBOOT_EXTLINUX_FDT in local.conf but =
it did not work.</div><div>How do I add a custom dtb? Ideally without havin=
g to patch u-boot or kernel. I&#39;m pretty sure there must be a simple way=
 to achieve this. Any pointers or documentation I can read, I&#39;d appreci=
ate it.<br></div><div><br></div><div>Thank you,</div><div>Katu<br></div></d=
iv>

--00000000000018a26805fbd01fac--

