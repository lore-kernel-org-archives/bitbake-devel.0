Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEDCD3446
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 19:05:01 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3807.1778180692976067283
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 12:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dd2d/sVK;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d102471a4so12505815e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778180691; x=1778785491; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cl31MYDM1ghaWvN2Qq7/lr1sh45UclUSKLWd7kjFUWc=;
        b=dd2d/sVK+YJulmdouFKKyhmNTPd3+NhPeK2rEDdGFPaaAdL+mde7bxN6awVKLze4zW
         AIsaippyIEQeMzY54Nf1gYUPcb1KhAEJQ0eLL0odDRVJNuwfohtX1PrKKpFh/7MesR6q
         SYgbj7VnTGrL44jAA8D0Ns82u20xoaUzEn5AhyWHRvl6rix2pz4T8HrXNvwd75fWRlXA
         y6CMkz60mL7OhsHYjT9QnAZm1/6JAXPvhSiAAC5lYn74Tc8PxiHPOQIx8Scx4WFXQCtC
         e5xHko0G34O1+nBYyzPAGE6OnQuUD1JL9KtfOiW95HlZ++X3FEzjoKD8oB9F9PA5+QMn
         n+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180691; x=1778785491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl31MYDM1ghaWvN2Qq7/lr1sh45UclUSKLWd7kjFUWc=;
        b=r2otjX/LN+DAtUVsmGSflXi1x2JaVsuli0L0OKhEEuUNtWL2/D4fcT9J3mJyDDvO3P
         hT/lCoy8anLUyyPz10Z/EB9K4hg1Uq66jKjObDBIpVoUujqZFuWywE8JwniNMlMfXTko
         eH2CUKt4lb6JvoFC+G90QIjB0ApPGtOY4XUM/9/WVv3X3EMQTBirBGCc/oCJAyon872e
         4CyEVpM16j/t11+6v+F9XN/d7XEjiVmARkhI769dGK5Eo1zY4Ewl9CUtAsDu4BcpIlBp
         dJJhLpNnJRQXxZGeQUENaqyarFxt1kDWShZzyOestwtqM6ZwPg0PBWVQ3K2ZKxYi2sfv
         mdjQ==
X-Gm-Message-State: AOJu0YwcIdSSVo4JDcATpexM1vP7ClQzck2wbA9+po+G/l5RJIyQCSc7
	W4WXKp5m1qWIbQb4TiUcTI/pY1GvPpMCHTtovwAsFo0715GDnQEmnhOP
X-Gm-Gg: AeBDievEo0otLF1P+rks8aZKGclToWfrjonBnlwTdrxgOOe29hIWEn9T9lbxW97BwmY
	foLSo/rJOZAHU397CakBQjGdXinXIgZ2BexSk4A+4q/aEhlusoghn9ekK4GMUGRKIqNRsWz7pa/
	nS4+0tgKjLSWAUMF+x92/Tb5T5OtpcoL7QnIu5oNSbo5CVIDYZwHTxcPPv2naMuKdkm1Xl4B8e9
	I74CaDbgN0v6nFBdJ6670K2gTCgjD31+zN3bcCZ9O7U2bZZTYyTIfCv0ZSEtz/dlH+SJDgz4aLW
	XI56YeREf/ElEXwBU7EooAnRuSo0o8od+M4BsP6EojN4o6ladCrOHXPJV7glGeCWAR936jR/Hw2
	OXVJutMC5A4hJ+AAPTnZzoy6GAYOl1JQBwZG0Zm9Q8B13LO/qF8URLa8Sf/MWrkEEs2ve8mWMd+
	QpAc2bW1hWMPnoRJDMi6r9fxeDZOIFvQt/kGHX8wnsLENAlMZg3wppSHsneyPCkqP5cEm24X1NZ
	J4xZSXPOmX3aZStuw7grbjmWdcVuNTk+VA+zyvB
X-Received: by 2002:a05:600c:c094:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48e51f3fab1mr107775555e9.14.1778180691062;
        Thu, 07 May 2026 12:04:51 -0700 (PDT)
Received: from thinkpad ([2a02:8070:d188:380:9ad9:81ed:5ada:862d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fad5fsm157112855e9.10.2026.05.07.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:04:50 -0700 (PDT)
Date: Thu, 7 May 2026 21:04:42 +0200
From: Dawid Bijak <bijak.dawid@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [PATCH v2 1/4] doc: bitbake-user-manual-metadata: remove
 incorrect claim
Message-ID: <ug27mu4jc54bkzrnkizmctu5bireuf3vov74gi75rsqf2ynxib@omnzdr4feoa3>
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
 <20260501091418.76994-2-bijak.dawid@gmail.com>
 <aff89f3f-7bc6-4634-b834-1872d559c8e0@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff89f3f-7bc6-4634-b834-1872d559c8e0@cherry.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 19:05:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19471

Hi Quentin,

On Thu, May 07, 2026 at 03:48:19PM +0200, Quentin Schulz wrote:
> Hi Dawid,
> 
> On 5/1/26 11:14 AM, Dawid Bijak wrote:
> > The documentation for inherit_defer contained the claim
> > "If VARNAME is going to be set, it needs to be set before the
> > inherit_defer statement is parsed"
> > which is incorrect and contradicts the purpose of inherit_defer.
> > 
> > Drop the incorrect statement.
> > 
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin


Thank you for the thorough review of the series. I'll  send v3
incorporating your remarks. It will however take around a week since I'm
tied up at the moment.

Greets,
Dawid

