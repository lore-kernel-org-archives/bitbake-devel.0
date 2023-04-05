Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B6C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:24:28 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.128413.1680697460012436236
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=hW/9mM4E;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 335COIR41419372
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Apr 2023 14:24:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680697458;
	bh=tsWiifawTHEcTSJzi7bnEJwj6qL7HUjXO95IspWce2g=; l=327;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=hW/9mM4EVf6D2gfANd8dbUQ/PWryxV2lEeogrM4F2KER8itUNQSpjk8AVPdQxy1Kn
	 G2AomfKfoIuFdgzLbtwJLH8vJq1+IvS38i6sQdb1LcxlM8ev9W6TeYzYTCnox9Y1IC
	 oRLl2otIr1tTmUjJMOWkUtZ7MFtOnJYQOWoo2mny2K6ByEBeXgiZjk3vEvt2menG1v
	 1n3OvpeOJcYk0M6vdMWSQ6VYk/61AH+r9XgDoLYHH4sQy0jzZGeOrVAqUf+3YJdK6j
	 iN11m0sj0Z58cLa7zE6kDytYBYtELMHGQy6IHQrhuQvqNf5QrWcpJwehs1BviQys9a
	 eqRe2GgUxCUYg==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 335COGe41662308
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 5 Apr 2023 14:24:16 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ([192.168.12.73])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id DE5QAYU3KA; Wed, 05 Apr 2023 14:24:15 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 335COFtR1374267
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Apr 2023 14:24:15 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pk2BT-00E5yP-29;
	Wed, 05 Apr 2023 14:24:15 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Martinsons <frederic.martinsons@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name'
 entries
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
	<CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
	<lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
Date: Wed, 05 Apr 2023 14:24:15 +0200
In-Reply-To: <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
	(=?utf-8?B?IkZyw6lkw6lyaWM=?= Martinsons"'s message of "Wed, 5 Apr 2023
 14:21:52 +0200")
Message-ID: <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642d686f5038ce378780cbec
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:24:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14654

Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:

> A rust project must have a Cargo.lock in its source (
> https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-i=
n-version-control-but-not-libraries

It is recommended (due to documentation issues), but not required.


Enrico

