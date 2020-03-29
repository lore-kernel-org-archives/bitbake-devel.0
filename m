Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.37621.1585518220368357852
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2020 14:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eX4w2lWA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id s1so18862568wrv.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2020 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PfOL0wqih6xlBQktvFp4l6HEJgM6580XK+qNwrczea0=;
        b=eX4w2lWAwsSG0FgN0E87GdqS7AnKb9GKalmFknSg46RFNXhc0svj0WE0ROO+137Y0Q
         ujPtQ0pbOnM7r3iHYm4nWh/fox4zTFDmA/mqvFMXN7KMiUKXUMeuP0U/Fh6efj1soHCq
         emwrcsF7ThoXSi4o8+YKZw3C0ZtwSz2pj1YsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PfOL0wqih6xlBQktvFp4l6HEJgM6580XK+qNwrczea0=;
        b=gxUC6Z1UNX9ZmPzl+u/QvDIUHJ8E83CZOGOl9V27VV4ahwjoAZTGR2zitLZb9y821U
         iMhjmKqNZCM2mNbXWOuOaya8bmnZ65jR0U+oVg+jXxgcux+FPlBzE8Q7ubPUMUWof+P9
         Fzxh/jr2ojRYcaq2NNr7TMhcvLGoPKZvJCUX9J+s/uDerZGB3fxUGlMd4IHTzrbCo41f
         f3MucrNQcVYLa1bCaQUfMMY6b89RKsBgBMciZxq9uyfBSebSAww7aAKcdsQaiWYyjqMO
         62FIaokJL5gdQJ0bCw0M5SpeCR+SOyErY5TyPhraNgYX0MlQwYW3Dtot2dD/se0lOEPc
         qp5A==
X-Gm-Message-State: ANhLgQ1bonSiYRjnm074X6b5jEHD7e5HyGJ560xTn84skk+DJ7kZOFV3
	/NUW4yjLi5SmK5QhUrF7EGxNgA==
X-Google-Smtp-Source: ADFU+vvijwDqNhm8l7keMNQJos+lkoQYQ42b9ZxBs/SHAoXFXeZB/pjPf4WrAtc15hYFXIq+FDWbMQ==
X-Received: by 2002:adf:f452:: with SMTP id f18mr11364037wrp.222.1585518218757;
        Sun, 29 Mar 2020 14:43:38 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id v21sm10113937wmh.26.2020.03.29.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 14:43:38 -0700 (PDT)
Message-ID: <6c9604fa0806a5799519858c300c9336d9e6d351.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Fix urldata_cache key issues
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Matt Madison <matt@madison.systems>
Cc: bitbake-devel@lists.openembedded.org
Date: Sun, 29 Mar 2020 22:43:36 +0100
In-Reply-To: <CAGgRHJoTW30z6gQwCJByEB8xOQ62K-ecuYEE7ZKyd1GZgYehHw@mail.gmail.com>
References: <20200327144825.562857-1-richard.purdie@linuxfoundation.org>
	 <CAGgRHJoTW30z6gQwCJByEB8xOQ62K-ecuYEE7ZKyd1GZgYehHw@mail.gmail.com>
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-03-29 at 05:21 -0700, Matt Madison wrote:
> On Fri, Mar 27, 2020 at 7:48 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Upon inspection its clear the way the keys for this cache were
> > being handled
> > would break it and cause the cache to never be used. Fix this.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/fetch2/__init__.py | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index d8ad19b59b..813f5eb773 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1631,8 +1631,11 @@ class Fetch(object):
> > 
> >          fn = d.getVar('FILE')
> >          mc = d.getVar('__BBMULTICONFIG') or ""
> > -        if cache and fn and mc + fn in urldata_cache:
> > -            self.ud = urldata_cache[mc + fn + str(id(d))]
> > +        key = None
> > +        if cache and fn:
> > +            key = mc + fn in urldata_cache
> This doesn't look right.  Did you really mean to have the 'in
> urldata_cache' here?

No! Well spotted, thanks. I've fixed the patch.

Cheers,

Richard

