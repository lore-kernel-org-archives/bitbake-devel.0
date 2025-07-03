Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B5C83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 06:42:24 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.16426.1751524940902668095
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jul 2025 23:42:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DVij1/uC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d6ade159so36955285e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751524939; x=1752129739; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCP0pCSEKTX08so0eLtsbjxsDkfTy9NSvZOmXGyOyw0=;
        b=DVij1/uCLco3WvHPuXlfBMvjHUANBfeNL1UXqHS/EFxRMcrhUsKj9+TSmQpbpUW21x
         e79YoqIRoxNp0iJxmKmkOWwBKjgD4bhmEjEa7dqZORyAJfXZLfiGqIGMlpE0OZKGvb/J
         GtP+1TXqNx1je/MAepgZjqWJyekTI/KWfMG9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751524939; x=1752129739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCP0pCSEKTX08so0eLtsbjxsDkfTy9NSvZOmXGyOyw0=;
        b=MlegoUOkSorgYh9/LVr5119gOasrdpTCuwqIsHuk7qodq1zVA47uNYXzftDSFTQika
         ulM0GlpndpFi9DBMe0oWuBVjQypzYjCtXOoL8tFBe39dLDc9CbJwuo+Cvpcxg+m+DRP2
         RA4n0rdY4+vv0n5u7+AJBq+ExTUxmc2b3NWGK9xNIeuhuvmrlqq8RWyi8UbC+WLy2fhk
         Nzy/nAqTQgpfTWcwAgvITpQxnhAhJkIiT2+gWmPmH/QYfget5xDH1Y23+ym7hBeFeHYl
         /zLCXlSlVK+2EROR34qPvY9a6Knr6wEqvnObqP0peuZFMp41krSEumabmWe2zylzh/WI
         0GQg==
X-Forwarded-Encrypted: i=1; AJvYcCVi0IdgxNNMGcKaBOmJafeDQMrOV3DAldiMCJ3AuuYz2B9MUxsDXsfgM/Ju1m+0ppimM34qvaOmCA1NYP4b@lists.openembedded.org
X-Gm-Message-State: AOJu0YwE5Vr2YYbX088i/0ti70spJAiIUaBXF103qbBoPkdXLPg89oJS
	qTfqhQwZ0VRgzX/rCEuo/k/oxk3sctpvGKiT2BKaibf7mjJmQjJLzkhi4iMY9IpTQUs=
X-Gm-Gg: ASbGncsy780gKBrwYZGvkGkju6/dImcqmGZuHLje94C/1g5UdSjC8XpXx8YW+ONBXH/
	ioSb9hStQWG1MrJ7iooOuL/yOO7wVlArNSfCmrAHUVnI/DYNo9y7rHx+Ey/1XlNOnG37F1BPL4y
	cYdD50p0ebLVYzxZ627zXUkIAFlY14ARcPfCczK+VlrIB82zB1m0KDRqjqACGyZRu9pHnV6Mi5B
	DzbpnOtRrTp2DGDrz0aADS4wf4RltMxRGOixnGmCRozqZh3uJdXYaab9n4vpezLg4Vb6ZwojUiy
	IT37Gz/WfTY/TTNM51gdkNbP7dJZYKykOk0OMiS1bCx7ZcEyZOE1IMZ9a+cJPdNTgl7a90WQEIp
	h6VqrpXbuKlU2c2eH3IpcnW9Wb4oV6Zsg9fSjmWg42L62oHpbzZc=
X-Google-Smtp-Source: AGHT+IEgboFQTEQiB7K55PaXrndxXaXT8UqVhSV21lbvLEy8XngJWyx6TRK+qeRPsRl7NHzMuDSWBA==
X-Received: by 2002:a05:600c:3b82:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-454a3b34003mr55096155e9.6.1751524938940;
        Wed, 02 Jul 2025 23:42:18 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e9f6:56ec:1d33:85c3? ([2001:8b0:aba:5f3c:e9f6:56ec:1d33:85c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969058sm17470535e9.3.2025.07.02.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:42:18 -0700 (PDT)
Message-ID: <1350a18ac7b6985471ac15e89321c559dbabab62.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] uihelper: Fix KeyError race condition
 in pidmap access
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Date: Thu, 03 Jul 2025 07:42:16 +0100
In-Reply-To: <20250702204758.2773339-1-ecordonnier@snap.com>
References: <20250702204758.2773339-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 06:42:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17739

On Wed, 2025-07-02 at 22:47 +0200, Etienne Cordonnier via lists.openembedde=
d.org wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> I'm seeing random build errors on scarthgap 5.0.10 because the pid is not=
 contained in pidmap.
> Fix the error by ensure the PID exists in pidmap before accessing it.
>=20
> Call-stack of the error:
>=20
> ```
> Traceback (most recent call last):
> =C2=A0 File "poky/bitbake/lib/bb/ui/knotty.py", line 681, in main
> =C2=A0=C2=A0=C2=A0 helper.eventHandler(event)
> =C2=A0 File "poky/bitbake/lib/bb/ui/uihelper.py", line 43, in eventHandle=
r
> =C2=A0=C2=A0=C2=A0 removetid(event.pid, tid)
> =C2=A0 File "poky/bitbake/lib/bb/ui/uihelper.py", line 28, in removetid
> =C2=A0=C2=A0=C2=A0 if self.pidmap[pid] =3D=3D tid:
> KeyError: 21041
> WARNING: Exiting due to interrupt.
> ```

The code was designed such that this should not happen. If it is
happening, it suggests there is some other issue going on with the task
reference handling and the patch is just hiding some other underlying
problem.

Is there any way to reproduce the issue? Have you other patches applied
to bitbake?

Cheers,

Richard

