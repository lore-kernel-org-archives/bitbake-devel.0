Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C344C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 13:24:59 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.10417.1737120290815093739
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 05:24:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FwyCxS0T;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dce7263beaso19812096d6.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 05:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737120290; x=1737725090; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dM8ZZ8YbFUCv1/mx6pXEItFV0mIobEq4iKPUoHtEo0=;
        b=FwyCxS0THmDlJ2qDQsOdgkXSEoyoPO8pJEuJahjmduJJllljuPmvzZfm+P8Mbuc37X
         hOURD/arc10R58M24Vnq7aM/8aZM//WMGTDGVgg1kE9MxbiANB80dLqhIVWJAdyl4YDd
         GCo6udgvoX483lSFf3T5jZOhv+Qh11A7Q1tCFU1hEHdSmQNoHcjnyTj5hE0vaMLEq/yo
         lBiUImidNuM+/1Vo72uAVepMdZ/Ij0WdbhvHS8z5y3ZbxN9a1I3o8crHx65KLmMimwVS
         dWQdZh8mk+jmcQKSayhHeYOtZfOC91W1TdZgPiHRxmwNP8gOhlWLTD7y0t+U1BaDMuuW
         Umjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737120290; x=1737725090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dM8ZZ8YbFUCv1/mx6pXEItFV0mIobEq4iKPUoHtEo0=;
        b=GFbNJwwrwogvtYqq+NkAdaC3R7IUMrFaMZdKxmMXRC1m1Ukm+HulfsxnoaQHdzpBO3
         B6jBKwRFOOyARMMoW7FYXDMd/JWrvcafq+DephKYiWU4/Do8+BNlx4lVhuqjh3Qzm8ZC
         R610vdHv+usVvOuh1/+I9Dju5lpfpr2wY0EOoZgF80qYQC39p8sf7M7bRmlQTIyRRf4P
         WGdjmgd3SESiMVcqpTz2dmSJzBDRgnLkBwdkt4pESwsLNu8ZS3qYyC0vOEWhpVpA29zN
         /HWyUPmpVgnx/L10vxOciGu0qqSRjExVSjMmIH8z4cKOD6MvzcypqHi5lPQmsOHXvMPf
         MSuQ==
X-Gm-Message-State: AOJu0YxuKMQZo6q5HgFSS0HsxG+y9xyvItIFf0h9Jk2q1wnC8+N5ELi0
	xDERirRSZHJucY0QhpQVSLx6CK5VuryR0gtslrerHtQKRwEChxPkMmcmK2bw/kgcwDrtiLMlKMq
	1PkEBpY5Zd9GsDk9SQ/7kFdb58+Q=
X-Gm-Gg: ASbGncvHpq3au2KJYuzbqC83dwd5b5T31mX048wZ7oGamT8Sm/RL0uGMEI5j3HBB7Vx
	xZQ9cqyoQ3hF1Kyv0YIJ/Sr9kArb1yGEguhk2KCyet7D9CS0Pz5EsRZLPWnc9Q/BJO85Dxnuf
X-Google-Smtp-Source: AGHT+IGdA5vCMyZuKom5NYpAeaZ+/ZF+UnY0pjqjgpk1YwFilgkRsO3uYRupVpnBk+zmXolUtrq0S0Fq//d5HK5SNPo=
X-Received: by 2002:ad4:5ccd:0:b0:6dd:dd0:764 with SMTP id 6a1803df08f44-6e1b217e46cmr46408806d6.17.1737120289818;
 Fri, 17 Jan 2025 05:24:49 -0800 (PST)
MIME-Version: 1.0
References: <sHHJ.1737118955583729476.ujxu@lists.openembedded.org> <Z4pYLs1mXZPG-aG9@nuoska>
In-Reply-To: <Z4pYLs1mXZPG-aG9@nuoska>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 17 Jan 2025 14:24:38 +0100
X-Gm-Features: AbW1kvbw79f5UQfXAB_LF2Kn7RofdddNLgeJbaSmFWo34vlQ5SqAjxGKtl4ZlaU
Message-ID: <CANNYZj-U44qHKd+BHAg7BbgTrNYe8YqYScyexaS5aQbt62PStQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [scarthgap] Gplv2 layer incompatibility
To: ganesh.manoj.mahajan@signify.com
Cc: bitbake-devel@lists.openembedded.org, mikko.rapeli@linaro.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 13:24:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17031

Also please use the correct forum, such as yocto@ list. Bitbake-devel
is for development of bitbake itself.

Alex

On Fri, 17 Jan 2025 at 14:16, Mikko Rapeli via lists.openembedded.org
<mikko.rapeli=linaro.org@lists.openembedded.org> wrote:
>
> Hi,
>
> On Fri, Jan 17, 2025 at 05:02:35AM -0800, Ganesh Mahajan via lists.openembedded.org wrote:
> > As we have phased out meta-gplv2 for Scarthgap, but my system needs gplv2 and also i need to upgrade to scarthgap. Is there a way to have both accomplished.
> > I am getting below error. When i run bitbake.
> >
> > build@ubuntu-bionic:~/project/build$ bitbake
> > ERROR: Layer gplv2 is not compatible with the core layer which only supports these series: scarthgap (layer is compatible with dunfell)
>
> Remove dangerously out-of-date meta-gplv2 and build your images without
> GPLv3:
>
> https://docs.yoctoproject.org/dev/singleindex.html#images
>
> This can be done with poky, but may require changes to the SW
> components you ship on images. Details depend on your setup.
>
> Cheers,
>
> -Mikko
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17030): https://lists.openembedded.org/g/bitbake-devel/message/17030
> Mute This Topic: https://lists.openembedded.org/mt/110665090/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

