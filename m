Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web09.42689.1629222256899520586
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Aug 2021 10:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=Zw8fjUZW;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17HHiC6a483064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Aug 2021 19:44:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629222253;
	bh=rURgfzs1tCeOFVJ2CdEIrNVc9y7q/dD+RV7RKameVRA=; l=711;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=Zw8fjUZWnS8aQ52Cot2aS+raGLZsF9WxDhnwDJbfufEW2Ioh57zqsHPwRfTAg1BRW
	 nIAYSeNIAPXpaGzSZ3UeNmCE+SzXiFx1Z3TTxatpHw1HNMfgDCnJ5eSKcC9zNYWYeD
	 CHmiYJt3xVuTyYlULaNaCzK0fn1rOWaS8Azqo2es=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17HHi6ba652930
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Tue, 17 Aug 2021 19:44:06 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 5426E7BDA4C; Tue, 17 Aug 2021 19:44:05 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17HHi5SK581613
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Aug 2021 19:44:05 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mG388-00A7Hn-Te; Tue, 17 Aug 2021 19:44:04 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Ross Burton" <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 3/4] fetch2/wget: ensure all variables are set when calling urllib
References: <20210810165509.19121-1-ross.burton@arm.com>
	<20210810165509.19121-3-ross.burton@arm.com>
	<ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de>
Date: Tue, 17 Aug 2021 19:44:04 +0200
In-Reply-To: <ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de> (Enrico
	Scholz via lists openembedded org's message of "Tue, 17 Aug 2021
	19:39:03 +0200")
Message-ID: <ly1r6srmor.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Enrico Scholz via lists.openembedded.org"
<enrico.scholz=sigma-chemnitz.de@lists.openembedded.org> writes:

>> Instead of just exporting the proxy variables when calling into urllib,
>> use bb.utils.environment() to export all of the known variables that are
>> needed for proper connectivity.
>
> This patch breaks fetching from sstate servers[1].
>
> We have
>
> |  PREMIRRORS="\
> | ftp://.*/.*
> https://sstate.intern.sigma-chemnitz.de:30011/api/v1/download/irdjqumJ5ImHIGG5/source/defaultpkgname/

wrong variable;

| SSTATE_MIRRORS="    file://.*    https://sstate.intern.sigma-chemnitz.de:30011/api/v1/download/irdjqumJ5ImHIGG5/sstate/defaultpkgname/PATH "

is the correct one



Enrico
