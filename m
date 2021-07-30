Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.24331.1627654285007807803
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 07:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aTr1y2VN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso7818652wms.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MIatyQV+i4dULOGyiOtU042ljadQnFeuEEFEwsvCDoo=;
        b=aTr1y2VN7lUWLdXOL83PhlhXoTnQ0luWbN3se2gNp9vI4zb62NUsnQ23v0uQtTnD3/
         Bgx8wbaKmu1A9mG8SvrKCPx3/foAZRVC6ofjrdlZDmQT9jc/wFXQCeJNX+1E+sJXo30F
         7pRUXnniAuuGOnkkTpWHFNWM4sE5iuAmXWM3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MIatyQV+i4dULOGyiOtU042ljadQnFeuEEFEwsvCDoo=;
        b=RLMPxJWViCK8N+iD4m/aZcWoosFpPOQZUk3B3eJEy2SzZAqEy1Kd43xNKTYmhsecAS
         j78ePtJZvYdEHmvOqEUkVYsKJa60WJRmXhe2d83VQkHlO5cD9la9BEObmY/0nEz77MbN
         HN5F2bWWbD4ZFLpUWjpbE9unHhKcXjnmSSYjWSb60Q1fRYZKiOgJFtdRfITuBjM1CkGw
         iNLxlwJyII3/5BVlgJBW2iXCx4j2dHQ8zx1hTL59j+9gTGUSaQdHphczijEOE+PInasx
         GKgoF8qbkAOoq/zo7y+PfKmUrQ2Ik+FqQsiPx5LUt3KnF1aIlh+IXy6+QNO6j9n5U2yP
         GUuw==
X-Gm-Message-State: AOAM531EVuofquCUOTrnUbWNxMlDF+RP65zhKxGKUdtN9NRIsS6GtcNT
	2HlOo0ihctSxtS15Z5KfssIHWw==
X-Google-Smtp-Source: ABdhPJylA/RM3r/nk+ETikWdxXWDrWp3o242SwYid7oi0VgNtO9TN7vd4wXFcVop2KMYyjfGn0hNZw==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr3133129wmc.86.1627654283318;
        Fri, 30 Jul 2021 07:11:23 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b? ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id w1sm1983735wmc.19.2021.07.30.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:11:23 -0700 (PDT)
Message-ID: <ac49ab278c80f87ed190355bd489a83994f131e0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/4] doc/lib: Update to use new override syntax containing colons
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Jul 2021 15:11:21 +0100
In-Reply-To: <20210730140804.fsmnmhdxvbdbtcdb@fedora>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
	 <20210730134706.3360651-2-richard.purdie@linuxfoundation.org>
	 <20210730140804.fsmnmhdxvbdbtcdb@fedora>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-07-30 at 16:08 +0200, Quentin Schulz wrote:
