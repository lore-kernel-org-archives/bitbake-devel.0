Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.16003.1627594264490600490
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 14:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RYik5clm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so4939865wms.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jul 2021 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bX4nlt2cHCQEs/+PTtSQ7jahAPBukX8yc36/mYFsntc=;
        b=RYik5clm85YqRsUphtF0PqaOWjmFvA/tudhMUs0p9jpas1fUvrnuUKJzybUQWn2TEj
         WxndKTumKvrDghLDFNGqX/V8Qu2wzoEjNA9DqtEiDlL6Hisadtwj/TWOuqTJKk2DKrAu
         niyg7OHLAjdPeUK08MaJPR6rKT2rdWOXBgAz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bX4nlt2cHCQEs/+PTtSQ7jahAPBukX8yc36/mYFsntc=;
        b=bwtpgkE2BKkbomC9lPsYUCSngTRFcLAJpgXwbsDIBk675gppxOVywXziylnUu81NO6
         Eqd7ZgpPjDlilCNxOXR//qVIc8lBgQce9TtiuY5hLc9zHb11ugDtM9NLZktFbgtA7CWq
         9mfBJbuosVrziK8t2y+d+nfl1shiVXt0di3qkQu6M7L29FNL1mebtUdZSyWvs6/kvOTd
         ppuhd+lg3qSo6ZWBfNGx1m2vORGQfsHRYFxEyJi91NjGj2aZ396ZA9XfV8TjSaLATYds
         aG115v5eJTYG3+mBDwo1Hwv0UR+MPd3tj2yJTY3PpQqtxsAP4u9k4pL0FjK2yd1Zf4wf
         d7XQ==
X-Gm-Message-State: AOAM530BHQSqq3nS2xt0dft9DpYjxu0ecYPp1YvpTaPyGIBl0ZrkcN9J
	v4nVpIvHWnuXuCTTpy95oLTmzw==
X-Google-Smtp-Source: ABdhPJz7rMnG8vTeLsaQmeYm4oqq82ne1IFtDjzBmaTZH56LRsVfpOwkvkJznz7MuRBUO5PXCxjSTg==
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr6792327wmo.46.1627594262991;
        Thu, 29 Jul 2021 14:31:02 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:89c8:a51f:1301:604b? ([2001:8b0:aba:5f3c:89c8:a51f:1301:604b])
        by smtp.gmail.com with ESMTPSA id t17sm4630925wru.94.2021.07.29.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:31:02 -0700 (PDT)
Message-ID: <ebf96a35dd0205f17136e1c60860224889006890.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: grammar fix for the number of "metadata"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Michael
 Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Date: Thu, 29 Jul 2021 22:31:01 +0100
In-Reply-To: <20210729130521.e5dkww5yktdf3uno@fedora>
References: 
	<9aebdc2ca149587d39cd23628c392423148f22ba.camel@linuxfoundation.org>
	 <20210729130133.163787-1-michael.opdenacker@bootlin.com>
	 <20210729130521.e5dkww5yktdf3uno@fedora>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-07-29 at 15:05 +0200, Quentin Schulz wrote:
> Hi Michael,
> 
> On Thu, Jul 29, 2021 at 03:01:33PM +0200, Michael Opdenacker wrote:
> > "metadata" is used both as singular and as plural.
> > The first change fixes a case in which the verbs have a singular conjugation
> > but articles that indicate a plural case.
> > 
> > The second change is for consistency with the first one inside
> > the same paragraph.
> > 
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > ---
> >  doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> > index eb140665..64e7305d 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> > @@ -27,11 +27,11 @@ Linux software stacks using a task-oriented approach.
> >  Conceptually, BitBake is similar to GNU Make in some regards but has
> >  significant differences:
> >  
> > 
> > 
> > 
> > --  BitBake executes tasks according to provided metadata that builds up
> > +-  BitBake executes tasks according to provided metadata that build up
> >     the tasks. Metadata is stored in recipe (``.bb``) and related recipe
> 
> Then "Metadata are" here seems appropriate to me. What do you think?

I'd have said "Metadata is stored in recipes"...

Cheers,

Richard 

