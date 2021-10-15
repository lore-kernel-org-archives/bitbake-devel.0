Return-Path: <weaverjs@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C3C433EF
	for <webhook@archiver.kernel.org>; Fri, 15 Oct 2021 13:08:03 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web09.9060.1634303282395916040
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 06:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lQ7+PKi0;
 spf=pass (domain: gmail.com, ip: 209.85.222.170,
 mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id p4so8424309qki.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KsqCEtpUg9MnU6z+i2yCC9GatwgNwtcjlYQSuqUYsg=;
        b=lQ7+PKi0AFwXqMhgLkPPOw3zedA0SzUuwE409UoCDmLcNOC5lW1wQYq7x86L2/ED09
         Hj/8PUP0Dp3M1EGu42c/qLESwwAQzFLZ8ggE19qfsYMZPKfMJJoGwsgvIltwgoavHkDo
         U0BVz1VZZDLGNSKXHXYRn87aBeJqoXYIbd87IB+5YIYo+u9g3thhC+3MB+ko4tG1IC3f
         lr3RhLq88vK7NRKIolLdLNtWvky08Pk6s2e7l20PRKnsDilC1eAB4Auk5w1oKT1QjJvc
         Ejlq9lhKlOnrfvd97FjW4vH8xQclVmuRtu4MWV3B/Z96MzP5tfVAaWe3OdZpF1T+BGQ3
         m89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KsqCEtpUg9MnU6z+i2yCC9GatwgNwtcjlYQSuqUYsg=;
        b=Dk2hb9a1gYy10dZ7SRmpO7xlrFhDvlRhgBGsCk7knbtyHWm9mDghE24bJOOrszjgz4
         QZ15wpn4s5RraDS+IkP7TyM5Zkol5/pAGc3XGgcz99GkQTaqKGV9taqkWaOtvkeBwuqP
         Aqjj7IvtPTUIV7ghYoFw9ZGgrwxqR+Ujfi1XzKwJ1LTFEtyJtf77XNA2BWLU/a04V+tM
         8CorJQBFhFqJc+QiTr2heEmyAyexzXdUGRCCTCNzceYlDAj/0oqJ51oaBfZhok4wfowt
         ChrP7174XIoZxYloLu5Frq0TMFNzLCUYlwWJnoaJJ70VPA0/5JE1PqejZW+XdJ19b3+8
         Zh3A==
X-Gm-Message-State: AOAM530L78sa7wZUiPsjO8eNxXO3VzOz7Lg+l4OpvknN8xXOKneDs8dC
	Gd/ucsfGJ0BFkDF0vpM4NzBduUpcuBviALI=
X-Google-Smtp-Source: 
 ABdhPJwhvZ72tGM8WuL7ZekSdyNrbYZL9O7qBKDTk07eetAKqZrMqQKQvMlms+9Bwrn6RQo+fnQmwA==
X-Received: by 2002:a37:91c7:: with SMTP id
 t190mr9652585qkd.282.1634303281324;
        Fri, 15 Oct 2021 06:08:01 -0700 (PDT)
Received: from popos
 (2603-6011-2200-ab10-0ffa-44d4-9d59-6846.res6.spectrum.com.
 [2603:6011:2200:ab10:ffa:44d4:9d59:6846])
        by smtp.gmail.com with ESMTPSA id
 v3sm2604198qkd.20.2021.10.15.06.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:08:00 -0700 (PDT)
Date: Fri, 15 Oct 2021 09:07:58 -0400
From: Scott Weaver <weaverjs@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Chen Qi <Qi.Chen@windriver.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue with
 premirror
Message-ID: <YWl9LqGlSO+eB7Kp@popos>
References: <20211015061753.70640-1-Qi.Chen@windriver.com>
 <582824039f6ac8e11b9a5ff91256ee591372c1ec.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <582824039f6ac8e11b9a5ff91256ee591372c1ec.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Oct 2021 13:08:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12784

On 21-10-15 12:35:24, Richard Purdie wrote:
> On Thu, 2021-10-14 at 23:17 -0700, Chen Qi wrote:
> > The following commit to fix [Yocto #13039] causes regression of
> > the behavior of PREMIRRORS.
> > 
> >   "bitbake: fetch2: fix premirror URI when downloadfilename defined"
> > 
> > Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
> > as an example.
> > SRC_URI = "\
> >     http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
> >     ...
> > "
> > With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
> > freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
> > not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.
> > 
> > The commit above tries to avoid fetching from invalid url such as:
> > https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
> > And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
> > regression.
> > 
> > This patch fixes the above regression. For Yocto #13039, it now tries
> > to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.
> > 
> > Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> > ---
> >  lib/bb/fetch2/__init__.py | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 666cc1306..000b49a50 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> >                      # Kill parameters, they make no sense for mirror tarballs
> >                      uri_decoded[5] = {}
> >                  elif ud.localpath and ud.method.supports_checksum(ud):
> > -                    basename = os.path.basename(uri_decoded[loc])
> > -                if basename and not result_decoded[loc].endswith(basename):
> > -                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> > +                    basename = os.path.basename(ud.localpath)
> > +                if basename:
> > +                    uri_basename = os.path.basename(uri_decoded[loc])
> > +                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
> > +                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
> > +                    elif not result_decoded[loc].endswith(basename):
> > +                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> >          else:
> >              return None
> >      result = encodeurl(result_decoded)
>


Hi Richard and Chen,

> I've been meaning to reply to this thread as the regression wasn't good. We need
> to be able to use DL_DIR as a mirror.

It's my understanding that DL_DIR is always the last mirror attempted if
downloading the artifact from a SRC_URI, MIRRORS and PREMIRRORS fails.
In my testing, this still works.

What we're saying is that we want to be able to copy or use an exiting DL_DIR as a PREMIRROR.

If this is the use case then, yes, this is a regression but I'm just a
little confused because I always think of a mirror as just being an
alternate site where the artifact defined in the SRC_URI can be found.

Once that artifact is found and downloadfilename is defined it should
save the artifact using the name defined in downloadfilename.

My apologies for not understanding that downloadfilename also needs to
be tried when attempting to download from a premirror. I was going by this definition:

https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#var-SRC_URI

-- 
  - Scott


