Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.16780.1629905657481641797
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Aug 2021 08:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NHyentM0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id b6so1631400wrh.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Aug 2021 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=dzpypa9z/ByYKJRBEhmixK3CCctX3p4wpWHTE/8pPzg=;
        b=NHyentM0yLcmwuShI9PebgafXGO4UHG4hp1ahse9b4aR9baXhdoYQ9fun8nHCayOgU
         o8gLd5rotTDtN4MRdbTq8trYBmgxMctKvjdyb9pwheX2/9r+uo7KCHEwPbAkY+qhWiSS
         zA8LthUEVzqJOG+k0Dikz2aBbXdgZZYfSjiJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dzpypa9z/ByYKJRBEhmixK3CCctX3p4wpWHTE/8pPzg=;
        b=rZGixZxS/E1V7FTBI5AFtT6RcDgmjgiISkz8AbmJ526z8RA7az1w4IFkXffwopnZWF
         zHSMmmEUe5+ypwgoJLb7Rj/8Q9N1Ogfk4iAYsLqCAGhk7G/0OVuO/A7OS/MSWowdwghi
         5Isaxvt7hp1k14CDMzLL4VjiAc1NSLBVSUAId7RQzV9d2iOPVqzRBRYxMM6JV7I60zBl
         +kkal4vU9N4WW7qrBRbUqyVMyh4Ha82jqM2HiyaOldROiWIHA5R4WUAzKJB8Cb1va1uh
         3n/pFe3K6ub9R9YcP+9+xo+r9pkin1+oA97napmWEArqRPGU7elBm/ZPS9qILlX3vlBh
         M/VA==
X-Gm-Message-State: AOAM530xACFbOebVCV/X71pC8937gxA0uwd3vezx9e5JINWQCwnXi4Q2
	C3/BmbCizchnO3TDYd8Hh0P19w==
X-Google-Smtp-Source: ABdhPJwY7WOpTkebj3emnKVDvRUsb9i913t5Z1jYEMJhEIYf43qP3zeZUmGijzya3obV10UlTsMU6g==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr25958089wrv.219.1629905655916;
        Wed, 25 Aug 2021 08:34:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:139a:6a20:b11e:f656? ([2001:8b0:aba:5f3c:139a:6a20:b11e:f656])
        by smtp.gmail.com with ESMTPSA id z1sm240536wrv.22.2021.08.25.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 08:34:15 -0700 (PDT)
Message-ID: <7fca677746856b934cf29355db6a40aff6fa008c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Trouble capturing layer revision as variable in recipe
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Aug 2021 16:34:13 +0100
In-Reply-To: <DM8PR12MB5430AEE26B2BD0933BA452D98BC69@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <eb65ff99d5863afa3425269ff7e3b0d532c5fa0e.camel@linuxfoundation.org>
	 <DM8PR12MB5430AEE26B2BD0933BA452D98BC69@DM8PR12MB5430.namprd12.prod.outlook.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-08-25 at 15:26 +0000, chris.laplante@agilent.com wrote:
> > > However there are two problems:
> > >    1. Making an empty commit to meta-our-layer doesn’t cause the
> > > recipe to be re-run. What’s weird is that when I use ‘bitbake u-boot
> > > –e’, I can see that the value of  OUR_LAYER_COMMIT is indeed changing.
> > > And with bitbake-dumpsig  I can see that OUR_LAYER_COMMIT is in the
> > task deps for do_deploy.
> > >    2. If I build ‘u-boot’, then make an empty commit to
> > > meta-our-layer, and then run “bitbake-whatchanged u-boot”, I get a
> > > “The metadata is not deterministic  and this needs to be fixed.” error.
> > > 
> > > Am I misunderstanding the purpose of vardepvalue? I thought it could
> > > be used to here to help bitbake ‘see’ through values that otherwise change
> > unexpectedly.
> > 
> > I suspect you need to have bitbake always reparse the recipe too. Maybe
> > BB_DONT_CACHE = "1" ?
> 
> Thanks for the suggestion. I guess this is because unless BitBake sees that
> the recipe file(s) changed (or they use SRCREV = AUTOREV), it won't reparse
> stuff in general?

Correct, it doesn't reparse at each invocation as in general that would upset
users! It doesn't know it needs to reparse in this case.

Cheers,

Richard

