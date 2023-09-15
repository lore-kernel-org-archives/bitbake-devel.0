Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA74EE6450
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 10:00:52 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.17040.1694772049890229337
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Sep 2023 03:00:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XZvdnkXH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1808037f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694772048; x=1695376848; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SUuDBlm7Qy2g1zsKogN0lXi/dta6rC5FL8oW6j0DFzE=;
        b=XZvdnkXHuwRuUrWhFzgibIYdx3n92S63MeXKyHS/Ph9n2JUvSeNlsds+mhp3DFiVGX
         cBemow+nLdq9+pVDsdoF4y/IZZndrWsakZqnn33zins5VN2hebL7gRd7GOpeJMwBeJUG
         34fKpwYLeO8YrOP8cL/hihVpvMYMUbbhmxWKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772048; x=1695376848;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUuDBlm7Qy2g1zsKogN0lXi/dta6rC5FL8oW6j0DFzE=;
        b=EAAHmQPq8mfjX+AElDEyxVWFvnIPQGKxRlBWapUu6jb92EhmN3mq8AEeBeHCgL+ucc
         VzIPVtu3c6JyH4XLd9O6Xpxfq1gMwOIHYe+GctEdsmLky5/YcBCerKxCltG76OcCQS9Z
         S2jO81uwo/XYWfxIouM37g4hrPP28mbVCXx2A7IWqoKd82BFkgswi5yZVFEOFRa6wzLe
         uUd5kvY79RHZpcdnDCn4Qu/wOFcWSYKUpPhqIgimHbFi6VDs8DFRyqTJEcsbTThlkV6w
         uNBrN7JYbRGmsEygwtwN8pK/JbgUSTEvTm5/ekA2W9RjLsi3Y99Jm29wV/Lf4+FE0n34
         rkrA==
X-Gm-Message-State: AOJu0Yz6Q/hK0plo+tgwZhQUBqBgDtOMtQSk2PxhCF9I0D4vJNafyrjy
	vnB99TyjfCsrE4+U+v4wBhWDtw==
X-Google-Smtp-Source: AGHT+IEz2pv8jmy2jfoJIvgjGyOshZ9f8gc+vO1uISeiL2AlD1arM9nFAPHjrNzSnjt+TQViYBcgHw==
X-Received: by 2002:adf:fbcf:0:b0:313:fbd0:9813 with SMTP id d15-20020adffbcf000000b00313fbd09813mr812482wrs.28.1694772048156;
        Fri, 15 Sep 2023 03:00:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:93a7:bb97:496b:8932? ([2001:8b0:aba:5f3c:93a7:bb97:496b:8932])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b00317a29af4b2sm3992146wrq.68.2023.09.15.03.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:00:47 -0700 (PDT)
Message-ID: <2847791eff7ae8c024bb156994dc97a9b999f7cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] prserver: add self-tests
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rusty Howell <rustyhowell@gmail.com>
Cc: Jose Quaresma <quaresma.jose@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 15 Sep 2023 11:00:46 +0100
In-Reply-To: <CAE+BM3myUg93MVuKqOzO6UCqshxVWnxCAutBV_nEW9c9NLZqLw@mail.gmail.com>
References: <20230913050824.13599-1-rustyhowell@gmail.com>
	 <CANPvuRnb4XRK4A=YDXdS5cXjsNxPj_k1S4acfzFYHsKtUSs-Lw@mail.gmail.com>
	 <1784CA099B7C177E.28514@lists.openembedded.org>
	 <c5e1e8071e10f795996eef5efdc03d3a674e1863.camel@linuxfoundation.org>
	 <CAE+BM3myUg93MVuKqOzO6UCqshxVWnxCAutBV_nEW9c9NLZqLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 10:00:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15066

On Thu, 2023-09-14 at 20:05 -0600, Rusty Howell wrote:
> There was an article by WindRiver that pointed out that the database
> is only written to disk when you stop the prserver.
> https://docs.windriver.com/bundle/Wind_River_Linux_Toolchain_and_Build_Sy=
stem_Users_Guide_LTS_1/page/use1553887504762.html
> What is happening is that as soon as the prserver is started, an
> exclusive transaction is started. That transaction is held open during
> all the queries. If the queries are just SELECT statements, it doesn't
> affect the currently held open transaction. But any time a new row is
> inserted into the table, the transaction is committed and another
> exclusive transaction is started immediately.  In summary, there is
> always an open Exclusive transaction active.   This exclusivity
> prevents other connections to the database, like in the scenario where
> you want to dump the database for backup purposes.
>=20
> rhowell@sirius:~$ sqlite3 ~/pr.db .dump
> PRAGMA foreign_keys=3DOFF;
> BEGIN TRANSACTION;
> /**** ERROR: (5) database is locked *****/
>=20
> The change to remove the "BEGIN EXCLUSIVE TRANSACTION" command is
> alleviates that. Always having an exclusive transaction is not
> necessary.  If a row is inserted into the table, the changes are
> committed immediately (written to disk), but there is no need to
> exclude other connections to the database.
> That's why the unit tests wont work without this change, because the
> unit tests open a second connection to the database to check the rows
> in the table directly.
>=20
> Hope this helps. I should have added this explanation to the commit
> message. My apologies. I can amend the commit and resubmit.

This definitely sounds like a bug but it needs to be fixed but in it's
own commit before the commit that then adds the tests. The info above
sounds like the basis for a good commit messages!

Cheers,

Richard

