Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD0EC88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 05:53:36 +0000 (UTC)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16973.1789451606758182105
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 22:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sqdAd4G4;
 spf=pass (domain: gmail.com, ip: 74.125.227.140, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso2150371a91.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789451606; x=1790056406; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2bxAjqBqPrHQy/CqTlm3wztjzLcLXLOtFq6FHFjpB/0=;
        b=sqdAd4G4q/YLMHKg1ijqHnp/butwuo387EaMKrIj7nUHrxznYa+lDoBGYcRUdG44Gi
         wb1IKY0eDWt0bxht+R5Opb1GTWywvlY2X/4oWbs51+1brFLuTO3WL6hNxGplocDNzg6j
         JxnSdb+SpgZwpcb6V8fVDCtoW7vr3NARO8XzktflV8o4Peh59MNToUF1bB43vScta7sa
         LGQnOdfbMsURCBRSqQpLogj5Sj+CVaMDDhz7rBshLhWVkshVs9XuobS1t9yzYCsxPzTq
         guTfQPe0tDaeI47R08GbPWnI27d5fi6r+Q8tumkQPeT+KuVT2IoOMtnnXW58qKRRWmSb
         LaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789451606; x=1790056406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2bxAjqBqPrHQy/CqTlm3wztjzLcLXLOtFq6FHFjpB/0=;
        b=U/uulcDSh2iq0IcrsGJRC2UzpN4gMlGyc9Bw68khV/0MZ0MMsJwJ7mMsWx+2+O9p3z
         QrinDi9O4RFqpUkjwYHEeazJCIAF1aYG91iVF5BeQf1NirGyzxFXNck9HPIH+s4SFMHD
         TftCxRqPGY3MRon4VMYcJIQa77Hr2ydlsckgFmu7zE/cnmOcbTtFZQJrUZjYTl6h/jww
         wzKlm6OAszp/IeS2U1BTVE5brjqXwzRibGVF4OasSAp1grefrJ6Hg0++M7HoOa9YNATm
         lMJvwwc5+Z1QhrzBtUahdh+O0tLlEDSKq4OSb/Egz4H6FO5ZPnVQscoEXIdQsiRyCpfs
         aIVA==
X-Gm-Message-State: AFuF++m3zSheWdvlGi0DoJSZYFK7qpdDX6px1QDHwqLjLWb0jnCGmDoM
	7IFdkyOfzgnZImSDiEWvVPlJ4B59JQ6dtd3jKBlLpBLNo4emPUpEdw/zq81qyrtDuwg=
X-Gm-Gg: AYBFou3SpETEXntXO8YxiM/r0OPizhk1dLSbM8ZDY3cwSG56dAH+hMIw5zcqbV9VTA/
	l+vK0kjqRm4ZDgHgV8DZwsVTVprDz0D0jyLsIp4/cbjnMv534NVkYQgAF4ezCOdnbLC6V7IQnUX
	PKwh6Wtxl2NvSnR34TKRZ4poqLt3ACuh3Eqla8ar5zIsrl7QZQr3AbkqV5Gcwg0FhJQgdX9OBLb
	FU/fbYAYLdJFA9YNcug0d13e0wmd5s25LTRbHiux1TCdtOPhQaM7cN/QgUm6ou+egbyGpkRNFpb
	3TUyPSWn1REKm76esQg5kEQ4uzrh0/u8SJXwHO/FIVsdYdNU2VEkdoijoIivKSyM+xd/d8yrpXr
	vueiPVYJdlh2m3YDGHLN/TAM/8LzqLe8M4S87dUUPqqX52bEcdhcmUrCHxQD50Zey0Eyv6POxPW
	27w+ZlFmyftMqPtdDJ7JwDvsDO8s3UOsQUgGcJaJu0fskZRa0y8URM72WlPIk6M+NITqysUB0=
X-Received: by 2002:a17:90b:2250:b0:39d:f5b6:ca41 with SMTP id 98e67ed59e1d1-39df5b6e8bamr8267067a91.24.1789451606034;
        Mon, 14 Sep 2026 22:53:26 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda8bdf4sm3055210a91.12.2026.09.14.22.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:53:25 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] prserv: add --status to list running servers
Date: Tue, 15 Sep 2026 05:53:24 +0000
Message-ID: <20260915055325.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c842e0a047d06841610d0087df00b76b94cc1114.camel@linuxfoundation.org>
References: <c842e0a047d06841610d0087df00b76b94cc1114.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 05:53:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20212

On Mon, 2026-09-07 at 20:58 +0100, Richard Purdie wrote:
> Unfortunately this patch does seem to be causing failures in our
> automated testing:
>
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4607
>
> I did wonder if the code needs to cope with the port already being in
> use too?

Thanks, and sorry for the noise. The server dies right after writing
its pidfile there. The old stop test didn't catch that either, since
--stop is happy with a stale pidfile. I can't tell from the logs what
kills it on the workers, but a busy port gives me the same failure
locally. I'll send a v2 that makes --start wait for the server and
fail with its error and puts --status on top of that.

Thanks,
Baban

