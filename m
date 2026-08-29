Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D8C61DCB
	for <webhook@archiver.kernel.org>; Sat, 29 Aug 2026 09:58:14 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4657.1787997484828721269
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 29 Aug 2026 02:58:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Zflt9KvQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso896669f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 29 Aug 2026 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787997483; x=1788602283; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FoyJSgMWMSu5vJW8FxPk9dMVPJFcnqewuZyBdvA1DIY=;
        b=Zflt9KvQ20U3sH7GO1X4qlg5UmvqZKxfrVJi6Qh0wUOQVDBRaQybjCIkHgKP4yhosv
         1PdneL04JFYUUvNTFvFmjWNqIe0defEW0t7uBMNsmHwrWc20j5DOCDY+zc5FGhveTcG0
         4jpUKWWqQDfJxkHnUzEx2AaOD1IPJMHYfGulE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997483; x=1788602283;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoyJSgMWMSu5vJW8FxPk9dMVPJFcnqewuZyBdvA1DIY=;
        b=DTxepdSeAGwRDSeBrAd+xk/Ve9XohrZcgoARiRhMohddnfl2MdRbhaleMQufB7XbBG
         Umuu46fe8iqDiCMbRQbhReAl4OOOxEeB5hXOqZ+h+3XlwVSZvNvUbUAOFN0mF0hTq9aH
         pKn0mxsqAH5ru32VI1Izu3I+7RO7+hcbEqqiirmYiLvZmEy+D8+nq6xp92lwSDeeRbzp
         bo+MvhdVcw+YjQp4uw0ORPe/eHEU6t7nH10SHZFV4VrfGyE8G1A4ikxCbENpY91nLCbN
         3dAoGxw2clfYzpMD84d18mP/0Cb1iew4Adtk9kIcUWYArwNLd9KKqRzNW/J5D7zVnecp
         y7DA==
X-Forwarded-Encrypted: i=1; AKwUvBzNRwo2XMbb/6KAc1/Us5EVJrR2TEdjrNLpf+ayFvkfpT2J5DH3gtHyR9pkDU5Po+sS6U73Xwr9ehrpCu82@lists.openembedded.org
X-Gm-Message-State: AFuF++l3TLLbbF96haTAv/g2TKDiZIPBu0IbEUYL7qVwYeOjS1VdjlVC
	2+mHKBxoUGOQgU+rjCR48EFc2Ns7r1EkjLQZIVr2rfOeEyX6dx2WnO1GBhF2DgFcXNM=
X-Gm-Gg: AYBFou1NxcbCyLvB2SyD/9HUgs4ICYO1wwPdEtguQnoxEZaNEzyIFjlW8UmVUwAO+ho
	hDlgf4O101moWTJo+EZ9acq+2knpUUDP/jPs6YoE4hXd5186JI/TqzF/5jA9uzMeP/bdUkp3up3
	8TRTVdOTa817aS5XngYD16h1RjOdTXRm5kFN/sfRE7EdXTGlx40AQQVdKcaMFsLbF3Uje2VOb7e
	yXqXc+A75BajcX98aMUbHPeMaXZZJiV9xJNu7nHwHnAhi3ujP39J8dC1UaRycaFpK73yW21qbtl
	+4WFSTDYIgXnpdZKI4n8w24fjr3FfcmQ2kZOxRq+x3HtvIqG/SV0wqL+fFN0YC0WJ8SaQQKfQi/
	ih7rlXAGboJRk1zLHikZnRThgyHwP6UIlJueG/lM45pPrEXkcK+jeWr9942qJ5yG+phxgv6rweU
	5Kg8bN4ENb9KZoLB8mMh8i5BW2DTE1HQb0dbAtVyyRaVDB0/Mk0MQKHQP+7vM5A2RdVZL4hEAKk
	emKHcqXfMZfUzqP2wWNtH+3R9KW81oRzi9ySGNgGxlnKzYToQ4v
X-Received: by 2002:a05:6000:41d1:b0:482:f4f8:7a00 with SMTP id ffacd0b85a97d-482f79cf9fbmr22288874f8f.16.1787997482908;
        Sat, 29 Aug 2026 02:58:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8d9f:3b8:a15a:494f? ([2001:8b0:aba:5f3c:8d9f:3b8:a15a:494f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb278f7sm11591359f8f.26.2026.08.29.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:58:02 -0700 (PDT)
Message-ID: <81f397e0bfb6373b29d8a6205ae926946f8c12e0.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert
 compat shim to make bb.fetch2 = bb.fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: docs@lists.yoctoproject.org
Date: Sat, 29 Aug 2026 10:58:01 +0100
In-Reply-To: <20260828162612.753815-1-chris.laplante@agilent.com>
References: <20260828162612.753815-1-chris.laplante@agilent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Aug 2026 09:58:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20125

On Fri, 2026-08-28 at 12:26 -0400, Chris Laplante via lists.yoctoproject.or=
g wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> bb.fetch2 replaced bb.fetch back in 2012, and the compatibility shim of
> bb.fetch =3D bb.fetch2 has been in place ever since. There's no longer a
> good reason to keep the '2' suffix, so lets drop it.
>=20
> We also invert the bb.fetch =3D bb.fetch2 compatibility shim to now make
> bb.fetch2 =3D bb.fetch. We do this by creating a new lib/bb/fetch2.py.
>=20
> Layers are accustomed to accessing bb.fetch2 without first importing
> bb.fetch2, so we declare a module __getattr__
> (https://peps.python.org/pep-0562/) to keep this working.
>=20
> Finally, we add a deprecation warning for good measure.
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>

I confirmed this is still resulting in failures in oe-selftest, e.g.:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4744

I've not dug into why...

Cheers,

Richard

