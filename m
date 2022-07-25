Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B6BC43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 18:15:19 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.31791.1658772912179666564
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 11:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=iCECRvM6;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67,
 mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de
 (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id
 26PIF9Xa461007
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 20:15:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1658772909;
	bh=ods/jFByCPv9RGJEJPWCH+Yj3YVf0uZsHvJiq8vE+Lg=; l=503;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=iCECRvM6rug7zAOxm/dHD4llFIkrjFQ3OCTe5bvtKq7I/3jOZBZCbR8iDwLyVcikw
	 taSrp7j+pRd6TbLeo+mwhUrLxHJ1/ZJfdLzOlZLdhsC6/ajhJESdnX8SZ4HQ+0hOD0
	 j57wql76Gw0RjdldI5p6vjCxLhnKOT68bJ09ZcpYc5Qf7hR1tJlnufwAGUA+lu6xYL
	 +qAGieVWvmKusvjGQQQ9J2URfFZxkkj4TAxpqI7bbpwaW4qJW2IS4D2choKaYaY9KO
	 gkex5+RvKC+zmN26eOvwAP8UKBIlkaXWubAUSUzC8ixqQ63GTBm9e5NtpQD59r3kHg
	 XOitAmDGch1lg==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local
 [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id
 26PIF64Q575040
	for <bitbake-devel@lists.openembedded.org> from
 enrico.scholz@sigma-chemnitz.de; Mon, 25 Jul 2022 20:15:07 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by
 reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 1479363FA9D; Mon, 25 Jul 2022 20:15:01 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de
 (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id
 26PIEwTf440211
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Jul 2022 20:14:58 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.95)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1oG2ba-00FmrU-DX;
	Mon, 25 Jul 2022 20:14:58 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: "Marek Vasut" <marex@denx.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-user-manual: Document
 override :append, :prepend, :remove order
References: <20220725155625.381756-1-marex@denx.de>
Date: Mon, 25 Jul 2022 20:14:58 +0200
In-Reply-To: <20220725155625.381756-1-marex@denx.de> (Marek Vasut's message of
	"Mon, 25 Jul 2022 17:56:25 +0200")
Message-ID: <lyr12983fh.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 18:15:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13846

"Marek Vasut" <marex@denx.de> writes:

>  
> +.. note::
> +
> +   The overrides are applied in this order, ":append", ":prepend", ":remove".
> +   This implies it is not possible to re-append previously removed
>     strings.

fwiw, this is possible by anonymous python functions which are evaluated
after ":remove"

| FOO = "123 abc XYZ"
| 
| python () {
|     v = d.getVar('FOO')
|     d.setVar('FOO', v + ' abc 789')
| }
| 
| FOO:remove = "abc XYZ"

results in

| FOO="123   abc 789"



Enrico

