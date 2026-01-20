Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC8D2ECE9
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 12:31:25 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5365.1768912281849761799
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 04:31:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eC3tN7+d;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-888310b91c5so54403206d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 04:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768912281; cv=none;
        d=google.com; s=arc-20240605;
        b=QAVjNIj9jEQ8TGf9ZklJejDfjHkyAxk9kslWepHohYdeiLjCVdlq/GotNwhZIgLCpl
         P3qAmRVJ4HpdxdLnoT9WKqkMIXxOHfsBjktsD0MgWNyMifROtegJ5Yvn6aMW+3TjDzjv
         tC+4Ix/ao3Qfa0UJc/a+QUgTSUaP0PnmSpmNEvwc6bKkpl4JZc20oKnnjZFh++3frjSa
         WIBlunmNEwSp9iHxI0iZx0zptVD+e7NzJwaATr8g3JzK09hzodqz8NfAShdHjUt4NbsV
         U5ppNsD6W7sJABTd2bSU7NnOXQXkn8S7HASfGQ95QUqpIJsX6IHcoe5GevAMmSsCcQXN
         xPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3FOVJGag79m2izN7S0yu1Cgo9alM3OM2bBGislUcfp8=;
        fh=4iyoqXWXzr419C+IQOwDq6Y51UQKhKZf37iVDBoh7vA=;
        b=h/q9StEn/UdnUeseaLwZlNSGMk1Eg5GzbsFVJAxSdz0y1DqORjZnhjTkzRTyVsM4rI
         SpirpUjUf20qlDOBg5CDfFEq6J6qFHn53flCrG51MBTna80sSEKHEIxLvnKTuH9DyfYM
         M6plaEbJApUEQy6rqQWE4GZEWiamAPcoO9VnOq6NeecTesSEkLOkK3azqsdMuEdoAoLu
         VnulYlyYcTeSxudrLH6uSroBfR586jBDa7RzU94mo1c4lPGBilxvLTfnDN1yO0i/Z6rd
         0nssgzOthMUPZTgPlAOBVfqe3tzhY42ed9EGjpCL7NEjgiVgkXJxtuJfhWM9LzTG7BOu
         wqbQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768912281; x=1769517081; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FOVJGag79m2izN7S0yu1Cgo9alM3OM2bBGislUcfp8=;
        b=eC3tN7+dNIdiMvwzGgMUKyxCU6P4YDlprQYUKRLW74TptryDAsHnQEEsUuTHHHLaAB
         ptMYaHg+zknnLdEToL/CHQ3XRVvrjFvzEPn5hG4hyXLbs+oGnvoIAxFGUHagCPMd0Vgu
         HAlQYnDqgaQL1xIcn9hFq6IkDlPj/Phjwf14oW6HD8OSAm07jOrKC+m6CbdZN+DQv5tg
         RsaukXteo3zaB6smxROxF+w+71QID0s4uFaKwyFiluhUF0XJ9iKPS6R44zXa7PEX1XLl
         06qaZWsQV/IDTx1SW575c436TrJhll+w01YB6ZRIPV/icKq1bDaBAHp5m1cO3DsuhkYp
         GGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912281; x=1769517081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FOVJGag79m2izN7S0yu1Cgo9alM3OM2bBGislUcfp8=;
        b=k48+AdznxHXVECHxvuORyjXlB0e87F81HnOkgg3O7S6gqlN2vVjRQ1pvBlV4LgS56v
         0OHOxpoD/VgPYgrBtEr34n+iCfYDk+XVOL/wHJvy4SuHVsB7wj8RDrAVJODev+ZOZhbQ
         qINyGBrUUIRbvzrzzWi/Uu9kZK0OYoEdDBpFqOheefJOn6BIx6v0qqXH9CwNtO2+bJwP
         YtXMxk3CdQ9ALHQ3icYbSiLdaZ4gsnZGpKP0ODvpNGapjpbc51tHC5XrBwSDbXD+FEFM
         OkgpHKcPztlKfp9mL47ImHb8UR0r/iLuS/ZpBRx3wQzal3VLUHQYQtrFplV9j7LcnHCm
         2p+Q==
X-Gm-Message-State: AOJu0YweHenuazfIcLricnwTTEsmiI3AkEtoJcWqx6k7XDZNV4/b7wn6
	uwvsTS+hQyd938FW1PeLrrfxNLT0Pb6ik43XuHzQP/Y61UNIboXSfHhy0at3fxYyMin+TWAWnhs
	0NxgUoRC6wPwLwzdOVDkMFtN4uzLMFds=
X-Gm-Gg: AZuq6aJ8nAkKTi20HDj0wkC57yAUkNHLSlIYLHVhT9pNboCxJJba9j5b3zqErV9evNE
	SjnLtP1I2VqPbCbogIiariYhUtQak3I1of2VJfJpvxvYRW7pDemAG1JFxRF9Ilj7eX708+fRss3
	rI5Xu2DBOVaPAsKiewENditFZ/msVdxDekVkpTaC8YwLeJXDMcbuarMJIkEfTrB+gEq0Hayo/ER
	aMmydMi6rHhnulB+wsUHQvyIogbopJIg9rx6lI2VZ5h7mhDG5NroqBTUmDnMlC5Nmhh0PRTgTnD
	1DZ+slFjH+Us1DfYBwz+YYKggraCIQ==
