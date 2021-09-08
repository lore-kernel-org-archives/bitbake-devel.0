Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web08.9353.1631094996629538331
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Sep 2021 02:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=CxWEUFoQ;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 1889uWTQ696379
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 8 Sep 2021 11:56:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1631094992;
	bh=gvAsGDLjOt4dsi7sW8RnCWCKPnz+elm2xuAIwDRIvIk=; l=493;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=CxWEUFoQSThiX35km7RqWasRq20SQSl+gJN/bEkwsL/c5IcyOrQf77w8rUkn9Xra/
	 dCcAJ2/b6SFnRs+Dwbph+pSQsXAOyhN56wA2mDByZ4F2stjPBCgOVXy9pBZcIGVCM2
	 j3AYifpJnpXpF1hRNc+QaiX+M1DNmtbxgcvVlQMQ=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 1889uUk2920496
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 8 Sep 2021 11:56:30 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 328890ADD4A; Wed, 8 Sep 2021 11:56:29 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 1889uSvK821362
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 8 Sep 2021 11:56:29 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mNuJg-00A3z8-Ez; Wed, 08 Sep 2021 11:56:28 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
References: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl>
Date: Wed, 08 Sep 2021 11:56:28 +0200
In-Reply-To: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl> (Damian
	Wrobel's message of "Fri, 3 Sep 2021 16:28:40 +0200")
Message-ID: <lyv93b9yr7.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Damian Wrobel" <dwrobel@ertelnet.rybnik.pl> writes:

> It frequently happens that the 3rd party layer is, in practise,
> fully compatible with the older version of yocto. So, instead of
> false positively reporting an error, it seems to be more
> appropriately to just emit the warning.

You can achieve this already now (when you are really sure that it works
for your bsp).  Just set

| LAYERSERIES_COMPAT:<foreign-layer>:append = " frodo"

in your bblayers.conf.



Enrico
