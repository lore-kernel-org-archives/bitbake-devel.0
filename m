Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC28CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 09:49:19 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7864.1762508950976734951
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 01:49:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GPSOCxy+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so4194395e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762508949; x=1763113749; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EQCEBJyrKOmnrrC6KHB8zXMRVP20SjyUctfsIpF+5zY=;
        b=GPSOCxy+2Yred47Ytq2XZ0lwJsX51kykJoymH62QiAikifBG2zO29b81B07Fdbdiv2
         UvR8ZO8vXh8Kc6DoBrjfkDKLpuFXuI+XqkkGhQWfzb4qNwS0BRg/VzJIZLWIgP/YGoRa
         XoL57J+OgO0xRCgPtyU4ah6IojFMUKlMjjkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508949; x=1763113749;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQCEBJyrKOmnrrC6KHB8zXMRVP20SjyUctfsIpF+5zY=;
        b=E4WnsdYo/Ilfz6VDAedEYTbYXw/hO12kuD2bZUUV4y0SVeNQzD1c6Mxx5qsAEQPWDA
         VhrQaCSOc8lLSLtVHJMywfClfmG6YL9P47/TdxlnYQ/maqhEn10iCcL9G5PMJZwzBMnu
         cFV4O2UnlOzpoHi0LZxRR8SLhhhOWVTU3YAQxTJlPL+zQELY+KYv7OX8x5y/qYsLgRmJ
         IV6s3Vx81MeDmcPbyimrH8paOq8L37H47c56rcR9yjDUEY8rEaNAx4tqXHveFlVZx3ER
         qyI1M7/QNfurSSh0RD1PiXfUAiIFV0JBIVXBEdzIUVgcPrfs/fTCtDgMt9cZlG1iIqaP
         Bgeg==
X-Forwarded-Encrypted: i=1; AJvYcCV6NM6HaOD5nmaGeCAzvhu1vJ/SI+wNfd8t6MCBW0zkNW95AS7qZ+o+yRx6C8GkawBpqro09PzvWU8GLspx@lists.openembedded.org
X-Gm-Message-State: AOJu0YwXuc38zmsa2CRzSIRroHYml6McqLW4kkWBrk+4BzW9Pm+MMLA0
	Jw/CEwUs3PlBQJsie/yNTcw4NpD3e+uNCrkXq+7vrdw+yyQkxBZLpMMSE9Zl132pFVc=
X-Gm-Gg: ASbGncv951actH3LEPUloGzbnczIipDg1buQIAa01sSqRAF4LyTSqH4b/aY5fPHdpgt
	kFyLP94qxibsKAFgF5hWmagj/Bi4ZHv/9VfjDmimSkZGXtOBpMIOyeSK9bwL/Nm6xvOPmJEOvlf
	li+7n2NfwI/wZtcYjTQrvWI0osAKEA4fgqGsxcvUCqJnNZtH/1a8Ei1sYwJWH6diF4oR23V/hYH
	+NviYxLAhVQiIW2r1hbXWirdsJ0IeoK1WG7ovKOq6JzfhA7cS8NFrUQUjsjp3pJdrMFZxggKZt3
	1Zy/KlgsO4wHOxdQkasoyBYGWTKAl8yH9+MMNhL/DYLv+TnWFH73akGKs/VQi57K/ubjCMDKNbU
	5R+xvpBNFoi3lRXpBYycQtrV0GLTZBMSlzJEc31302APY5pwIG8xNYxDukXpQf7Avko9IJDDJk3
	TEpZcz1/eVtVlB5s4Ud7nAfROW2mrrbsmrhUI5CdeiqLhPiB0jj8cjJoLGLOmZ7QzO
X-Google-Smtp-Source: AGHT+IGwplVABPxzxe88vOIYAknudQQ4ORexFzX+w63t9lnoZ8ATE36ZAZaxMcpxExFGb3yTPhBwYA==
X-Received: by 2002:a05:600c:c8f:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-4776bcae602mr15337485e9.10.1762508949050;
        Fri, 07 Nov 2025 01:49:09 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm160739075e9.7.2025.11.07.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:49:08 -0800 (PST)
Message-ID: <13179deb9c814179d00e7bcd125c3999399c5819.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 07 Nov 2025 09:49:07 +0000
In-Reply-To: <20251107080026.2599821-2-alex.kanavin@gmail.com>
References: <20251107080026.2599821-1-alex.kanavin@gmail.com>
	 <20251107080026.2599821-2-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 09:49:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18300

On Fri, 2025-11-07 at 09:00 +0100, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> 'layers' is not a good directory name, as it contains bitbake, or reposit=
ories
> that can contain multiple layers or no layers at all (e.g. yocto-docs).
>=20
> While there's a chance, let's name it right: 'sources'. This aligns nicel=
y
> with both the 'sources' property in the json configs, and oe-core's unpac=
k dir
> which also 'sources'.

I'm afraid I strongly disagree with this change. Whilst "layers" isn't
ideal, to me "sources" is worse since it implies source code and the
general downloads. It is all too easy to think this is going to be a=20
downloads cache directory of some kind, or where S might get unpacked,
and so on.

From that standpoint "repositories" would be a more fitting description
but I think "layers" is reasonable.=20

> Then the setup directory contains:
>=20
> - build (bitbake's build directory)
> - config (bitbake-setup's configuration data under version control)
> - sources (everything that was fetched and unpacked)

so the linux kernel?

I say that tongue in cheek but it illustrates my point, new users will
not understand that.

Cheers,

Richard

