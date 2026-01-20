Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84B6D2ED0F
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 11:57:34 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4652.1768910246158014015
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 03:57:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VSRy6s8x;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8946a794e4fso2709976d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 03:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768910245; cv=none;
        d=google.com; s=arc-20240605;
        b=E8lw1Qe7Yl2jwECGkw/WQtM40M5bsnr9w2GdpmobzrhIb1yQvGOQHo5p4gBOij2ii4
         jN62zJZ6lnf26y6YMGqdvtU8lB/ZrXYrhZahS7lWZetXd1onoO9R9z0Rl/wevcCnA8Xu
         kWlAv6couRw36PtjabQKAubien2QO1xATUsSctshGmhppj5oLwmiDPzjbS2jH2ztjgDP
         n2cB/MPUUcH6bOx0j2tpGfsae3UwBfvWEjVguU/m9kViVO49JAurNjgDqQb63gWZ8zh9
         N35CQnC4sqFqXTil8JGC4r4eoQEmNyu+LG4WFO7xXxt7h368GLtcLLv4dVpGU40sh/IQ
         1WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZOO2y4959VCS3gD34Lh1cmLBymkcO2F+PnfkYmHweBc=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=VhbmFH44mxisd2+3SSEpomLui5hSPQdnISAmkzZTNWSVRhsoltyW11KJRhpvUJMmpl
         L1YY3/vQCbxoogv5wd0eItWywpnFYRNLtfIL1pMg6SWgR4GqEF23dAPnBCWS3t3fkX3q
         AUZMXaHdFc8oiPEHRJvZRHAT8YUdmET57FuD6BaWP9kyV8VybpqiKdctzP+MEvvmgzp1
         NECWMEf3s7stfjMe5f0w+rt+K8vtWIR3HcceF30C6T16QuBvl6k9KMeWccVfNcdzlV4w
         0+C2Ro8V+xH6dp1tEE16EHp9gfLRKi2PsWDDTT3HLjDiS40CplP+msKzSi9bWhg13mDs
         6bPQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768910245; x=1769515045; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOO2y4959VCS3gD34Lh1cmLBymkcO2F+PnfkYmHweBc=;
        b=VSRy6s8xUCPMCt1F7/L60/wV8k71evjN3z0nIJYam6xiyG+smcpaKjyoy8B2C6r539
         Xo+RlITF5m26rmxuYycFwynoj8FHBvcz5vUJT1EvTXknBVZhMHl3u3Rln9O4mHzKc9y6
         5fI/csJGvF2/LwKlXWEjjCsjXfS9pc0fykxH1P3ymelnY3rRVWMnSnXZQxAZvdrorxwx
         CRbzTZRXxiCwrv1UWWLxZOmvXbqnbdQl4xouxa02K+TzVL6Up3n1ZYnhcd/aqKKKaLBz
         Sq80rbXeqIpy3qQJ7MK5/luA6Mes+ISAnAGAeOV+6p82RW7OQd6yzY5BZwOFX6JU6kJb
         pd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910245; x=1769515045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOO2y4959VCS3gD34Lh1cmLBymkcO2F+PnfkYmHweBc=;
        b=TEZETXSLaxxzxnfoyvNNl6oGlOnrnp9ELG6nNihlt3fZ/ZkETjayvouCHgaPxXn026
         9PIH8W3AfXzdqjGCDhfYtb8fAlwz76niB9n+XJqRDY9mrpFHRyPuklVJEJEouUJin2VZ
         RQCFPgHCA4Ivjzz94gXMRQ0PEe1zaZce8ECbN/gc+FDVnKEV1c4MBcJHHRBR/sxDYC2g
         1mFAKW3e/TYiioeC4NtHaZiAwo5/PQqlD06socVbbCvtfNiksXzAa5BTrDR8h6kfof4T
         y0HEfqXKkBtvN4FO9rivc3wK1Nlwlh/tSysFahipxURYnQbFs28/8ZgjDewldFnYG8Wi
         JKiw==
