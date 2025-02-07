Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0144C0219C
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:59:52 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.68653.1738933190234007785
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:59:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ce3Uzpca;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e1a36b3684so21236336d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738933189; x=1739537989; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0trl9caZTKPWOSYIdjUV7JdyjoPNd4HumQEV5QfxMp8=;
        b=Ce3UzpcalyjfHFqdWu0eADuNDMj/7/idVQ++7+Z7nEcrn0cPhbOjffToUK44UVrAJA
         8H1waXH6B6tWtNREUH+i5XyhsiR9KKJ4G1S/1ie17dkedwrhZjNe22k51Qj1mgqKqLEI
         BmvrKCty3Bo+XKBDha/qG5VWXn7VbOgomZy/SkDOsQDjvakgYnPEdSKFQKnnQLLlPW5/
         /90+fpJs6Bb0QN1Xm5fjCKwvJFYJifeaVrhF7+tfBCUc/GYyzN49fwTQJbVG4X+tA8AY
         CG4j5+zR+LUWhZexI4/SuTlroqm7GPecoU30ca9sVtsthWFEN/Zyh+rSSwWuhid6ZUV/
         AlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738933189; x=1739537989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0trl9caZTKPWOSYIdjUV7JdyjoPNd4HumQEV5QfxMp8=;
        b=L4onsobFvyh+MQJ0wnuxHSxEiHKn51BuB7o/UTdPWwbrXNQAWj7Jklc6tX7OfYlYqv
         y3lzBdAhFL4vLYk73AstKQe5X9+p/V047N2wD1bNFjrArEw0b105ZcqvYNeSueU5wF7y
         vvtCmJVMmZMMttuBIZX2csdvvkaDo4NKo45wO7E43yodDgzIb1Xu9frALtCQTCqdnmzQ
         A/o+n5SQa+Vu9V0Z9J48QuyvxM1xTfw9r/5V7McH7nlrJUulD75tnuAkk8V3h5kpqpg0
         JHa694F0c/9uNLy0CehPoUlh5BpOp04eztV9HHSOWC1HEv0d1mYFlgSK2EIOpvNgCgYv
         wpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbxR+MxKCZMrpur5t3LPoVGl7RHxXPeyvzSuvj3D+H3PwktrcF1rhIpx2cYsw7Hlw/jHECuVri6jRUVSbC@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy8RwFvisPGpyHlBFsL3ILSvDeRFAywk6nOiRz0NUBgUoZbXycw
	0l1H10MryfPG8DHWOaBPXiI+y+tDozID8H35FQXWPxghNmHJL3Kde52E2lDbiIUpdwqAB3s4GlB
	iz9Lg8dcpytrdCN6WmvdxVnSPcta4Mg==
X-Gm-Gg: ASbGncsQc+xh593GucVpCTQ+Hm4jQrE00zRA4eoQrLBL8vtTeHPNMrtD8aBV3n+4CXc
	ISuc+Tmq1xS7VICZWENcwrPZDTCZu7/ywJ4rWSTEtwvYCQ0yxItSC0fFajP56nm3l7nEAbCzUaD
	9LcCdJFNTTG05vK4q8fIojmLCOm34ehvE=
X-Google-Smtp-Source: AGHT+IHPgLMGb0urY0jtZ1Il/yfxaM3mf+4DaCIafDrg6buz4GmzPtt7lI/+807tdL1A0r/D1etrb3vihhUbEsfTedM=
X-Received: by 2002:ad4:5d6c:0:b0:6d8:d79c:1cbd with SMTP id
 6a1803df08f44-6e4455fa8bdmr40773016d6.15.1738933189308; Fri, 07 Feb 2025
 04:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
 <20250129112406.1660522-3-stefan-koch@siemens.com> <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
 <1821E627D6FBF186.752@lists.openembedded.org> <1821E75CA5CDE51A.18160@lists.openembedded.org>
 <1821E95A02BB5E12.752@lists.openembedded.org> <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
 <07ed332ad4733a7a4d5160b390124eb3053266e6.camel@siemens.com>
In-Reply-To: <07ed332ad4733a7a4d5160b390124eb3053266e6.camel@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Feb 2025 13:59:37 +0100
X-Gm-Features: AWEUYZnb2VilJR6__vmgqSZh7dvQQ0Qk-e_klyEq6qKamNtuVwsTIGQpb59oZfE
Message-ID: <CANNYZj-aKm-A14gv3eAjbPUj0UpbqBecvb+o_xmFhW3DfoCtdQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: "Koch, Stefan" <stefan-koch@siemens.com>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:59:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17184

On Fri, 7 Feb 2025 at 13:41, Koch, Stefan <stefan-koch@siemens.com> wrote:
> I have made the test with BitBake 2.8.
>
> So the commit
> fdc55bb649cb77456d0ac48a9600ef289a52af18: checksum/fetch2: Switch from
> persist_data to a standard cache file
>
> is not present, there...

Then you could check what the sqlite database file in cache/ contains,
and if the needed revision is recorded there.

Alex

