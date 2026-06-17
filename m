Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F528CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 13:29:14 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15417.1781702950674323601
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 06:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=drtfE5IC;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df49c5fso88105336d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 06:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702949; cv=none;
        d=google.com; s=arc-20240605;
        b=MUSIpGSb2A55J/KExbblvBQF8TdoQU/PEnD5e3J+DcEXvZrhcho0Xn2bKPF/683m49
         lBx0l7SyUUYLJvvjfivdguKRb8oRgEaxrMbrCD4mg72yIompO1h+uXEZlAWjfDTzY3th
         IuvjzaaGOgqNk8GarqLxMTfqTAH7yfcPxypSWIWmcvqWDkOrW01QJ/hKDDYH9a+/CyN1
         O3Wkl/xNitt8VOyxb386oYErEgrwS5rWvn5ZG0Y9fQw5C23XxmjnnxSOxpeQhY6MnyIy
         4FEUoCeB8fjPLRKjab+6/YfQ2wa9SM1CmRIl29CFuFXbUDw3SNmLHtj8Uo6jfyuBxS0n
         3Kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MqomSAIj0AGLIMcS7EOyZt0QAAk97FfrlzyonYgmqw4=;
        fh=ko0as7gY/UfLSYX6PbjmttpCEN7Fc8BAaCyHmPfhGyc=;
        b=gAbqArj7pv68Ie+Zr96a7aHAYKXP5NIKu6a1Vi1VBgnt864VkcJPZvqaDUGaqTXYPh
         r3s62JiPMlQA6w0QKqh2gUGQAQKo93dUu/xT+3vJVClWadKiqTeFZAPMuM/cVxSf6xoV
         pzigDNH1M4p3FPnxeLMXJyM2vpZJkZu9acHHUNZGWhzb8fMzqTBQpYysh1+PYmoQ2ZwF
         TXf59cNVt2PEAEmKuL2tp54K8OGAvA9rRKJUN5o47ZOOxSPjhYxl8Q+CzzsSeQMuGXSH
         C0Yt9s8RvhhAQos1x+RoZzmj8SuNzaGarcIXo9bKxQ1avG05Ub7ofiNXq+WdDThMw1Wp
         d82g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781702949; x=1782307749; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqomSAIj0AGLIMcS7EOyZt0QAAk97FfrlzyonYgmqw4=;
        b=drtfE5ICccyRJ4gtooI+0G2RYKQYlNzXdI3WMgKu4e3HWY1WgdOZUAqoXCjFRuqugH
         JRUD1Lgt6NnpCVEWJjdGhXlm0/THKu4FP561puLgBrsdtUeuiFVdoYnHR2lIt2S0xX/3
         7cJNy8rxzeqkzbMAcZ4Sz+o7A75YPKWHmAIMl3XIv0wQDG+BHfpECIxi6tB65PoX7Luy
         c/eyxBrKXUafUXnwmOg/V059iIqQwbDdqhsBf+TRBZJKpyuaYN7lVCTLqV3O7G7N+MX2
         nsjMcfPK7/FYEKW5yP04jAMaF0rIXz1Ichc8DTV8aczyEy+wmIlw+Dh74cFKo3qTq4M+
         Hgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702949; x=1782307749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqomSAIj0AGLIMcS7EOyZt0QAAk97FfrlzyonYgmqw4=;
        b=I5aYEBBGWgEicUGUP8FI02CxCojDXHfadLitJFzlCDW4aKAxYWWsux0wmc0phG+g5i
         Wpfbmq1iaL8g2BwBfdnYkUes5nQk0ph+FZvopy98RvAGR5U3NG0RVwUMS3BHMv9sGCvP
         MUdA1RdNe7Du7CPqDvx7qOwsl4tGVQHJXGpKEXVprAPOBR1kaM82LiYTR2WVW9uC32UD
         ZOmEaeMiPUC53x/FOt8xZDuHm1kGvYzPmUicVGw3IiuUcfdenHnT0mVmDMjc9+HK3V3c
         igk8FsQujro4TO9ERNx0z6Gar+PApLwK8aHzUdGD8aq/ySnQ06Z2nKUATugaB61jm6v+
         3m8w==
