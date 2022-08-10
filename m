Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E7EC00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 16:19:35 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.343.1660148369203215551
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:19:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RVAQ70RT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id
 i128-20020a1c3b86000000b003a536d58f73so1255397wma.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=X0Kn6hUT0hdFF8dWO2c7YzkPj7lzm0a0NIKbDfT8o/c=;
        b=RVAQ70RTH9IW0j5HQYM4WDjcIqAv4xC5FRUmDtv37zbWshDm4lN7fouo8zgBeTtxCA
         uTHHP7WQeVa9fvkoJXQwBnOUzw5u9CoAr2USrNJ6vlvYI3C1eChw9CeZ0HM00eNmIBFv
         kPf98y3UEodOfylqtocl+h3Izi7cKVtwXL4tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=X0Kn6hUT0hdFF8dWO2c7YzkPj7lzm0a0NIKbDfT8o/c=;
        b=dJFUTTPmIadecc40KzcNhxyVOVGUv2Oa//DYfYnxLFbfEOKVi2pl0sWnZZVvMglYqR
         zghu7BLYLGg4ktsEUEosLyWvArOdG0Nexgy0x/AwH2OqeexePTEZUrUI0xQM5JdoQy2L
         uB7CMyL6pELZiQo4A+3GY7sZbOIUvlkgxFFIuYcMTKehHsvCv3ARyK/d/5fZnGyjwzWA
         Nn9unovsOOVccXuQoLe9HvInWYAnFAc/SBvMDHFGgP8ohNigCNoGP568ez8awIPZi6vn
         hUtr6EQv7bGipUBgGoH1gMKB/MAUvhDCf9v6Wko9W7ydy3jXHGIL/ZIJs72iE16PITuK
         rLBw==
X-Gm-Message-State: ACgBeo1Cc0zzMZMGAtXeQg+S82p79A4ouqkFcGn1roUq7kML3S9jyi+q
	YS1GCU5yY09hrL+wn42fAzXqXA==
X-Google-Smtp-Source: 
 AA6agR5zeD82dmbHq0P1W4VA1ncxFc/Ww7aTPO4QcR5htnfeehEeYZMSQSLml/aJzCZK1eXeF5gvRw==
X-Received: by 2002:a1c:2785:0:b0:3a2:dcff:7903 with SMTP id
 n127-20020a1c2785000000b003a2dcff7903mr3137071wmn.113.1660148367557;
        Wed, 10 Aug 2022 09:19:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b?
 ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 8-20020a05600c020800b003a52969e89csm2967251wmi.4.2022.08.10.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:19:26 -0700 (PDT)
Message-ID: 
 <e37b5612a36eaebe3ac3aa93f36ebe9bcda3861d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] BBHandler: Allow earlier exit for
 classes not found
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2022 17:19:25 +0100
In-Reply-To: 
 <CAMKF1sq8xAqD-yzEkV67yDPs3yoeQ86ygHKXoLHbp0Go2n=kWQ@mail.gmail.com>
References: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
	 <CAMKF1sq8xAqD-yzEkV67yDPs3yoeQ86ygHKXoLHbp0Go2n=kWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 16:19:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13888

On Wed, 2022-08-10 at 08:55 -0700, Khem Raj wrote:
> I seeing
>=20
> % bitbake binutils
> WARNING: ['base', 'sanity-meta-odroid-extras', 'clang',
> 'report-error', 'image-buildinfo', 'package_ipk', 'buildhistory',
> 'buildstats', 'buildstats-summary', 'debian', 'devshell', 'sstate',
> 'license', 'remove-libtool', 'sanity']
> ERROR: ParseError at
> /mnt/b/yoe/master/sources/openembedded-core/meta/classes/buildhistory.bbc=
lass:10:
> Could not inherit file classes/image-artifact-names.bbclass

I think we need something like:

diff --git a/meta/classes/buildhistory.bbclass b/meta/classes/buildhistory.=
bbclass
index 4345ffc6939..203310ba975 100644
--- a/meta/classes/buildhistory.bbclass
+++ b/meta/classes/buildhistory.bbclass
@@ -7,7 +7,7 @@
 # Copyright (C) 2007-2011 Koen Kooi <koen@openembedded.org>
 #
=20
-inherit image-artifact-names
+IMAGE_CLASSES +=3D "image-artifact-names"
=20
 BUILDHISTORY_FEATURES ?=3D "image package sdk"
 BUILDHISTORY_DIR ?=3D "${TOPDIR}/buildhistory"

Does that help?

I need to remove that warning too! Although it does help debugging right no=
w.

Cheers,

Richard

