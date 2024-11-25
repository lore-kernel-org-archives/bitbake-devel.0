Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5301D59D70
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 21:00:26 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.29685.1732568420097168737
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 13:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BCNh4sLt;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d41ec318eeso35689836d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732568419; x=1733173219; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GYbB+1sL6dCv4X0eEjKwkwNJMhMUxnXbkeBNjC547A=;
        b=BCNh4sLtg8XtvqOnDc805rXnuUjwnp28yYVvzZz8RN2ihHrjhl8BHXnk5TOXO1187R
         F5MFQ/nmBGfgl5oBxmVf7++xhw8RrgXbm5NZQpB1Kn9LCBhnhPDsvXLroxCWUQncbLwO
         TkhifTCVcFHFETiHV7WBBRE7ni+Bozcay0uztPN8LAwlsxf4MRopjHvzImMpFE6LlDxf
         hxV2Mxt2XVLOu3+xklf/n8sPGqEadytyhrbCMi5sVnSL/1xEkizacIJLJr4G18IYQVzk
         DqBzsgp2a/erRHkOju6F7WI7s137qRcN5adbm3cIfzpz+BO9waVmMThgc7mLCcmcsh9j
         BYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732568419; x=1733173219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GYbB+1sL6dCv4X0eEjKwkwNJMhMUxnXbkeBNjC547A=;
        b=AeuZFD2cCVF9VOi5eWHinOKI9jQvAZrRqDAIB1dOwQIWiAMghMiUl6HbC3o9BjS4rZ
         1ObGrHt2HWAT+xU8NZSf1duUPRfxyQuFoUwIxlPCfZUOZveQDHUd0z8FvdazEJ6PibKK
         xsmemKyoCxjfv0rNs80EcHKBJX9GfPFeWa+GRxbavBa81puoHsFmh5Rh/MnSHyaDFncP
         PcS+Kl9fs0pc1HHtM5STpaUIMs07bCUH/ynHl13a1ZxLh0M59f0PaMPwz8cF6sC89Acr
         /+m8f3ZDPJ2WVw2JEi2WnGy1xi1VdlBjK0WPJmxtfVi4sFG5bkLeQvnuRjBC7SpGTfvg
         S4LQ==
X-Gm-Message-State: AOJu0YzMuR5VIulZBZpqxblC/F9TkU0pjQNLgUQ0L+JdY5D0HnZcjIbN
	cvyKX4Ms4Cjlq/3EeCh1/DIiaHVsd0C965DpKsBTUZYAqNWsPfWGg2+F1GL7ooYpRN4Q8r7J0r5
	PPhzVftD5J06dB+HZox+lxja8ID8hnw==
X-Gm-Gg: ASbGnct7qZV6jg+SU4nu8o+XOSD1ykKGTjBaHr2OoM0P4hQFoUv9FxW+nRQKcpezgpC
	7+ZUP0zMW8KP5AB78sYnWGb9bPrHRD9VUTv1W/rbvVSpfOc6yQFzfCulCRHGCc/Vbug==
X-Google-Smtp-Source: AGHT+IEnHAT71gERnmVmW1lWM5Jdi/pNzNE04vZLF/GSMJ6v7786ysIkTihtUZ9a9GsQWyDGRsd3YPLy5veQyhZHDIY=
X-Received: by 2002:a05:6214:27ee:b0:6d4:1e43:f3a0 with SMTP id
 6a1803df08f44-6d450feb18bmr213520696d6.27.1732568419176; Mon, 25 Nov 2024
 13:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20241118162610.1423384-1-alex.kanavin@gmail.com> <DM8PR12MB54306FC322E76141FE4E05388B2E2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54306FC322E76141FE4E05388B2E2@DM8PR12MB5430.namprd12.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 25 Nov 2024 22:00:08 +0100
Message-ID: <CANNYZj_4vEXMz-hcS2RijnycFJ48BSnHYDVHvn2in7dF7BPXoA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] bitbake-layers: ensure
 tinfoil.shutdown() gets executed when tinfoil.prepare() fails
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 21:00:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16835

On Mon, 25 Nov 2024 at 21:50, chris.laplante@agilent.com
<chris.laplante@agilent.com> wrote:
> > erroneously moved tinfoil.prepare() out of try..finally block, where 'finally'
> > contains a tinfoil.shutdown() call.
>
> Why not just use a 'with' statement here?

Perhaps; can you send a followup? This already merged.

Alex

