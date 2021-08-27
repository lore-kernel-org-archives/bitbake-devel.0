Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web09.5468.1630053074798878944
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Aug 2021 01:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HRmE2yNH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso8613012wmb.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Aug 2021 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Rgy1l4CLQDBZp2GTWyxkA5s5WS7JLd6DebMbmQyN8eA=;
        b=HRmE2yNHoHWLiQ/zfRskkuG3qN1s/KmrBA2dB+xiVMBTVTEw3+NgYOihEKpxbzVOFy
         gvjJ0HvXyTOrISOqUVMP59zme/MqTIQXsyagTEet4C+daXK6gWrawbZ2AGM/LYGJ2XD2
         XUKMrDRG1zY8r1DG5jAEdVGkbvRV3VYQjcMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Rgy1l4CLQDBZp2GTWyxkA5s5WS7JLd6DebMbmQyN8eA=;
        b=AdRNAPyleKbB0NFdSvqQISKjkO2jO3qaNaRgC6ZL4VwPD74jkw4LzQ/A6Sx/tFKrKk
         scJdfLn5TK9nAGkAWoRhYoF7hCfzdbwQhnMFlq6dV/W//z3/TEcnjqsJ9hgZPKQgOOKl
         Tw377SHBuGKNSkZXXJHUH2POSZnLzreeMlomFj+2xvHgc6LYqxRycby+x51DqvBDlCan
         4d8RXX+/nWvIpnrMDK+/lSdfJ/IDU25NTksZStQkxnL6JxSIDEJNRBYPceSK6tJUS0i9
         O5W8B0G2+WOLArhzJKMqsCct66jyWvr5W9iBIFU4eJAjT/jkuQlQfQdDPpvTAYJf/rPM
         kXCg==
X-Gm-Message-State: AOAM531t5yDpgVL0B2XgO3lUKQu2h51KRQfYcTWs6Bq/+EreDy6GOR0Y
	t874Ps2tD3u3MGNHxRrb9po2tg==
X-Google-Smtp-Source: ABdhPJyGp3ORXJgdWCq+sPiNgiG4WLchCBt2z/XyF/TQ/8+uahBwHeEsB8nqHsEEmvYrEw1x7K5jbg==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr7767321wmp.73.1630053073282;
        Fri, 27 Aug 2021 01:31:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5262:687a:b257:b6af? ([2001:8b0:aba:5f3c:5262:687a:b257:b6af])
        by smtp.gmail.com with ESMTPSA id i68sm5744551wri.26.2021.08.27.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:31:13 -0700 (PDT)
Message-ID: <12b10bccc900c508e246ab993b403955264454cc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] providers: Use new override syntax when handling pn- "override"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Aug 2021 09:31:11 +0100
In-Reply-To: <2f401da4d3e646e7b2aaecd9ac871acb@axis.com>
References: <169EEBD79694E731.9667@lists.openembedded.org>
	 <2f401da4d3e646e7b2aaecd9ac871acb@axis.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-08-26 at 17:45 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> > Sent: den 26 augusti 2021 19:37
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] providers: Use new override syntax when
> > handling pn- "override"
> > 
> > Make versionVariableMatch() support pn-foo overrides using the new
> > override syntax.
> > 
> > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > ---
> >  bitbake/lib/bb/providers.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
> > index 516d45e4aa..8c1c31a5c5 100644
> > --- a/bitbake/lib/bb/providers.py
> > +++ b/bitbake/lib/bb/providers.py
> > @@ -94,7 +94,7 @@ def versionVariableMatch(cfgData, keyword, pn):
> > 
> >      # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
> >      # hence we do this manually rather than use OVERRIDES
> > -    ver = cfgData.getVar("%s_VERSION_pn-%s" % (keyword, pn))
> > +    ver = cfgData.getVar("%s_VERSION:pn-%s" % (keyword, pn))
> >      if not ver:
> >          ver = cfgData.getVar("%s_VERSION_%s" % (keyword, pn))
> >      if not ver:
> 
> I do not know why PREFERRED_VERSION_<foo> & co have not been changed to 
> the new syntax, but I will argue that at least PREFERRED_VERSION_pn-<foo> 
> should be changed to PREFERRED_VERSION:pn-<foo> as per above to not cause 
> confusion. Though I am unsure if anyone actually uses that format, at 
> least I didn't know it was even supported until I found the above code.

I think this was some plan of mine to migrate PREF_VER_<name> to PREF_VER_pn-
which would at least be more consistent with how we do things. The pn- override
was much more recent that the original variable. Obviously the plan didn't get
far.

Rather than change PREF_VER_ to PREF_VER:, I'd probably propose we move over to
pn-.

Cheers,

Richard

