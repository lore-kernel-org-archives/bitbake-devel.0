Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web08.15395.1629667482262709098
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 14:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CqDAngOt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id g138so9288535wmg.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7B6FGaN8ghjEGWdr+cbXVkrSrQvNwSoZVRojzFiBFwg=;
        b=CqDAngOtkMIJHrN0i3SVzwho0LXFc1QDWjCaow9kutskVxvymw6MEo9DBKNOpWYNrh
         UmEEyeXfOPwr3wWNOCSkwzeo/J77JaR64twwe+ii0X/nHvKdwO/hyvwUcaEeUViOcFD3
         M9FC/6OpMDdXZr6jN/xInGH4wxouqennB85o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7B6FGaN8ghjEGWdr+cbXVkrSrQvNwSoZVRojzFiBFwg=;
        b=Z4zfVnqJr3zQtkUxNGj8+cmu67EITdwdXDUoRVMcSCU1yoH6rxn9CIJMQIsTpzFDx5
         h2kinKN0uOiEtnUrwdcufmDVplO73joqEH/HGtDOTD9NB+DaDGT61TLDaPhqR5liqMv7
         mmuWb1ZUUGCzbt25nKbXCjLpImWnqxR5AQ9ytkK8+99Pzh8Tax+zms4npuY6vz+thk1V
         AlVRu3G+kxy0BgqRS2ImE6lZCPgvzNq7wQRqocKj1SZpI75RZWEVmAD5QQwk0IDTtlXU
         R+BPyYmYebCJQtgyvYrGKefpanAzZl7+ywIlZ/kUj9R9aLg5/2r3guMQJZhcl1Oi9HTZ
         k3mQ==
X-Gm-Message-State: AOAM533VcLcDz1KmAlFCLsIYfMLvOHX2D2S0Bu6RYd7UYR4683Fk90bG
	OIqrM0nORet/7kVNs6V511fScA==
X-Google-Smtp-Source: ABdhPJwmjYBcDHMlTANgDDwFCfLd3JIKnw3eiY7zYXv5m2C4Fq1Y3+e67Q79cB6178wPW4PoVhfvuA==
X-Received: by 2002:a05:600c:3b15:: with SMTP id m21mr13629976wms.186.1629667480552;
        Sun, 22 Aug 2021 14:24:40 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:d09e:54e5:5f12:c43c? ([2001:8b0:aba:5f3c:d09e:54e5:5f12:c43c])
        by smtp.gmail.com with ESMTPSA id w1sm16397972wmc.19.2021.08.22.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 14:24:40 -0700 (PDT)
Message-ID: <8e34f61d927b230cd9952ab7daafedc84150bf9a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][PATCH] bitbake: fetch2: correct PREMIRROR URI
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Scott Weaver <weaverjs@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Aug 2021 22:24:38 +0100
In-Reply-To: <YSJryQCkMbaRoDOl@popos>
References: <20210822123447.3477259-1-weaverjs@gmail.com>
	 <85b0c274cea943fc63070ac2eb0c1306a17d102a.camel@linuxfoundation.org>
	 <YSJLK8Os0/yp1p4c@popos> <YSJryQCkMbaRoDOl@popos>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2021-08-22 at 11:22 -0400, Scott Weaver wrote:
> On 21-08-22 09:03:39, Scott Weaver wrote:
> > On 21-08-22 13:40:06, Richard Purdie wrote:
> > > On Sun, 2021-08-22 at 08:34 -0400, Scott Weaver wrote:
> > > > When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
> > > > defined for that URI, the downloadfilename is appended to the mirror URI and it
> > > > should not be.
> > > > 
> > > > [YOCTO #13039]
> > > > 
> > > > Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> > > > ---
> > > >  bitbake/lib/bb/fetch2/__init__.py | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> > > > index 914fa5c024..0bcd566e83 100644
> > > > --- a/bitbake/lib/bb/fetch2/__init__.py
> > > > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > > > @@ -467,7 +467,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> > > >                      uri_decoded[5] = {}
> > > >                  elif ud.localpath and ud.method.supports_checksum(ud):
> > > >                      basename = os.path.basename(ud.localpath)
> > > > -                if basename and not result_decoded[loc].endswith(basename):
> > > > +                if basename and result_decoded[loc].endswith('/'):
> > > >                      result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> > > >          else:
> > > >              return None
> > > 
> > > Thanks for the patch. Should we be adding a test for this to
> > > lib/bb/tests/fetch.py (run with bitbake-selftest)?
> > 
> > I'll look into that. I'm not familiar with the selftest but it's a good
> > opportunity to learn. :)
> 
> Well, I've learned that this patch breaks the selftest.

I had wondered but hadn't got to testing that yet. Where we find corner cases we
do try and teach the test suite so we try and avoid regressions. We've had a lot
of issues with this kind of thing in the past.

> I was wondering what the usecase was for the original line I changed but
> it seems this code is sensitive to whether PREMIRRORS is defined with a
> trailing '/' or not.
> I'll dig deeper.

Thanks, I don't doubt there are issues in there and hopefully the testsuite will
show it's value and help figure through things!

Cheers,

Richard

