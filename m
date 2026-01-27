Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB14D2D8E7
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:19:08 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7623.1769509140977253716
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:19:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=krP8F9U3;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c531473fdcso739746585a.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 02:19:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769509140; cv=none;
        d=google.com; s=arc-20240605;
        b=XLbbXlTWcevX26xuW23BBnNeqHDflG6PFIjSMf+vl0MTSWrKl3mikMrnA48n3nKjRB
         TZ0CmSgmfsc5A9S8LmXld4jbvQGklp4LANEnjg/cLJ65X3VqanhsPvn1b2SeHG0Mdwhw
         4QgCWkCu7JKSIWBWBN5n/jkJ9o4NWtIebRT8o3uByWoi1KVgv07LXybuGTB9DEnY7GL2
         bx0r7T3+YhYHkO4sNTvATB3P5cXFb8GNziv6aue6+Aa+Z1JRUgSNwv3rbtF71ojzYGA3
         0VENV1UZNFsEkcz94CBudVrWN5qNX1Mf5lzGASio+ZDM77adDrHmxqpe/sWTIMJgxeAm
         5/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7uwuUyCiDsaB+YMKwFWZX+6GIb3Jhr1HsPuzDrGDRH8=;
        fh=KW0f7yRIx3yXFpTJLQhuYUN1/mEK/3oIWqWPK3KyzVA=;
        b=JPLzUBQIH3H/4vp0IcHM0yRVgmUCKBw4gM8nfBXzKtxe3iJBD4JDVpKAG6WbRYcIC5
         h7m/aUdUHyY7VJ6cdyKq5V4jd684G/bPql/l7Azh3ct2WWE4NebKe9fqYtO9Tp6kjpv2
         j0i4Ae5hM39nfpPuK3WKAlDXPmifN8z81kNuAgGw9v7UKGi6irQ0CFYRfUQ57FMwp3qg
         2AiNRk7e6Qnl4yxTEHYnA+ETN2ae+DlFLLYLfAPYLRMkU09y42byFzKWaXpKtl1Rxh2H
         GxC6EEcKWVrJf56NM5uCStVUb0djyWZi/6QYvIcKhAr0guPHCPPWB6Fixq3PVL4eCrOx
         zpZg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769509140; x=1770113940; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uwuUyCiDsaB+YMKwFWZX+6GIb3Jhr1HsPuzDrGDRH8=;
        b=krP8F9U3WzVhx2inSgpNLxwnmzn5NmqdZp/L+wYFoBEO+ov6yTofbZS1/Rs9Zf5hSK
         LpwxDutT9uIHGHxoUFfMH0LL8LjLDTfV/+nKwWE5XbAzOzWeNrGRl/0mCbG90nl8r+Rx
         3W7g1y56VohcGxlKzJdPDXeRtSgWTKAykP/F2cLtwzcXcwWMFLMRCr006CSK1dX3oG1j
         WrOmuClASIqhU1QekMK+i8o2Ivl/jzGkurLleHsxxhJxyDoTU5QN427LyZJwuNX5ZRRt
         EKBtR210HHVdb7W8itCiOXEvBRF9LxFVJXgPn7ssRJLM2VIIUqLfBplwdJDV5rcXFKPq
         Goig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509140; x=1770113940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uwuUyCiDsaB+YMKwFWZX+6GIb3Jhr1HsPuzDrGDRH8=;
        b=J9E5Tmi1Cf9uGGg6llsGNxiTeT7CEVkinXD4hFEaatvYYHa6M96UUq+jtKgsSuEAmP
         qV2z6evlbLkMQvuk10t1X5mKY6O1afpcNVswSuT3W0nG7d4vu85UQdp2SU1epQLCfv3I
         0/FOly3EoyJBCX4KCTD7LeqhSzoOPxKYHzqhWLq2GLbasDS1h8B2ZxMCfO9iKHbxPAC4
         DF7HFP47deDnCM5qSSiATutt9E/BJTjE1tWdzf7Arvj9LKXzQgJPtejg/Z3lB48ru9+0
         SHD6zwn3sAsTTVmVNtn25edmsB/o9Ub1qpMOwWiCEKsw5aMEtZ3/OnYRJoZFq2fAma3b
         pDxg==
X-Gm-Message-State: AOJu0YygqyweoTzbxc/Axhgs91i3a1S+xKrVtGMa/wKJ14AKFOvoeG9O
	alRhZT4waXr44sZ/kYEkrntqdq8loCmUeufs+7BQers5EaumFz1HRd38f3yq/FhFyttE0Tn7A5H
	cWJnXqlqKWoEMXH66tqpDcIoFwLtu4kA=
X-Gm-Gg: AZuq6aJ9d9y9SP9+HFeF1Iz00fmimed3BiOQFcO1Ba8CCZZvXCSGJmHJEZUCSjpCsKp
	UDb0Eae/EI5wy9kqHiH5GY0y88XpIgfv1pqP3eVfGkcIyVtjWz/PRB5k/mqipwRO7LALNQfvaSW
	gsJJgKXv1MDeHl8eZBJqc12X/6cZpircPouKkNV0mowGH6oEmXO7Uc2UdIRhwfuWtoyBVjJKoG0
	hP7Q8n3Vs+zwbKg1IkICj3/WPPxnrcL8a058Tafy0xdGuoqRfGBI+8rPgQaKP6RQSx4JYwkATuv
	3RKWBXQgO9++PA0GYYRbthVFjy90vA==
X-Received: by 2002:a05:620a:3190:b0:8c6:a8a6:e164 with SMTP id
 af79cd13be357-8c70b8fb2aamr137486385a.45.1769509139968; Tue, 27 Jan 2026
 02:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 11:18:48 +0100
X-Gm-Features: AZwV_QgbHdMcPvIK5m7YPWGvCET2ogpIJGLKoWWiYCORslr8EsRG2D_CcYCJFgc
Message-ID: <CANNYZj_mFfO-cw9KO9u4wkC4qUrEgAP-kA1YEYLeabuZ=mg5oQ@mail.gmail.com>
Subject: Re: [docs][PATCH 1/5] doc: change some terminology around bitbake-setup
To: daiane.angolini@foundries.io
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:19:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18876

On Mon, 26 Jan 2026 at 23:28, Daiane Angolini via
lists.yoctoproject.org
<daiane.angolini=foundries.io@lists.yoctoproject.org> wrote:
> Change some terms to use more specific wording:
>
>   Generic Configuration  -> BitBake Setup Template
>   Specific Configuration -> BitBake Setup Instance

I believe the consensus was to retain the word 'configuration'. E.g

'generic configuration' -> 'configuration template'
'specific configuration' -> 'configuration instance'

From the context (bitbake-setup docs, bitbake-setup output) it should
be obvious that it's bitbake-setup configurations, so I guess it
doesn't need to be prefixed.

Alex

