Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9388C3ABB6
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 22:46:40 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.63292.1746485190245279095
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 May 2025 15:46:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G+oL7cQt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so4746970f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 May 2025 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746485188; x=1747089988; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iPr5q8mix1MDDyuA6tmHTlttjA0a8iA8gC8oLK7s11Q=;
        b=G+oL7cQt4l3U0TxMTOZO1cpWcvIZAptV+VkAXIhYLP93O8HVB8DZUdSeQPyf6Fo2PP
         cZE160gzQs2Dz+N2fkPdZd5x3UCzYKstlH9XSYIK57b+JiXEXgV4JDmGynyu8UghgDv8
         NvRFfNTODbmPttIRG9AIRusgWv8z/iEv2j8aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485188; x=1747089988;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPr5q8mix1MDDyuA6tmHTlttjA0a8iA8gC8oLK7s11Q=;
        b=oLDUhXounSDeWpuutdMQVCeKyhVfh/pw7lCaNP7INUzkjIQrW1LqAyrqFXlaoX6sIo
         44ko/1LxPpWE71U8kxqOERVJAOfxPDZP9C6iooL5QxAbiki65Cw/QYR8cRO5mjaMi3vf
         s5Nmci/feEMzkU/BHjtVbFsCKUPngGsAba5ZQ83Jnhe1LkUa+7rLRSBFEzd6cE6QXI7G
         QzjcIuwh73SqqtONMrx6Dv5R6nEFjWLX0C6QrROjtCafIinI9oxFcjJYb+J2i/k1g7CG
         cuyxQfsD9aRW2v6SkzRrGYs/4ZUFNXCNqoZrSfEZGa+JMQqxqGKkILecDlbhKe3nnN1e
         4OFA==
X-Forwarded-Encrypted: i=1; AJvYcCXiRf/nKZ3jLX9bIALUz/Z/60rmyaRPH+Jl03DIXDKFVmL33rzjbEyDmO4lzUXAW/E8iYynB1nsXTusYpub@lists.openembedded.org
X-Gm-Message-State: AOJu0YwCrLxJZLaMSfgrvBe1+YvYe1GHHv3FPckDTJx17x8+wTQhw4yk
	v3MpNOcCdlir2Gps2dOfA8DJvmEr3Izg3ob8VEnalaUj5jTPhCctVvoHC0mTplw=
X-Gm-Gg: ASbGncvlHQm3sxWXc8Cxs6TSxo6xbF9NKtKeh3MzmaO/GtXjYCcmAnVwKSxl4NL37iM
	xdd0vCJ94KlA1LQajn0my/mxWMla7+lw7Qli1X6HUJ2XVrPKQaB2ef7Pt9bgm1okyOfIfy1g19a
	n8ppSraUDDP+65BQ8r9jLB4eKFhE8ogdeQAIWIuVP4Cvy5SBb7QbB1ClmwI90lKcr4gyPu2+FZL
	EzoJO7R0rOrZBoFQTf3Yd7oQZTegUsuugD3scmxaq03C0tN8j4dcLKoGoBVqmZcajtl00vHOyyq
	nBnqLvsAYaQ7SyHqJhY9A4B1cI2P6CpND9pBo6w4R30OsMmRPbDNiN/hdBzK+yNj5sEvq+P8oQT
	Zdo+dFOQ36Symn0VvrzRAZ+vWnjQPmA==
X-Google-Smtp-Source: AGHT+IGp7DCY7JP4nShNSy7w6ckJk6bEJJdHZdorBb+owEdJYhSgVlXdeCuT2k4+8mdEowFhHJEP0Q==
X-Received: by 2002:a5d:598c:0:b0:3a0:9f24:7749 with SMTP id ffacd0b85a97d-3a0ac1ffa5bmr586092f8f.36.1746485188620;
        Mon, 05 May 2025 15:46:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2c56:fbf7:44dc:ae77? ([2001:8b0:aba:5f3c:2c56:fbf7:44dc:ae77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ff8esm11703938f8f.79.2025.05.05.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:46:27 -0700 (PDT)
Message-ID: <292ee69d270d71860a7ebada65e4f6aeeca01d13.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: Add support for
 remapping URL's
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: setairidis@gmail.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Savvas Etairidis <falital@hotmail.com>
Date: Mon, 05 May 2025 23:46:26 +0100
In-Reply-To: <20250505185755.1952-1-falital@hotmail.com>
References: <20250505185755.1952-1-falital@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 May 2025 22:46:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17594

On Mon, 2025-05-05 at 20:57 +0200, Savvas Etairidis via lists.openembedded.=
org wrote:
> From: Savvas Etairidis <setairidis@gmail.com>
>=20
> This commit adds support for remapping URL's in the fetcher.
> This is useful for cases where the same server is access with
> different protocols or different URL's. The remapping is done by
> adding a remap entry to the global configuration or the recipe file.
>=20
> Fixed #10699

I'm curious why you didn't use the PREMIRRORS and MIRRORS support that alre=
ady exists?

Cheers,

Richard

