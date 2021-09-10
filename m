Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.10186.1631285671765750941
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:54:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PSuipLCe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso1591434wmc.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RmnZ+E5yp7nljR04xN9RzEG1NKPCO/OtXu299dB1uFI=;
        b=PSuipLCeTjrztrlCXgIQNpB4EFKPmUZ6Vv3uY59kKbhqNWMG8xexgmqwvEnBR9Je/o
         UaDdmmqiizIuaYOuiNzH+ODuFNkrismdOgPSXUCx7YX9jBNgKd1d7sfH9mgIr0BmheIl
         kPf56IajW4koBpVYLMEUis5oLGizmc+Xd8LVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RmnZ+E5yp7nljR04xN9RzEG1NKPCO/OtXu299dB1uFI=;
        b=4PLaf5IXDnPi6Fa8rA2nBJ9Gux6dIOeemLnKzv/5C4+lZX9+/Uw5AcxPe1lyXkNw1u
         fsATXHjbtGGhK2vqioFsn4aPuqFNMPGjYwrRcWOEfA39JF6DaVnRgeZ8wS1I6aevtLKM
         6HuZmShiUbeLl4wavdNOvTfTJL8STAZD7vPTFie0HB0XBEo+obKpNv0iaSWNARJtbY80
         nfMhqjxcBZPrYlnGA+rPq7Ox3rgZQCn8facna6W5Ng5VR2kjYJNtARClO23235IVyhlI
         /vgZ8myAiK259OLv8eCJllFnkn3vVMKYyx2Lm9e6zovH/gIsttZ851ysJwgWU6/kh91c
         572w==
X-Gm-Message-State: AOAM533x2AnWt34cB6k62TEBVyootz/15Pu3TcWQIQeerotMT0a22mQ5
	BwEDc+B3hbgHb1Bs3eyBUcWjWOwbTdAvsy7+
X-Google-Smtp-Source: ABdhPJy88kDm+h1kwgJ3drAnC1t5oySnUrdOBRM8LIFAdyUOCD2t728q0YFXu5H2IsXhS/STsxw6RA==
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr8658830wmq.153.1631285670325;
        Fri, 10 Sep 2021 07:54:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45? ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id z6sm4534621wmp.1.2021.09.10.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:54:30 -0700 (PDT)
Message-ID: <8cc846add7518345e6a948ef11dab6c0c528e14b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] build: Catch and error upon circular task references
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Sep 2021 15:54:29 +0100
In-Reply-To: <20210910144229.osayhx4ewsmtc7cl@fedora>
References: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
	 <20210910144229.osayhx4ewsmtc7cl@fedora>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-10 at 16:42 +0200, Quentin Schulz wrote:
> Hi Richard,
> 
> On Fri, Sep 10, 2021 at 03:07:38PM +0100, Richard Purdie wrote:
> > If there are circular task references, error on them rather than show
> > a recursion error. A simple reproducer is:
> > 
> > """
> > do_packageswu () {
> >        :
> > }
> > 
> > addtask do_packageswu after do_image_complete before do_image_qa
> > """
> > 
> > into image_types.bbclass. There is code in runqueue to detect these but
> > we never get that far with the current codebase.
> > 
> > [YOCTO #13140]
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/build.py | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/lib/bb/build.py b/lib/bb/build.py
> > index 1e062adb51..4249c0be2b 100644
> > --- a/lib/bb/build.py
> > +++ b/lib/bb/build.py
> > @@ -1034,6 +1034,8 @@ def tasksbetween(task_start, task_end, d):
> >      def follow_chain(task, endtask, chain=None):
> >          if not chain:
> >              chain = []
> > +        if task in chain:
> > +            bb.fatal("Circular task dependencies as %s depends itself via the chain %s" % (task, " -> ".join(chain)))
> 
> depends +on itself?

Well spotted, tweaked in master-next, thanks.

Cheers,

Richard