X-Gm-Message-State: AOJu0Yy5xGGrXLSKlL/LN0nx1Cnhq5VJ80YCI0mnLrRWJ1w8QtgvTY1P
	m8NCwoXibI1i7qVQZ+o15OvrCNvZ3Ok4fvZRxvW39umwOY7rbnzRX+dmskMdZtRLSIuicFtjRr0
	W4maCKf+XIgubJ3U5YTLMne+ic1Ya4l8=
X-Gm-Gg: AZuq6aKeh/U9UEKk2hyeYlp9rYZQnjkhwmw0x5VNfMSGQlsO1L95cqZsKeYKEAXFGzy
	yoXcIbm5HPzft8lV3jfVC0SMEwfqkNFDVhlQknD0ZvVbcQhUQt5N0Jm2ae5EAl5WUES5wBOe974
	oiSF3l0a4aO+Sp/WRyxLfYONNbVm61dX76lsVQT369TL3PXdTjarsH0n/OWsFCQxLLzylnovR98
	II8E0TLL+TDApWH3qa3PjdJeCo05msXaMEF3Boz/G76j41bxnRFBw6MAX5hestBZH4RHigJxMzC
	E3pTSHQ+3bPNM7Vbhl2DVjxkQeymBw==
X-Received: by 2002:a05:6214:2a88:b0:88a:30aa:6c01 with SMTP id
 6a1803df08f44-8942e4ca244mr166779166d6.57.1768910245044; Tue, 20 Jan 2026
 03:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20260119073419.952608-1-adrian.freihofer@siemens.com>
In-Reply-To: <20260119073419.952608-1-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 20 Jan 2026 12:57:14 +0100
X-Gm-Features: AZwV_QiQsdOYk91SXEAcmIZ8Jm-_KlQW_wRa96KLu2ioknhlpgawAXYwxEjyWOs
Message-ID: <CANNYZj9rLfTy2A7P-CbEuM4uEqOELqABCPJc_XQXr3W6R5e18w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/2] bitbake-setup: Add VSCode workspace
 generation support
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 11:57:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18816

Hello Adrian,

the approach looks good, but the changes are not small, and I need to
set aside a bit of time to give it a proper review. I'm now trying to
fix some of the more difficult autobuilder issues we've been having
with newer distros (f43, ubuntu 25.10). I'll get to it.

Alex

On Mon, 19 Jan 2026 at 08:34, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
>
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> This patch series introduces automatic generation of VSCode workspace
> configuration files for bitbake projects created with bitbake-setup. The
> feature enhances the developer experience by automatically configuring a
> multi-root workspace tailored for bitbake development.
>
> The implementation generates a `bitbake.code-workspace` file that includes:
>
> - Multi-root workspace structure with all layer repositories and the build
>   configuration directory as top-level folders in the VSCode explorer
> - Pre-configured BitBake extension settings (paths to bitbake folder, build
>   folder, environment script, etc.)
> - File associations for `.conf` and `.inc` files mapped to the bitbake
>   language
> - Python analysis paths automatically discovered from layer `lib/` and
>   `scripts/` directories
> - Sensible exclusion patterns for `.git` and log directories
>
> The workspace file is placed at the setup directory level, outside any
> version-controlled repositories, avoiding repository clutter while providing
> a centralized configuration for the entire project.
>
> Adrian Freihofer (2):
>   bitbake-setup: generate config files for VSCode
>   bitbake-selftest: add test for VSCode workspace generation
>
>  bin/bitbake-setup     | 198 +++++++++++++++++++++++++++++++++++++----
>  lib/bb/tests/setup.py | 201 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 384 insertions(+), 15 deletions(-)
>
> --
> 2.52.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18805): https://lists.openembedded.org/g/bitbake-devel/message/18805
> Mute This Topic: https://lists.openembedded.org/mt/117341468/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

