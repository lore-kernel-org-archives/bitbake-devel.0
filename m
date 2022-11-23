Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29FBC433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 00:07:20 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.8243.1669162036387865905
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Nov 2022 16:07:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ehafj/+K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id l14so8297597wrw.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 22 Nov 2022 16:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pb7OibdNPRu0B+KHT+Zp3MwaKux7lLZ8NssM4EUkPxE=;
        b=Ehafj/+K4+zKcG/wkAmAt5BbuvgvZDOXI0XNRpbBT9mhRftuMvuhsF0LXQaSto6cNa
         icKavadB3FxTd2lcU1On+iLVTxLEQ2f0xnoS87F67b4WOCbkDOTJ65ila4aJ5r/JFvzc
         zCquZaI3sFj9NWEv0Nl+VAvZyU6jujx9zcNKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb7OibdNPRu0B+KHT+Zp3MwaKux7lLZ8NssM4EUkPxE=;
        b=BURgrMRCX5NxagCjHp5rdzndKrCOw6A5NbIDV4B5S7+sXRJj7HExQ969IZ1Qoki6Lb
         aYr6H4QnfAz1LUz9Pcw7ZjhD4C8sQRf6BBV1LjfdiBIieuEoVKUGbl1FtX8klWU2GqHH
         BqeXRlLfBx+E++DLQMltKA/X2pR+BqUFxdNzOnVHNGd0YZfOuDAArTeHyVHzIugncCIJ
         QjLvKgBZifLH+Wo29+8nX9eLHpF599DXrvv+4PDOSPBOQ3gwlEpTHCkQA3o6rVRPClnV
         /DtVXbg1wQ3ufbWiAltTUS8K/OFmsKDJos+eKOTtnozRaEz1cSyHnL3PpluicML9saLb
         0xKw==
X-Gm-Message-State: ANoB5pmSxn6yPcPCxA4wtZAz/GT4caZHpunY12OIyHKKHYcITwNtXfre
	CREPYHD8ZxW1YvqauAjdvnfUxR+QpSCuZw==
X-Google-Smtp-Source: AA0mqf7eRo0m8N6J5xSRpCdHEksoqiEkqecLhHDjqj+uzgXrRWjPV3itXUOyjUgAfzosr6l9QYlFZA==
X-Received: by 2002:a05:6000:107:b0:22e:3460:5e28 with SMTP id o7-20020a056000010700b0022e34605e28mr3997711wrx.211.1669162034234;
        Tue, 22 Nov 2022 16:07:14 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:978b:ac21:2786:e95b? ([2001:8b0:aba:5f3c:978b:ac21:2786:e95b])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c4fc100b003cf6a55d8e8sm363672wmq.7.2022.11.22.16.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:07:12 -0800 (PST)
Message-ID: <f963c6619df931162db7de468699d2aad0c1b76a.camel@linuxfoundation.org>
Subject: Cache timings with various changes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 23 Nov 2022 00:07:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 00:07:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14098

I've talked about changing the data we cache in various forums. These
are some actual numbers from a local system (88 core):

Patch                   Full reparse time    Cache load time    Cache size =
(compressed)     Cache size (uncompressed)
-----                   -----------------    ---------------    -----------=
------------     -------------------------
master baseline         5.732s               2.261s             N/A        =
                 24M
frozenset changes       4.326s               2.289s             N/A        =
                 24M
pickle in one           4.509s               2.177s             N/A        =
                 24M
compress with zstd      6.040s               2.204s             3.4M       =
                 24M
add hash data to cache  9.693s               4.327s             17M        =
                 83M

It seems the frozenset improvements I have speed things up nicely and
look like a good change. The compression does slow things down, as does
pickling the cache in one go.

The patches are in poky-contrib rpurdie/t222. I'll post the frozenset
one, the others look like they need more thought.

Cheers,

Richard




