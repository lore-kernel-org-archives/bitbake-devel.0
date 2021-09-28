Return-Path: <weaverjs@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A63EC433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Sep 2021 02:00:24 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.8461.1632794423321646796
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Sep 2021 19:00:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CxlYCCMD;
 spf=pass (domain: gmail.com, ip: 209.85.222.177,
 mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id q125so24506780qkd.12
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Sep 2021 19:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aGKjbRbTZ+IyzVdJuMI+1mgJvTGJl3Sq+vpEXm5CDDI=;
        b=CxlYCCMDbZ7Uq0lEZnv/DkiDqKsDuhpAfxA87n2kX2x/PEkKTmHg46WFSUFFa6bPiw
         5AOVcNOebkr5vyxP4B/DWqh3qCiM5G5yjV0WGEn0W94SUceano65MjOihlsvoYtFIEka
         ZNgnpA9byr8xRssD22pvncbSpVk/8waJNcUm4oBjLOXQkWDpvihABHhaCOXCkq/iobt3
         r3nM7mMxWjPQAHa9ihn4HGp//ha/IybCx6gBYUOnRkzFE3buEIsbrNCp8Ud+A6ekh5A5
         zNeSFSiBPdGPbhJB8V3C2D9gjU5SrWvPzmi+gtfDyi33IGF+UymRMMrDoqygPjZRb4c8
         8pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGKjbRbTZ+IyzVdJuMI+1mgJvTGJl3Sq+vpEXm5CDDI=;
        b=P2P9RS07DnSiAZG2aBJO5qtje95c3Gg5QddJV79rpsHsK0os6gk+aFGqN/hAHh9TdS
         9OskvxDiLhAxAAArSj4ZYQoU9qESuo9a2WCKf9vRyoheRLeO+cxeIVaTpztEasD+Y3TX
         sBYPU53mLWpTgtTq4VgztOjpwlEOfWN4k72P1hlPTRzEEb+D0vnCNO5OwRVA9ojVuYXY
         Kf6O3JckNfFKPLBI53jmD0fVmrRIbA9DW0Zyx/rg+SDTKWLIiAL9EbgiPBXLtduExBCg
         hjEtHOcYF2GClaSW7WN2kSEjlcsiYm20vxa+nUsYws16vjCjuaEN3b//C4TfrAsmdm3p
         j+eQ==
X-Gm-Message-State: AOAM530wENZemVJVVsUH2Yx5wPKJJFdrOLg10+e5J14TwOWyfMXaDLb+
	RMAkgrbG8C0uwcQTX67B7qVzKmg=
X-Google-Smtp-Source: 
 ABdhPJyvG7MSOsN4jKYrJVlMAZRn+JAkM+qxMWBQjk2CGJlVHB6AT3YKu2zpuGqOv7LdHGj6t1k9tA==
X-Received: by 2002:a37:a64b:: with SMTP id p72mr3066039qke.459.1632794422342;
        Mon, 27 Sep 2021 19:00:22 -0700 (PDT)
Received: from popos
 (2603-6011-2200-ab10-97f0-85cf-2ba4-5d6d.res6.spectrum.com.
 [2603:6011:2200:ab10:97f0:85cf:2ba4:5d6d])
        by smtp.gmail.com with ESMTPSA id
 u9sm11759167qta.90.2021.09.27.19.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:00:21 -0700 (PDT)
Date: Mon, 27 Sep 2021 22:00:19 -0400
From: Scott Weaver <weaverjs@gmail.com>
To: Kai <kai.kang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][ 1/3] bitbake: fetch2: fix premirror URI when
 downloadfilename defined
Message-ID: <YVJ3M8RII6ssdf8/@popos>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
 <20210905222738.1050768-2-weaverjs@gmail.com>
 <dd26626a-079e-86d8-34ce-ad5d2b71ac8b@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd26626a-079e-86d8-34ce-ad5d2b71ac8b@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Sep 2021 02:00:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12711

On 21-09-22 09:58:13, Kai wrote:
> On 9/6/21 6:27 AM, Scott Weaver wrote:
> > When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
> > defined using the same URI, the downloadfilename is appended to the mirror
> > URI and it should not be.
> > 
> > [YOCTO #13039]
> 
> As I commented in the bugzilla, I suppose it is an invalid bug.
> 
> It save the tarball with the name of the value of downloadfilename rather
> than the basename of the url.
> In this case, the name of tarball in the premirror downloads/ directory is
> uthash-2.0.2.tar.gz rather than
> 2.0.2.tar.gz if the premirror is created by run bitbake do_fetch. So when
> premirror is used, it checks
> uthash-2.0.2.tar.gz in the premirrors but not the original value
> '2.0.2.tar.gz'.
> 
> With this patch, it fails to fetch the tarball from premirrors. It could be
> reproduced by config:
> 
> BB_NO_NETWORK = "1"
> BB_FETCH_PREMIRRORONLY = "1"
> 
> Regards,
> Kai

Sorry, Kai. I didn't see your email until just now.
I'll look into it. IMO, I would treat this like a new/different bug
than the one I addressed with this patch but regardless it is a
related use case to this BZ.

I'll update the BZ after I've dug into this.

 - Scott


> > 
> > Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> > ---
> >   bitbake/lib/bb/fetch2/__init__.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> > index 914fa5c024..47a4943369 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> >                       # Kill parameters, they make no sense for mirror tarballs
> >                       uri_decoded[5] = {}
> >                   elif ud.localpath and ud.method.supports_checksum(ud):
> > -                    basename = os.path.basename(ud.localpath)
> > +                    basename = os.path.basename(uri_decoded[loc])
> >                   if basename and not result_decoded[loc].endswith(basename):
> >                       result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> >           else:
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#12592): https://lists.openembedded.org/g/bitbake-devel/message/12592
> > Mute This Topic: https://lists.openembedded.org/mt/85401309/3616933
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kai.kang@windriver.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 
> 
> -- 
> Kai Kang
> Wind River Linux
> 

-- 
  - Scott


