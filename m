Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FACCAC59F
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 22:24:36 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.36739.1758147870980310755
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 15:24:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fDhp7b62;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so2158055e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758147869; x=1758752669; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gpjs/IMqIQ/BODkNnCXwGefeKhFOMcALyYS5x/UAeB8=;
        b=fDhp7b62dh/3x/f71lCWaVAuQ7Z7N5PPRzwIaXXT+zrqZh4wIeq/IT448Pk851jGUB
         eFttouMPKVauvmz0S6dDuFyD1hk9PQltm5x8S7E1ZmD6RkReoQD9/bnPHZTk/6vceREW
         bYoEqUCwBmH8CK4ZJEHdsXiooqZ6kj1dUPZvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758147869; x=1758752669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gpjs/IMqIQ/BODkNnCXwGefeKhFOMcALyYS5x/UAeB8=;
        b=pzN3fYx1OfqIH+4VVIFKjnZFoy0d+koYFVzk31u62AA+DlzRC/SSMzMF7CY/BkdfYK
         yMt0DU9U6BXHauQH3CroAL2zFfVegI52aOlJEzYj88djvT2RH6CHby6XxR6CU5KkQyFZ
         S1P5QmG63JQau8PIdWO3ULcrGS9Bpw8KJKDO++WTd99CP1IQ8NVEX7AwaGut191okabR
         Sqx/equA1qOfRF0TKSxsjqDmgFW+YmEGLnLpNs+S5U3Wgs9gBcNztLw9MKFLs1pLIoBp
         oLRIKfrlxXOsirPpURCwkiC+g/LdcsK6c3i4Z2FGlhDY03/K2xFqy4QH498nnM6lUGkz
         TEpg==
X-Gm-Message-State: AOJu0YzOf7oNDimr02lg/L7Olki7vEn3W+9XJHJbVZ3JMtx/NIBas5Ma
	9hl/Q0JVnip4sKFpmg6+PgTMCKSlVw+jThzCjHyyN7SKC2jx+36rTBf7hCI8/rC0LX8=
X-Gm-Gg: ASbGncs7uh6XAMKM9hkjF5T/2Ktm1+PNi+W08yjVXbzfoNDxuhTak+L8b/V2pAMBnHH
	6xkfHde+lYEoAXb9uvcyMVdzpvDhwah/9/eHWQOg+60pol6Fh8olt4h3pFKGP6dxBUbeoye8tj5
	vqM2e9MFFe1wHgWZsBP43dpQP5yaGpSH3XObkaZVWRLc+mAslhrh+VL71YQhVf4LVJB3NAB8wfw
	zMFUZ/FLaUyaONonloHk9Ji1NbS715MpGoDyCVxkljHBlicBhj+KdQoZ9gFFxH9puJP5XqBM4YX
	3Q2D04OE//ceMhKzZstlQ+WmWMEto3Yc+W4O2F1Ri+AQXyxSWkgT0qKpAwy17aFT83S9f+bLRZS
	ffpHBUQhJh4gILgw8u8pQB2dpbI5a7zIyctlAuR7nSdPXiqU1iHuZAKkwMwc5B3OuSFZz84zF6q
	dEb5k7ImEY0JhILi/JwIvKTlBe/HpfRQ==
X-Google-Smtp-Source: AGHT+IGJhWUySzYAs6uXfBQTeq15P94/xHg4EMEKUG3fzRu6PVG1/kcAf4GCfE5Qxbj7Tp9OTRzqNw==
X-Received: by 2002:a05:600c:444c:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-46207897e75mr35649485e9.36.1758147869304;
        Wed, 17 Sep 2025 15:24:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a42a:bde0:2db0:730d? ([2001:8b0:aba:5f3c:a42a:bde0:2db0:730d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613186e5c7sm60941865e9.0.2025.09.17.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:24:28 -0700 (PDT)
Message-ID: <1bb21a2901691c6744b0325f23c866944ab67c53.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: martin.jansa@gmail.com, steve@sakoman.com
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Sep 2025 23:24:27 +0100
In-Reply-To: <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
References: <cover.1757519577.git.steve@sakoman.com>
	 <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
	 <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 22:24:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18057

On Wed, 2025-09-17 at 09:27 +0200, Martin Jansa via lists.openembedded.org =
wrote:
> Hello Steve,
>=20
> I've noticed today that 1.12.3 tag was pushed for current 1.12
> branch:
>=20
> commit 710f98844ae30416bdf6a01b655df398b49574ec (tag: yocto-5.2.3,
> tag: 2025-04.3-walnascar, tag: 2.12.3, origin/2.12, oe/2.12,
> github/2.12, github.oe/2.12, 2.12)
> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> Date:=C2=A0=C2=A0 Tue Jul 29 16:42:25 2025 -0400
>=20
> =C2=A0=C2=A0=C2=A0 utils: Optimise signal/sigmask performance
>=20
> Should I redo this as 2.12.4 and adjust the related change for oe-
> core
> to bump the minimal version to 2.12.4 as well?
>=20
> Similarly for scarthgap and 2.8 bitbake, which has 2.8.12 tag
> already,
> so instead of 2.8.1 I would bump it to 2.8.13.

Sorry about the delay.

Your patches are right and the tags are messed up. They're getting
cleaned up and I've merged the patches in the meantime.

Cheers,

Richard

