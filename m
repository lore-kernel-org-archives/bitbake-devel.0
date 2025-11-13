Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D78CD6E6C
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 14:06:39 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24683.1763042789192278669
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 06:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bkOMmuvj;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so8571086d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763042788; x=1763647588; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x6EO229385/UA8J1Zt/2XT55CQnCBNFh1vPhwTFp+RM=;
        b=bkOMmuvjGheQcE6yiZkwQU+9p/lN6clmzgoZhQxiS8gWEHZs6uywlTwecH+KZYiG/l
         he+/Spm8Vjiu7RSbB04Qky9bFIsI/mS3yOrqp1sWnTmdlwq2bLbJDcRiN9xsZTBeRIBI
         fDOyPx41Ir8wFMeA4ZEefFCc7PJKSlTnjd55TyVrf+6ts4bMvBl63l1E6ARCw7i0CHDk
         ptudXJUBcRLEmFLqrAMkgBX6KwxI9c46zp4gGXb2BEEMh2UXXfsLbYcgBuPloJ3T6r+G
         trTK0sDAXz7RGl39M4pvmW+ILoY6kL5sSWNQkzXThGb1YLJHDY2/25Cfj4znTAClVNEj
         gZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042788; x=1763647588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6EO229385/UA8J1Zt/2XT55CQnCBNFh1vPhwTFp+RM=;
        b=tjuEOyGI0EMv134ClO3etwMd3UEqkyY0I0RIUEzivzrP1JaDarz5F429mgraiiW8EL
         VcGWMTGF3qvJt9pAic3JE2QKtJtyTJ4OmwEHBWRcP+btUao98IpFjPVQDJw43kGQny3/
         2iw6LLfX/FZD4MxJFo716tDXJC4gSzeCirIbByXqDOsB51nndvxpfpwciOPclhVnrNn6
         lwjELPaq9QOax+Pqml7b+n2qrabfl1g6DPt2UoEGnwQpPgw6K+mzTakakEy9XBzaFDf1
         L8V+LiPMwgRc+yXyzgeOflBbqbyGfdfHyYft45w9qw0CT+EG22keSH4HvYb4/J0hrzN+
         rDng==
X-Forwarded-Encrypted: i=1; AJvYcCWCWRV4sa+BuyaOvpLT6resVxLSH4ghGjcz1nm2gabK/rAmj1VlqasTJawHHeoPfoFXn1Ne6mChQNsdRp5X@lists.openembedded.org
X-Gm-Message-State: AOJu0YzonUelc4uV1df+2Z0u/Bh5SniybIaCVKqWpRQIVk5y4/mYsOOV
	0NRvDLiVOojXYFE94TH5PEf9z+AM/fGNBLNGMQD+pm+7sWHColt9jUSZ34yxpTmMdRKPr06OQnb
	L+rAUk9vvUFYLjlJp5s6pvYsSGU1ZhuE=
X-Gm-Gg: ASbGnct5MBHhUxBbIBb5Wfd+p0ddXrxM+SvVnhwQaWlZIzXus5uG6bwiofcmqEe9Onr
	0cLY9uB3HBCGtEh4XZtlB6SQNJekXoSGjMD93IaXiHbx9yL8Xv57N/OtMfOC4kIYbOHez4YJJX2
	ZIoTZ5ynLYqVdANMRN0nyBp0pf2nt0Bcks/YP7l7YwrlT2gxlmgoG4Q+qr4busyoFVOSjxdgRQd
	VHnRhGwEoZNQv489PXQVYJj6InQifMtcXcS+pSz2d8Eu6Flp3+8vHWNjL8FjX25NPTvIWd1uwXq
	9b6RZKeRV7PLjcFYhd9RLXXosFyAoQ==
X-Google-Smtp-Source: AGHT+IHtWXxSsptU6OAb66Rj1bqHfsvfUheZLfihJQLSx8Uhcz+NOZ8YK6kcE58N7Re7+BZKMMda7fShF5K17PE1C9o=
X-Received: by 2002:a05:6214:262c:b0:880:53a7:a445 with SMTP id
 6a1803df08f44-882817c2dc9mr44459696d6.2.1763042787975; Thu, 13 Nov 2025
 06:06:27 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev> <18779541E6AD04B6.981615@lists.openembedded.org>
In-Reply-To: <18779541E6AD04B6.981615@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Nov 2025 15:06:16 +0100
X-Gm-Features: AWmQ_bmbLZnga3Ju5gv193LQvHAkzvifSUPhIhEBslua5ri4FjhcHw_Mx0a8DUs
Message-ID: <CANNYZj_p_FX1sb6UduS-5H=jsmBrZA5crpJFPi3juRXjRtarXQ@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup steps for release
To: alex.kanavin@gmail.com
Cc: Paul Barker <paul@pbarker.dev>, Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Ross Burton <ross.burton@arm.com>, 
	reatmon <reatmon@ti.com>, Robert Yang <liezhi.yang@windriver.com>, 
	"antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 14:06:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18375

On Thu, 13 Nov 2025 at 14:51, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:

> I'd probably extend the schema to have 'local'-type entry in addition
> to 'git-remote'-type, and then you can override one with the other
> from the override file.

Then the implementation would symlink the original local path into
layers/. That way things like bb-layers entries, and various other
places that expect sources to be in layers/ will work as before and do
not need special casing.

Alex

