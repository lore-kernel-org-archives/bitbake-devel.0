Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2491C433FE
	for <webhook@archiver.kernel.org>; Tue, 26 Apr 2022 21:55:18 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.990.1651010109387232664
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Apr 2022 14:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CTJCstjT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id u3so27302657wrg.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Apr 2022 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=shdmNfCXtEvn3+S2Xs0q3Mj7OGnGZypFqE0T0oTRDVM=;
        b=CTJCstjT8BMY4ag0WJlMSGIEN0AlRlwCw9DougPYzaEXnNetGSptcOZLVwn5xgWqxH
         l+olTGZtUrFaFSrKvZEDue+AWfMYViSP3HHrQi+QJA3rau7uB29I0jTTxlSrJh3kV5iq
         jwUuw9GqRaVRbNEF6H1f5Grs/HoKE2oDHAX7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=shdmNfCXtEvn3+S2Xs0q3Mj7OGnGZypFqE0T0oTRDVM=;
        b=AG7AICtGcruxK9MC+LRg6CaEiK5v1VM0ClaJJ7dolxoUZghMomIuEd3kzm7uII0CCo
         4H4NKvon3DnOqKPXFj1BuvrDIeeosxGXk6jOlVjM/CyFe2sG5Q1Ju7OHy2iXQj/KeEof
         yxgEDeM+LKkaK5pxFJJU5zQFgTRlTBAkqeZUczou/C48pvggB5BgAdUTm7iV0yHMWn1b
         he+MILsy9RpUYKPFDQLiTxqOgGEGK6lNWS+r0JVYIKxhEZe4BwnGZ0uTK0cC4zhORxAT
         GN2fEyeusPL7WWiU5YS0+OqNvNxR8RcmrDjV8puJGi0bHLntpUjr9NcVXGanJ1bomgZv
         Lvzg==
X-Gm-Message-State: AOAM531I9G9pjzRajkDwErCoLUfQwgm+rake9mkcQDs0IIZ/qYVzXNiA
	aoXBzV+fJMaG4Cll9B3G63aluS2kAF57SA==
X-Google-Smtp-Source: 
 ABdhPJyWoRwizOAyDHWyXBr6RBiINa/xKasV9+diBWf7m16O4vSZ45fa2hLzxfRk0dLmPU4PsT4wMg==
X-Received: by 2002:a05:6000:c7:b0:20a:d8c1:d044 with SMTP id
 q7-20020a05600000c700b0020ad8c1d044mr11241048wrx.422.1651010107951;
        Tue, 26 Apr 2022 14:55:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:aee4:ace8:5bdc:9ee3?
 ([2001:8b0:aba:5f3c:aee4:ace8:5bdc:9ee3])
        by smtp.gmail.com with ESMTPSA id
 g25-20020adfa599000000b0020aeb9e5bdfsm818328wrc.43.2022.04.26.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:55:07 -0700 (PDT)
Message-ID: 
 <00b365e72e066f0d5e36f2cd039e7acedceff00e.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual: document
 TEMPLATECONF environment variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Tue, 26 Apr 2022 22:55:06 +0100
In-Reply-To: <85d42805-0691-ccec-1f0b-f4be34ff8cc0@bootlin.com>
References: <20220426214901.201802-1-michael.opdenacker@bootlin.com>
	 <99a5bd79f212a830d28427c72dcf83f924c13cb9.camel@linuxfoundation.org>
	 <85d42805-0691-ccec-1f0b-f4be34ff8cc0@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Apr 2022 21:55:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13661

On Tue, 2022-04-26 at 23:53 +0200, Michael Opdenacker wrote:
> On 4/26/22 23:51, Richard Purdie wrote:
> > On Tue, 2022-04-26 at 23:49 +0200, Michael Opdenacker via lists.openembedded.org
> > wrote:
> > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > 
> > > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > ---
> > >  .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > > index af4ff980..80005580 100644
> > > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > > @@ -1483,6 +1483,22 @@ overview of their function and contents.
> > >        consist mostly of task logs and scripts, when building a particular
> > >        recipe.
> > >  
> > > +   :term:`TEMPLATECONF`
> > > +      Specifies the directory used by the build system to find templates
> > > +      from which to build the ``bblayers.conf`` and ``local.conf`` files.
> > > +      Use this variable if you wish to customize such files, and the default
> > > +      BitBake targets shown when sourcing the ``oe-init-build-env`` script.
> > > +
> > > +      For details, see the
> > > +      :yocto_docs:`Creating a Custom Template Configuration Directory
> > > +      </dev-manual/common-tasks.html#creating-a-custom-template-configuration-directory>`
> > > +      section in the Yocto Project Development Tasks manual.
> > > +
> > > +      .. note::
> > > +
> > > +         You must set this variable in the external environment in order
> > > +         for it to work.
> > > +
> > I don't think this is a bitbake variable, it is an OE one?
> 
> 
> Actually, it's used in toaster.
> But I don't mind adding it in Yocto Docs instead...

I did notice that but toaster breaks a few of the boundaries between bitbake and
OE. It is meant to be an OE specific variable.

Cheers,

Richard


