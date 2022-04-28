Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86BEC433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Apr 2022 03:21:32 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web09.5730.1651116086990137395
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Apr 2022 20:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Qsw3qdD5;
 spf=pass (domain: gmail.com, ip: 209.85.219.169,
 mailfrom: bruce.ashfield@gmail.com)
Received: by mail-yb1-f169.google.com with SMTP id y76so6791755ybe.1;
        Wed, 27 Apr 2022 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOjSFtvlZ3JUw2toaynOFvsqjJaxFWV/GKlro+CGbPQ=;
        b=Qsw3qdD5qY+GA7x6MLvbIk+MjJHR1zwR9mPekZsMXOro3a7D9+y0gl14DVPcIZQjuV
         f+Ttwi3xOUO4Jry9dQ7Y35Wwyut90aGp3l/7oYVcu1t2BYYXLBS967fhCBpe/CVeAreA
         IAO8mRDIPKECN26MTJgYug2NsETBTcbGlb9j9VCRHcGC3oJjz2TziqAaLSdWGb8Cwe5A
         reJBk9pZjR5OK2aqvDFXbZ+sNwNbzcPuOBll2Y1BlhY6nNibWiX2wUvVuMia53JHebL6
         BuDoxwPiFqCbFM4zy2W5764RnsnYx+U9SS3n1nTCW7cYqE9I8eXpIHUG8L95+s88hBNq
         2TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOjSFtvlZ3JUw2toaynOFvsqjJaxFWV/GKlro+CGbPQ=;
        b=FfRZAKZ3/7499/VlQELlHi7LV1UuCeCv6QbnDLWi6drL2yNeeiDWx98wNXz59oxag8
         MsiEi8g/zuewbphDs0kjU59Wkop/FgFEL4EIXdZvrg8PRHU0Vn6URYdalmb4qYJf5swu
         g1E79SGelkTom0Of1810u3fYfNBpyBj9u/WYqO0qjt6oz45ryrEQKN7RZ6JEY7RNMaBm
         w11ZU/cUYcuMU6SDYdf4KYriKq9hO58AYZ1Z8ng/xJvXXF0fES87gMc7FZWMZepX9jCD
         3gPvw/2cGm1SsrY/mdilQrAOKUxg+rcf4k+zQchpn8a8yjYR/h9kVy7eB10HU/HgicJK
         Lw4A==
X-Gm-Message-State: AOAM533m17OCGYhQqpqLQH/M0FhtCLewHKUDCMyywbXgm5cAD+Solms+
	s3obPxtTEbqJoooAk4f86EaYVQKidEXXLbgFgS8=
X-Google-Smtp-Source: 
 ABdhPJzK02RxtVwZEw8xmcnKBCKeIWsjO+7vW25pTSBZKFOMX9D+SNIUmWip8xfpAg16ZTcCIG76bBi3InfNRmSiZmE=
X-Received: by 2002:a25:8a83:0:b0:63d:a537:2e8c with SMTP id
 h3-20020a258a83000000b0063da5372e8cmr27321710ybl.131.1651116086048; Wed, 27
 Apr 2022 20:21:26 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAA=hcWQDJ19JkCL-SMhkkzSJ_1ZqnP+JfFE1uzFOyTta-HpBZw@mail.gmail.com>
In-Reply-To: 
 <CAA=hcWQDJ19JkCL-SMhkkzSJ_1ZqnP+JfFE1uzFOyTta-HpBZw@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 27 Apr 2022 23:21:14 -0400
Message-ID: 
 <CADkTA4M6==DNTvN4T48pFPwSzPTuAM-vQMUdu=EYsOgCB-235w@mail.gmail.com>
Subject: Re: [oe] Honister customer defconfig replacement doesn't work
To: JH <jupiter.hce@gmail.com>
Cc: openembeded-devel <Openembedded-devel@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Apr 2022 03:21:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13663

On Wed, Apr 27, 2022 at 6:09 PM JH <jupiter.hce@gmail.com> wrote:
>
> Hello,
>
> My apology, I am not sure which group is working on defconfig syntax
> for version 3.4 Honister branch. I posted the question to Yocto list
> without response, let me rephrase it again:

oe-core/yocto are the right place to ask. I can follow up there.

Bruce

>
> According to the Yocto document 3.4, out tree customer defconfig can
> be used to replace the build/.config, I used a working kernel
> defconfig to disable configures, I tried many tricks found from the
> mailing lists, but none of works for 3.4 and branch Honister in a
> kernel build bbappend file to add KCONFIG_MODE = "allnoconfig" or
> KCONFIG_MODE = "alldefconfig":
>
> FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> SRC_URI:append = " file://defconfig"
> KCONFIG_MODE = "allnoconfig"
> do_configure:prepend () {
>     cp ${WORKDIR}/defconfig ${B}/.config
> }
>
> It still generated build/.config in do_configure
>
> #
> # configuration written to .config
> #
>
> I changed to:
>
> do_compile:prepend () {
>     cp ${WORKDIR}/defconfig ${B}/.config
> }
>
> It still restarted config to generate build/.config
>
> *
> * Restart config...
> *
> *
> * Kernel Features
> *
>
> I added unset KBUILD_DEFCONFIG,
>
> Is it possible to disable KBUILD_DEFCONFIG and to use customer defconfig?
>
> Thank you very much.
>
> Kind regards,
>
> - jupiter
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#96814): https://lists.openembedded.org/g/openembedded-devel/message/96814
> Mute This Topic: https://lists.openembedded.org/mt/90741694/1050810
> Group Owner: openembedded-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/openembedded-devel/unsub [bruce.ashfield@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

