Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.8697.1594559678558666503
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Jul 2020 06:14:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BnAbF3Ru;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id q15so10622171wmj.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Jul 2020 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=+HL0e0f6leCrn21GCRuMigxfbb6kDghzfDHCLPy2IbU=;
        b=BnAbF3RuhomDDDGFviAiH02NvsBFxmjPCAZgEqX1gWy3fx2hVkNql1pzhq7Nr1vmI2
         3gU/l/KRbO0k4OprfJrtCMK49kGAsadLSKytlBTvnrnp8QM0RbEVelG0jX7Shsw89oxo
         E5N1dUnnjynmiZE3RjSuiRfuuhI8RRlgawTLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+HL0e0f6leCrn21GCRuMigxfbb6kDghzfDHCLPy2IbU=;
        b=ghDNxcazbBBRIruyUX/gxYUYEUiZpbIKc/28K1AdOMc+ENRAveGB4LMuI62Lul3bxi
         5favV5P9CFTA83SjsSc8ddG9PAPu0oRehKytBWN7BPZkDDP/sYbnGNVA9hJWgxqBEFtU
         Jh+99sWsv801YlYmTjJ7LPM5VYG+xIdxPD3oJqoc2H5kIVxsJusmymaW/fw/dq1xVgtw
         gMtxJBFT+sbEkZb0h9oOhXnm5il8dms27bMVCpZfEVlh+WSXxPld+JSDQRbt10EI978N
         /vr2LTO22MO6Ilr0pFUjahUnCogQJV3NPjzLDZkmc+kZnM1/XjzgN3YAasyy6HVvIFLn
         nUoA==
X-Gm-Message-State: AOAM531U/yg/Amk0LyscQjKNphQFdezJgA+uXtLqfBCEk+FlDGOaMRjN
	Dp79AAAplHlmMVuj+sxZXZgezQ==
X-Google-Smtp-Source: ABdhPJxh7z9E/lggXuUgi+/LkrStT98rZ0Nx7CQwNVTczsZ9HnoDCGQR9GcyzMqFuiCq7mGRF/UwNw==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr13552475wmb.147.1594559677007;
        Sun, 12 Jul 2020 06:14:37 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id j6sm19777592wro.25.2020.07.12.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 06:14:36 -0700 (PDT)
Message-ID: <c81353254ba925b0d1b11165cdd5df522e8e55b0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: Fix a rare lockfile race
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Sun, 12 Jul 2020 14:14:35 +0100
In-Reply-To: <fa3dd37a-0cf2-95ec-46e0-c7df69f211fa@gmail.com>
References: <20200712105516.507243-1-richard.purdie@linuxfoundation.org>
	 <fa3dd37a-0cf2-95ec-46e0-c7df69f211fa@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-07-12 at 14:05 +0200, Jacob Kroon wrote:
> On 7/12/20 12:55 PM, Richard Purdie wrote:
> > diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> > index 83385baf60..b3a7f8b419 100644
> > --- a/lib/bb/server/process.py
> > +++ b/lib/bb/server/process.py
> > @@ -243,7 +243,6 @@ class ProcessServer(multiprocessing.Process):
> >                   lock = bb.utils.lockfile(lockfile, shared=False,
> > retry=False, block=True)
> >                   if lock:
> >                       # We hold the lock so we can remove the file
> > (hide stale pid data)
> > -                    bb.utils.remove(lockfile)
> >                       bb.utils.unlockfile(lock)
> >                       return
> >   
> 
> I'm no export on the bb lockfiles, but if this is correct we should 
> update the comment aswell.

I left the comment as its still right in that unlockfile does remove
the stale pid data potentially but I guess it could be tweaked to
better match the code...

Cheers,

Richard



