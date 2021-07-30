Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web08.24736.1627654332184212334
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 07:12:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L5+mCfat;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id f18-20020a05600c4e92b0290253c32620e7so9061151wmq.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qRkjAmumwEtE677/8rQeqVnc6bdZGdl52weFwG/QF4w=;
        b=L5+mCfat6pR7hpehDNIIEveSiz9BZ+xe8HOjoXgD1Z0RceXiA1Wr4lV1JAnG6YLD53
         fFpJM3W3DBu8EdSKObx3fvrcrkWsBb6+U173E5xFg3TX3F3mfOBg1Eh5F6EXLfh0QbVh
         Y3VXE3I1wpdFa9i9jttO9DjuWlkB7nurBVEIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qRkjAmumwEtE677/8rQeqVnc6bdZGdl52weFwG/QF4w=;
        b=AfaKT4RI6b3WgLzRAsOmm/AmW/87vO6RLR8KtjdyynJqQn3OHGTjuyWm9GHcIwAVAl
         3QoARG5Kpxc+8HveA3pDMJ+9j4A8QX5aI3AU+tq33fF2LVnzA5IM/nXX9AdRDWB0uPLI
         VTMyHehtpYAD5nhIPdnzb/0wk6D73sRIjb9mjNLd2EYpIacRxJNY23tWSPIlEhSKL9BE
         DUd4wb0yUEiPPU4Goh9v7+24oRyWPC14hS8JemxOt5cvxrR8QkS6vmDwOxDi5lULn3/P
         Yw7U3kp1oSdBC7SJpegwa+pVJ1WARaYFcWuijESZj9Q2KvCzGvUBDNtOT8cwI3x7crax
         8zMQ==
X-Gm-Message-State: AOAM531qFoXHn1EbBTwOd9UZcHaJEo5KlOxf6oX61AWzLWEkx6/DCxbl
	bQEWHiuCKSvk91cve4kWw2+fSg==
X-Google-Smtp-Source: ABdhPJxc3xi1o9pZga1+chHRHgmV4wac3Kf7uaIXf03O6HU9wDW+lZJO1+uq61NNojlJHg5ooxUa6w==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr3144792wmi.70.1627654330865;
        Fri, 30 Jul 2021 07:12:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b? ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id b6sm1997595wmj.34.2021.07.30.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:12:10 -0700 (PDT)
Message-ID: <1f481e671364d3f3b6711d430636722d679db6f6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/4] doc/lib: Add fixes for issues missed by the automated conversion
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Jul 2021 15:12:09 +0100
In-Reply-To: <20210730141112.7j6n4pdpgfykp3vx@fedora>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
	 <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
	 <20210730141112.7j6n4pdpgfykp3vx@fedora>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-07-30 at 16:11 +0200, Quentin Schulz wrote:
> Hi Richard,
> 
> On Fri, Jul 30, 2021 at 02:47:05PM +0100, Richard Purdie wrote:
> > The examples and tests use non-standard override names, convert these to
> > the new syntax by hand.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> [...]
> > diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> > index 02a5c4952a..1b6b6d412e 100644
> > --- a/lib/bb/tests/parse.py
> > +++ b/lib/bb/tests/parse.py
> > @@ -144,7 +144,7 @@ PN = "bc"
> >  
> > 
> > 
> > 
> >  
> > 
> > 
> > 
> >      classextend = """
> > -VAR_var_override1 = "B"
> > +VAR_var:override1 = "B"
> 
> s/VAR_var:override1/VAR:var:override1/ ?

I think not since in this test case, var is not an override?

Cheers,

Richard

