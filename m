Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.5129.1630367500432405505
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Aug 2021 16:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ulPbs1Wb;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id c10so17632833qko.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Aug 2021 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m5Cm6CjivGJ2pBLTkd98L74IAbeoFCPLIpmJytXL/Uo=;
        b=ulPbs1WbzvxzLLp1iRTIBzP0IWm26/klhFsOWWnbL2wO2KOYGxvfN4hHciSSPAC9Ys
         qBVzu99gr/XuypYKXuo5deFVJLWZB/6Mij0OVJiVqNaPMKNhQfe7kfnRjMUd7zBkJoRl
         2Nk5IFdy8HzFCYsbZwoiG30MvK6w75II3IP1IXTlw7HsTeQTwC/sIvv6vsNM93oQR4UU
         D+Pk3Lt2Zf+pOGDAud4hDCs4gu4AEs9vh25NKSH3oy+SQepkIrY9gkzcmqYwJHUAlQkI
         uLz8H78o+WwpTevMU+uAADtIKb8marK8sS0SKxPORtGluy5KLnbriPS9wezfc9qq907q
         orUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m5Cm6CjivGJ2pBLTkd98L74IAbeoFCPLIpmJytXL/Uo=;
        b=XwwAOPnQgt3J80ta7sUXi+O/bOaSBH5BxrovafAJBFLuhskBSfEEWKRv7n1KRIlKrK
         +IPQFwYrIIfzbdWunrzAJtOeBARfxB3eFOdBgiMsb/SKc3cCr8ypTsGVn0+ItWczJXZ1
         gQDiKW6A1yYpJZomqXjHZB4vj9e0gjpY3BQ6A5JIRBnU9uAKX4ogsCyG7f5bMJlllHBs
         duBOzWuzZjKuQuzjjA+vmfYPp3xhvnKFLRj8AYsdRgAKhsAdoEzk5yZw+vh+Jnn5Jd3w
         1ppUAR50+8AQ5mnD5JQIXBs9IAJjyLopziPMJoJwH5weEyu0SstbZhTE/r3CWZXmXnrr
         IZ9A==
X-Gm-Message-State: AOAM532vpVvWgNnPJCr1H9nDlLvEWjbjdrIxO/dzFGkLEkV6kCrGblnT
	0D+N4mmxjFRTtFQXpm9zgcGWpqM=
X-Google-Smtp-Source: ABdhPJx7Qh0oefRasAW9mrWQadLDtYxaFEiSr04EDe3vZFQIDzpMu0bn1zLkg/6XdfTGfUXvwL9zmg==
X-Received: by 2002:a37:9f4d:: with SMTP id i74mr210403qke.196.1630367499414;
        Mon, 30 Aug 2021 16:51:39 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from popos (2603-6011-2200-ab10-29b7-0b6c-fb13-465c.res6.spectrum.com. [2603:6011:2200:ab10:29b7:b6c:fb13:465c])
        by smtp.gmail.com with ESMTPSA id a9sm12453975qkk.82.2021.08.30.16.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 16:51:38 -0700 (PDT)
Date: Mon, 30 Aug 2021 19:51:36 -0400
From: "Scott Weaver" <weaverjs@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC][PATCH] bitbake: fetch2: correct PREMIRROR URI
Message-ID: <YS1vCGwV2M7fGAcY@popos>
References: <20210830035630.3634069-1-weaverjs@gmail.com>
 <381bd257581076645eb07f4bbc42d62fd92d6d17.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <381bd257581076645eb07f4bbc42d62fd92d6d17.camel@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21-08-30 21:37:34, Richard Purdie wrote:
> On Sun, 2021-08-29 at 23:56 -0400, Scott Weaver wrote:
> > When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
> > defined for that URI, the downloadfilename is appended to the mirror URI and it
> > should not be appended.
> > 
> > Three new fetch bitbake-selftest tests were added to test downloadfilename
> > scenarios.
> > 
> > [YOCTO #13039]
> > 
> > Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> > ---
> > 
> > This fix is for BZ13039.
> > 
> > downloadfilename is defined as "the filename used when storing the downloaded
> > file" under the definition of SRC_URI [1].
> > This definition appears to be echoed in 44.3.2 where it says downloadfilename
> > "allows the name of the downloaded file to be specified" [2]. Although, the
> > second definition isn't as clear and could be interpreted to mean that the
> > name of the file to be downloaded can be specified. Which, if intentional,
> > would not match the first definition.
> > 
> > I believe that the first definition is the correct definition of
> > downloadfilename.
> > 
> > I've added three new tests to bitbake-selftest's fetch testsuite.
> > 
> > Executed against the master branch, the following new tests fail (see patch):
> > 
> > test_fetch_premirror_specify_downloadfilename_regex_uri() fails because
> > the fetcher attempts to download the downloadfilename.
> > 
> > test_fetch_premirror_specify_downloadfilename_specific_uri() was added
> > to address BZ13039 and is expected to fail.
> > 
> > These tests pass when executed with this patch applied.
> > 
> > However, this change breaks the test that I have commented out in the patch
> > which is executed by MirrorUriTest.test_urireplace.
> > I don't believe this is a valid test because a mirror is normally the location
> > where an artifact can be found and should not specify the filename itself.
> 
> I'm afraid I have to disagree on that.
> 
> If someone specifies a full URL in a mirror definition, they expect it to map to
> that specific url. We need to find a way to fix your corner case but keep
> complete mappings working.
> 

OK, fair enough. Thanks for the review.

-- 
  - Scott