X-Forwarded-Encrypted: i=1; AFNElJ/qcju1EduaWdYBGbDat+tnkZb56q7hMiOpZmNB5KIqn8QFq5IiyuRB+L6QM4ouCoiUTQrzrYldSuhfZ/Db@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyd7QLqUfZfl6JDv8ttRBeFZl2hCtLGgR+rFCzMm+A9nqtM3igs
	METZTVT7Chl8hTF6uN+Cv4GY0dEb9hO3ueVxP7spfA3+zhSIr4/U0W9cEvK652+qlj+eFmj5DCy
	oyUi0AnHjg7ULRG6s2R5Rap+sweBBgGU=
X-Gm-Gg: AfdE7cnvbkT0OESfO4aRhVow6Hf6WwBZ50P2pfl+u1tXxle8SWFz4NpRMA4sv02Lrtf
	F/2XjwPBVxi4H08vCtc77M0C7XJ14fRGPFc9rw0lpFNBmBZGv1SfSPr6VyUjzpZlYWZRXEnhp4V
	eZQVKwlM+rlWDTMkh7NzOFuHQWTKu/8Op+GEzh3x9j9t3bIgs5vwZj9JmnmNX9axxmLlVUJMu3X
	wwskGoPCc/mS4j9nIrDJNo/w7Zil/U+RdnZquTbJjCwpGLngdv6mfObuFVS8AKEPW4DnPgXizWU
	qkUzkpmqYGVLpusMLvCYZHQ6jrPRfI4=
X-Received: by 2002:a05:6214:3303:b0:8cc:ce03:c017 with SMTP id
 6a1803df08f44-8db5a72e2acmr66499056d6.9.1781702949330; Wed, 17 Jun 2026
 06:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <4beac8227f89f57e5ae0984a5163685132577583.camel@linuxfoundation.org>
 <DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
 <CANNYZj_j7irKNRdeGDpF6mfKit_78ML5=XQJ3CeZckcM3924ZA@mail.gmail.com> <GV1P189MB2954EA1ACC412797B25F889DF3E42@GV1P189MB2954.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB2954EA1ACC412797B25F889DF3E42@GV1P189MB2954.EURP189.PROD.OUTLOOK.COM>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 17 Jun 2026 15:28:56 +0200
X-Gm-Features: AVVi8CfSUajMNUS3ybmhURnWVKvN6WjUHf6ONfoxjv1qg_eFPibHoyP4i48SjnA
Message-ID: <CANNYZj8ykta1MHGCHkOvNsZ7UZdZ8F0YgHsFBMSYPpQ_4bnrHw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
To: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 13:29:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19727

On Wed, 17 Jun 2026 at 12:30, Jaipaul Cheernam
<jaipaul.cheernam@est.tech> wrote:
>      Two options for install-buildtools here:
>
>      (a) Update install-buildtools to handle file:// URLs natively =E2=80=
=94 uses the file in-place, avoids a redundant copy of a potentially large =
(~500MB)
>   installer to a temp directory.
>
>      (b) Leave install-buildtools unchanged =E2=80=94 wget already suppor=
ts file:// and will copy the file to temp. t requires zero changes to
>   install-buildtools, making this a bitbake-only patch.
>
>      I'm fine with either. What's your preference?

I like option (a). install-buildtools is in oe-core, and can be
changed if there's a use case. It can be modified to take a new option
--local-file that simply takes a file path and doesn't perform
checksum verification at all.

>   Config format:
>
>   "install-buildtools": {
>       "url": "https://downloads.yoctoproject.org/releases/yocto/yocto-5.3=
.2/buildtools",
>       "filename": "x86_64-buildtools-extended-nativesdk-standalone-5.3.2.=
sh",
>       "sha256sum": "a1b2c3d4..."
>   }

url and filename could be combined into one complete url field, no
need to split them, as they're not anymore given to install-buildtools
script.

>   If sha256sum is omitted =E2=80=94 bb.fetch downloads with a warning (us=
er's choice).

I'd say absence of sha256sum should be a hard error, with a hint about
how to add the sum to the file.

>   If sha256sum doesn't match =E2=80=94 bb.fetch raises FetchError before =
install-buildtools is ever called.
>
>   Standalone usage of install-buildtools remains unchanged.
>
>   Does this match what you had in mind?

Yes, more or less :-)

Alex

