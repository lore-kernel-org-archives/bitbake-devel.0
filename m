Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.11329.1629645772754215159
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 08:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=cFYyNVSy;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: weaverjs@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id j9so8328960qvt.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fkG0cshGfmV4cfxUaqmJMGnIRMSvaNmhu1lO42lJdos=;
        b=cFYyNVSy9Y70kEKiZyHpMk7Q9/q9Ar6sufLdirINGT7HPyaEJDihCm0+aDypGKVrIi
         nhpWUZnrDCptjQ1Eu869VozD7vjt6xA18VRF7NFjU5eHtAld+VLLanq1kfeuill7IR92
         2+sSrNEpNO/G5hxdnIpAha/PG7jJJovwAf3jRW+pldzsPT443UM7ShzfuyeZhuhpQ+od
         vByGtpfljhHF/0ecIjt+KIHfig8KtiMWH7u9pWzsF4dvw46oqLmU1cLwj9Dp/pWW1cjq
         0iMPR4rXWhVO21d+usagN+4+Lxv2o94RGbnNKU+HfWXLiNn6Fq6OIUNp+P1MA1mzEOGA
         fHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkG0cshGfmV4cfxUaqmJMGnIRMSvaNmhu1lO42lJdos=;
        b=r024KuFRtTNTrmOnyGBg0KPHiz3JfeuvOIyxoA3r+ebTfjzP4xmeIRUMSShmrV1ToP
         hsrB/V6lbrHhp+olNdjZVGkFNq5lgWtXODVubEvpVdkCOztvSYpASkU1eDTvdX+TCk/d
         UeVyRbacOJiO/6ZQcgDwVax+Lk1n27ta+TwEqjD8fD/bTjD7uCAah+xiv3l8YTgHd80l
         D64DIXqY3jBF0XGNQO7rJWFq4XRWzwtuR+ftGuf6H7fqSyl2JVluyg5/2cz6jBTYX5wB
         U27cgaVSlHQFc3blOHEAM3KVh3PATM+5P5EP8lD36sfucChJgBz+YxYxOe7zUglvu3dS
         T9Dw==
X-Gm-Message-State: AOAM531JgZ9JdwqyFQLllIvQZMfDz0JDPtWCNuqbTVWicTL9MZEHsiZy
	MQzQu5lI2UPPoV8YwOar0lmvUBk=
X-Google-Smtp-Source: ABdhPJyJYgJkhRcGFSqOVNmVurh9juB+pfHx84gL1Iezv7oYALxZ5TocMmpu0ebPVsoQlQ5Jnfg7ZQ==
X-Received: by 2002:a05:6214:2609:: with SMTP id gu9mr28482369qvb.35.1629645771860;
        Sun, 22 Aug 2021 08:22:51 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from popos (2603-6011-2200-ab10-1728-f536-0632-26f3.res6.spectrum.com. [2603:6011:2200:ab10:1728:f536:632:26f3])
        by smtp.gmail.com with ESMTPSA id n18sm7101457qkn.63.2021.08.22.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 08:22:51 -0700 (PDT)
Date: Sun, 22 Aug 2021 11:22:49 -0400
From: "Scott Weaver" <weaverjs@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [bitbake][PATCH] bitbake: fetch2: correct PREMIRROR URI
Message-ID: <YSJryQCkMbaRoDOl@popos>
References: <20210822123447.3477259-1-weaverjs@gmail.com>
 <85b0c274cea943fc63070ac2eb0c1306a17d102a.camel@linuxfoundation.org>
 <YSJLK8Os0/yp1p4c@popos>
MIME-Version: 1.0
In-Reply-To: <YSJLK8Os0/yp1p4c@popos>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21-08-22 09:03:39, Scott Weaver wrote:
> On 21-08-22 13:40:06, Richard Purdie wrote:
> > On Sun, 2021-08-22 at 08:34 -0400, Scott Weaver wrote:
> > > When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
> > > defined for that URI, the downloadfilename is appended to the mirror URI and it
> > > should not be.
> > > 
> > > [YOCTO #13039]
> > > 
> > > Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> > > ---
> > >  bitbake/lib/bb/fetch2/__init__.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> > > index 914fa5c024..0bcd566e83 100644
> > > --- a/bitbake/lib/bb/fetch2/__init__.py
> > > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > > @@ -467,7 +467,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> > >                      uri_decoded[5] = {}
> > >                  elif ud.localpath and ud.method.supports_checksum(ud):
> > >                      basename = os.path.basename(ud.localpath)
> > > -                if basename and not result_decoded[loc].endswith(basename):
> > > +                if basename and result_decoded[loc].endswith('/'):
> > >                      result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> > >          else:
> > >              return None
> > 
> > Thanks for the patch. Should we be adding a test for this to
> > lib/bb/tests/fetch.py (run with bitbake-selftest)?
> 
> I'll look into that. I'm not familiar with the selftest but it's a good
> opportunity to learn. :)

Well, I've learned that this patch breaks the selftest.
I was wondering what the usecase was for the original line I changed but
it seems this code is sensitive to whether PREMIRRORS is defined with a
trailing '/' or not.
I'll dig deeper.

> 
> > 
> > Cheers
> > 
> > Richard
> > 
> 

-- 
  - Scott

