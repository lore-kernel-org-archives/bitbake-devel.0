Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.9194.1595681921994971115
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jul 2020 05:58:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CQpaIBbk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id k8so171858wma.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2020 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uISsJIlHZQ+1DQVIswEishFNIHIvFpphBt4F9+bQV/s=;
        b=CQpaIBbk8eoDVD8CFj0WKG0Xx/1bedDd7I/WEJP1DZ3segNim9g/12Il9QeFkDQaZN
         UzeofZUw25bSO9hX2XARPB+BNjFtAeiL4bhoOepniVwMjim3BqtpRWdK6HkEdMfyV4XX
         DOhlmUdhkQhZIPDK07EM81y6otdMLgW8hjQyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uISsJIlHZQ+1DQVIswEishFNIHIvFpphBt4F9+bQV/s=;
        b=UbwPerH92hL4M9yrq1CRdh6JXCms975rwnx62N/q/VBMtprqtB3AI9MPBoAMlWD1GX
         EvFjEbPmXLXc8QwkzXLEdqkfp1c/fLwqPVb7uNDJgXKJvsEgt7Dv309frgj7xp21Kfz/
         3n8X8A6hghiq1bdTNO145cO2u/sk1L90IC9aut+smWzJCOAa8SM61Rs7tAp49/HxiSqF
         Vl8iwmeVto2z4KXkN1UPY+/CqF4AgKJ3xQ3nirnv45LA8WK4KC+WMRSBH4QWLEyLu9qr
         33NgTwdKEET3rht82EDEcfUGC9ES6WlD7ZSRwysgcK/uYOGVMqNjdgxlPXMZ+lvrV/6t
         QHVw==
X-Gm-Message-State: AOAM531D1Ob9Tn5SN/r3HZ3/Mzq2aZZrqQgot2qyPyu3I9Rh83mkJ9QS
	8wKZyw0rXGOXGqWbVBT+2kTjrg==
X-Google-Smtp-Source: ABdhPJzIPNPcfWOTdLF0hrInoBsmHRy59RW/dD+cwyYSyowuAuHPWHwwjikeyJ137Utmcn6toi/f4w==
X-Received: by 2002:a1c:c343:: with SMTP id t64mr6900543wmf.168.1595681920375;
        Sat, 25 Jul 2020 05:58:40 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 4.0.f.e.b.e.7.9.7.7.5.0.0.c.1.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (4.0.f.e.b.e.7.9.7.7.5.0.0.c.1.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c1c0:577:97eb:ef04])
        by smtp.gmail.com with ESMTPSA id w10sm39674wmk.0.2020.07.25.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 05:58:38 -0700 (PDT)
Message-ID: <83850f87b067c439ada0e8a1feeeb04f057c2dc1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH][master|dunfell|zeus] knotty: ignore pipe errors
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mikko.Rapeli@bmw.de
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 25 Jul 2020 13:58:37 +0100
In-Reply-To: <20200724075819.GE108868@korppu>
References: <20200723145812.14029-1-mikko.rapeli@bmw.de>
	 <48c641c1f8be55e4e6bb862f543df9178b8ff69f.camel@linuxfoundation.org>
	 <20200724075819.GE108868@korppu>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-07-24 at 07:58 +0000, Mikko.Rapeli@bmw.de wrote:
> On Fri, Jul 24, 2020 at 07:01:46AM +0100, Richard Purdie wrote:
> > On Thu, 2020-07-23 at 17:58 +0300, Mikko Rapeli wrote:
> > > Piping bitbake output to another process like less currently
> > > results in an ugly error if the other end of pipe exits
> > > before bitbake has written all output to it.
> > > 
> > > For example with "bitbake -e linux-yocto | less" and
> > > pressing q to quit less results in:
> > > 
> > > Error in atexit._run_exitfuncs:
> > > Traceback (most recent call last):
> > >   File "/home/mcfrisk/src/yocto/poky/bitbake/lib/bb/event.py",
> > > line
> > > 133, in print_ui_queue
> > >     sys.stdout.flush()
> > > BrokenPipeError: [Errno 32] Broken pipe
> > > Exception ignored in: <_io.TextIOWrapper name='<stdout>' mode='w'
> > > encoding='UTF-8'>
> > > BrokenPipeError: [Errno 32] Broken pipe
> > > 
> > > Fix is to use default signal handler for pipe signal. It's
> > > perfectly normal that on Unix systems the other end of pipe
> > > gets killed before all data is written.
> > > 
> > > In some cases there seems to also be a loop which results in
> > > a large number of "[Errno 32] Broken pipe" messages printed to
> > > console until knotty process is killed. I think this also
> > > fixes those cases.
> > > 
> > > This patch applies to master, dunfell and zeus branches.
> > > 
> > > Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
> > > ---
> > >  bitbake/lib/bb/ui/knotty.py | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/bitbake/lib/bb/ui/knotty.py
> > > b/bitbake/lib/bb/ui/knotty.py
> > > index 87e873d644..56ac41d0f9 100644
> > > --- a/bitbake/lib/bb/ui/knotty.py
> > > +++ b/bitbake/lib/bb/ui/knotty.py
> > > @@ -29,6 +29,9 @@ featureSet =
> > > [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
> > >  logger = logging.getLogger("BitBake")
> > >  interactive = sys.stdout.isatty()
> > >  
> > > +# ignore pipe errors since they are normal
> > > +signal.signal(signal.SIGPIPE, signal.SIG_DFL)
> > > +
> > >  class BBProgress(progressbar.ProgressBar):
> > >      def __init__(self, msg, maxval, widgets=None, extrapos=-1,
> > > resize_handler=None):
> > >          self.msg = msg
> > 
> > I think but have not 100% confirmed this caused the failures in:
> > 
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1200
> 
> Hmm, I can't see the connection based on logs though I don't know the
> test
> setups at all.
> 
> > (new build running to check)
> 
> Looking forward to these results...

It confirmed this patch is at fault. Looks like devtool/eSDK/tinfoil
are the problem areas at a glance at the failures.

Cheers,

Richard

