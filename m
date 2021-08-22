Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web12.9724.1629637422976975781
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 06:03:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mV8b166C;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: weaverjs@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id u21so8604878qtw.8
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lt6XTnjwTxlKok5SXlFU4PKZNtRcZQiJo+g1vp3MhwY=;
        b=mV8b166CgxLhowLgjUBJBukggj3pePAS/xbC+BAPlMxABFrR/qGFbqucuTdP80/YCt
         lv4zcytHf88bOslTbeJyVlHxLytmZqRMtYJZiO1Kqs9qyGv2kfXi3WOcBA1tAn2iTcQa
         VyJUP3WIaiEXN6EWc5uBIonhgWotI8fpSeLGV9iPd6O+GSiiAEglUqGiOXsq+OeZ6AhI
         y6YH9SRSN5cj83+s3Ps6c6T+eI9rt3WWjlv4aY4x4wqxe05g35vZuoqyiRUDGlNl0VFw
         K53gOW5j6RosD/INKfBWAlHLAVvgCWVzpZnLwC2bYuwSICnKhoo8wZjN4kqb0/lZJL+y
         n/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lt6XTnjwTxlKok5SXlFU4PKZNtRcZQiJo+g1vp3MhwY=;
        b=WvCViiCuTxvTxseMlWHRl0WWY5POo6RPGUSXFC+R4wZuDsQ/IrHIjvMDQ48Hx1o07k
         OSBeY38VMWbf4p+UJjYL8cChc+4xPBj/ZJxvZxgUl4UY6u5POus7EjDTj1BEU94jq4Mg
         U9X23X3ueSlBWfV3nnuyDmeHtrQqZZXogWlewTR0TQLhNNrlZDIWlIjHpEkaZmt03bi0
         zk0ElAdn6Um+KXA/jkFPldHgCe/jb0FiH5TV4R1p9cl+Bl1H4Xj2/aLTUvHRx43egHfx
         Fr0o+nEWQmnLh6J0jaBhJ0S5p+SeJXFKNelyH+xOw4JFNwC96JStXP6Q9zmqmGWZJ493
         Qlfw==
X-Gm-Message-State: AOAM532KIXtgMAewFAgwyLtu5a10VxQvTwfyVEUqxNv/p97oghMyMlXO
	2RPnNezKlgg+o0IpjzXynE68mf4=
X-Google-Smtp-Source: ABdhPJxdQg0Jqlg/PCEch2SwOL/jXcsNAYAjbkzBfL8jj+q/1E6KNnZFzygREDvqU2x2sZ8WbU2cdA==
X-Received: by 2002:ac8:5fd3:: with SMTP id k19mr19708670qta.323.1629637422092;
        Sun, 22 Aug 2021 06:03:42 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from popos (2603-6011-2200-ab10-1728-f536-0632-26f3.res6.spectrum.com. [2603:6011:2200:ab10:1728:f536:632:26f3])
        by smtp.gmail.com with ESMTPSA id c11sm5201169qth.29.2021.08.22.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:03:41 -0700 (PDT)
Date: Sun, 22 Aug 2021 09:03:39 -0400
From: "Scott Weaver" <weaverjs@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [bitbake][PATCH] bitbake: fetch2: correct PREMIRROR URI
Message-ID: <YSJLK8Os0/yp1p4c@popos>
References: <20210822123447.3477259-1-weaverjs@gmail.com>
 <85b0c274cea943fc63070ac2eb0c1306a17d102a.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <85b0c274cea943fc63070ac2eb0c1306a17d102a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21-08-22 13:40:06, Richard Purdie wrote:
> On Sun, 2021-08-22 at 08:34 -0400, Scott Weaver wrote:
> > When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
> > defined for that URI, the downloadfilename is appended to the mirror URI and it
> > should not be.
> > 
> > [YOCTO #13039]
> > 
> > Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> > ---
> >  bitbake/lib/bb/fetch2/__init__.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> > index 914fa5c024..0bcd566e83 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -467,7 +467,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> >                      uri_decoded[5] = {}
> >                  elif ud.localpath and ud.method.supports_checksum(ud):
> >                      basename = os.path.basename(ud.localpath)
> > -                if basename and not result_decoded[loc].endswith(basename):
> > +                if basename and result_decoded[loc].endswith('/'):
> >                      result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> >          else:
> >              return None
> 
> Thanks for the patch. Should we be adding a test for this to
> lib/bb/tests/fetch.py (run with bitbake-selftest)?

I'll look into that. I'm not familiar with the selftest but it's a good
opportunity to learn. :)

> 
> Cheers
> 
> Richard
> 

-- 
  - Scott

