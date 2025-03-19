Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19924C35FFC
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:12 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.10330.1742396585348945036
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 08:03:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IqBk2Gmq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso32111205e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742396583; x=1743001383; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M+O4jQlYy/jvXgBBOE/+kwCV1a282wQgDkE8RXOGOpo=;
        b=IqBk2Gmqm36VYNbIw9/mR3MqTwSPmzGDCpHKUBMcULhQF9DxnEMhsY+oElb1SR5JGw
         QV79GitiB1EjWEEua/aVxy4VbNoBC3xj5VkJgT+93Z20hbaTxDWngoAHp2eCqJFx4tTN
         gs+Aj9o/psx6Tk+18CfKn/jxaD5odb/1qH8W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396583; x=1743001383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+O4jQlYy/jvXgBBOE/+kwCV1a282wQgDkE8RXOGOpo=;
        b=ri67jDysAjMf/ZGJX+/2EKOy+SanCdohcN3BxVotAkt5gFEgGGob2QxmSxesF+LDvY
         9t+4OwmTDEHgEEmAn8qaDamqiHADTMb1qvZKU2QfzK5YoeacVaoTPDgnt08vf7KERv9z
         9JiE23eEDZCp0+JsN+a6lNBWZ5y6QHkyRYPTW5FlbOzsbfOlMcMOj9H5Zu4UtXVKoUNP
         9icw9pArZ8TfqoqbgwI4D+V5lCWsuAECg10TD24X7zeVhiNNLWlaSy8YISdLVWWqvGaj
         bRPEq3mShNRuNtIO9Fd20PI8548ZM+yPRVlAWdoRr/U3l5LZkoX1Rhks6myDmwv4wg6L
         jKuw==
X-Gm-Message-State: AOJu0Yy95yomdTPBAXX9UmILY5ltGevBEwPwWrBSy/70tKu4RLg/LInP
	XzikevY9MeGHZbjAMJSlA0P6Fyz+akrSWu27oXT9LpEZ4YWuJUIVNAcdDekbme4=
X-Gm-Gg: ASbGnctGwYSAt3tj+KF1G2XSOvZpxWkedQ/46uhFAQJJS3UPK5C/oWvbiDlmg0OO0e5
	LscVV/f+/3j+ddtHk8QQEHH4oLtss7b2kVzweD2vcpzxE/lFbSYaEueyCqE6qZvi8sZ37lvhldf
	Z95/OUkcZMfzTcbPw1gtJvlBR8Cxm/S+z5tqZSM0cauAwPciw6G3w9eurht6hUXC64YlCBMeN0/
	gIrMANkrbDobfhFdeQvW3+HrtTxseqZKRSHUAV+XVP7kJhgGSJtxzi8tb+5lQRjsBniwdTAMe+D
	z4Sx/LF+qTg1I4eQozCN62Xb0lzAuazWd1sWBx07W8ZgHcK3J0rM3IMhDKHYUMoz3R4rYVSq8bt
	Sfmv1L8J7kMx2PRFOg+j4aJemSEnbZjY=
X-Google-Smtp-Source: AGHT+IHLNt7kWQ+e9OpvERZsXc69aJrcMj8azw420ui9T2+yqrOBLXY1pFuHUxI/xjdVRUW7DsXSqw==
X-Received: by 2002:a5d:598e:0:b0:38f:2ffc:1e99 with SMTP id ffacd0b85a97d-39973b437a3mr2677561f8f.49.1742396583323;
        Wed, 19 Mar 2025 08:03:03 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dad:b471:9c34:4577? ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df339asm20959894f8f.3.2025.03.19.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:03:02 -0700 (PDT)
Message-ID: <d47238f4771f505dcb0816e03ab731f7c5ff1c2e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0][PATCH 1/1] siggen.py:
 Improve taskhash reproducibility
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Steve Sakoman <steve@sakoman.com>, Ernst Persson <ernstp@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Mar 2025 15:03:01 +0000
In-Reply-To: <CAOSpxdaupXeT4cg9jMOfzB2fE+Lmt6e679-igdqKc42qw-PfQQ@mail.gmail.com>
References: <cover.1741808747.git.steve@sakoman.com>
	 <da5f41996687e18b78d9c9845e621d832115aa1e.1741808747.git.steve@sakoman.com>
	 <CAD=4a=Umi_YD9i=FB+412DQJLLi4b_AdDn0MeTWiBMMmZ+WE3w@mail.gmail.com>
	 <CAOSpxdaupXeT4cg9jMOfzB2fE+Lmt6e679-igdqKc42qw-PfQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 15:03:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17469

On Wed, 2025-03-19 at 06:43 -0700, Steve Sakoman wrote:
> On Wed, Mar 19, 2025 at 1:05=E2=80=AFAM Ernst Persson <ernstp@gmail.com>
> wrote:
> >=20
> > I tried building in an old kirkstone workspace with this patch
> > applied and I got a lot of taskhash mismatch errors.
> > After deleting tmp and cache the build was fine, though it did
> > rebuild everything from scratch.
> > Does this need bumping of something like HASHEQUIV_HASH_VERSION or
> > SSTATE_VERSION... ?
>=20
> I didn't see any taskhash mismatch errors in any of my testing, so
> I'm
> not sure what happened in your build!
>=20
> I don't think bumps to HASHEQUIV_HASH_VERSION or SSTATE_VERSION are
> required, but perhaps Richard can confirm.

I think it probably needs a cache version bump, something like:

https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/cache.py?id=3Dfced0=
b8d7c852e52606fa8da321211a98a1dfaea

which would then trigger a reparse. Things should be ok after the
reparse.

Cheers,

Richard

