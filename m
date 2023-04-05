Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3260C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:40:17 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.126041.1680687604299117597
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 02:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=KVEg1mu9;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 3359dx021418157
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Apr 2023 11:39:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680687599;
	bh=QRbDYW1AZvWRXUZmNVKJKofmKo67HvzEzVL/EGKPKTk=; l=707;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=KVEg1mu9VrMu9wDgwMwvyd0jlGVyuZvkf4mb3CLaZ81Uz0Mn5KiaGsB3w3YeTEpqD
	 zcJxXh3Wh8/aa9xdzl22jgJtB3KAp9O1qHxj8GQP18rla3k3Jonc5jwM/0FLqzjGS/
	 5nw3gET0ixMrJ0T7KWUS0QvcwDlYjxT2LYzNubt9+JAym5msL5eo3z7CtF1kB+LBRT
	 QTDRiZuHiXdFHAY2jaifpH+6zJyNoJgBIU9GbFQ9dfM/UI/ChVFe+5nDwTuStw4pzZ
	 atirmP1GYnwugJLtTxnFaktVw9g+GdyoJ6ycb75j2uvM9H52PLe3sx/CHaZfSvpdQp
	 9lLuodjgYKCug==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 3359dvH6398992
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 5 Apr 2023 11:39:57 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id GVMME4RSS4; Wed, 05 Apr 2023 11:39:57 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 3359du3e1269126
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Apr 2023 11:39:56 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pjzcS-00DgSK-0c;
	Wed, 05 Apr 2023 11:39:56 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: "Frederic Martinsons" <frederic.martinsons@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, akuster <akuster@mvista.com>,
        bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at
 once
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
	<7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
	<CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
	<68045681-5481-80f5-30f4-e15616503dcd@mvista.com>
	<CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
	<CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
Date: Wed, 05 Apr 2023 11:39:56 +0200
In-Reply-To: <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
	(Frederic Martinsons's message of "Wed, 5 Apr 2023 07:20:16 +0200")
Message-ID: <lysfded5w3.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642d41ed5038ce378780cab0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:40:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14641

"Frederic Martinsons" <frederic.martinsons@gmail.com> writes:

> I looked at the suricata recipe in meta-security and it didn't use
> cargo-update-recipes.bbclass
>
> You should modify your rust recipes to use this class and have access to
> "bitbake -c update_crates" .

Is this really the recommended way for rust packages?  As you already
mentioned, this has a big problem with bootstrapping: fetch (for
downloading the crates) and compile (to create Cargo.lock) must be
run before do_update_crates works.

IMO, the crate fetcher should be changed to create versioned 'name'.  Then
the 'cargo bitbake' output can be used directly and missing checksums can
be copied & pasted.



Enrico

