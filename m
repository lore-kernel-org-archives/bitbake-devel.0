Return-Path: <matthias.schoepfer@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE95ECE8E77
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 13:42:07 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.14832.1729777322194671793
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Oct 2024 06:42:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@googlemail.com header.s=20230601 header.b=HepF7zx1;
 spf=pass (domain: googlemail.com, ip: 209.85.128.49, mailfrom: matthias.schoepfer@googlemail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431481433bdso9518025e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Oct 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729777320; x=1730382120; darn=lists.openembedded.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQMvkOotP9+r+lR2F66uKJI7YMzadcWWjq6HtM7X2i0=;
        b=HepF7zx1fhGo163PFDmLAAOwP34Y51PnJBZKJ7ND+r9OCBp7pzJX34IWhAyQpt+EqK
         EWaKcKjSaJN0Rh3N85uM4ITJgEbk5/KFobgmF2+2jUR+4QyMpPWOnzU/srkc014QCPsA
         WiGwH4FqgAaIcr+3/2d8f/qQr201VDmgqfNT719P6YI21YcAju9T2m/vMlmIqMK5wpg+
         +2fmmL96c/smZqLrlbqM3/jRFeUbylI9uRwumUNmXmoPz3qbnbji0+hp4baUjHoro7oO
         8aXQPjB2bP9O3zh/Xa462obUosKwNJLVKDGM3M5x3oBcQd8exkAm7pl6CBCQgXSdw+Vz
         3SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729777320; x=1730382120;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQMvkOotP9+r+lR2F66uKJI7YMzadcWWjq6HtM7X2i0=;
        b=Li1Rre323im7A7Lg8nwo16KcG2h94NJo0tQNa3629HWMJCfm9lYp/xcFec5nnIqiCT
         C8+JNFCcSLlrC79tzn4VNB6xVrC+GxBpRylMZGmWrQpKwLKy6Bcd5SrBzkMXMhvbwXs9
         qlgSRh+XuXl33/TU6BQfe6mbsJAeQFWIkzuy+s/BPQiNVQy3lzMAiomfyzQVZRbU2gDX
         phRKBRp3LQbTHDJFGzABJfAlJduehZFQolmqKwixGjeJEnlBV13JJeiLFzjQ5c/F/o0j
         Ye+axJjFqB3BgGexeR6wRE6pRJgaco0W9PwD8GDxEmhU8PWXfKFMQlmaRBuQ7tui8AuL
         bVYg==
X-Gm-Message-State: AOJu0YyJL1omZ4/tEH2f3Um/HpJqK8RBHxio/iDpy+XijrF8bJM79uZX
	TcMxXpGDXhOpMjzWNqTulIkqO9jWY0OMbHpoyc90QTjHrU0u1y3AD17ZZA==
X-Google-Smtp-Source: AGHT+IEXRVk9VEx3M+u73oUcon97/AVHBKqdT7EZdFIoOFbN1b3Bvj8KSr+4Plxnr+8j4yo5VZTsDw==
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-431841aff4emr54491555e9.29.1729777320300;
        Thu, 24 Oct 2024 06:42:00 -0700 (PDT)
Received: from [192.168.178.41] (ip-088-152-186-249.um26.pools.vodafone-ip.de. [88.152.186.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd6856sm47023215e9.6.2024.10.24.06.41.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 06:41:59 -0700 (PDT)
Message-ID: <00b87e99-7b7d-4cdb-b800-000860eb0263@googlemail.com>
Date: Thu, 24 Oct 2024 15:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: bitbake-devel@lists.openembedded.org
From: Matthias Schoepfer <matthias.schoepfer@googlemail.com>
Subject: Stupid Noob question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Oct 2024 13:42:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16723

Hi!

I am stepping totally out of my comfort zone and had the idea to write a 
custom fetcher (shall pull docker images O.o). From reading through some 
of the code of fetch2, I would guess there is no way to register a new 
fetcher from outside of the bitbake code itself. Please correct me, if I 
am wrong.

Thanks and Regards,

     Matthias


