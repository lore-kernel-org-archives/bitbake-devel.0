Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.689.1611602082706753203
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jan 2021 11:14:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=jD69/0Xh;
 spf=softfail (domain: sakoman.com, ip: 209.85.128.51, mailfrom: steve@sakoman.com)
Received: by mail-wm1-f51.google.com with SMTP id c127so530667wmf.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Jan 2021 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUXgAV4mvAWtalwBRPeyBndOX5RsC3fX48+bspl5awc=;
        b=jD69/0Xhb2KeRqHvb12HRPN+BLZPwKoynheUCJtC21ZVh9++sSCWi0OLJA/RSZQfo3
         VxF19f65pxATcmL6mmNGI2HApIlWeyAbg53htMQVQIZ2b5eHaVZ72ZdGfloT6hlxt2xs
         TeGSboZRnEuQI6WCyA6go3eiC5gVxwu5IEYipwagQ7JT0R6x1XTSYA0vXTxyA+UXWTR4
         /F/b/4XclgAB+fzJYJNPl2NywCPs509e+nUoYCpSqnFQj2qoMfM1zlj+fDVx+W0dFsWz
         DgI8Zbt0t/EBR0E2193se9xe0j13zb1dLTTMZn3oEzAB0k06YJh8k5Mat+D693Kng+Sw
         btGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUXgAV4mvAWtalwBRPeyBndOX5RsC3fX48+bspl5awc=;
        b=WDnc0O4Bt64GrlOQTUm//CVuOPvjOxbDYgIThLKWvxK9rRBRU2RT2Qr31UBngwmocZ
         4u7dpo5cKpJdvpOyindeDsVgkDDA/hEtp1VLrDe34mriv3U26mlWyBwBktqkv3LSYdhZ
         gjbkZ071Evlv+GuALf+iBLE0VfmnBs+CEIo2cbonyvfYRKB9iWBYAUSMjk6l9TBPmrD/
         4ThZUAncjLnrSC8XCZx97XCW+ZQMq4/PJoVehV9gCxWzw/uPzxthUpasawXJrLLZMdtD
         FyiIGhS2RxJoL0tOqMknwzy8Vnf5MOYtB67uBVhoIGfMx7+yNIEBECsqFHFzZ7/oJ+us
         cuQQ==
X-Gm-Message-State: AOAM531IP02TlGbfk2I971ELfwnVsNOvK1M/U8eFiPBXAQpe5pApogtW
	QYQXwB8wz2bejGU5aOIVxHSOY4fvbCkjkyB0/+YTjA==
X-Google-Smtp-Source: ABdhPJyVz0AM+ztTmTUBA9gdQ7SnBvKQ7AJgLTNxXP/C2CpjhoVBSmYFC6CI/GJs3IJ2JG8IhlLHmc2DOpAr5pFbR3w=
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr1532416wmh.4.1611602081110;
 Mon, 25 Jan 2021 11:14:41 -0800 (PST)
MIME-Version: 1.0
References: <d5882aa4c29d4f268dd9312d597538ce@XBOX03.axis.com>
In-Reply-To: <d5882aa4c29d4f268dd9312d597538ce@XBOX03.axis.com>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Mon, 25 Jan 2021 09:14:30 -1000
Message-ID: <CAOSpxdZwYAyQpch8Yy-E2zt_wE4_k9p6GQOVapfC_U4r-AbEMQ@mail.gmail.com>
Subject: Re: Backport fix to ensure hash reflects vardepvalue flags correctly
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "Mittal, Anuj" <anuj.mittal@intel.com>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for catching this Peter!

I've submitted the dunfell backport patch to the list for comment, and
have also staged it in stable/1.46-next on bitbake-contrib.

If there are no objections in the next day or so I'll send a pull request.

Steve

On Mon, Jan 25, 2021 at 8:54 AM Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>
> Can you please backport 26ccf1575aef2d6e2d7717d3bd10b1ed0d5a777d
> (data_smart: Ensure hash reflects vardepvalue flags correctly) to
> Dunfell and Gatesgarth?
>
> I am seeing errors when building an SDK with 3.1.5 because commit
> cc2e2c2d065530a5ab33fed139d16fe1dcdca4d9 (metadata_scm: Fix signature
> handling of METADATA_REVISION and METADATA_BRANCH) was backported
> to Dunfell in OE-Core. For Gatesgarth, the latter commit should also
> be backported (once the commit in bitbake has been backported).
>
> //Peter
>
