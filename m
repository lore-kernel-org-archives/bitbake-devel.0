Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.21592.1590698648264757348
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 13:44:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DwyN83pa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id j16so724567wrb.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NW9glXMD7BlllT3PBG7fT+KlHjtWIxQ8jADuUs7j+mc=;
        b=DwyN83pajIV/kLlY1ajdNdRf9xQJj4Ry+kZMnvi0s4pNuOjuWjmj1/ktzJgtuRHLZK
         O2LSXtoO9A/VF5iKCgfJdU7i+x4kYgph+GYopibN/Rju/AIOXxRm6SIY+hRTL0YHqcPC
         D8WxfUN+gTfnr56ZZ0G7Luky3/JnPaWIbB29U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NW9glXMD7BlllT3PBG7fT+KlHjtWIxQ8jADuUs7j+mc=;
        b=hqlSKZZMmC5U1SVcg58jUclTBdrA5rf5g0PmY+X3puHr+7HcWIeasfqTDaAZKdzuSO
         FZdB6CheAWS+YlGB8zJIQZnzw318xxMib78FkZ7xjflz3v5gq/js0FmY/uZaWf6Ozm/o
         R5dvCyMIWp6qJdBfACbfY9WjxXKzUvh++xbUpzmLdTc474j2+0EtwO0m9d2G9tYlWQAe
         /iq8XZfYJRhbHHMXQGEa9uRnBqVnSNEIjGPOyGXV+E8R18tuUo7p1W7DTL1N0p4QIOgT
         czJhNtSKR9SxJL7JzhmCr2M1ToZCmZVgJA/Pe6aFMKIEUW4aUXPr+2u6VLcvEZZozjHc
         5VBQ==
X-Gm-Message-State: AOAM531/fNBQ1Vcay7C6WcJzCHmvcc3W2v33JvnKCZtT7sZjNQIvSqTF
	DlAUl6LsHIGo0jyq4tmehJwR+Q==
X-Google-Smtp-Source: ABdhPJxKa5/Sc99hRIpB2v/ENNi5w/nL4uZQ2Oo6pEay0WrU553FSe4toVAqE9MXvP1y/FY1TshIig==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr5141285wrw.404.1590698646706;
        Thu, 28 May 2020 13:44:06 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id u74sm7597062wmu.13.2020.05.28.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:44:05 -0700 (PDT)
Message-ID: <6d8ab0cddad89cff295e26c8d406ee66f0432232.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] doc: Clarify how task dependencies relate to RDEPENDS
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Denys Dmytriyenko <denis@denix.org>, Jacob Kroon <jacob.kroon@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2020 21:44:04 +0100
In-Reply-To: <20200527200601.GN17660@denix.org>
References: <20200526192146.420290-1-jacob.kroon@gmail.com>
	 <20200527200601.GN17660@denix.org>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-05-27 at 16:06 -0400, Denys Dmytriyenko wrote:
> On Tue, May 26, 2020 at 09:21:46PM +0200, Jacob Kroon wrote:
> > Clarify that BitBake knows how to map entries defined in the runtime
> > dependency namespace back to build-time dependencies (recipes) in
> > which tasks are defined.
> > 
> > Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> > ---
> >  doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> > index 10b58835..95a8b95b 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> > @@ -2526,6 +2526,9 @@
> >                  In the previous example, the <filename>do_packagedata</filename>
> >                  task of each item in <filename>RDEPENDS</filename> must have
> >                  completed before <filename>do_package_qa</filename> can execute.
> > +                Although <filename>RDEPENDS</filename> contains entries from the
> > +                runtime dependency namespace, BitBake knows how to map them back
> > +                to the build-time dependency namespace, in which the tasks are defined.
> 
> That is quite an important clarification!
> 
> While working on multiconfig, I faced this issue - I can get build 
> dependencies covered by "mcdepends", but there's no way to pull the 
> resulting packages into images or SDK, as RDEPENDS or anything that 
> results in RDEPENDS (IMAGE_INSTALL, PACKAGE_INSTALL, etc) all trigger 
> this build-time dependency namespace check in bitbake and end up in 
> errors like "Nothing RPROVIDES <blah>".
> I wonder if multiconfig-aware RDEPENDS is needed to bypass this?

Possibly. The challenge is that this RDEPENDS resolution is already
horribly complicated and I'm not sure such dependencies are going to be
at all easy to implement :(.

Cheers,

Richard

