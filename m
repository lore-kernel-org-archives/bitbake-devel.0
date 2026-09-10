Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B28FC79FBF
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 17:19:11 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20048.1789060747239166662
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Sep 2026 10:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Zy2PFaro;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351832so953984f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 10 Sep 2026 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789060745; x=1789665545; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LTFm3rDBwpqLOqfSGQ9gjJqDe+Xcyf1ttZ1KnKhAc8o=;
        b=Zy2PFaroqQceybR4zCqQ4PjtTPfNqyeRA5AGqByYLXokfX7NHC5yNYgw7EfgjFsRYB
         0bzP8Dmi2fhs4lJWYDY22ndhQU7na0KRiJ3HOWHhogfzk/BsLGJRXCRWeRD2+JOxCVsc
         cQmZiw/FbYpcnILc/m8HonKJPx8ZBE1QC/vp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060745; x=1789665545;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTFm3rDBwpqLOqfSGQ9gjJqDe+Xcyf1ttZ1KnKhAc8o=;
        b=qDv7cRdZ/iFLSGuWIlBVQ+EgvFzIhs4TSCku+Z7cPbFGJ6OGFJzDsJQ4TWBjKYrPPU
         uF5WJYWfwbtdpbXoFnWKCmg7k9eyiDsDGY8wkc0zau6hg7LNaeHjmnSjpMyMZYO7ov+A
         kEFMVw3RAVpcVr/H7GlaD/F6ebEkblfI3OeDlQI+4rrEtaIGzshrM7BqL0C+CltQgnZs
         xofN0pJ96tITke9fcmtK3IW0sA1tXD4h4rYjFszZ5bMccoF2MTvTxyCwK6zPeLK/i+Wc
         X7JklDih8bxIIar+L8X8upckknvjHd6uir3O8rEwMzus6KrEc4xzpf+Pn/IcpnCjf8/O
         88eg==
X-Forwarded-Encrypted: i=1; AKwUvBzC3uK93MKfUFnEe7BQt9tdDe4T9ZynS1YtevUumu6cbFrBkRVUqKSwhpdc8PWM+PErZt71n44Vz8HTcQ13@lists.openembedded.org
X-Gm-Message-State: AFuF++lhpOUdzlrrSNt6+n8BX8H4lsc0bdi3+yD2tCOcOx7eXwSJcfSf
	xyhyYNR0y228va1p67ksPMaeHTg5SbsusXXmND+LrJbO/kQWBNIkcejlPyJGqE6HGNA=
X-Gm-Gg: AYBFou2FdWcfnEqg2u7IlX9XYEqTzPI319J1n3wL6nIsuFPOMglpj+NI+5YzTmzCNZK
	c7aHrPEww01GKpUF1WO0r8uRbYXdp3OR+h/XkjTo2p2m0Oi3avlJTW8tKbUe848TXi1szafJFoV
	ovQscpZIZ0LXz5d+AEyyr6sNTSxWo9qEFNEOFLMZFgBPFGDqK3/5fp3+j0L9zFGoaFFL408c40K
	0BU3QO0ahnlPS3AUjIxKIlVdC7ACroSnCQ73rlN//438r6j6AOi4gMy94FCs2d7ukbT/iFeqpmY
	v5qZTMdN0+p71hjMO/k3lih+FY4uxG14G5/uXe5OsBkQYkCiw2kgZ4tYmB3xB85wB+LBbWGYvbu
	cuCGXNZjKfPaIl6dnGG7Q4rdNCk25EYxKYDzPgtXuiul7pYlVFx4OO7+RJfCwhBspYGk2O3lEts
	3cDU+H9e6mbZycpXIxEmeWGBLGo7XUBpdDNrwMfEqUa5yA5C4oLJRnSSVJ7IwqjsrRo3SUYJ8Vp
	pawwR30IGaKy6o2NePAKEejP9df+ruvUF54gROsBaRaKmeInh4iBiY97L4jlRGi+Q==
X-Received: by 2002:a5d:64e8:0:b0:482:f724:f4ba with SMTP id ffacd0b85a97d-485ba5c551emr10147385f8f.19.1789060745414;
        Thu, 10 Sep 2026 10:19:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:788a:18da:6c2a:9f16? ([2001:8b0:aba:5f3c:788a:18da:6c2a:9f16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm50848622f8f.22.2026.09.10.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:19:04 -0700 (PDT)
Message-ID: <93ae42005a26c1b0aa1525875394585bbc65b265.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git: replace stale clones
 when using premirrors
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: svsvenss@cisco.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 Sep 2026 18:19:03 +0100
In-Reply-To: <DM6PR11MB39626186CF03268680D049DDCBBF2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: <18CEBA5A9DB58325.510612@lists.openembedded.org>
	 <DM6PR11MB39626186CF03268680D049DDCBBF2@DM6PR11MB3962.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Sep 2026 17:19:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20179

On Thu, 2026-09-10 at 06:27 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:
> A gentle reminder about this patch. It is still listed as New in
> Patchwork, and I have not seen any review comments.
>=20
>=20
> The patch prevents a successful premirror fetch from leaving a stale
> Git
> clone at the original download path, which otherwise causes a later
> do_unpack failure.
>=20
>=20
> I noticed that bb.fetch2 has since been renamed to bb.fetch. I can
> send a
> rebased v3 if that would make review easier. Please let me know if
> the
> approach needs any changes.
>=20
>=20
> Patchwork:
> https://patchwork.yoctoproject.org/project/bitbake/patch/DM6PR11MB39625BB=
95AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.com/

It definitely hasn't been forgotten and is in the queue. I was trying
to find time to provide helpful feedback rather than just saying it
wasn't right.

Firstly, I don't think the fetcher should be deleting data like that,
if it is stale, it should just pass over and ignore it as something
else my want or be using it. For that reason I couldn't merge this as
is.

I do appreciate you're fixing a real issue here though and therefore
the question is how to do that.

The fetcher has traditionally struggled in this area and it isn't been
clear how to handle things from the code perspective. The
"update_mirror_links" was one way we've attempted that but it is
clearly flawed.

I'd note a recent change I made for sort of related reasons may be
helpful:

https://git.openembedded.org/bitbake/commit/?id=3D58872250f72f5760b4126552b=
dec5497f5a1a1f4

I'm wondering if we can use the presence of "origud" as a way to build
any mirror link when the fetch succeeds and maybe remove
update_mirror_links entirely instead?

Cheers,

Richard



