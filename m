Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.974.1617743986492062256
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 14:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I9hLygtt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id q26so9970369wrz.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Apr 2021 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6iYA5saeCmV8zceA4I1bY1K8oHg3GsuM6chRyLavEIM=;
        b=I9hLygttRwm3KVA5rKwUxlZlr/MTkFceUsnrqs+Xe+Nvx6/FuYf8k8gX9PdzKnxsvp
         BjQsuhlkoYK/xF+EhwAfNfBdl5g6yuPwE3kqp/0CA9jnCZZ2fl9XogRqXFw6uJoNAa7l
         AythUsWSIhWg/7BhjoJ8vXfUuvzPGK2NLxn6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6iYA5saeCmV8zceA4I1bY1K8oHg3GsuM6chRyLavEIM=;
        b=gFCuhyVG6pxMGKKSu0N/JJmeD2ozm+A3+m8oOQYkrp32MJ+GcmtB1px8Oynp3SZgfy
         uqTNf/+VLqGNG29t6Brg46cqYETz9jY+uimHATb2Kn0HFIK03N3lY2LCvHAo74nGceyN
         jPrsyx3lacUPNTqPwDOH6Um0KgZjpFmAz/ecWHxoYkhYn3INnNdp2fScbvTbpdJurzXq
         TqXMus0U9h2EcV8VFLNTXgaLLu7Cghh06obHLAsmw9WzZci73xV7fXhwJwTQBoulb4DV
         H2TkWixNaLT4e2DXsnat8VzGiWLaYk4avQqr0u/tIoEyW31pEWCNilt5bGyh+MPRn0YH
         Wg5g==
X-Gm-Message-State: AOAM530eSTK9AMO7UTrHm59/aAk405w5h/CeUlSWa//k5vozBWxrg4pW
	ltkFNcnWhz0Ybs3OolklA1PijQ==
X-Google-Smtp-Source: ABdhPJxA9IFPku+cXSNPBCP4a7PUg5VfgfVLezzleYvapebSlbD2rlhJ94S0vF1/JI2/I7ekAzSU1Q==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr233142wrw.3.1617743985062;
        Tue, 06 Apr 2021 14:19:45 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:82e4:10af:e1ba:c8de? ([2001:8b0:aba:5f3c:82e4:10af:e1ba:c8de])
        by smtp.gmail.com with ESMTPSA id j123sm4717663wmb.1.2021.04.06.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:19:44 -0700 (PDT)
Message-ID: <3984862b382b08d5da05f740d86075d8f2acd322.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] still confused about valid wildcarding for bbappend files
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, Mark Hatle
	 <mark.hatle@kernel.crashing.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Date: Tue, 06 Apr 2021 22:19:43 +0100
In-Reply-To: <5166362-3350-5421-72c5-3eea3ca947fe@crashcourse.ca>
References: <e66c2878-5f82-394b-e6a-ccd45dc44c73@crashcourse.ca>
	 <4d45946c-442a-53eb-53e9-b480a2b83112@kernel.crashing.org>
	 <5166362-3350-5421-72c5-3eea3ca947fe@crashcourse.ca>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-04-06 at 12:34 -0400, Robert P. J. Day wrote:
> On Tue, 6 Apr 2021, Mark Hatle wrote:
> 
> > On 4/4/21 2:51 PM, Robert P. J. Day wrote:
> > > 
> > > from current bitbake manual:
> > > 
> > > https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-intro.html?highlight=wildcard#append-files
> > > 
> > > "The use of the ” % ” character is limited in that it only works
> > > directly in front of the .bbappend portion of the append file’s name.
> > > You cannot use the wildcard character in any other location of the
> > > name."
> > 
> > The filename is broken up into: name_version.bbappend I believe the
> > intention is that only "version" can contain wild cards.
> 
>   that was my understanding all this time.
> 
> > >   that *appears* to suggest that you can have one (and exactly
> > > one) "%" before the ".bbappend" suffix. so how does that
> > > explanation cover examples in some of the OE layers like:
> > > 
> > >   meta-security/recipes-kernel/linux/linux-%_5.%.bbappend
> > >   meta-anaconda/recipes-gnome/gtk+/gtk+3_%.%.%.bbappend
> > 
> > "%" is a wildcard for the _version_ only.
> > 
> > It is my understanding it can be used in any part of the version
> > string, but can NOT be used in the name.  The above example shows it
> > being used in the linux- recipe name.  So perhaps that has changed.
> 
>   agreed, that example is a bit of a surprise.
> 
> > The later example (gtk+3) it's being used in the versioning, but looks
> > unnecessary as it's just patching all of the version elements anyway.
> 
>   perhaps, unless by adding the periods, it's saying that the version
> number must contain *at least* three components (since the final "%"
> will always suck up whatever remains). but that's just a guess, and
> probably wildly wrong.
> 
> > The general case is:
> > 
> > recipe_1.0.3.bb
> > 
> > recipe_%.bbappend - match all versions
> > 
> > recipe_1.%.bbappend - match all 1.x versions
> > 
> > recipe_1.0.%.bbappend - match all 1.0.x versions
> > 
> > Any other usage might work, but I doubt has been seriously tested.
> > (And the key isn't that the '%' be right before the bbappend!  It
> > just happens to be there.)
> 
>   that's pretty much the way i'd always thought of it, but perhaps
> we've been mistaken all this time. :-)

As Mark says, the above is what is documented and meant to work. 
Easiest way to figure this out is to check what the code actually 
implements to handle it. The code (from cooker.py) says:

    def get_file_appends(self, fn):
        """
        Returns a list of .bbappend files to apply to fn
        """
        filelist = []
        f = os.path.basename(fn)
        for b in self.bbappends:
            (bbappend, filename) = b
            if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                filelist.append(filename)
        return tuple(filelist)

so it actually truncates the expression at the first % and ignores 
anything after the first one. That is there to chop the bbappend off
but can obviously chop off more.

meta-security/recipes-kernel/linux/linux-%_5.%.bbappend
may as well be:
meta-security/recipes-kernel/linux/linux-%.bbappend

so matches a bit more than expected and

meta-anaconda/recipes-gnome/gtk+/gtk+3_%.%.%.bbappend
is effectively
meta-anaconda/recipes-gnome/gtk+/gtk+3_%.bbappend

Cheers,

Richard


