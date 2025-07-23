Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26682C83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 10:45:36 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.11041.1753267535026444124
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Jul 2025 03:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Hz1jtS+m;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so50270115e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Jul 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753267533; x=1753872333; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tRLjoHBYWBA8aR79EoRe3ZiOlbgLCCHK1suXGFm8eNg=;
        b=Hz1jtS+mmZcaZJVpMhZBqow4dydty+K+1OAY+aqlkiJN5FBgY2ouYpmPm2WoXyBME+
         xfiGvNcVkr6lTXaxpN7928KmVJ9TQk4ynzANuIw2LBbPEM4hgYR0fKO5fdRD+GVxFd+c
         OIzBrU5TYwkK+tgcGvyxcjnUGyrtE0bTYmmq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267533; x=1753872333;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRLjoHBYWBA8aR79EoRe3ZiOlbgLCCHK1suXGFm8eNg=;
        b=XDrKHx07H99euxtntHOOK7U0WLWbn8uGuOOmL5yNJLy5DDD+eJQNGL1ADc7njxaETr
         8WZLWhwQDMNX2scFGZp6NDUotXStq6sMOWgwCZCloI0ZqMXzw98kZcJPOFNbha1kUvIY
         lHbL0N9i60EF5qEAptLNIWcvgYGnJmQ5SMJK8DaKXqLO5t2VGrGBBCimNhWkCr9AEAZM
         BdxOkqG18feLZFxdclGszuWed74XaKVMye9a8hHsIsjoW2brfsP/mvrDWYHYZ/4/IPsq
         h/W5t/4GB5wdfGmDX4jsD3dgTWmHYUaSe3gns7+k10sXqwyrclcUp7ehChgNe2J/hBXB
         M7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVC25d6XwcjLms/CirvCY5qdVR/SxgqXg1RPq2zwCBdmxCaubrZ3iH0cxIFVzOyj33G0FdPlCfBZA3CJdTB@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw3wZC/tEHjIAKiF2Z6uANa0zWabO8hWDY14bh4b89Io9PCZf3Z
	lGmiXhQaSnCZ46bS7IXI+uUw3hBbh9AjaZgJkWpLIcqx0FZ4fvjw+MmiW2gmhP9GJVA=
X-Gm-Gg: ASbGncuBeT0TTcTL6RDiePrHqLspM32QXu0kKAEpACYgEAu/4y/bkt8FVnPpDlFXAcM
	n4ybnCURZjEnjTA6HbyfnaA8ShwRAs+DnbY8Io+/LuGXcVwMf33HACqrRnjQIBPuRzUelulPhXs
	qCkAmxqe4JA3UB9VCBSPCBVpSIwC3x0vczZqdp3SILb/f1tYcy66U8DaRiS4YwPJffgTaDwH1E5
	eqE4+NjUCvOmwJarAn8y4uHODSSharjnqrPD3YdftHcdvj30KthOkZTaImVPo6ZW3jfmfRRdKjR
	sV+Enj0WgA6bhWc6kPzqqu3hYqC6t1JFAxiotqHTkwPAjjMN082mii4jfFgpsttkpv21pa0ZQkc
	g5Z66txbB7UYudFu+T4X0pum4Z6848l7W52ZdnB9XXZ4ASPNBHOAq8drunNHCHYPK+vp/vDf5zO
	ssYwbgbj5O2Sw=
X-Google-Smtp-Source: AGHT+IE5rVAWokmT8UI4xI9jkViGw6Sdqw/TBm2EH0qOApsHQ+R+KXUxXcnloEdgSyK5TQrJQ+GyzA==
X-Received: by 2002:a05:600c:6208:b0:456:191b:9e8d with SMTP id 5b1f17b1804b1-45868c9cccfmr18285035e9.11.1753267533250;
        Wed, 23 Jul 2025 03:45:33 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8e54:5d9e:fc41:f168? ([2001:8b0:aba:5f3c:8e54:5d9e:fc41:f168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869182e99sm19607525e9.4.2025.07.23.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:45:31 -0700 (PDT)
Message-ID: <965923cb6979f8066b596810e5c5344d7739b8a6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] uihelper: Fix KeyError race condition
 in pidmap access
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Cc: Steve Sakoman <steve@sakoman.com>
Date: Wed, 23 Jul 2025 11:45:31 +0100
In-Reply-To: <20250702204758.2773339-1-ecordonnier@snap.com>
References: <20250702204758.2773339-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Jul 2025 10:45:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17805

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
>=20
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
> =C2=A0lib/bb/ui/uihelper.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
> index e6983bd55..0bc526ca1 100644
> --- a/lib/bb/ui/uihelper.py
> +++ b/lib/bb/ui/uihelper.py
> @@ -25,7 +25,7 @@ class BBUIHelper:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def removetid(pid, tid):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.running_pids.remove(tid)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
del self.running_tasks[tid]
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if se=
lf.pidmap[pid] =3D=3D tid:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if pi=
d in self.pidmap and self.pidmap[pid] =3D=3D tid:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 del self.pidmap[pid]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.needUpdate =3D True
> =C2=A0

FWIW I did discover a bug recently:

https://git.yoctoproject.org/poky/commit/?id=3Db7173ca2254421c45f01243a77be=
611fe4b9d1c5

which could potentially have caused the issue you saw.

Copying Steve as this fix could potentially be stable branch material.

Cheers,

Richard

