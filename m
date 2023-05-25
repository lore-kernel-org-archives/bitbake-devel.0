Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EABC77B7E
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 12:31:49 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
 by mx.groups.io with SMTP id smtpd.web10.10507.1685017908993690873
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 05:31:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=a5uTU1dZ;
 spf=pass (domain: gmail.com, ip: 209.85.221.174, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-45719322ed8so168720e0c.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685017908; x=1687609908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRiTnTpkJqOWgicOvg/+31gWRnQxlKLdXpJ0t+HBXH4=;
        b=a5uTU1dZQXUVHGmUgNijhjt+YkZlsctHlcwPGCFep4MYIItz03v7y5wkmUweDSJdBd
         eOXgfGExSQdvNQaJDJVU/WvHIb+i13H78+u2amgg9BJ0VLbRw5USJmCSVRvxR4YKf535
         CUR1KMr826Bs37phECWJsQpv981ku8f0wL/m0mtKI58L7/yME3ls6oXppCvGVRf+/dsj
         Y43XIWg5DiiUPkjsUIWzhf128XUDwxhSxdnSA0plv1POmEcIK/u6F0fBrXD9sDcJet2w
         cMLxd20BOCysl+UWt2QnBHgrYCpWGsW/ApV1tXjdSqTgiYPkheHTIWXIZnrkIO7PPwI4
         VTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017908; x=1687609908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRiTnTpkJqOWgicOvg/+31gWRnQxlKLdXpJ0t+HBXH4=;
        b=FlGE6FGBryO/KicSMBXe3EZE1a4jvXoxyssLMwmVNpYCt4Y/0lufM37jLgQn4+Oy/r
         cosM6vEJ1wE4m7roPQ7Fh9eKGT0dt1ZIP6dtaXc8fSdP1DftGONjBwd5ZGr3aDBoZAGh
         wN2NF3ZN3iTcuvDuXXPepHCocna7rzBvyRh4AGHG59DC5TJHq6RSpzp+ho6EyT3fArG/
         0f+dFxgBRhFNDRPVy+Y18k703hVKwDLDVUiwFqSjUfqcLe5ECVtJbUD8VWmAMpiYQQAz
         2SfUv7/QvDv5BUnhP6yKloGLlmWH+11mD2p4frofp4df3Hq3THM4Gpz9NJ34XD9fEaTH
         baxQ==
X-Gm-Message-State: AC+VfDyAyk817gnkk8Ph8oP4bUoDou0BSdkf3peaBk/YAQ+KzNnkofJ9
	1t5L4SlgOPaagCmHP6Y+D0ur3fR2AW9i820bR3A=
X-Google-Smtp-Source: ACHHUZ7IJuAhdAjVs8ytckktDAU1aaOLSSJuIbl9gxS5bIBB5mNtOB1Lb23iHE5h/uZLYaXL9EQY9C52NrsCXtlblRk=
X-Received: by 2002:a67:fc0a:0:b0:439:4a28:df3c with SMTP id
 o10-20020a67fc0a000000b004394a28df3cmr4427783vsq.12.1685017907987; Thu, 25
 May 2023 05:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
 <ZG88JxkZkP4z3kR5@nuoska> <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
 <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
 <CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com>
 <CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com> <CANNYZj9LiEv3O6fxYYkE2TsmtRn5S9-PTps5cnUS2pHSSfnFkw@mail.gmail.com>
In-Reply-To: <CANNYZj9LiEv3O6fxYYkE2TsmtRn5S9-PTps5cnUS2pHSSfnFkw@mail.gmail.com>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 25 May 2023 14:35:07 +0200
Message-ID: <CAJkqNs2isdo9ranP1Fo9nakUzgwLPgsGhhmxD15B4cxkk+8bOw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Michal Sieron <michalwsieron@gmail.com>, 
	bitbake-devel@lists.openembedded.org, 
	Mateusz Marciniec <mateuszmar2@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d8886805fc83cddd"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 12:31:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14813

--000000000000d8886805fc83cddd
Content-Type: text/plain; charset="UTF-8"

>But then you can simply wrap git with a timeout command.
>https://man7.org/linux/man-pages/man1/timeout.1.html
Well, this is a good point. I don't know how we could not come up with that
idea :D We can just simply use the FETCHCMD_git variable with timeout.
Please disregard this patch then.

Best regards,
Tomasz Dziendzielski

--000000000000d8886805fc83cddd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt;But then you can simply wrap git with=
 a timeout command.<br>&gt;<a href=3D"https://man7.org/linux/man-pages/man1=
/timeout.1.html" rel=3D"noreferrer" target=3D"_blank">https://man7.org/linu=
x/man-pages/man1/timeout.1.html</a><br>Well, this is a good point. I don&#3=
9;t know how we could not come up with that idea :D We can just simply use =
the FETCHCMD_git variable with timeout.<br>Please disregard this patch then=
.</div><div dir=3D"ltr"><br></div><div>Best regards,</div><div>Tomasz Dzien=
dzielski=C2=A0</div></div>

--000000000000d8886805fc83cddd--

