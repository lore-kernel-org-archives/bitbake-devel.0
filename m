Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0491CC3ABB2
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 13:22:38 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.15522.1748438549753953549
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 May 2025 06:22:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L56G4qEU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso51573405e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 May 2025 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748438548; x=1749043348; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dW7buL2g4ZNiE1k7B9EKcvYyjJgx8/D5hI1vSixDwkw=;
        b=L56G4qEUXmuU7AV8fCiLy0lsdHMBSAUvZj2cEAAwxHQsAfXXTh4aPYrweSh0KHhYAZ
         xubxh6hMHc0PjDZh7Hd6Z+XApvPPASaJPJv3+egNPLoD0b1g1ZtL82ix8qPwnBOP0+hb
         pJjr8ELFip7XrfizOTdeiq6SSKrJw7JqtRHTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438548; x=1749043348;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dW7buL2g4ZNiE1k7B9EKcvYyjJgx8/D5hI1vSixDwkw=;
        b=K373m+nuMhf8qA+WB1kWXE2YBI3gSHKOGHF+S/zyyJm2S30lyGs/qyNE4IaccpaGLh
         MMje1eTtn32IjVtTikZsnmQDNXPKuKu+qNgUEdeMVNrpJ4F443525o+6GTf9gzBt27FU
         ct1FjrkBC2mVkY5DKiCf0ZA/rFhWyjXeyR1iaBjE4azgiCQ190b6JGuPx5I9TYbAsQTu
         ALQUHbdDbb3OP9mhM7TDB6Q8dvPCDE5RXK192/27fPa4UFs7Ppk4vz3Zr1GUciFe/QLm
         6lfckMbWddz2Lb/YwGT+vPVdzgjAMPVL47dIRqRRdFUThcUETXpPDzyzS9eFnC3sAJ7H
         o0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWs+K86tlI9tYmDglC/6/BvVUzR3WpQsjq8SvVISH5Y1X8aH/9cPhRLKonBeob1LsHawqlz1Yt9L2Uk9WhX@lists.openembedded.org
X-Gm-Message-State: AOJu0YzipVPn8TYgcL1hJFbPiA/ulasP2Yw+ysokML4cXCtKl9XAHOfv
	6ERzr8X100ftRkD/BBTI0YA7sRxpFSg5marFCMaMcsDTvNpOmBiyj65EoavCWeKZmnU=
X-Gm-Gg: ASbGnctfiVRzeTKAJpNBU0CKHqgdgeGXLXIK6fHZkRERBbIvSvaJuyb5EQ7sH+W2GY5
	+omdODNDEoJLVMY+iD5i+ALFzZb/fPNbzvoXv/VJKf47x4v7M86+4KExGgY8NEQ1uMJxw9fqkpn
	zXGUXnvPmQsYSNlWqZVU6ANU8fYbgayfErVEKDRJrZrmyZRimCWnmaHB0C6BuWdUxyJ+m/tC7ag
	Yu/ZHfi368LH3ZKEUvHYVeSiJj7LjzqoQ03Op+eSI26f55pQcNfyl/UEDm1qG4AGGeTgLVe2Eh5
	f27AFpHKkkmpjc1Zy4MaUzpOPUoIjo0zL75JwjUWidlwwA4zb/vqKU3N/Hm4ssj3UYp0tjGaTfb
	sVV9B3+wEr9Cu/Yr73N+MAYVHWd4fHcGFEXbyF2nS
X-Google-Smtp-Source: AGHT+IFVlpLbuQOO6awmDbjnEcMW5kmtWdG5AV1jE5ibsxm+vQkWcEay1RYLeYPJIQFFMLMmYdp+Jw==
X-Received: by 2002:a05:600c:4fc5:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-44c9465bfe3mr187880025e9.15.1748438548147;
        Wed, 28 May 2025 06:22:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ebb4:3a70:7323:f416? ([2001:8b0:aba:5f3c:ebb4:3a70:7323:f416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064ae786sm21527505e9.23.2025.05.28.06.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 06:22:27 -0700 (PDT)
Message-ID: <3cdc7c12efbedfda3a705d34d87ce78462010268.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH v3 3/3] tests/fetch: Add test case to check
 shallow cloning using `PREMIRRORS`
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan-koch@siemens.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, liezhi.yang@windriver.com, 
	niqingliang2003@gmail.com, alex.kanavin@gmail.com,
 quentin.schulz@cherry.de, 	jan.kiszka@siemens.com
Date: Wed, 28 May 2025 14:22:26 +0100
In-Reply-To: <20250527095903.2300556-3-stefan-koch@siemens.com>
References: <20250527095903.2300556-1-stefan-koch@siemens.com>
	 <20250527095903.2300556-3-stefan-koch@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 May 2025 13:22:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17652

On Tue, 2025-05-27 at 11:59 +0200, Koch, Stefan via lists.yoctoproject.org =
wrote:
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
> =C2=A0lib/bb/tests/fetch.py | 27 +++++++++++++++++++++++++++
> =C2=A01 file changed, 27 insertions(+)

I've merged this series, I just wanted to say thanks for getting to the
bottom of it, getting to a good fix and ensuring the issue doesn't come
back (hopefully!).

Cheers,

Richard

