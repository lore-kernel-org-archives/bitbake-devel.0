Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD955C001B0
	for <webhook@archiver.kernel.org>; Sun, 13 Aug 2023 08:37:05 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.82141.1691915821147855158
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Aug 2023 01:37:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IOn9sgI4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-31751d7d96eso2873791f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Aug 2023 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691915819; x=1692520619;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnsZlk8qrqZgrsr9zdkCCrMlk6K7eKHSdJEVPFTeK5M=;
        b=IOn9sgI4J+GgKrsEgNiL8T3MtQUMLTkMSsHNrVl1IsChm36Ga9+SqI/5AyfPRKCmr2
         KSURHKKkCDNcmq0eCDz1tdZpUkJNRQnQrxZfzj/CazOUYqUsB5K0jxSyJUo370uUHOCn
         GHENZNyfeXj1PwsiDggWKvoZoekQrl9p2Y5Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691915819; x=1692520619;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnsZlk8qrqZgrsr9zdkCCrMlk6K7eKHSdJEVPFTeK5M=;
        b=arFqmvZKgP1pobokqgO177vJTk7NMXCWaXYP8iyxjBreQEbcIBGSjxz1zQo+hLYX18
         +bkOh1rXelFQo+Re6O+tvIUkm3Fih/5sOiiyXZEliRfMD6qpm9+cuZmsxFMKovuVnXfX
         kcg1kr+3InT5yV3bXPDS0+fLkLGd55jhpXrikeRhKMni/sTsYWmESqOB9vJvYiccEY7C
         gFbQjnFM5W9sHrcyt2o1YAaBXS98o8xOEP/mGnA6RTnFqpm8R335YdHpzMEzhLnY3uBU
         6pTbRUs6nzOnSjykm+DUmsHfxeJkc2GfZkOis6Ky1nNkroT9aGjObKaFHhP1YdugNuM6
         g6Wg==
X-Gm-Message-State: AOJu0YyWop7RxXtMkv6d/pN9k/ocLhJsSGUbJMAww9//BapZPx/XILfL
	qR9KpKEDApClTF1e3bVVvoplutmtnDjtJSpxGWY=
X-Google-Smtp-Source: AGHT+IFQCXc5NmJp6unKg7VflPPR+Zd1Bpt3y5kACGaqD5EwsZ4pgBJBBpiBHHRFJc6k+b1h3Ps7dQ==
X-Received: by 2002:a5d:6942:0:b0:319:6caa:ada2 with SMTP id r2-20020a5d6942000000b003196caaada2mr2319773wrw.47.1691915819148;
        Sun, 13 Aug 2023 01:36:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:17a:7286:2cf2:8a86? ([2001:8b0:aba:5f3c:17a:7286:2cf2:8a86])
        by smtp.gmail.com with ESMTPSA id w4-20020adfcd04000000b003176eab8868sm10830548wrm.82.2023.08.13.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 01:36:58 -0700 (PDT)
Message-ID: <5c8fe14bde6417035a38d9199f0457afe34db968.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, "MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 Aug 2023 09:36:57 +0100
In-Reply-To: <CO6PR11MB5602151D76F55281E46F9E47ED0DA@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
	 <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
	 <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
	 <eb48693137116c26346d2eb07d726022d3525f50.camel@linuxfoundation.org>
	 <CO6PR11MB5602151D76F55281E46F9E47ED0DA@CO6PR11MB5602.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Aug 2023 08:37:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14937

Hi Qi,

On Tue, 2023-08-08 at 05:55 +0000, Chen Qi via lists.openembedded.org
wrote:
> I implemented the logic you suggested below, but I found the 0 result iss=
ue remains.
> I also checked my solution suggested in the previous email, but the 0 res=
ult issue also remains.
> So I added more logs to check the PSI data behavior. (I really should hav=
e done this before!)
> My setting is: BB_PRESSURE_MAX_IO =3D "1"
>=20
> The result is a little surprising to me.
> See https://github.com/ChenQi1989/poky/blob/io-pressure-logs/console-late=
st.log=20
> and https://github.com/ChenQi1989/poky/blob/io-pressure-logs/io_pressre_g=
rep.log which is derived from 'grep io_pressure console-latest.log'.
>=20
> There are lines like:
> WARNING: io_pressure is 50448.00396988443; tdiff =3D 1.0781397819519043
> WARNING: io_pressure is 0.0; tdiff =3D 1.015068531036377
> ...
> WARNING: io_pressure is 50448.00396988443; tdiff =3D 1.0781397819519043
> WARNING: io_pressure is 0.0; tdiff =3D 1.015068531036377
> ...
> WARNING: io_pressure is 124236.79015441194; tdiff =3D 0.9999372959136963
> WARNING: io_pressure is 186346.268013355; tdiff =3D 1.0000200271606445
> WARNING: io_pressure is 0.0; tdiff =3D 1.0000898838043213
> WARNING: io_pressure is 0.0; tdiff =3D 0.07874345779418945
> WARNING: io_pressure is 0.0; tdiff =3D 0.03340554237365723
> WARNING: io_pressure is 0.0; tdiff =3D 0.04926180839538574
> WARNING: io_pressure is 0.0; tdiff =3D 0.012816905975341797
> WARNING: io_pressure is 54966.74998052512; tdiff =3D 0.11936306953430176
>=20
> From these logs, I'm starting to wonder if not using the average10/60 PSI=
 data is a right choice in the first place.

I merged your v5 of the patch since that seemed to make sense to me but
I'm really not sure about the PSI data itself. That is something Randy
looked into in a lot more detail than I did...

Cheers,

Richard

