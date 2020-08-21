Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.135407.1598019645809897325
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 07:20:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S5GsvK1p;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id x5so2063260wmi.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JVcRyGN5BltC/pds8maqNxzunXTHpubPknh9ouYtoMU=;
        b=S5GsvK1pnEN63qG0hmPp5eoeflYtN31KaBrUCskOdmeXS3d+nDhhMs/vkzsrbCsbBJ
         loW24zfrI4Gpda6uVKXbUoo40yIz5tufOboB8KmExLp7YQQGYr8sJDb8cly/JM3KAfT3
         xll+jNgwB9HGwVaVC0W7rLCpPsEN/punWk4bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JVcRyGN5BltC/pds8maqNxzunXTHpubPknh9ouYtoMU=;
        b=B8GDF7sLqPrnZDPSEewPYOmzGmJtThFZbxG20ZwUsXu8WWPHyC4HizNGXepDSE3iU+
         vwLGKABFjWnHTWpPBRuphQ7SmzDP5QtFEjUpju4tnIoXmguIEZGtywhpJCQR2NGpzFv1
         nZZrRUC67dg9KSzuveFpyFVCMRMjYoU71wCIdb+7W4kqDcGk0OdpmBPPZFL7QFuKT17j
         d7Ci8Y2v/8f9V8VVjy/F1HOOKfHiV5DXVs6coyXffybhQHnKUpfURM5juIJNJjFvCRTc
         gvbzYYqnzeAij5L9Q/ZZFG+NuAsTtfJCoVfxNeGMm5FXdEf0T40ci3qOghUsrAXOuRvh
         u/5g==
X-Gm-Message-State: AOAM532UTtAnIjYaQty50LJCyQReNebB2e8fftAyJUmkGYWuo+p+S3oj
	6z+lucbcdpOqJmmsqnV33nS8/BfYHRpjNvUl
X-Google-Smtp-Source: ABdhPJwoksdP4/yQZ5V60lpya3bYHhwWKwaF+gw/pG+LRbsBc9hdIxBM6WvQe8pmLUTk6BDZIu4DKw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr3262333wmj.47.1598019644262;
        Fri, 21 Aug 2020 07:20:44 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id n18sm4617137wrp.58.2020.08.21.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:20:43 -0700 (PDT)
Message-ID: <606c29630870cb03b87171f1b57e3cfb2c9206ed.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Maxime =?ISO-8859-1?Q?Roussin-B=E9langer?=
	 <maxime.roussinbelanger@gmail.com>, guillaume.champagne@sonatest.com
Date: Fri, 21 Aug 2020 15:20:43 +0100
In-Reply-To: <162D4E42F9CDE339.12673@lists.openembedded.org>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
	 <162D4E42F9CDE339.12673@lists.openembedded.org>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-21 at 15:18 +0100, Richard Purdie via
lists.openembedded.org wrote:
> Hi,
> 
> On Thu, 2020-08-20 at 17:49 -0400, Jean-Francois Dagenais wrote:
> > While investigating constant mismatches of hashes from our
> > SSTATE_MIRROR depot,
> > Maxime and I came across a bitbake-diffsigs which showed a
> > suspicious
> > cause for
> > the mismatch. It appeared to be an underlying taskdeptasks which
> > contains the
> > full path of the recipe, which is totally a local build thing.
> > 
> > After searching for a little while. We came accross the
> > `clean_basepath(a)`
> > function in siggen.py. We added prints on it:
> > 
> > def clean_basepath(a):
> >     mc = None print('a: ' + a) if a.startswith("mc:"):
> >         _, mc, a = a.split(":", 2)
> >     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2] print('b: '
> > +
> > b) if
> >     a.startswith("virtual:"):
> >         b = b + ":" + a.rsplit(":", 1)[0]
> >     if mc:
> >         b = b + ":mc:" + mc
> >     print('b+: ' + b) return b
> > 
> > Sure enough, this looks like the culprit. Consider the following
> > trace:
> > a: virtual:native:/full/path/to/poky/meta/recipes-devtools/gnu-
> > config/gnu-config_git.bb:do_populate_sysroot
> > b: gnu-config/gnu-config_git.bb:do_populate_sysroot
> > b+: gnu-config/gnu-
> > config_git.bb:do_populate_sysroot:virtual:native:/full/path/to/poky
> > /m
> > eta/recipes-devtools/gnu-config/gnu-config_git.bb
> > 
> > Looking at this, it really seems like the intent of the `if
> > a.startswith("virtual:")` case is to insert only the
> > `:virtual:native` at the
> > end.
> > 
> > The simplest fix we suggest is simply changing `a.rsplit(":",
> > 1)[0]`
> > to
> > `a.rsplit(":", 2)[0]` and causes b+ to become:
> > 
> > b+: gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native
> > 
> > Since this is so profound and core to the way signatures work,
> > coupled with the
> > fact that this code hasn't changed in years, we feel being the ones
> > to find and
> > fix this is unlikely.
> > 
> > Perpahps the content/format of the passed `a` variable has changed
> > recently?
> > 
> > The following email is a patch which could be applied if deemed
> > correct. But please
> > consider this re-written version:
> > 
> > def clean_basepath(basepath):
> >     # basepath is a string like '/full/path/to/recipes-
> > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> >     # or 'virtual:native:/full/path/to/recipes-
> > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> >     # or 'mc:somemachine:/full/path/to/recipes-
> > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > 
> >     _, parent_dir, recipe_task = basepath.rsplit("/", 2)
> >     # drop what is left of the second slash, searching from right
> > to
> > left
> >     cleaned = parent_dir + '/' + recipe_task
> > 
> >     # if there was a 'abc:xyz' prefix, add it to the end
> >     if not basepath.startswith('/'):
> >         cleaned += ':' + basepath.split('/', 1)[0].rstrip(':')
> > 
> >     return cleaned
> > 
> > Both simple fix and this rewrite were tested with `oe-selftest -r
> > sstatetests`.
> > 
> > We feel this version has these advantages:
> > * improved readablility
> > * improved efficiency (the split is not repeated twice and function
> > it has fewer `if`s)
> > * honours the open/close principle better by not hardcoding
> > "virtual:" nor "mc:"
> > 
> > Thanks for your feedback! I will submit this version as a patch if
> > it
> > is positive.
> 
> Well done finding this, the bug has clearly been there a while! I've
> had a feeling there was something going on somewhere but never found
> it.
> 
> I've taken the opportunity to make the code slightly clearer so have
> written and sent a modified version of your patch. I hope that is ok!
> Please take a look and let me know if I've missed anything too.

Of course as soon as I send that I realised my patch is wrong since
virtuals can have multiple entries, which is why this is written
searching backwards.

Your patch is therefore the correct one!

Cheers,

Richard

