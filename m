Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA885D0EE1C
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 20:15:39 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3410.1764101737705379634
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Nov 2025 12:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A1MM6VUG;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so62954375e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764101736; x=1764706536; darn=lists.openembedded.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B/ajuzIoEZBr9d69arPz3m/iHMyMbmnwNsLsK+C9nkc=;
        b=A1MM6VUGG8dmvNKT7N2Ahl6S04yERho+4+l9xkwHpjDF2+wzhn+mOF62tZQL+WRame
         djRelOInJsiFDTKNr/2vm37eMnyWXNxEXs+qlGwjh172cycd9p7PCijiJOucC8aXL4aQ
         u0C1t+1Iq9RqalNUh37e9ymiCnIdG0+gXK7MoqjnhseQc+97ah+VaLa73nJlLm4Yi+b0
         l4T4XBHNM/YRXyunRwtc7rm60DTHIYVbL3QHl4ZUGTH0PesRVg6xkpZA/KDcgSc9wy40
         jsMzLgDGQvlVbs3otZ2xeUim03bBx+KmdBVXIUZ7XBDhKd7lnxVMMdQtd7VO7vjcl4c7
         8faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101736; x=1764706536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/ajuzIoEZBr9d69arPz3m/iHMyMbmnwNsLsK+C9nkc=;
        b=YMU7iCKK6vccHbB5NGUnTuOUqaXED9ZXGT2hjsr6ZsDO216GOZEPS0nXrDI1eYdoOk
         gac87rS/KdHHweMht6ip4WpIHVjNlirE7lq1b4Yaz69hZpxAlgVzJUQccRh5vH6+VPnT
         Uecg7frj837T3G6s/TMIuSZL5i7pEqrVNH88s9zZ5YveQWIrH0ec2QG40z+2tY9iYJOB
         aUbGbCBMQP5aREeAwUS8fO9G7b2CcPTpq0D893QZaX2Ck+Yhz+oTzld2jhDUqeX3vu2E
         g56RUBQimJ8fZydamxWk+zkTdr8sRmRtQvzggAbTPqozN00zyzKmANlWFqm+Bk9GlYX0
         PHGA==
X-Forwarded-Encrypted: i=1; AJvYcCVJAnCo+NTG415ziUiMAaXEUQSAzOZTWlUONTZWkZDS3tndU45Hi6796UWITe9/bzdDWXr3IRvO2l/Gj5aK@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz8VjDGLKIHl6ZCfMOim4Hy198KABVmlC8Ggtb1+NYb4nLBViSm
	ECa3IfCpyWdL8r03drlAhtNkFmctEw4s5AOKbE6NEu44hzBbxKSbg9qA
X-Gm-Gg: ASbGnct+Vc7K4V+AyFUtt3fKYG05apC0cdN+PRLcdQlE1VpF86cOomenOQVouyslVFw
	vJQgeMU7Kag/aLd32vBU3HW2XKXt1XTfzH7XARGNpvZKGRBBq/TLgKznYhSoSTBS6CuazgAY7Mz
	L/rZNVqhgSO4srewxOT8UPyKHjHJALsy/xaMDZOzvspQP8aEkBeNnWwgTfni1aAfsseU6yPhzax
	LzlWFBdRrQeSUm6dmaIEYRfINAVM9WObOVdqZhiOUBXtqC5WUZgdxxujs28Z/nDYgUUoN1H1inR
	ka9HU3vjA8qgt+BtF6GpFl3bVNcQCqY3oO0F8FHk7zKvuCRhurheEvXyg0J86wjGpacIQxHGEyR
	I3aPp2vknwHGOuGmqqc5uqtApEBsmYpeHoZjYhLoPVkbt7cHHE/cQDltCMAw3lQTp9uGtS+Wn1e
	1+PiMMC+E93is=
X-Google-Smtp-Source: AGHT+IGpYYeAkXAlsHdGwcmJQQDm+COxGICyoZZpSgpYayVfhwHMeeYpm2pOtGU9tF8FF6mKt5fPZw==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr50794325e9.24.1764101735866;
        Tue, 25 Nov 2025 12:15:35 -0800 (PST)
Received: from osama ([197.46.139.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47903c7360fsm28222045e9.0.2025.11.25.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:15:35 -0800 (PST)
Date: Tue, 25 Nov 2025 22:15:30 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [RFC] Proposal: New tool to display recipe
 dependency trees
Message-ID: <aSYOYgiB4gtFMB85@osama>
References: <aSSUtHYFQlychNQk@osama>
 <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
 <aSSnE0X9kycDc60G@osama>
 <CANNYZj9ieQUQUEEjxV7bAznc3=A0rESOSr_+hy=RFragEA1Y1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANNYZj9ieQUQUEEjxV7bAznc3=A0rESOSr_+hy=RFragEA1Y1A@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 20:15:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18492

On Mon, Nov 24, 2025 at 07:53:52PM +0100, Alexander Kanavin wrote:
> On Mon, 24 Nov 2025 at 19:42, Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
> 
> > My motivation actually was so simple, to know why a certain package is needed in an image.
> > The simple way now AFAIK is to exclude it, then bitbake prints backtrace e.g.
> >
> > dnf
> >  ├── libdnf
> >  │    ├── libsolv
> >  │    └── json-c
> >  └── sqlite3
> >
> > dnf -> libdnf -> libsolv
> >
> > libsolv is needed for dnf. so would be good to have a query command or simple tool to show that?
> > something like apt-rdepends output.
> 
> Yes, absolutely, and this is missing. You can deduce it from 'bitbake
> -g', but it requires look at dependencies of particular tasks
> (package_write_* if memory serves) and ignoring all other task
> dependencies, and then making a mental dependency chain in your head
> if the dependency is indirect. This could probably be post-processed
> with some filtering tool to only make a tree of those dependencies,
> and present it in a human friendly tree format.
> 
> One other idea is to add a task to image recipes that would produce a
> tree of package dependencies. E.g. instead of making a package repo
> and then constructing a root filesystem from it with a package
> manager, it would use the repo to write out a tree of their
> dependencies - unrolling the top level packages that the image
> specifies to install. Probably it could use package managers like
> dnf/apt/opkg to assist with that.
> 
> Alex

Thanks Alex for the feedback, I'm going to work on that soon.

BR,
Osama

