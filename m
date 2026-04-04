Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8ECE63FFB
	for <webhook@archiver.kernel.org>; Sat,  4 Apr 2026 20:58:19 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24347.1775336296309905280
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Apr 2026 13:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W5UIkqVK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so13536365e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 04 Apr 2026 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775336294; x=1775941094; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nAuGgcGHt+yQxgloBpEStYyUQyOCGQPQ0bFmPPZ5XI=;
        b=W5UIkqVKp4Ss74XXgLGVucuFnieZCA/OugA2WISNXJgtvDUcIyldlxgsRz/iwy6VMq
         chAlONL3rS8oJaNVW+YAtS80D9VHvhKK8OFTLIoL/A20LpnzpqnaXA/mxoAfRBmeHWJF
         AgWuUWVLL56AOrv/fUzwANouWRM9DmdNQG/OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336294; x=1775941094;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nAuGgcGHt+yQxgloBpEStYyUQyOCGQPQ0bFmPPZ5XI=;
        b=k5a+VOC55Ym48cte3lxSNJmDhE2VrLC1qZUEBAmsz9pqCVV7qSiXsPA64EVK1OlMkc
         viEGU+xgr8lsZd/NGRGX0MkROF5knOqdYnXkAu9YcDct0voWkA3hvokgO96q3E+RYL5t
         KYz7Un2rkD3fIvB5v1AiBf3GjTg/Tu4gOTo7gg3OxRY3tGAAR2wUVEie251ly1UpJJ3H
         aQRZfjnDzri+N+XGboV0Kdxckpc6EH/xzFflljzutMldMX48ylHA89cql9p0oJXqJ7Qn
         sqCo0wBjGTcvJHarD6hLIuYIo6rME6SKBe3cf8bcM8rYwb4ecmRE4IyNe3RsA3bFiylJ
         bRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcmc4n5JGGO4LOM7mamWLmzEAxJx20/AzGJgcEKISngppttILs77iwLSKsuShrOJyMDkylF+dHjq2gurbk@lists.openembedded.org
X-Gm-Message-State: AOJu0YznRkGk1r/++6MyJnIGAA3Oyh9TlXQ19M34Vdtcxd8KwNoMHz5D
	+lRWk3PZGan6BBszWaes4nxz8hjv38UDrl9xxaeFKifP1EAeYuJWO/lGmRNft2Qbz4Q=
X-Gm-Gg: AeBDieuHgDc6RZFULLjDRK1R2CwQA388kPGJ6yLeoMo8On42ko2fX0cL13yCRQAnsHq
	Lyo6CHzLVhah4oWB0wsuvMUEW1s5gI9MwaEfavtpTrZAWeWNGv2BMhTDETqoIyYnUoweS4+/7Qb
	js/C3mT8YTMuwk0wMyar6C6StgPK7FWJInUu3m3ekLz0w+7kxsbMqan6hKRJzmWT0F/rHAT1fWv
	lxagjgDgAMueeI6YRrxPZ85AgqewISmIulpSVqWZ+3Pg2SvKV/2h9li1vbxmU1L8lgPnkvLBlxJ
	qn4Sdo+wlcYPV45Ejb6fIN84CtEzsU5Ub6PTCEtEi6xQS/UARkga/jns5LA4GxKvqmX/waRrtLN
	Wv4fkafdhXoABsjnc8UVmn3NaAyEFUjWwNk4tyCrPlr+N1+NT4bT6VCC8I499oq4O6rEb0AvEWR
	3MusCYv/ze+Vzt5bPk8iESqZlmSml6IartdJNJbIp4AFdHWYE0UoBpLlJ+oV5oRXcEy0RjGzPIe
	BjRdEK3vIEvLVwi
X-Received: by 2002:a05:600c:3549:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488997d1f50mr105048325e9.21.1775336294378;
        Sat, 04 Apr 2026 13:58:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3181:d9a0:79d5:affd? ([2001:8b0:aba:5f3c:3181:d9a0:79d5:affd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a8ddfde7sm84857255e9.5.2026.04.04.13.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 13:58:13 -0700 (PDT)
Message-ID: <112696b9cf819c10a162830a2e7759cf188ba216.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Resolve symlink duplicates in
 layer paths
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: zizuzacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Sat, 04 Apr 2026 21:58:13 +0100
In-Reply-To: <20260403153327.64044-1-zizuzacker@gmail.com>
References: <20260403153327.64044-1-zizuzacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Apr 2026 20:58:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19321

On Fri, 2026-04-03 at 22:33 +0700, Zk47T via lists.openembedded.org wrote:
> When BBLAYERS contains two paths pointing to the same directory via
> symlinks, bitbake incorrectly reports duplicated BBFILE_COLLECTIONS.
> Use os.path.realpath() to resolve symlinks before comparing layer
> paths, and emit a warning instead of a fatal error.
> Fixes [YOCTO #15591]
>=20
> Signed-off-by: Zk47T <zizuzacker@gmail.com>
> ---
> =C2=A0bitbake/lib/bb/cookerdata.py=C2=A0=C2=A0 | 14 ++++++++++++++
> =C2=A0bitbake/lib/bb/utils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 +++
> =C2=A0bitbake/lib/bblayers/action.py |=C2=A0 2 +-
> =C2=A03 files changed, 18 insertions(+), 1 deletion(-)

Why would you want to add the same layer twice, even if they are via
different paths?

I don't really see why this should be a warning...

Cheers,

Richard

