Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D69C433FE
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 22:18:00 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.3488.1633558679422447299
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 15:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fwN8OFYp;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id u18so13063507wrg.5
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/VVBn5ogEg5Co+pUTwuW6ImxlZ0vRF0UNyA7gzcKz3g=;
        b=fwN8OFYpyRyRxHLHjxEGggBBls3w62UvojN5EYjCl5SyIeCSKFhqbFntkuGLlkn4IP
         mcxqT+OxFtTNYM6mTvA+1u93x+3RiKKFQpEVHBVmlEYI7URU/pELyhouOJwtwIvwpPTG
         DIdXRjsCiVSGARkGz/itn+4daCvkMZPH84jXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/VVBn5ogEg5Co+pUTwuW6ImxlZ0vRF0UNyA7gzcKz3g=;
        b=7QQZSfZhaEo6uw/uygTVzx+XwkH0J7DxF4UXlmRbm9r7eD5cVdGtRj7nGO2RFQnW8n
         A3ELkyagXRcpNeZE+VvLpeMD1JpWWW3cM1GWkOJHm394WMidkS/FAzqbB8jh62gqdny5
         VEQ7654D5P6d49B8vItJIryIQj66vIsPMIVZBB+LrSUd7D+2jduBrxct4Mj0pRaoPHDW
         QKkZZBjgnlRSEqp/tZCXc259e0O+vpJTpKf9n7G/meK/Y0/AWfl2JNGIXN5t/W5fj9Qa
         tWUIXDhIS0Q4uRu3+ALQ/4QAxH1OcZc59R+S2hP9Xe4WCT1n0qOeGGhjsj7IWevuShc+
         BU5Q==
X-Gm-Message-State: AOAM532eQ7+H9A2WKGbBREhQcURSOrCurbPAmM1hF7LlRB4/xHZIE3Aa
	9rUJxEf/TZu93wcnta5q6EQjmA==
X-Google-Smtp-Source: 
 ABdhPJwG5XPprOFvvGccEZjnsDJdIiMRnXTaQ2W6D1gsYWeQSwX8YJUs0e7WrICoEHz2Pi21p4QgvQ==
X-Received: by 2002:adf:a34b:: with SMTP id d11mr799700wrb.107.1633558677841;
        Wed, 06 Oct 2021 15:17:57 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4ef0:3e29:718c:a98a?
 ([2001:8b0:aba:5f3c:4ef0:3e29:718c:a98a])
        by smtp.gmail.com with ESMTPSA id y5sm7159852wma.5.2021.10.06.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:17:57 -0700 (PDT)
Message-ID: 
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] documentation: update
 sources mirror URL
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jon Mason <jdmason@kudzu.us>, Michael Opdenacker
	 <michael.opdenacker@bootlin.com>
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Date: Wed, 06 Oct 2021 23:17:54 +0100
In-Reply-To: 
 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
References: <20211005224513.14134-1-jdmason@kudzu.us>
	 <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
	 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Oct 2021 22:18:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12734

On Wed, 2021-10-06 at 15:53 -0400, Jon Mason wrote:
> On Wed, Oct 6, 2021 at 10:41 AM Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
> > 
> > Hi Jon
> > 
> > Thanks for the proposed update !
> > 
> > On 10/6/21 12:45 AM, Jon Mason wrote:
> > > The URL for the sources mirror no longer works.  Update to the new
> > > location.
> > > 
> > > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> > > ---
> > >  documentation/ref-manual/faq.rst       | 15 ++++++++-------
> > >  documentation/ref-manual/variables.rst |  8 ++++----
> > >  2 files changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
> > > index d3a603d4a438..f06abc84ee6f 100644
> > > --- a/documentation/ref-manual/faq.rst
> > > +++ b/documentation/ref-manual/faq.rst
> > > @@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
> > >  ``local.conf`` configuration file::
> > > 
> > >     PREMIRRORS:prepend = "\
> > > -       git://.*/.* http://www.yoctoproject.org/sources/ \n \
> > > -       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
> > > -       http://.*/.* http://www.yoctoproject.org/sources/ \n \
> > > -       https://.*/.* http://www.yoctoproject.org/sources/ \n"
> > > +       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > > +       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > > +       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> > > +       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
> > 
> > 
> > Hey, doesn't it sound weird to show an example that proposes to use http
> > when https is usually recommended?
> > What about proposing https://downloads.yoctoproject.org/mirror/sources/
> > instead?
> > 
> > Or we don't really care because we use source checksums anyway?
> > 
> > Just my two cents. I don't mind accepting the patch as is.
> 
> A quick and dirty grep of the trees shows many occurrences of
> downloads.yoctoproject.org without https.  Perhaps it would be good to
> correct all of these in a follow-on patch.  I can do a quick patch of
> all of these and get that out in the next day or so.
> 
> Also, looking at documentation/profile-manual/usage.rst (where most of
> the occurrences in the docs are), shouldn't we have a newer kernel
> than 2.6.19.2 as an example?  I mean, it's almost 15 years old.

Careful, some of us remember working on the 2.6.19 kernel and have patches in it
:)

I don't think we've worried too much about http vs https for the downloads as
they are checksumed but it is probably cleaner just to convert them.

Cheers,

Richard






