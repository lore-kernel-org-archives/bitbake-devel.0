Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7FF9B602
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 09:59:18 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78685.1776851951014940659
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Apr 2026 02:59:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UzawGzJo;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8aca4e14411so63420086d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 02:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776851950; cv=none;
        d=google.com; s=arc-20240605;
        b=hAnl8Jo67EyoNCKYf2l94BcIHTJPbFocMPAuaBSeqSSSmWrCwo47POrZieNs5c0TZ9
         UAeB4ULxwp4BiYLcjHNTkBv19X/aEko9vK4OMVKxaO7HYFsHyc+5EO9HGBgYelnqu+I9
         3pqxdmONRD1Qhu+Tbi1c84VElfCNSKMEJ1pKsQRLqYlVcQ37YL0Rd1KUUM2Jn93JoVuf
         cLXl7ltiCglgfUGU4uJ/wuLo+HFaulVqTXfiOMVC51RS6stvaY+P1cHZXhQprM8Ib1WV
         zy6hSj6n4aTVsBZ7iYgsVOBl3lK/5bPin5ZEJGE4lGeiAP31avY8Ko/DHspGw2AcLZ7F
         Rd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tMhxRoPomMTmQNAoA+oJGtNbnKcHVQo5pjtG97EausE=;
        fh=nTTaCMLSXiKcsNq27TrJZaTuW3XGD70wCTeR+9P8VtA=;
        b=QlTYzcXmKl6KUl3BILScriMZI8p8iMJRmXMLTCdhhYBb5kAuGMTjTkyXc7duujKSl4
         k4JzVcriOPOVVltcvOULW7SDCs4h59uezfT8PM6B2fRpTLcEjg+znxniF9iVXbWsL8Iu
         1UCqb3Jrq88SVM5tnz1HdF9PnikUH8svpHBmTg3vNjoGlF5OsRuR9HWPpD9kGuwXQYqK
         jH9n9lVHrC88WYns+fMCuWdh7lP5NrD4mxbemMksaMiTluBU2t+sTes9dtuOEDr4AuPy
         DJIjNVgoG0K8P+bBexFt/29rh4GLYnankhJDj6HIcG2sLNwe8MsSskjvHpVvQr27k1AZ
         NvnA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776851950; x=1777456750; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMhxRoPomMTmQNAoA+oJGtNbnKcHVQo5pjtG97EausE=;
        b=UzawGzJo7oxFD12h+IWnP6cvJ8SkZx8+xseL5/fRL/B9FV2eiBoym37raSjdEPqUW9
         hjBBPAM2WGYy3sqe5bolhr97dlqVAMR1adv/AhsLFQ5bzz6YE0hrt5byxD53dyEY257N
         y6np4wxCvJHY1saEH9egr/wkv9sw7GgjAE3rJIlGp8gSsIzjyviVIMDljVCBep55A5xc
         oFYycIMJs8XVBpgILOvYUirw7c2tzgAqUzfKdDDXTARaaiwkJ9dP4+mznjwxoyWRpDrj
         PD5ZuU93WLqgwDscS+imwt4iZ82lQ7YOV+hX2oareVal8sZisSfR8TNEPaHdwOjV5QuJ
         zL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851950; x=1777456750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMhxRoPomMTmQNAoA+oJGtNbnKcHVQo5pjtG97EausE=;
        b=Buu7ncZx/jqJNvwYQO0WP2i2vv/iG7LdBizXC4lrk/1eidoyb8kAu5y+fc68gGk5tn
         cJXXwgPWTs1EDvbHXwR4Wof4SySHxMRA/MGAOKpY6KreW4s97+XFbQYaXYIhBmZF7Emo
         zqW8nuKM/9ecPAT4twuUP6N1ZmWiuTEQVl9SJ5Ab2XX1LfSnswBQ+LEg3Hj7fCadt5lM
         egxuealpxEl5KEIRLKzRT1QQD3Rt3SLxkKk1x9EZ+mljrBTWU2+RiaAbwkPcO4FmxsQN
         ci5myIpY5TjE70xH8a69Y+JyhqO1cQy/ryBkG7aqAbUNHGSTPlp9eXg/7lJ401Fb+GN+
         eteA==
X-Gm-Message-State: AOJu0YwerZpfbFdRFLFaHdz68TE2Lj+RiYe1LSqYeZZ5l8eFFr2+FVqk
	s36dnZNgFLAFoETMwyuGrfkcSD3ihQ8FoOQjPCt0EXD4O7zxuB7jYTljTgMfExJc7jptY8Scl5W
	1TtX36/t5tGdi5itMYKmno6AFx+CNZYhiUlXM
X-Gm-Gg: AeBDies3lUFDN7PzYdNJiAZ+sDfRc+SOPp6WgC0Zq/SjOUe60FSN3Bfv26uzth0iAvm
	MaHUnDra9bP6xHEkv+XdUXB8TaJzqQPBI1GCIfgS9uc5zKiEjwhGST4a5SkjAB5VjnyWAHE35Bo
	eM3CmWxQeL/ru3wvmKra4STg2dtkPx7Abuo010IGOOlly1Xf2s6JAfNlBEWKujV0zJmppjh9uCf
	c7BQ0MbiHMV1NJN0tmV/coRl6OALjxCWiAbdRUIK0naBU7LA9jMcgSut7YDeHBzx0FvPCBgW6z6
	+lRF0D+uYAeAUWv6ClsTj90LbG+G/5YKzjwLHNsbP5t6peIHewMU
