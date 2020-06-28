Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.25704.1593339032004717232
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Jun 2020 03:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gacFiZxh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id f139so13205837wmf.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2020 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d2upPdUFwyTT9LOpaVxIOB8Fso3brTO5nZZgDC66j8A=;
        b=gacFiZxhW7ByIJdDMrZ4HUsF2vUa6EW6xj5wffKvz3HGSKluDCPoE8bvG1Hov0AVz8
         huEnKZMsUkN2+EkYazIRuWbDsgavSY6BgfneremH4EBYUbKK3s2iCf5qoQaDehI+q7dS
         Sk31wzO4H+LQRsLeOe2oXdjb8TAjhMgmz1DdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d2upPdUFwyTT9LOpaVxIOB8Fso3brTO5nZZgDC66j8A=;
        b=KUla5RnBxmOdFtKvfhlGAKQzEp/qUABkq2kwf8vfhH2SjtDUPQYNQuLxVEyUKHRDxB
         QAdQwioYtmg9OU+/TXGj8k9ewziIeQCUUopjUy4AlcxmbHjyJomiayinYsNErtBZufiw
         5rNACYktBHZ0MYEMuO8y+v0E7Lo49KLa2f2lVB0MgLsJ/VvwwT6d6DVU8qYsevb636TF
         BldvVY/zNQ+iWQ8xwmtvGCKyE2mPPSytHWblNAPtwpGutn3T25lsYykEZsU6EzVehSeM
         CgnObOa39V6apNToFZbgdSJ4CW5By1irBNu+3SArk7q/qXS6paLlWDQ86Fcnku3VeRNf
         lDZw==
X-Gm-Message-State: AOAM532KxdONGRlQxFmZUhXs9jPbF08zq+RszpalxLdRykDnouWGzK26
	BA7fDnzAlCCEN5YeZXfnCLoOmA==
X-Google-Smtp-Source: ABdhPJw361noEH8vra7fJxfzt6RLGptruMGx5A1KsIv44keZMWU0FHp4zFTmsx+G3Fg5juXkBbUbqg==
X-Received: by 2002:a1c:6805:: with SMTP id d5mr11562289wmc.19.1593339030512;
        Sun, 28 Jun 2020 03:10:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id p4sm34504568wrx.63.2020.06.28.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 03:10:29 -0700 (PDT)
Message-ID: <48bd2a542a8629b7400f593b816d2da54128f53c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Support for git+https://foo.example.com like URIs
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel@lists.openembedded.org
Date: Sun, 28 Jun 2020 11:10:29 +0100
In-Reply-To: <lyy2o7cyi4.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
	 <099ddfc8784d7760adb9b1fdd8207325d29895dc.camel@linuxfoundation.org>
	 <lyy2o7cyi4.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-06-28 at 11:48 +0200, Enrico Scholz wrote:
> "Richard Purdie" <richard.purdie@linuxfoundation.org> writes:
> 
> > > > PROJECT_BASE_URI = "git+https://foo.example.com/project"
> > > 
> > > Is there some generic interest in this functionality so that I
> > > can
> > > create and send a patch for bitbake?  Or is this too special and
> > > people are happy with altering ${MIRROR}?
> > 
> > I didn't (and don't) like writing special cases into general code.
> 
> mmmh... In my original report you complained that code is not generic
> enough and works for git only.  Now, that is has been generalized,
> you say it is too generic...

I'm making comment on what I said four years ago, I'm not making
comment on the code you have now. The code you have now is much neater
and more general. Its simple enough its worth considering.

> > My intent has always been (and still is) to see if a more generic
> > solution is possible which not only addresses your use case but the
> > ones others have as well.
> > 
> > That will likely mean using the mirrors variable to remap things
> > which
> > will be slightly more complex but will also enable others.
> 
> I do not think, that bothering around with mirrors (or better
> PREMIRRORS)

I was meaning mirrors in general, the mirrors/premirrors code all uses
the same code so yes, PREMIRRORS would be most useful in this context.

> is any helpful for this cases.  In 99% of cases, people want to set
> http:// or perhaps ssh:// as a transport protocol.
> 
> People want to completely rewrite an uri; they do not want to try
> another one first and then another one.  This is nothing which can be
> solved by mirrors; especially when you start to use AUTOREV.

The single rewritten url use case is handled by only allowing
premirrors which there is an option for. Adding more ways to do things,
each with limitations isn't usually a good idea. One way or another we
are going to have to extend the mirrors code to support the protocol
remapping.

Cheers,

Richard




