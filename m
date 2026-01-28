Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3243D46BEE
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 18:30:13 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1769.1769625011989801929
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 10:30:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Otxwi6DD;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6a822068eso23431785a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 10:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769625011; cv=none;
        d=google.com; s=arc-20240605;
        b=dSx3ZiOnGIuHnQgt9X8yEgIB7R8B3IlzUa97phaKYx9lTlY2Xrj57f2eozOW1ix1Ra
         arCHUr15mwPHMyflgVXqCqSsuW2K3D3MXIdNrv4/N1zK/d7DY63WxBiOgcG6UWKfNGQK
         tW6YYadbinqwAz8OW+A3B+F9Np55bGu2S2rfZouj/0JsWjn01E4HDJhgqA2tlRTeP5mq
         nQZabM6McNz5U7RgBgS8vXGIVEqW2iTz7JrlR3E56fmsA00c9rVlz970CSTLC2H1HDoI
         Vn8o7emaYN8UjAE0Fqc8SozqQffmflTs/wWpy1VQCirNc8fBCEBjfWvcHZ+rKK3YJ9y6
         YJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a/UnkRQT2WY75MIekpPYJtWrtNyOh5axGjCJfqe0i1M=;
        fh=jlfXIGFqiJJmji0XOVSr5x4A2G0iBGLYFcLfj1AUCow=;
        b=W3GQvLDtHBTdDGPKKjajILYMxPTkZpamRhymt+dGBA5Y594Ff9fDUtjleyjOrX2H+w
         ImGeaYC1lGeOTlGKDfh5v4ngtSVcJUPiAFUXsZZXns94awxl34tIR3LLnEJRbi04uTuV
         CPh7H2w9/0c7RENhLVh4KngQxXEZLusMDF7ppSGsl2sZmBdDIWiAPDSn176+DvkHPzCB
         TPZ8maejRvKvuw/RDazwTKATwho+7BppIlWcf8uQCiOq5Y3p5IHSgIw8IWn+a5xy6lu/
         nxGAlllaoLZzOPydcLP77CLFSY1vkgEgaco1O83PChbVn9iArghaL7KyvEvSowoUkxhd
         ZfOg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769625011; x=1770229811; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/UnkRQT2WY75MIekpPYJtWrtNyOh5axGjCJfqe0i1M=;
        b=Otxwi6DD2GMCUJR1Z187XG0tXN9YKSxUTgdrWh7yz4zjAZxWOXh6D1mOvH3oKx1/W5
         J+fBp3nklDfwugHUJ2hPSNMIr85T2HZI9qzcLVXXcHRtLltPKFp/d0vmmxm2chrFa4UD
         iIPalvsBWHj+WsFgRpWpULAbEdv1A08DlLjImaXr1gL3F3xwCsOtiCv9YYLK/ne0hCAk
         AxxXEtqmR8Kg8eYx2lW2NuZBgXObyrdhsbInHMEm7tskWU5Bzn5QCwsI5zPJMaBcwB8t
         oUc5Zjld+M2CGjaBe9UzXDbeJx0TinsChA+OdgpcZWU3Z6RaVcLIkhEQIOoeQMUZsZVc
         mskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625011; x=1770229811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/UnkRQT2WY75MIekpPYJtWrtNyOh5axGjCJfqe0i1M=;
        b=ks9NFqA2rQHwKp2LcA48Ps2Ot6MjqC16KaRSvnbs844UVngPVE/jkpEvESqag/4e8u
         I1hs5nP1txX1OxtND8O+VKmoXWS5I4Iqp5/j+LFUVE8Q1DcYC97VYgfyscTSsYoBW6/o
         GHxRcvYMHPpQ+9IqcHq3340PjRJkWJ9v2CrWTJ2apLJg/wgHyxqlLVIZi2cKubU8JRnB
         SN4GWL8oExBo6eZZXTxOOhKqX8ghLUVnu9pkloG79yLEykHx0+5RCMuEJARl1vBbZWrp
         aDR1mtSvcSC38NUBE6cRxWLhZKqZ7/M6t+IgRygskmUHXeS9+zzMvzIH+4MF2F87oZSg
         tE9Q==
X-Gm-Message-State: AOJu0YxRxxjTyVrrmoA8Efu13C/eVxWMY7b+j4rwnbriJP4wO7eKe4e9
	7LS+91XAdDzJz0qgkZDYGW9jPqgHpjFC7MXWawU/Yscv3uD0/HIQwnGv1Bx7BEaIww0YaXPLrBq
	0v3Han0c3lylCOyYgWxreV8TTm2HAp6M=
X-Gm-Gg: AZuq6aKUAOleypKWSzDnYWZ57GaCuxknelbs/HKQHJktz1cL5jLkFsbA1ZiyPv1mb2v
	dbi4n/VSIzGlC5yshymvkC1nJOoDfrS+XD0pVb9EOPCj9U98Izd/kjRgLsTRf7pH9nD4rHP/V/M
	xGGToFct3/9qMeCG32bKU229gEyU274Z5rYYLDatyh0O2tqXDLGbHy6jM2TnSME+zH6hFP+2Z62
	3qcy60vRnX1jh1dRv6gvM9BZ9NBRHoyg494RJK26a3CELst/KbDYih9rSTSsNckuCozn2tVBmS4
	49nJ5jbLeKDxj5uRJOm5dNkkl76QOI6jrVIOmeX/
X-Received: by 2002:a05:620a:d85:b0:8b2:e284:1bd6 with SMTP id
 af79cd13be357-8c70b91f12bmr757082685a.76.1769625010896; Wed, 28 Jan 2026
 10:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20260128143336.1963432-1-anibal@limonsoftware.com>
 <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com> <CAOU5ZMtxf68nirg+9znM=LskB=YCzGMz=To9TkGLs0ERRpjz+Q@mail.gmail.com>
In-Reply-To: <CAOU5ZMtxf68nirg+9znM=LskB=YCzGMz=To9TkGLs0ERRpjz+Q@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 19:29:59 +0100
X-Gm-Features: AZwV_QhMLst4RKzgDi-Y8fjD_gqZfn_RHKfIHuM807ZRnUjNla-TCrcGZYIFgbw
Message-ID: <CANNYZj87ReKiR_hVyxdLJm1P=ZBOKUbR68nu3z+TPRgbd_J_jg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: _has_local_modifications
 fix layer add on existing project
To: Anibal Limon <anibal@limonsoftware.com>
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de, 
	jonas@limonsoftware.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 18:30:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18922

On Wed, 28 Jan 2026 at 19:26, Anibal Limon <anibal@limonsoftware.com> wrote:

> Yes, so returning True and may be a different message to the user?.

Yes, perhaps it could issue a special warning if this is detected.

Alex