X-Received: by 2002:a05:6214:4a84:b0:8ac:a5a7:2888 with SMTP id
 6a1803df08f44-8b0281491e7mr325786036d6.50.1776851950035; Wed, 22 Apr 2026
 02:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260422095624.241708-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260422095624.241708-1-richard.purdie@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 22 Apr 2026 11:58:58 +0200
X-Gm-Features: AQROBzCQFbQQhXBxOML_a_mvC8YX1k_RSQGwu1Nd9UC1apZK6Rae7ZfXOmCWFKo
Message-ID: <CANNYZj8g8rbRnxJJ2SA7thJ5SuZS6vChwS=kXNW0EuwLHay0aQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] default-registry: Add wrynose
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 09:59:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19375

Thanks, this looks good!

Alex

On Wed, 22 Apr 2026 at 11:56, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>
> Add the new release
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  .../oe-nodistro-wrynose.conf.json             | 48 ++++++++++++
>  .../configurations/poky-wrynose.conf.json     | 74 +++++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 default-registry/configurations/oe-nodistro-wrynose.conf.json
>  create mode 100644 default-registry/configurations/poky-wrynose.conf.json
>
> diff --git a/default-registry/configurations/oe-nodistro-wrynose.conf.json b/default-registry/configurations/oe-nodistro-wrynose.conf.json
> new file mode 100644
> index 00000000000..278ce4dd029
> --- /dev/null
> +++ b/default-registry/configurations/oe-nodistro-wrynose.conf.json
> @@ -0,0 +1,48 @@
> +{
> +    "description": "OpenEmbedded - 'nodistro' basic configuration, release 6.0 'wrynose'",
> +    "expires": "2030-05-31",
> +    "sources": {
> +        "bitbake": {
> +            "git-remote": {
> +                "uri": "https://git.openembedded.org/bitbake",
> +                "branch": "2.18",
> +                "rev": "2.18"
> +            }
> +        },
> +        "openembedded-core": {
> +            "git-remote": {
> +                "uri": "https://git.openembedded.org/openembedded-core",
> +                "branch": "wrynose",
> +                "rev": "wrynose"
> +            }
> +        },
> +        "yocto-docs": {
> +            "git-remote": {
> +                "uri": "https://git.yoctoproject.org/yocto-docs",
> +                "branch": "wrynose",
> +                "rev": "wrynose"
> +            }
> +        }
> +    },
> +    "bitbake-setup": {
> +        "configurations": [
> +        {
> +            "name": "nodistro",
> +            "description": "OpenEmbedded 'nodistro'",
> +            "setup-dir-name": "oe-nodistro-wrynose",
> +            "bb-layers": ["openembedded-core/meta"],
> +            "oe-fragments-one-of": {
> +                "machine": {
> +                    "description": "Target machines",
> +                    "options" : [
> +                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
> +                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
> +                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" }
> +                    ]
> +                }
> +            }
> +        }
> +        ]
> +    },
> +    "version": "1.0"
> +}
> diff --git a/default-registry/configurations/poky-wrynose.conf.json b/default-registry/configurations/poky-wrynose.conf.json
> new file mode 100644
> index 00000000000..d2792843773
> --- /dev/null
> +++ b/default-registry/configurations/poky-wrynose.conf.json
> @@ -0,0 +1,74 @@
> +{
> +    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 6.0 'wrynose'",
> +    "expires": "2030-05-31",
> +    "sources": {
> +        "bitbake": {
> +            "git-remote": {
> +                "uri": "https://git.openembedded.org/bitbake",
> +                "branch": "2.18",
> +                "rev": "2.18"
> +            }
> +        },
> +        "openembedded-core": {
> +            "git-remote": {
> +                "uri": "https://git.openembedded.org/openembedded-core",
> +                "branch": "wrynose",
> +                "rev": "wrynose"
> +            }
> +        },
> +        "meta-yocto": {
> +            "git-remote": {
> +                "uri": "https://git.yoctoproject.org/meta-yocto",
> +                "branch": "wrynose",
> +                "rev": "wrynose"
> +            }
> +        },
> +        "yocto-docs": {
> +            "git-remote": {
> +                "uri": "https://git.yoctoproject.org/yocto-docs",
> +                "branch": "wrynose",
> +                "rev": "wrynose"
> +            }
> +        }
> +    },
> +    "bitbake-setup": {
> +        "configurations": [
> +        {
> +            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
> +            "setup-dir-name": "$distro-wrynose",
> +            "oe-fragments-one-of": {
> +                "machine": {
> +                    "description": "Target machines",
> +                    "options" : [
> +                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
> +                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
> +                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" },
> +                        { "name": "machine/genericarm64", "description": "Arm64 SystemReady IR/ES platforms" },
> +                        { "name": "machine/genericx86-64", "description": "x86_64 (64-bit) PCs and servers" }
> +                    ]
> +                },
> +                "distro": {
> +                    "description": "Target distributions",
> +                    "options" : [
> +                        { "name": "distro/poky", "description": "Yocto Project Reference Distro" },
> +                        { "name": "distro/poky-altcfg", "description": "Poky alternative with systemd as init manager" },
> +                        { "name": "distro/poky-tiny", "description": "Poky alternative optimized for size" }
> +                    ]
> +                }
> +            },
> +            "configurations": [
> +            {
> +                "name": "poky",
> +                "description": "Poky - The Yocto Project testing distribution"
> +            },
> +            {
> +                "name": "poky-with-sstate",
> +                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
> +                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
> +            }
> +            ]
> +        }
> +        ]
> +    },
> +    "version": "1.0"
> +}
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19374): https://lists.openembedded.org/g/bitbake-devel/message/19374
> Mute This Topic: https://lists.openembedded.org/mt/118952259/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

