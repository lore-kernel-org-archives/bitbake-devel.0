Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDCE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 10:50:58 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.45398.1736419850758555285
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 02:50:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BaMOxoam;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8edad9932so5167796d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419850; x=1737024650; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqBplh3iyRwKqKE1DcMzuknujLe8PRbxbw1yadidrL4=;
        b=BaMOxoam1O8JxxKXIfANamMlNscEx2s+/ktRdglp3weeWGn3HKHcmpET0n4OFwRpeb
         tdmjVJmjCTs9Lkr+ioVln3ptlx6lVIAoSSrd2mk1wCP2VdkOtM/ocALjAuRvfrxrMB/X
         lloL3/GkNYVObhqSj68jcADGKgPlz0bwpaz2aDQVqNSX6K0fTFE/MIAPKAixX3ZKZ6RS
         iVsQkVxJYSj2VNwyvAl228vQh/K5GrSdhf9KTvf1YJrEWLYW/f3MMuDgggLptXkHav9b
         QFoyNCLvPdMF/WZJKAfigq1RpwWg/ohVOB8nUtomLJgHe0mnHtmAG46OZk/MilteqJ41
         mUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419850; x=1737024650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqBplh3iyRwKqKE1DcMzuknujLe8PRbxbw1yadidrL4=;
        b=WjwEINzTZjcvzeJ+ZFlTxe/ymgxYulH4nCouW9KL18zMhbrKwBoXusNefGk62VOC0x
         wPwpJSCQu2hOqVR9VU2l8OsqAj0ZvBRdNvOYodYYaBzv7h2oHZ5+rgjJ0Ym39uJjQOOI
         +SOIXUk0JoV0QPr0UySjfshN4vkDhglQude0S68rP0f+Xx1s/hBAHxPVAFFgOK9vOtIa
         w4sdzLg1O/2z9BGHMIv6GJx8sc/afjPwi1T5k87kpERA9Yr2pcm9n0oTZDxUkSnfvkCz
         Sxf5/Opsj0n5jfgEoBy6ro8XZXUOXHqR7UXw3izsT/t5VIpWPdF2BNvq8c0Oa3BztCSy
         eTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZ3InQdhbEEeJjzuh5///dIqT2ChjdVP7Vi7cNzG/QfZT8lMQsFCnZGG0tLUyRYZ/3ZOSO29SUD7ssQz+@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy4iHnGK5fxnlKClEdgORAR5+Zzs4VmUzQ9LEs268Bi30Aq/f28
	LmQ2gHOk7BPRUdKiMFCvjQJCzKmJdRkr2OSTK4u7FQh44HHIJB98U4WhtVuHk+d3g7F5bOCkx+M
	puMxE2uUhgdBM0bHNajHjXuwiM5k=
X-Gm-Gg: ASbGncvajOS59tExFSODWmX8Y+n2VceQN2w0nMq6o17lxxN8Q0/L48+Zyche5t3PbMH
	hyBasLApmTfqY2I9HW4oVKNt1PYss/TP0s7ZTFQz+j0F4mE8JB6Hk2BcpXz0EqSQGvTG1Q9yv
X-Google-Smtp-Source: AGHT+IFV6EAdczb7atuivt93gkjWBepX+fZhOV9ZF8l4y50Cft9SVee+Ka4JzO76KwD8Jv2waXi+bQBv0hhV9l70uo8=
X-Received: by 2002:a05:6214:3111:b0:6d4:2910:7f13 with SMTP id
 6a1803df08f44-6df9b286032mr104610086d6.32.1736419849812; Thu, 09 Jan 2025
 02:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <18190013516DD62F.1999@lists.openembedded.org>
In-Reply-To: <18190013516DD62F.1999@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 9 Jan 2025 11:50:38 +0100
X-Gm-Features: AbW1kva670rVQ3C40z1p96kv_nPWdDDx8e9CjJmxrTEDBC6A7-vtaftGyYBwSJg
Message-ID: <CANNYZj80Vphpyw5fe74RV5k1fxo=QxrGahbcGy+vDJiu+c1c9Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: alex.kanavin@gmail.com
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 10:50:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16993

On Thu, 9 Jan 2025 at 11:40, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> This is not a theoretical concern, I'm thinking specifically of
> log4j-like vulnerabilities, and how one would check that their product
> doesn't contain them:
> https://lwn.net/Articles/878570/

I meant to say 'yocto layer' here, not product. And ideally it should
be possible with 'static analysis', e.g. just by looking at the layer
content.

Alex

