Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65525C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:09:28 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.128274.1680696561189271056
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=H4lkGlrc;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335C9HDL1419260
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Apr 2023 14:09:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680696557;
	bh=kKLeWvaDiv9sEC8pNYW1F2Xcpk8zcuUuYh+CHCPDtzw=; l=1206;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=H4lkGlrc+2cLHLElvuRDko0qe1KuYa81wtEPbFGr/+dpPguz2WFTk3Sf0QnoQuG4P
	 Dips65j0GRtMknRGMieO3KRiMiqf5xGTFvFfJv7voCW7pKx7rUManb22PBHAimXRsA
	 E0Ls8d1kww6uUCsomCJAXlLgSs+rsNx7w+VYetFsRONV8BjA3Rb88SiL6+ZoP30ZIN
	 IugHyznOAOqfkV/d32kV8d2t/95fp31Ko5Gg/UTeunGtlNV/hz5QKHWYfXZ9YkYWty
	 UTVl3OfT40GdaD0hHvoKgjj9vivJwGIuCp40y6D1NcMf5gaH6ZeFihqBJmueyQhM5V
	 9f97W60m8B4Yg==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 335C9FXE1662122
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 5 Apr 2023 14:09:15 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ([192.168.12.73])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id UCGGTNPKIA; Wed, 05 Apr 2023 14:09:15 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 335C9EIh1374156
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Apr 2023 14:09:14 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pk1ww-00E2Tg-1q;
	Wed, 05 Apr 2023 14:09:14 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Martinsons <frederic.martinsons@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name'
 entries
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
	<CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
Date: Wed, 05 Apr 2023 14:09:14 +0200
In-Reply-To: <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
	(=?utf-8?B?IkZyw6lkw6lyaWM=?= Martinsons"'s message of "Wed, 5 Apr 2023
 14:03:44 +0200")
Message-ID: <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642d64eb5038ce378780cbd1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:09:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14651

Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:

> First, this is not compatible with recipes which will override the name
> parameter in their crate:// entry like zvariant in meta-selftest
> layer.

When this is really a problem (I do not see why), it existed already
before.


> Second, the cargo-update-recipe-crates class already did that
> modification for you (it set name parameter to be pkg-vers and it
> expect bitbake fetcher to respect that),

cargo-update-recipe-crates is not very useful and has huge bootstrapping
problems (see below).


> Last, this modification makes the bitbake unit test fail.

ok; my fault.  I will send a v2


> To bootstrap a cargo base recipe which have not this checksum list, below
> are
> the steps to make:
>   - make the recipe inherit cargo-update-recipe-crates
>   - remove all crate:// from your recipe
>   - create an empty ${BPN}-crates.inc file and make your recipe requires =
it
>   - execute "bitbake -c update_crates your_recipe"

This does not work.  This class requires Cargo.lock, but to have
Cargo.lock, do_compile() must be executed.  This fails when required
crates are not available yet.


Enrico

