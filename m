Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14981FF8873
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 14:11:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12275.1777471901014141711
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 07:11:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TIWH5XCR;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso178279175e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471899; x=1778076699; darn=lists.openembedded.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DsaQNVoq4S6+n5sskorI9xNspPcsNDC+qNkAlpahskQ=;
        b=TIWH5XCRPrWdiMRESI/d/T1FF6aIUTXI0C7Vm386ZqGqnDrn8S3Rm34pDmr8FMiiNF
         tdstt2asGYUI7/A0KtkhGXKw2OtmfcV900bzCYr3sjl7RzGLScXAHwd6R5O82LmdP02l
         p6V+9OQuI1et5Eax6eYuXqraxCrZxw84DfBdFuM32DEyEhh9XUBpmbm4lOxL5oArdvj5
         hc9zHcQLKIMApnyi6/PZQAmobD/AioKCYz8BB+AdVqpXPWQI6qM7sulPeV80psQyMxOf
         hwh8z8WLP+Imyilx/ehckw433cLcWghRA9OJaaFwA/y1ndSM+D5IW2tRGX0fvfvY0Gv5
         pwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471899; x=1778076699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsaQNVoq4S6+n5sskorI9xNspPcsNDC+qNkAlpahskQ=;
        b=aLO+FsYkncDhvLgkZBhhT9nKv4hN4JUu14sfvqGPJ7PneA3XjjrsfzapatddvMpOGa
         2WZNj1DEv24TS2JIIVzrqV54kJMKf1fFEoHN5b3L4Yqpll5ltNSv2WO/q+I60ks08yrd
         OxqxpaTCcWgGO6XmqcHOpl+QSyPKE1VP82Sc4o1fM+VeshsuDTMbX/WWMdAf3NSl6X2f
         VYdD7TMonQP++p5vb/ilmByTnB7BYSfQWO+jEJXguaKCPk1775qd8V7RRYIGthECxktE
         6kfVLSSLDIixg4sV7ag+0DOrdMhtK9tmWXbuJCBBcm3WJpkoRw5qcyzQ5JUCIsidUU1g
         EPrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9K0B4niK+HSuudXJqENHEvhgKyl9mRHEBd4umRePg9cNLOSlpwalldq5VvWcHBUTW5xkOnGoak9dV1hl3p@lists.openembedded.org
X-Gm-Message-State: AOJu0YxsaAnaZDa7CjraqHlxay1ihn+f02WxIGnsoKYzxyIHBLqplaXW
	JLFZmsJWsm+gP+kkuynC8ugeMroSBrkm1DZR5QUc5Q82aN526luS2LLw
X-Gm-Gg: AeBDieuLWX4w/eDfZYobI3BG25MgurLa9BE3zddDBTY21I/mr/NU+1Exig1TXWqcWnW
	HEAsQJE/mCma3mBCdTXm3rxuhea48S5J6s33PcUjBFzETop45hsbH7RqqikQZv414p19myO6j8T
	SZEl+iiigKB9k/yEeYJp7wwhWNynXhhYoCF2cltTgtZjxG1UlzKgvJRq5mf0JdnxVjGLwIQapsE
	e/qrOfx/wiiJ9xRntxrcLlr3wFAckT/rmGA8sY7SXIMza1sskanpReuJPB2dB0idQRlz+mD7uR5
	K7kdsMSxtB6ItbYO0svW/dhKsbpCF4qRGocn6uK0YSPlpCgIFj3UUvxPCQFpjgdLLmBYAX1PVRj
	TYF88BuCx3gjXIDLmgWcvkvE15/dUBPj9PVUyvmCeXjyB0sG7LrmAr1gJ2LxGdw839vmrEr691X
	TkMYInJLejMk9aNsRf3WLn4kHHjdJl1uBLr9JZEcUiTRFIAf+V5jXyfupCqZjaNTLavJPcm3NYC
	m6iGm7OURCjkD34fLVvqcVeM00+lXfYGfRej4dmbawu2kqvdBw=
X-Received: by 2002:a05:600c:5247:b0:489:e696:836f with SMTP id 5b1f17b1804b1-48a7b519485mr69695185e9.10.1777471895031;
        Wed, 29 Apr 2026 07:11:35 -0700 (PDT)
Received: from thinkpad ([2a02:8070:d188:380:590d:4498:b2ca:2c58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c3057f8sm19643125e9.14.2026.04.29.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:11:33 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:11:31 +0200
From: Dawid Bijak <bijak.dawid@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [docs] [PATCH 1/1] doc:
 bitbake-user-manual-metadata: fix inherit_defer documentation
Message-ID: <qwehgszst3cphuw4jqsj2u36333p2lpo6cytkdcx22prjmxrdx@acnraxmxwfl5>
References: <20260424062327.820993-1-bijak.dawid@gmail.com>
 <20260424062327.820993-2-bijak.dawid@gmail.com>
 <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
 <ljbjkwt32h72aziah2gepb6k5rfxygfrhkfysmulj5scnca5pu@o4vikz4hfmh3>
 <eeab5758b01722f5474855d21f718ea2d5cabff8.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeab5758b01722f5474855d21f718ea2d5cabff8.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 14:11:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19415

Hi,

On Tue, Apr 28, 2026 at 09:42:28PM +0100, Richard Purdie wrote:
> On Mon, 2026-04-27 at 20:14 +0200, Dawid Bijak via lists.openembedded.org wrote:
> > Hi Quentin,
> > Thanks for your response.
> > I'm afraid I don't quite follow your point about PACKAGECONFIG.contains.
> > I'm not sure what you're referring to exactly.
> > But, as far as I can tell, the inherit statement works fine with inline python expressions. 
> > I think, it evaluates the expression in place, much like := would.
> > 
> > For example, on current master I tried the following:
> > �COND = ""
> > �COND:append = " x"
> > �inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
> > This inherits foo. 
> > 
> > However, if I move the :append below the inherit directive:
> > �COND = ""
> > �inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
> > �COND:append = " x"
> > it inherits bar.
> 
> It works, as long as you are sure that COND won't be changed after the
> inherit. When mutliple files altering the variables are involved, that
> is often unclear. I think the doc's intent is therefore to recommend
> anything with variable accesses is therefore deferred, unless the user
> is sure they know what they're doing.

Richard, thanks for chiming in. Your explanation reassures me that my understanding 
of inherit_defer was correct.

In summary, I believe the 3 issues with the current documentation that I identified 
in the cover letter are still valid, and my patch still applies.

Greets,
Dawid


