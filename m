Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.14919.1595321586789842752
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jul 2020 01:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HU5P2bCO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id g75so1981788wme.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2020 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zYCNEJACaPiEaUhEZirYxzQJlragZteVQ/Y6JR8khRQ=;
        b=HU5P2bCOgnZa4vUNTBsuOU24RDcTkE1lyiE656vv8YbD2OJYS7RIJ6PIWGRCSMWoAG
         /GIDJCbswCGD14Y6DBoAFWMIcsYXvOc4YnUvZ9mpc9o5UaatpG8OSy20HLcbfujtFvJf
         pOTcV9fr7CEs9GU6IrhE4HF1GO/vpmzZlvVTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zYCNEJACaPiEaUhEZirYxzQJlragZteVQ/Y6JR8khRQ=;
        b=J0Qih/LJI31JLzqK3axXsLX4tvgjKUJEvglSMzu8GciZnr1F96+L139RvLOI3Y0XfF
         2/nwA7MOxat0l2kt1krDkFgoKgfxX5UkFuINi7h2IweNzC3MvAu0mfMRLqk655mf0las
         TW1KWzKCIe5az5MyQ2a42+QoWXE8LgtStgbVCsph3PbhaTGNJMib9z2ifjNX6D3zZV9D
         QU0TvXyOoMWjzUdEIJ6EL6/YXC0QlTpmpo9phgTcMPquarhqHJmSzh4bRaHi0wwEL7TK
         5MH2IAvM2v3HVxIh+CMg0aOY32F6CojdysadIwlfFwRdEbgKXH/JP7PqazOxf4biqtIL
         GNjA==
X-Gm-Message-State: AOAM532Q9pZj3867T+Y4LqJ0mWRh6DMJPGI3Foet0hpw7XnV68xrqcsN
	HuiwrzzF0eMfvoW91Ny6DOGltw==
X-Google-Smtp-Source: ABdhPJwmzdzRKW+GVQvXv5EVZ+ZvImTsC3czMBC7v5o1nKBEvqWSkC9AVIClfBGBOBP8cPHw5Iarnw==
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr2961779wmd.67.1595321585130;
        Tue, 21 Jul 2020 01:53:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 6.d.c.a.e.4.9.c.8.4.4.2.b.1.8.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (6.d.c.a.e.4.9.c.8.4.4.2.b.1.8.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:181b:2448:c94e:acd6])
        by smtp.gmail.com with ESMTPSA id l1sm39019702wrb.12.2020.07.21.01.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:53:04 -0700 (PDT)
Message-ID: <cca863dd41cf837cfaa89484c010578e5ac0809b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [yocto] Stable Warrior branch
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Adrian Bunk <bunk@stusta.de>, akuster <akuster808@gmail.com>
Cc: Patches and discussions about the oe-core layer
	 <openembedded-core@lists.openembedded.org>, "yocto@yoctoproject.org"
	 <yocto@yoctoproject.org>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Jul 2020 09:53:03 +0100
In-Reply-To: <20200714135619.GF25970@localhost>
References: <03a353c4-80dd-e66c-3222-7850a98182f7@gmail.com>
	 <20200714135619.GF25970@localhost>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-07-14 at 16:56 +0300, Adrian Bunk wrote:
> On Thu, Jun 04, 2020 at 09:28:00PM -0700, akuster wrote:
> > Hello,
> > 
> > The Warrior branch of Poky has had its last official dot release.
> > It
> > will be moving to Community support and EOL within 6 weeks if no
> > one
> > steps up.
> > If someone is interested in taking on the responsibilities of
> > maintaining the "Warrior" branch moving forward, please email this
> > list.
> 
> I have an interest in keeping warrior branch alive in poky and meta-
> oe,
> and I'll take this responsibility since noone else seems to be
> interested.
> 
> > Please look at the
> > https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS for what
> > will
> > be expected.
> 
> I have some ideas, but not yet a fixed plan how I will set this up.

Ok. FWIW we are struggling a little with keeping the older releases
building on the autobuilder as the workers change. We do have plans for
handling this with buildtools but its not rolled out on the older
autobuilder-helper branches.

I do have work in progress working with Jeremy for thud
(contrib/rpurdie/thud), much of which should apply to warrior too
(contrib/rpurdie/warrior is a guess). I just really want to highlight
that there may be some initial work to get these older branches to the
point where they continue to work on the infrastructure.

I think we may have to accept backporting a lot of patches in helper to
bring things more into sync with master/dunfell to make all this easier
to maintain/get working.

Cheers,

Richard