X-Received: by 2002:a05:6214:5092:b0:890:3eb8:1ee8 with SMTP id
 6a1803df08f44-89389f83a29mr229041026d6.2.1768912280821; Tue, 20 Jan 2026
 04:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
 <20260120-bitbake-setup-choose-builtin-v2-2-ade604ff2351@bootlin.com>
In-Reply-To: <20260120-bitbake-setup-choose-builtin-v2-2-ade604ff2351@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 20 Jan 2026 13:31:08 +0100
X-Gm-Features: AZwV_Qi-3mk_mMayIM75ExSj7e6t8ZgqO05f1RnUvxjEqWJEkyw991WlubTjOEo
Message-ID: <CANNYZj-O4u6t3ECRcvbdWnCQU_AW3dJmVE5aGopA4kSDmsxr2g@mail.gmail.com>
Subject: Re: [docs] [PATCH v2 2/2] default-registry: update fragments choices
 with descriptions
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 12:31:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18818

I think only master configs should be adjusted to use the extended
format? Whinlatter configs should remain usable with whinlatter
version of bitbake-setup.

Alex

On Tue, 20 Jan 2026 at 09:57, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
>
> Give descriptions to the fragment choices to help the user know what to
> pick during 'bitbake-setup init'. These descriptions were based on the
> descriptions found in the corresponding configuration files in
> OE-Core/meta-yocto.
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  .../configurations/oe-nodistro-master.conf.json            |  6 +++++-
>  .../configurations/oe-nodistro-whinlatter.conf.json        |  6 +++++-
>  default-registry/configurations/poky-master.conf.json      | 14 ++++++++++++--
>  default-registry/configurations/poky-whinlatter.conf.json  | 14 ++++++++++++--
>  4 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
> index 180d2008a72..00c4befb1ac 100644
> --- a/default-registry/configurations/oe-nodistro-master.conf.json
> +++ b/default-registry/configurations/oe-nodistro-master.conf.json
> @@ -45,7 +45,11 @@
>              "oe-fragments-one-of": {
>                  "machine": {
>                      "description": "Target machines",
> -                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
> +                    "options" : [
> +                        { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
> +                        { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
> +                        { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" }
> +                    ]
>                  }
>              }
>          }
> diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
> index 7b183ae1c43..8d416015ab0 100644
> --- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
> +++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
> @@ -46,7 +46,11 @@
>              "oe-fragments-one-of": {
>                  "machine": {
>                      "description": "Target machines",
> -                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
> +                    "options" : [
> +                        { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
> +                        { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
> +                        { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" }
> +                    ]
>                  }
>              }
>          }
> diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
> index 1de038babe7..18657ece103 100644
> --- a/default-registry/configurations/poky-master.conf.json
> +++ b/default-registry/configurations/poky-master.conf.json
> @@ -54,11 +54,21 @@
>              "oe-fragments-one-of": {
>                  "machine": {
>                      "description": "Target machines",
> -                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
> +                    "options" : [
> +                        { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
> +                        { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
> +                        { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" },
> +                        { "name": "machine/genericarm64", "description": "Machine configuration for Arm64 SystemReady IR/ES platforms" },
> +                        { "name": "machine/genericx86-64", "description": "Machine configuration for generic x86_64 (64-bit) PCs and servers" }
> +                    ]
>                  },
>                  "distro": {
>                      "description": "Distribution configuration variants",
> -                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
> +                    "options" : [
> +                        { "name": "distro/poky", "description": "Distro configuration for Poky (Yocto Project Reference Distro)" },
> +                        { "name": "distro/poky-altcfg", "description": "Distro configuration for Poky (systemd init manager)" },
> +                        { "name": "distro/poky-tiny", "description": "Distro configuration for Poky (optimized for size)" }
> +                    ]
>                  }
>              },
>              "configurations": [
> diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
> index bfa67426dbf..d9f75a8cd38 100644
> --- a/default-registry/configurations/poky-whinlatter.conf.json
> +++ b/default-registry/configurations/poky-whinlatter.conf.json
> @@ -55,11 +55,21 @@
>              "oe-fragments-one-of": {
>                  "machine": {
>                      "description": "Target machines",
> -                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
> +                    "options" : [
> +                        { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
> +                        { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
> +                        { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" },
> +                        { "name": "machine/genericarm64", "description": "Machine configuration for Arm64 SystemReady IR/ES platforms" },
> +                        { "name": "machine/genericx86-64", "description": "Machine configuration for generic x86_64 (64-bit) PCs and servers" }
> +                    ]
>                  },
>                  "distro": {
>                      "description": "Distribution configuration variants",
> -                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
> +                    "options" : [
> +                        { "name": "distro/poky", "description": "Distro configuration for Poky (Yocto Project Reference Distro)" },
> +                        { "name": "distro/poky-altcfg", "description": "Distro configuration for Poky (systemd init manager)" },
> +                        { "name": "distro/poky-tiny", "description": "Distro configuration for Poky (optimized for size)" }
> +                    ]
>                  }
>              },
>              "configurations": [
>
> --
> 2.52.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8588): https://lists.yoctoproject.org/g/docs/message/8588
> Mute This Topic: https://lists.yoctoproject.org/mt/117360439/1686489
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

