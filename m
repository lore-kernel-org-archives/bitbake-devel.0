Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B8CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 10:08:51 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14467.1762250926301685499
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 02:08:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RG/lZFFJ;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8909f01bd00so631531785a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250925; x=1762855725; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvlt/EQqOSHl+hV4quABbJ4CznNg1ed7HxKWd8SMVYo=;
        b=RG/lZFFJG6L/BHcGmn9l0jJVxQKxCzTOLqxeNYF8Oduzk+pEmgifUHt2+/y9pZ7c0B
         +WGsmg0xllEooLznaaN1rRyIs+yV5aRUOa5p79QUjl7lkkfRSyMiT4uAZuUizYLYAI0i
         PGANG1NWFQb8/1XZweJH4ojTyLhCgBWSeEHPczhQjcRKfM1unJeQ2UrdVh237b08ur76
         uTXyQCp8f6up5Wo4uQ4qxVnfKKZ/CTNLaGYbKwiIsxhf1ekF4Kz72a63kgIkv2HJh/D6
         bXBOKtztR6grO6ACMZ8/LgwcoLXuo1mK6veyWQWVEg/9/vWfbEBd0r+vDi+cHSewnYOy
         R54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250925; x=1762855725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvlt/EQqOSHl+hV4quABbJ4CznNg1ed7HxKWd8SMVYo=;
        b=l+yJLgnRpdvfaONd+ll6WOTpA7c4N/rBBLGZj9i28h7PTvGQt2PzYJBt6bpnjR3EN7
         mHfzngX5EuTBQHOnPZhk276MP4siHWnJ+CD1KfePlOJxwTm4IPD7jN4/LNpzVR16Wp+v
         FOini5VB9fUUAECbqfw6pW2/ZxLRieQ5WC+5cu04kjLPkVfyMwNl051/to6du8Jq3lWe
         DJiRipz5T6XxqFh63JhhXHwvqe/1geag+K7qb6UTFTH5Yc/1mgl7omhlD10k/k2tG12T
         8kCCW7829kzlashe3ozo0/DARcyRTmlZYbhUV0yI8Di6L2IAyipabhEfbrXB0OfrNNlf
         InKw==
X-Gm-Message-State: AOJu0YwX8YMXGKAgBiYrS01pS8+WWA7Cc4EbkpIvO2+Kq8ssF90IZSEu
	OHTXQvYQ/Jhsd+rDDnwZPubz5dY8tn2LcrBImeevowVP2XAgNw/nvgpOyeyS/1s+pEoPyv4Fckv
	wAInMK3GjxwLsFaNqyjeGiGnSzQk+o3s=
X-Gm-Gg: ASbGncs/DRGTLLqqEFM4t6RjMoiot5l2IR5ZD4FixXps5MbKBS/lrUl4EDWyHsH/AFq
	nZXqzSj39NQk20XGxw9FL9cilXDQBCWYHzFF6mXvwRyxgJ9uc6sQNEmzG8+mUREL6Xq0uyZJKfC
	VJ/RJAcJlJzYyb+CGQbhvyrRv+kQCnz0j/2dAY1Jm7wdhESasFZDpNxXcDAPnHmajgdZ87xNECU
	uzrDbBr/sLYn+lxub5qih0ndHIzMWmxJHZu/lqcK7XCr4fpd7PVXXSv6P6+PPiHH6tLN8b23DS8
	akclnJ5KIsYXZq8TiNk=
X-Google-Smtp-Source: AGHT+IHEZrQgjB8FVIP7JEHMykSWHq+2x8qCUFt8GfCJ5Vxy88PvXF+eS7WFQSazIWRxDNUhIRi4AadfTezxT2sIvMg=
X-Received: by 2002:a05:622a:188e:b0:4ec:b598:2544 with SMTP id
 d75a77b69052e-4ed310af577mr221130771cf.54.1762250925230; Tue, 04 Nov 2025
 02:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20251103135759.1129769-1-alex.kanavin@gmail.com> <2ffeb4b46910a5727c3642e7a900c4eecc3a5017.camel@pbarker.dev>
In-Reply-To: <2ffeb4b46910a5727c3642e7a900c4eecc3a5017.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Nov 2025 11:08:33 +0100
X-Gm-Features: AWmQ_bmHJYzVDNQR8nI8WoRdMaK1asizGa3eRNs8xiMc8wuQyUSZElZ7NddwR_0
Message-ID: <CANNYZj9Q58BNwjR1Tk=SD0TBz5v2ES8+ZO5N1MVQ=qcfGHWekQ@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: rename 'build' -> 'setup'
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 10:08:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18249

On Mon, 3 Nov 2025 at 15:45, Paul Barker <paul@pbarker.dev> wrote:

> Terminology is hard, especially when we already have concepts of "build
> directory", "work directory", etc. I think "setup directory" is a good
> choice to avoid confusion.
>
> There's just one place where it reads a bit weird to me:
>
> > -    print("Initializing a build in\n    {}".format(builddir))
> > +    print("Initializing a setup in\n    {}".format(setupdir))
>
> Perhaps "Initializing setup directory" or "Intializing bitbake-setup in"
> would be better.

Thanks, I corrected this and sent a v2.

Alex

