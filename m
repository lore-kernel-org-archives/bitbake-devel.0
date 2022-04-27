Return-Path: <jupiter.hce@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C7AC433EF
	for <webhook@archiver.kernel.org>; Wed, 27 Apr 2022 22:09:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.2863.1651097350849888725
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Apr 2022 15:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=R19fKexP;
 spf=pass (domain: gmail.com, ip: 209.85.221.48,
 mailfrom: jupiter.hce@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id w4so4272411wrg.12;
        Wed, 27 Apr 2022 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XNtcz0rXpid6NVRrG6mNduP0hPhzfSNSV247HBxd8sk=;
        b=R19fKexPXhHI87OhcmPeiaQwZuolqT9TaIwmHSxgWSHYC81iI7T6BnZRIwLHtDt4sf
         6+P0LQIlNy98ZWPE9p3YFRG1Dmon6yOqNX3hggisRKLvQtyps5xFSNCybSuU5z0MX4Ax
         vmNnBiWOqBQ1XLGcqXSzwlAYF223Mir+KdeebWH2YJbUauxtMiJM892jsgeVEHcR1buW
         GuGfWi2XnG0vl7x++hL2UJUoMafzn8h/a779pvF479tyDdy6JjxJZxdeT+MMysYt7SeE
         jsV65yS4sZA/pASmJVf8HASeB2XWDnfjloab38w4AcMSMflcDnA8WlEyHiYeGJCSfAWl
         NHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XNtcz0rXpid6NVRrG6mNduP0hPhzfSNSV247HBxd8sk=;
        b=bUfvZtNDCa66UvxRWn4yyfkqVenouElBqV8nR7FfftLPzB1ubOIEluBvnPwe/ZMeGD
         h6rU8PGHXoiMnbYyHjN1608U7WybpjElr2MZew5UnRhLRJn6itMlu5s6P+7pD3Uhi81J
         kTxQ475X94VMdAENVjvCvScSuy7tnm5shSAeApN7A3hPoWZitUKxLYWj7S786IDoahTe
         osVsKdNHvMFTCv1Sdzw6VAIzu45Q/XPkaPtSI/N2Sps5cCVqZlNXqkf26YXP/tdUTrVw
         k0Z1BhtpbseK07oR6NwkAVxyNPD3gBeh2hJ0YmNv5LcghVvZuhubc7Ix8KILVfEHXeUS
         BAMQ==
X-Gm-Message-State: AOAM533MtzQhTyFzVvmjd7Xu2t4Vqjek8anH3TfA9lfmE9Z2tgnPr45E
	gMSAYDr952CbRJyACjIttoKy+E7A5X9L55sU9z+lgVck
X-Google-Smtp-Source: 
 ABdhPJz4Bzqc0YOc6G7VW+YkMHkWXajN1xXF7vl/8OEUWYARRa0qmnehLbTvHWuyfQqKpG/CNgrEWZtLYn1ne6dBCSU=
X-Received: by 2002:a5d:4e08:0:b0:20a:f065:7024 with SMTP id
 p8-20020a5d4e08000000b0020af0657024mr3924006wrt.598.1651097348023; Wed, 27
 Apr 2022 15:09:08 -0700 (PDT)
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Date: Thu, 28 Apr 2022 08:08:30 +1000
Message-ID: 
 <CAA=hcWQDJ19JkCL-SMhkkzSJ_1ZqnP+JfFE1uzFOyTta-HpBZw@mail.gmail.com>
Subject: Honister customer defconfig replacement doesn't work
To: openembeded-devel <Openembedded-devel@lists.openembedded.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Apr 2022 22:09:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13662

Hello,

My apology, I am not sure which group is working on defconfig syntax
for version 3.4 Honister branch. I posted the question to Yocto list
without response, let me rephrase it again:

According to the Yocto document 3.4, out tree customer defconfig can
be used to replace the build/.config, I used a working kernel
defconfig to disable configures, I tried many tricks found from the
mailing lists, but none of works for 3.4 and branch Honister in a
kernel build bbappend file to add KCONFIG_MODE = "allnoconfig" or
KCONFIG_MODE = "alldefconfig":

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://defconfig"
KCONFIG_MODE = "allnoconfig"
do_configure:prepend () {
    cp ${WORKDIR}/defconfig ${B}/.config
}

It still generated build/.config in do_configure

#
# configuration written to .config
#

I changed to:

do_compile:prepend () {
    cp ${WORKDIR}/defconfig ${B}/.config
}

It still restarted config to generate build/.config

*
* Restart config...
*
*
* Kernel Features
*

I added unset KBUILD_DEFCONFIG,

Is it possible to disable KBUILD_DEFCONFIG and to use customer defconfig?

Thank you very much.

Kind regards,

- jupiter

