Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65BCC87FCA
	for <webhook@archiver.kernel.org>; Sat, 26 Jul 2025 22:29:05 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.50188.1753568935816174082
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Jul 2025 15:28:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GNdjmHE4;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso21217856d6.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 26 Jul 2025 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753568935; x=1754173735; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/FgSWz1ISxTrXiuzkvwcmJ5D3RHLzrIDa9/CLJ/tAcY=;
        b=GNdjmHE4fOa1IGdg26sPOO3872Hvwi+fgUC3JL+n5741CJrSCvRX2w/+1jxzbu68Qn
         JD40c6/enDg6gfPfmDIxyXQLXPVqIrUmcHUHZV767IDLiGzOperg0OeJU1I51nyu9pNI
         wsEceVLqRCJHHiyF/PtbX7++sj3qYmIoHg/3i4VB2fbBFE0r5v/nVJdU4TZlyRF8NF20
         8daNHPQ27R7MnAM/Qo6d/dqcxUyOEMn0mk1uxBPP2c+4y/chqhvrMGYkNexQv+xIjys3
         GXlYoHbpYORyLKyTjCzdDcyruRd+gl8wSnGE8yghxYeKZG9gf8HCHs4+wMXPurYIodmP
         67Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753568935; x=1754173735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FgSWz1ISxTrXiuzkvwcmJ5D3RHLzrIDa9/CLJ/tAcY=;
        b=ngeSlgngtuM8EMFkS9wO9zNR4TAJ/1DXzD75YFvA+CWPwMnGsRrRqC376WA4zin8St
         VuNBKk1zmfMzERdaDN/M2s/T6JJ4zs/I92xxMIOntHfaWU1ziFMgVTixVe7q5kDw1791
         mmjGDsy/SI1m2t9azwh0DswiXLhfLbW/Ndksjxf9vJYmEXTCcdbiPL4hXqCv9/qxp41s
         Xy2GD3C6mw7NxpB1BDCL4bTgs0VcFm9R0QjUr3pGovBqEudmslVZlDoHn/YvyJ3YAjzZ
         OyfbRr53oNEK/3IrYLM/6hnAsnq4/aHcEy4CUY1R9pJyAXWFxO+G6gzKkKZ6+Gvkpvf1
         n2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWGhCgs4bD46bzST3h2Hqc78B2q5zkH+AmSsu2rQ9QnSTT8K6IQ5EpJw74KtClCI9n3ZS9MZ55OF6OgWnt6@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw0Y5gHbh5vWstqMLktWW14MhdNo+i0ohFV2iCy5K2AVmBmLSUc
	7oVVRSq4GE5HBrfvJW40gA8Vhzp2ZvnzfwyCE227qi3YLQ78O62DnRDbe1C9thz6HFHDCqDCdiF
	8TC7iZgrg/RC+IzJV6yc6X7FzCz42BAs=
X-Gm-Gg: ASbGncsGUVokV7D2+FZh/w5R69dVJFEEFnigTK+qrcfi74OXNnuscWEp/GywQrsBLtz
	ukIOd/4HkvDG2+L8ypd34i0XofWg+R845p86cG1/0iiyiccvoucql28YYthB5DiMz0oljPpKugG
	UGmLELDb+jUntOueRixDE1ypu3LERRbFjgFqqNuxZ58ZZCwBZvuJ4iloHniKbkCW4kbPP3AFsQa
	xwRaVsP
X-Google-Smtp-Source: AGHT+IFHukXplVFU0HVeJwjmcK7Rkdhx9Iw9zYZJMvp4ie74ZS6OSNmL6tajS7xr9rFwr/VHujswMzaK/7tS5dQUzqM=
X-Received: by 2002:ad4:5d62:0:b0:706:ceb6:f8b7 with SMTP id
 6a1803df08f44-707205d0734mr95630096d6.34.1753568934796; Sat, 26 Jul 2025
 15:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250725111347.1812105-1-alexander.merkle@lauterbach.com> <1855ED6D281A8A7B.1178@lists.openembedded.org>
In-Reply-To: <1855ED6D281A8A7B.1178@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 27 Jul 2025 00:28:43 +0200
X-Gm-Features: Ac12FXyML4MH_CymLQl_QZF0Nl_Vh2cf2OAyudy9eR4sPFNq-lIsvXUGVIttr2Y
Message-ID: <CANNYZj8Es5-t7DChC+jZeLRkD6BaQZarpa9VOefGFZJbVoBzKg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: forward proxy env variables if
 network access is enabled
To: alex.kanavin@gmail.com
Cc: alexander.merkle@lauterbach.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Jul 2025 22:29:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17811

On Sun, 27 Jul 2025 at 00:24, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
>
> I don't quite understand. How does do_fetch work then, without having
> to do this export_proxies call? It also relies on do_compile[network]
> = "1".

Specifically, there's do_fetch[network] = "1" in
meta/classes-global/base.bbclass.

Alex

