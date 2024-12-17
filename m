Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F7BE7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 14:19:28 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.82796.1734445167989059064
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Dec 2024 06:19:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bgi+K22A;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so55436356d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Dec 2024 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734445167; x=1735049967; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZeZq9GPUKYqeZ3fPkxzrZUGnNpmSRoRDNKkiOVlpQE=;
        b=bgi+K22Am2hL/3O/CQ57k7UFC1TPLHmKGLQI4XbH3gib3+gtp3UGJFuz95i5+jvbHV
         +TawyaiVbsBBBDPhysmTY24KAA1xquiygnYv0TN/pOPEFkLX5FQOme7DHHmqH6xkmf07
         joLTCWlXTu88xucGYjmC0Xz+r79Dq2TWaU9D+mqzyQIFD1i4bL6VvP/ua4IO0L94lnfq
         BXq5BGDMidNYB3euyXM8UuvmjRR3HKNUMnJeWbgK6nACpT1w09CiEkvPXWxCB2X/QPBw
         TW5huRa9PBKGjJELZ7dIF2r+rs30edfjWrhHBBbpjt2HKeo67WsA4fyB1zvmNfp8AyF0
         IyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445167; x=1735049967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZeZq9GPUKYqeZ3fPkxzrZUGnNpmSRoRDNKkiOVlpQE=;
        b=oom/phxrGibWFfBaPmgOAKJzXAA/fZq74Q3Q/3Glfo+Rgy82TK5V5qaCz43iIZHZU7
         lCuTZxW71s086zd8Hcy3Crk51rXJua8DMyZo/rKhFwCe5HyHo0FB0KwTob5cL+ICRHZr
         J54fJTE3DjYbJBUNpYu2NxgzxFaE2M+MucaYmMJdRPbmTOrtIvHfEdCSlG5TBlfST64E
         IWklojPVnWO06T+Ozx1h3a8dBLhpYUevNtBLrumLl+nJkOkYOs3pdKSQdCLHO8xxmD/h
         wJfVQF4T7fTmiA0/O5dWXNV/LQLgIdiU8qBtx/Y9a+gS4evmikzt398+Mkt1dhnc+21Y
         h/nA==
X-Forwarded-Encrypted: i=1; AJvYcCX90OzBeAmkqp84sVgvRQcaTqX9avRXN9s7vWIVmdDHHpd5PeCsVBg1WxxNd958m2+QvLFRLErWAQ8aVtDa@lists.openembedded.org
X-Gm-Message-State: AOJu0YwEBjByweBssdwACXbSdXw0+/5ZCuJ1tRihCCugTiV4rWH3qsQf
	VaOL1ISF4IL6SXEKVMdxBB4HmKuNkrDMpxmDHI56okCd7vH/m6jwFUja0W0j3cABHxIsIqB3PPO
	D5Vpb+KxcpfWwDpCrv6EjzcXUgT8=
X-Gm-Gg: ASbGncuskf5beuvAFtpVdX4vD0LmvhiPWcTBYfP5rIyrwuMCCORF8U1GQJ8pNHO228x
	zoUFUMRmIBG0Ma3iL+u242un/MWFwkWZYjnU/sIFFHqFsHvPVzJGm8T7e5xifJUSw2APRzicb
X-Google-Smtp-Source: AGHT+IEOR3YLGm6nV7BxVWxwG9zMGrqyCbIprkhOpumM9BEPRUdyhBllOIXBJOsv0wjnfo+oV4a4Qwm7PeI5EfHfrWc=
X-Received: by 2002:a05:6214:194e:b0:6d8:8496:6b00 with SMTP id
 6a1803df08f44-6dc8e95fb66mr311350106d6.35.1734445166832; Tue, 17 Dec 2024
 06:19:26 -0800 (PST)
MIME-Version: 1.0
References: <DM8PR12MB5430AA0A8523E4086243CEB28B3B2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <df46a810902511e9427023e23663c74f5094f16a.camel@linuxfoundation.org> <DM8PR12MB543038304FB52F448BB740078B042@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543038304FB52F448BB740078B042@DM8PR12MB5430.namprd12.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 17 Dec 2024 15:19:15 +0100
Message-ID: <CANNYZj-bJu6YteYxHDMc6cu+3J6zLf_K3pPaAyBew6ys-Cdr_A@mail.gmail.com>
Subject: Re: [bitbake-devel] Potential compromise on adding type hints?
To: chris.laplante@agilent.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Dec 2024 14:19:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16916

On Tue, 17 Dec 2024 at 15:11, Chris Laplante via
lists.openembedded.org
<chris.laplante=agilent.com@lists.openembedded.org> wrote:
> (Expect another email soon regarding some different proposed code modernization efforts.)

I have to note that this email completely lacked context or
explanation or references, and thus it felt like you're seeking
personal favours from RP. Please write future emails with the
community as your target audience.

Alex

