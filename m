Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03344CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 08:44:57 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13293.1762850691152250686
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 00:44:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GkZTrMgA;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8824ce98111so25050876d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 00:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762850690; x=1763455490; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HvW2oLj3AFceaGfWj8IubLQ12+fvvRdczGt2rWSRjhw=;
        b=GkZTrMgA1mgArS3Ld7l/fn9VVMvgJNbuXQY/ECUDYCIzz0NxOsBB7/bcrXwOYNW0J5
         8LLasmzdxSqQvaK0uEPaBvG20fHyPwNcIU5bNRJ6zmbOct62S3A03mvk5HiSk620goRT
         EaVzAHYKzKDGPmccrM0zKq96aEyCXIBv/5u4Iq4AfTOP0BDSn5gMA11oeihusFkLL7KC
         3CY2meJfyE3pKmX63GkrUxKXlFdw1Nr4BU4q1dM+O24JyeQ0JJXxDQVhtGqE+7LduM03
         iLewidi/K6jAm+NemlwZ4F0kaNuR2f5qiTEpCL5jaZuxnWjHwMwmQ26O4ygbMmtijcP4
         3buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762850690; x=1763455490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvW2oLj3AFceaGfWj8IubLQ12+fvvRdczGt2rWSRjhw=;
        b=V1oBnbtesH/VVIj+/Cq7yHMiIdF1LYkR0IEuCXNXmZraxhAHf60GSNl/wX+5Jvc9Lq
         XkmFFBt3TNdRk4BRSdK5ZRUw1DChuMXxsgbG3Rqt+caq3wOHpj7yFK9sfWKVeBXtOI2g
         +rG7Ac+M4mE3JrHxsgBgGIHqgIpyaqoFQ0dbHhhPh5Uvdz5xBR92HMGHztAs1OPG/K6G
         OdZvHMqFvBes0Mj/ku1mOS/OwwSzWuyX86d7zdLCzG3mnJ22gWdJeGFtJdmrGfxykplx
         b+Nf7aTcIdbREWVif368OnZRAWWZ8/FfaLWKwJeyA+Czt405fFNh/AARxt257KUkU8SS
         HPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEiQC2BX2S0QSpEZ/n6y3pFdI5rwUCz8LHI9j0NgbNZGxODW7CN1BTD9EwC8dYlOFTMnSQ+J78gkUHMyWn@lists.openembedded.org
X-Gm-Message-State: AOJu0YyMTS/xqUd5PlTw42Ez/HvMoz8HPweEse0pmnVLR/3iEBT0OBBg
	MB0qtydgM0D2kxQm+HZAd6Zzn2zL9LfKzlPJZJRRb0pv8IsDz8ylQqFYY6HpxAo1otloF6PwIo+
	rVXZrXQmqF+EGakOI498Wri+XEtCak0Q=
X-Gm-Gg: ASbGnctfblHyA8SHnBvHmJxXSqk6zfdbfLdA594vHEuDIO3BFBTGGU4L0+aO8L7TQoc
	A4N9mgFBYtA5DjYTSa6t0MlMykbsNwd3BGgk+xbiuRCbe7U/GO+se8FjBU3y0vwyojHdGJFpvZD
	AdaOyoNKNSKid8gAtF/2aU62wDRHw9JwregKHXKSMC1yM/F2rHhc29AXG5nQjC97VuoMgL23vYp
	UNKD4/TlC+XKhIaRTJ7a6z5REjmHUQjcldqZM9IY1B33kSaCIKSiEVRIVLn+CE=
X-Google-Smtp-Source: AGHT+IH9aNtcOBhU9O/08k4a+lNAHJ6KNYtdoUdSnsTld4L/ScDSmBNWiHtZtb6LyUGXdag8Z7A60xWLMnV/kh+zt8Q=
X-Received: by 2002:a05:6214:cc4:b0:880:4bb9:4c94 with SMTP id
 6a1803df08f44-8823861121emr149769106d6.22.1762850690058; Tue, 11 Nov 2025
 00:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20251107-bitbake-setup-v3-0-9aa227ade002@bootlin.com>
 <20251107-bitbake-setup-v3-2-9aa227ade002@bootlin.com> <743a968c4958035964411ed3be7d434065f9404b.camel@gmail.com>
In-Reply-To: <743a968c4958035964411ed3be7d434065f9404b.camel@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 11 Nov 2025 09:44:49 +0100
X-Gm-Features: AWmQ_bmKOGorg64VznyFeevobunzaq7Rtb2oc0_kI42s3QvPo3FlJcDYWd5xsnU
Message-ID: <CANNYZj_j=RmGD6kSDs=4BZcmtqZAT4=0V-EkwfsJYFCGKPFoUA@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH v3 2/2] Add bitbake-setup documentation
To: adrian.freihofer@gmail.com
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 08:44:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18318

On Sun, 9 Nov 2025 at 16:29, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=gmail.com@lists.openembedded.org> wrote:
> This is based on the assumption that everybody knows how to get
> BitBake, but that's probably not the case. For many users, it was part
> of Poky for a decade, which is now gone. There should be at least a
> link to https://git.openembedded.org/bitbake and a hint that git clone
> is used to get it.
>
> From an OE-Core developer's perspective, it might be self-explanatory
> that BitBake is a separate Git repository which can be cloned and
> executed without any dependencies to fancy Python modules. It's also
> obvious why we need BitBake (the fetcher) to fetch BitBake.
> But for some users this might looks a bit strange. Why not pip? Why do
> I need BitBake if there is now bitbake-setup to get BitBake setups to
> my machine? To which path should the bitbake repo be cloned?

Please trim the quotations when replying Adrian.

Otherwise, I agree, this does need a section, up front, on how to
obtain the tool. And we absolutely can and should put bitbake into
pip, once there is a release tag that has bitbake-setup in it.

I've already had one confused user [1], for whom it wasn't clear that
bitbake-setup is not tightly coupled to the yocto release it's aiming
to build, and one should default to latest bitbake master. But because
bitbake-setup is hosted in bitbake repo, that isn't immediately
obvious, so the docs should stress that too.

[1] https://www.linkedin.com/posts/michaelopdenacker_yocto-bitbake-openembedded-activity-7393585408602718208-0kUF?utm_source=share&utm_medium=member_desktop&rcm=ACoAABJHgsUBoC4rs3Cqeu3vM4cHkuvzT90KZf4

Alex

