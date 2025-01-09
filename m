Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310F1E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 10:40:18 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.44858.1736419214082396438
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 02:40:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NfUHHCCG;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd01781b56so8202866d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419213; x=1737024013; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFKBWylNKnxzXkoetUpvc//DL4+uNCrsaof/OpeCuMA=;
        b=NfUHHCCGIlZu2YTOkU/Vfjqo3Zr7PLGp1jaCiJCtRQ/0puvlEjQoLKxDMgjtB5mGwo
         y8prV4qinJN65Jmgyx58sWfxEFaBWRmczgNYIdfDQPlf2iCEWT3KntRb/AK6kPFvHOik
         34ouPoibCXwSWwu3t2z61iOTjEaiYzae1Td0GABi/hosNOomcOWOjJdctOCtSVPy4FDM
         t5rmF+aoayYi1FV1TV8MBy3d1sXIz+ciq1iu6422mmncmnhFduuqhn9+kLtEbKS9SKnP
         26DtuFZJkrdr71lyLreVXALyGpq+0jv5i4Baf7xvOzVHkEE/elODJAuJHWELIKThYEfj
         dtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419213; x=1737024013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFKBWylNKnxzXkoetUpvc//DL4+uNCrsaof/OpeCuMA=;
        b=cpSSD4FbGfn/77LkV87xVE3E2zSNPl6ajxUSRdiPO3abFJU7cacBdX2eaGupuA8sjF
         ajvD/RMfrSzanmCNEAk76UsbW858BIU9oaN+L1tJQ1WuQBlc+sXFYbSBnkBLDymtu33w
         XDxnAhzsYtNReUweBcqlLxLWP7o2Jz7sGKEp+tjY8CcCb4dVWrcJGJMjbKY9YWH0a6bg
         u4Vm+6ZlaqAaTaf+7D0GGWqbbWwS8spPJXWSgIcvyzNG4JV9/qyzIgSCIQbk3RJEJnST
         DQ6Hcy9y0mebFJD3jmDDp9pOQdZjWlTxhxCmw6paL2ObxxjNWmw+dzGRmcvjN+VCDsVI
         GlEg==
X-Forwarded-Encrypted: i=1; AJvYcCWE+NSg+nII/+bsanRtuxL25D7lpxgXXEsBlF5Ie6IY6nGscxWKeyLSh+R1idNu29zR790STGUlm3dTN7K8@lists.openembedded.org
X-Gm-Message-State: AOJu0YxpsGJYZWKALGKmOqgjtvFAeNpP7bi07jNDMOnLKizFng+V5jSz
	ExeFTV+rWimkBBsixJfdaCsEmZDg7gaJVm7rjTCxALopkli9Gm4EMCqG22Paz6HO4Y6BHFQlst8
	ECNaf8jfMHgONBrYJV0WefhHElS4=
X-Gm-Gg: ASbGnct6PLR/tKz1YGHPopmoJUrdOnd0I75yC9aUtWqQCXOk7hqvK06+zZa3JUvvGZY
	iLcc/Ake/N1Dlv9j8SlBQFLo1Pmm4hn6/k2HGiBbHFqW8qAxqsSCSKo40e3IOVhZBr3+MUW4O
X-Google-Smtp-Source: AGHT+IFC6F2slHKBKFB8WN/C5izfYT7TmePssf3uNoEvIdA8mdUkVMHGgJrHD8LpS1EEpPA7SfvYcLsd2o7f/aEQ6NQ=
X-Received: by 2002:a05:6214:29ca:b0:6d8:850a:4d6a with SMTP id
 6a1803df08f44-6df9b1f3033mr90624716d6.1.1736419213010; Thu, 09 Jan 2025
 02:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com> <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com>
In-Reply-To: <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 9 Jan 2025 11:40:02 +0100
X-Gm-Features: AbW1kvZi2T41oXJ0MJBzCISROwOhA_P0M2w-ZsYM8iVK6_aRwRs5-ZlkqrYd4es
Message-ID: <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 10:40:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16992

On Mon, 6 Jan 2025 at 15:43, Stefan Herbrechtsmeier
<stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
> https://github.com/yoctoproject/poky/compare/master...weidmueller:poky:feature/dependency-fetcher
>
> I have migrate the crate recipes to the new fetcher and improve the spdx
> 2.2 class to include the name and version of the crate dependencies.
>
> You have to inherit the create-spdx-2.2 class and build the librsvg
> recipe to test the new fetcher.

Thanks, I checked out the branch and run bitbake -c patch librsvg with
the default build/conf/ config. It works and the recipe is short and
neat. I'm not sure what create-spdx-2.2 is needed for? I didn't use
it, and there were no errors.

Like others, I'm torn on two things:
- visibility
- control

When a recipe explicitly lists what goes into a build, this can be
easily seen, audited, and adjusted directly in the recipe. With the
new fetchers, you need to actually run a build to produce that list,
and it isn't clear where the list is placed, in which format, and what
to do if something needs to deviate from versions prescribed by
upstream.

This is not a theoretical concern, I'm thinking specifically of
log4j-like vulnerabilities, and how one would check that their product
doesn't contain them:
https://lwn.net/Articles/878570/

Alex

