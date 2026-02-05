Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5DDECD986
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 15:29:11 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23439.1770305343951438279
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 07:29:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UY3+pPNm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.222.178, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c6a7638f42so140734585a.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770305343; x=1770910143; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2kQwPKf2tgLyWFcsMKroC3BrsfHfoOav7SqlEdqPho=;
        b=UY3+pPNmyvTU7UPpPPMKjTlYmBg2IuObhbd80ja9OzVsJSr5F+sm8LZl2FeqDqS0Ej
         hFmjWcV1Vb1V/WUjslzc7IJggSU7otuY4sq7CnVNXa9+vlcflHe5YHXRUQhlNargtx68
         DDKO7kQmQzpm3Pwgl7IXxhbfqDRdh1Ov0ADp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770305343; x=1770910143;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2kQwPKf2tgLyWFcsMKroC3BrsfHfoOav7SqlEdqPho=;
        b=tTuwQXLvyS1uD568nVjbJdSsGerfHPMEiodoM9UCfitdViU1e+u8ot/pTEPLCuqd1i
         Ik21NEkMtErykkAdjzcDwZHwBEEXzT7a4QtYoLBRhA8GbcURdUFZz2r8OotoJnk4Nvhp
         a68SBWJ1NyrxmSX/UUjWBJewr/7rLu/mdW+lStF4rOoBeLfwJZcAzkq7BbIur+oYHQCL
         hj/FiOFSTqMDzjaRzT5nv3XQpb+qwIu7YUjimJUTnk3CJxxC0st+BRzIoYmZLvwk7fAe
         4b09jTnvABj8NUOuWwbBVteF+u3nOPmG8rl63TkDORrgGgm+ZK0VE90pyh7zFCDlp3HI
         40nw==
X-Forwarded-Encrypted: i=1; AJvYcCX/D5GVEuYzpEl9JQWd8alohHMyFwYMbqiETaX7R94cZkMKneQVV8alBxOoReqI8GWG7rgPvKzZVavdNUrq@lists.openembedded.org
X-Gm-Message-State: AOJu0YxfTbcRoaChzuLKhXdGxdHUXPp/n/VQV1iCpRV5R0twhxk1a8eY
	eCtXzT08XdZ69dnnRGJDDax8sdKN+jiSc4gWt35QklTKv2iMrySJDgJ2q3L6FbwVRzg=
X-Gm-Gg: AZuq6aKLGy17iuJm1pBlz683VNnBHEQWKXBaiNm7FHdIcCJxDwaqPSLVvmNdNWXX5VX
	zW5rlWJ21ML4rP7CyYOIl8NyCsVAwuu312c570DvTvcmnkeJImJCOVr0BeyPvlYfAcxeMQZyJFU
	y0cAEAVJB6j+OUV03jyHAYc3pg7c7XzR4RGS8gkbcyh4GEnEOHBieROEJJk+Q7m8ZeySC2sFHep
	BU3rrA/xGoG3mNvLCatgZl3CsZsDR3XBeUzc7Z/JhMBuStVXgKiRw1WTqnysOLoi+sN8Vb9y2as
	q4/o2D5b6DCNFfVoyXcRS8bmnIrwFlxn+cBo6Zwb+mDaJ8gTGfMucQJY0dapjzLIw4vZ3616x9n
	tNQJEySOkCwXbcVSy7UeCgszyjrXukqdomJXGad2OGf1E48rK+seLLUtHALzsXUZuBFfxN/GJXe
	NM7TbB0IFzf4IjWupIDXawtF6zRyQIU4sEzAnTXw6m4b9ujklCxnDitTANZelXr0EOk4zFQeoaN
	PI=
X-Received: by 2002:a05:620a:4693:b0:8c9:f4eb:ac71 with SMTP id af79cd13be357-8ca2f80cf38mr949286085a.10.1770305342835;
        Thu, 05 Feb 2026 07:29:02 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:118c:e754:4fe2:20ec? ([2001:8b0:aba:5f3c:118c:e754:4fe2:20ec])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d25b87sm42932676d6.45.2026.02.05.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:29:02 -0800 (PST)
Message-ID: <3fd43d892d87fee01b906801cec60b05bb203feb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bin: Hide os.fork() deprecation warning
 at module level
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mathieu.dubois-briand@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chen Qi
	 <Qi.Chen@windriver.com>
Date: Thu, 05 Feb 2026 15:29:00 +0000
In-Reply-To: <20260205-mathieu-fork-warning-filter-v1-1-e4bef89403c1@bootlin.com>
References: 
	<20260205-mathieu-fork-warning-filter-v1-1-e4bef89403c1@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 15:29:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18972

On Thu, 2026-02-05 at 15:13 +0100, Mathieu Dubois-Briand via lists.openembe=
dded.org wrote:
> Add the message filtering directly in the python module where the error
> happens, so we do not need to repeat the filter in all consumers. This
> will also make sure the filter is applied in any user of createDaemon().
>=20
> Fixes [YOCTO #16080]
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Suggested-by: Chen Qi <Qi.Chen@windriver.com>
> ---
> =C2=A0bin/bitbake=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0bin/bitbake-layers=C2=A0 | 1 -
> =C2=A0bin/bitbake-server=C2=A0 | 1 -
> =C2=A0bin/bitbake-worker=C2=A0 | 1 -

Nearly! :)

You need to leave bitbake-worker alone as it has a different use of
os.fork().

Cheers,

Richard