> Hi Richard,
> 
> On Fri, Jul 30, 2021 at 02:47:04PM +0100, Richard Purdie wrote:
> > This runs the overrides conversion script in OE-Core over the bitbake code
> > base including the docs. A handful of things were excluded in toaster
> > and for the Changelog file.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  contrib/vim/plugin/newbbappend.vim            |  2 +-
> >  .../bitbake-user-manual-metadata.rst          | 64 +++++++++----------
> >  .../bitbake-user-manual-ref-variables.rst     | 14 ++--
> >  lib/bb/fetch2/__init__.py                     |  2 +-
> >  lib/bb/tests/data.py                          | 52 +++++++--------
> >  lib/bb/tests/parse.py                         | 16 ++---
> >  lib/toaster/orm/models.py                     |  2 +-
> >  lib/toaster/toastergui/views.py               |  6 +-
> >  .../management/commands/buildimport.py        |  2 +-
> >  9 files changed, 80 insertions(+), 80 deletions(-)
> > 
> > diff --git a/contrib/vim/plugin/newbbappend.vim b/contrib/vim/plugin/newbbappend.vim
> > index e04174cf62..3f65f79cdc 100644
> > --- a/contrib/vim/plugin/newbbappend.vim
> > +++ b/contrib/vim/plugin/newbbappend.vim
> > @@ -20,7 +20,7 @@ fun! NewBBAppendTemplate()
> >      set nopaste
> >  
> > 
> > 
> > 
> >      " New bbappend template
> > -    0 put ='FILESEXTRAPATHS_prepend := \"${THISDIR}/${PN}:\"'
> > +    0 put ='FILESEXTRAPATHS:prepend := \"${THISDIR}/${PN}:\"'
> >      2
> >  
> > 
> > 
> > 
> >      if paste == 1
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > index 3e14163ebe..db44e26fbd 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > @@ -281,11 +281,11 @@ operators in that their effects are applied at variable expansion time
> >  rather than being immediately applied. Here are some examples::
> >  
> > 
> > 
> > 
> >     B = "bval"
> > -   B_append = " additional data"
> > +   B:append = " additional data"
> >     C = "cval"
> > -   C_prepend = "additional data "
> > +   C:prepend = "additional data "
> >     D = "dval"
> > -   D_append = "additional data"
> > +   D:append = "additional data"
> >  
> > 
> > 
> > 
> >  The variable :term:`B`
> >  becomes "bval additional data" and ``C`` becomes "additional data cval".
> > @@ -312,10 +312,10 @@ When you use this syntax, BitBake expects one or more strings.
> >  Surrounding spaces and spacing are preserved. Here is an example::
> >  
> > 
> > 
> > 
> >     FOO = "123 456 789 123456 123 456 123 456"
> > -   FOO_remove = "123"
> > -   FOO_remove = "456"
> > +   FOO:remove = "123"
> > +   FOO:remove = "456"
> >     FOO2 = " abc def ghi abcdef abc def abc def def"
> > -   FOO2_remove = "\
> > +   FOO2:remove = "\
> >         def \
> >         abc \
> >         ghi \
> > @@ -349,15 +349,15 @@ If, on the other hand, ``foo.bbclass``
> >  uses the "_append" operator, then the final value of ``FOO`` will be
> >  "initial val", as intended::
> >  
> > 
> > 
> > 
> > -   FOO_append = " val"
> > +   FOO:append = " val"
> >  
> > 
> > 
> > 
> >  .. note::
> >  
> > 
> > 
> > 
> >     It is never necessary to use "+=" together with "_append". The following
> >     sequence of assignments appends "barbaz" to FOO::
> >  
> > 
> > 
> > 
> > -       FOO_append = "bar"
> > -       FOO_append = "baz"
> > +       FOO:append = "bar"
> > +       FOO:append = "baz"
> >  
> > 
> > 
> > 
> >  
> > 
> > 
> > 
> >     The only effect of changing the second assignment in the previous
> > @@ -538,12 +538,12 @@ variable.
> >     that value based on the architecture of the build::
> >  
> > 
> > 
> > 
> >        KBRANCH = "standard/base"
> > -      KBRANCH_qemuarm = "standard/arm-versatile-926ejs"
> > -      KBRANCH_qemumips = "standard/mti-malta32"
> > -      KBRANCH_qemuppc = "standard/qemuppc"
> > -      KBRANCH_qemux86 = "standard/common-pc/base"
> > -      KBRANCH_qemux86-64 = "standard/common-pc-64/base"
> > -      KBRANCH_qemumips64 = "standard/mti-malta64"
> > +      KBRANCH:qemuarm = "standard/arm-versatile-926ejs"
> > +      KBRANCH:qemumips = "standard/mti-malta32"
> > +      KBRANCH:qemuppc = "standard/qemuppc"
> > +      KBRANCH:qemux86 = "standard/common-pc/base"
> > +      KBRANCH:qemux86-64 = "standard/common-pc-64/base"
> > +      KBRANCH:qemumips64 = "standard/mti-malta64"
> >  
> > 
> > 
> > 
> >  -  *Appending and Prepending:* BitBake also supports append and prepend
> >     operations to variable values based on whether a specific item is
> > @@ -551,7 +551,7 @@ variable.
> >  
> > 
> > 
> > 
> >        DEPENDS = "glibc ncurses"
> >        OVERRIDES = "machine:local"
> > -      DEPENDS_append_machine = "libmad"
> > +      DEPENDS:append_machine = "libmad"
> >  
> > 
> > 
> > 
> 
> s/DEPENDS:append_machine/DEPENDS:append:machine/


This patch was the automated conversion, there is a followup patch which
does fix most of these, I haven't checked them all. Could you have a look and see
if that does catch the other issues?

I left them as two separate patches since it makes it clear the things the script
does and does not fix.

Cheers,

Richard


