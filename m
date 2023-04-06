Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA99AC76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 14:18:45 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.159499.1680790716117052575
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 07:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=fD41JOzM;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 336EIXtD1319792
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Thu, 6 Apr 2023 16:18:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1680790714;
	bh=ou/tKU5TjiRckKGh1axku0GZTu8fEJfmcvHZE3JUC6o=; l=855;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=fD41JOzM2Gu8jktkyEBLVAOTSD219nC4DfO91mvJ4d1M58uACfVZsgFxtg3ED1q8J
	 o7/hV8/5UOgyLY3+wWbOvvJOn1p/3McRE7teIVNWTvIZiaGvlMU3IYdDtoLt4qWY9/
	 YFJ6ZKtL126V0p32bfjhUqDUjG8lJoMu5FtCW6ds83KIJEIANVfnJB8g8efLAK+bdo
	 i2sGAJUQay6aD7sd1BASUqvnH7HDzHfYp0cF8xZxb2npfooD0Df0Gd1jLauEJY+nyN
	 /f6LCTrEVkrgHMAYg8YBtQm2uItshtKEoz7qeg6ph8wE96NNoRQMAL9gIC9xEeSG0M
	 G7ZlBLrlbSsGA==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 336EIVI81680653
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Thu, 6 Apr 2023 16:18:32 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id H5U5KUZMT6; Thu, 06 Apr 2023 16:18:31 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 336EIUJc1280813
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 6 Apr 2023 16:18:30 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pkQRa-000TtA-23;
	Thu, 06 Apr 2023 16:18:30 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>,
        bitbake-devel@lists.openembedded.org
Subject: ';sha256sum=' attribute in SRC_URI (was: [bitbake-devel] [PATCH]
 fetch:crate: create versioned 'name' entries)
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
	<CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
	<lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
	<lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<17530ADB1695B5D1.3977@lists.openembedded.org>
	<CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
	<ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
	<088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
	<ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
Date: Thu, 06 Apr 2023 16:18:30 +0200
In-Reply-To: <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
	(Richard Purdie's message of "Thu, 06 Apr 2023 13:14:21 +0100")
Message-ID: <lyfs9daybt.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 642ed4b75038ce378780d25d
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 14:18:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14676

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> Now I've been looking more closely at this, I did start to wonder if we
> shouldn't just put ;sha256sum=XXX parameters onto the crate urls we
> generate though? If we do that, we don't need to name them at all.

I just tested this with

SRC_URI += " \
    crate://crates.io/addr2line/0.19.0;sha256sum=a76fd60b23679b7d19bd066031410fb7e458ccc5e958eb5c325888ce4baedc97 \
    crate://crates.io/adler/1.0.2;adler-1.0.2.sha256sum=f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe \
"

and got

| do_fetch: Missing SRC_URI checksum, please add those to the recipe: 
| SRC_URI[addr2line-0.19.0.sha256sum] = "a76fd60b23679b7d19bd066031410fb7e458ccc5e958eb5c325888ce4baedc97"


It seems that ';sha256sum' does not suffice but that you have to dup the
'name'.



Enrico

