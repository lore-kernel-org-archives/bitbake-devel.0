Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.43664.1629225920926619479
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Aug 2021 11:45:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=ka+hUhJl;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17HIjGM5522678
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Aug 2021 20:45:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629225916;
	bh=sAGP1i5AJuiZUdnszG57BmULAsm4ThiqDSXnSKno7Dc=; l=1593;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=ka+hUhJlSEGcIuVRo8/BI5PPYNyTXskHsotnDPEaMujYfyCnGTN+bbCJNXEywZrA9
	 4oXGwh7agvfQCwt0ZGE59ETt0UEa9SaFclclIG/jUXYn3cXVMjt+VShxsla1QQQ5Vy
	 SsIsfhI0H8LCFgeZgAZHfKAf1mu97vQ0ouAoUitQ=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17HIj9Y51258053
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Tue, 17 Aug 2021 20:45:10 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 713266516B5; Tue, 17 Aug 2021 20:45:07 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17HIj7gH582047
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Aug 2021 20:45:07 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mG45D-00ANVt-6c; Tue, 17 Aug 2021 20:45:07 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Ross Burton" <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 3/4] fetch2/wget: ensure all variables are set when calling urllib
References: <20210810165509.19121-1-ross.burton@arm.com>
	<20210810165509.19121-3-ross.burton@arm.com>
	<ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de>
Date: Tue, 17 Aug 2021 20:45:07 +0200
In-Reply-To: <ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de> (Enrico
	Scholz via lists openembedded org's message of "Tue, 17 Aug 2021
	19:39:03 +0200")
Message-ID: <ly35r7ykp8.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Enrico Scholz via lists.openembedded.org"
<enrico.scholz=sigma-chemnitz.de@lists.openembedded.org> writes:

> "Ross Burton" <ross@burtonini.com> writes:
>
>> Instead of just exporting the proxy variables when calling into urllib,
>> use bb.utils.environment() to export all of the known variables that are
>> needed for proper connectivity.
>
> This patch breaks fetching from sstate servers[1].
> 
> | https_proxy=http://www-cache:3128/
> | no_proxy='.sigma-chemnitz.de,...'
> 
> I can reproduce it here e.g. by
>
> | $ bitbake gettext-minimal-native -ccleansstate
> | $ bitbake gettext-minimal-native
> | ERROR: gettext-minimal-native-0.21-r0 do_populate_lic_setscene: No suitable staging package found
> |
> | DEBUG: checkstatus() urlopen failed: <urlopen error Tunnel connection failed: 403 Forbidden>

I guess this happens because in

| +        with bb.utils.environment(**newenv):
| +            handlers = [...
| +                        urllib.request.ProxyHandler(),

the urllib.request.ProxyHandler constructor takes 'https_proxy' from
environment (but not 'no_proxy').

Real open happens later (when the 'with bb.utils.environment...' has
been left) and there,

| class ProxyHandler(BaseHandler):
|     def proxy_open(self, req, proxy, type):
|         ...
|         if req.host and proxy_bypass(req.host):
|             return None

is called.  'proxy_bypass()' checks 'no_proxy' from env which is not
available anymore.


Normale fetching does not seem to be affected because proxy vars are in
BB_ENV_EXTRAWHITE and exported to jobs.  But 'sstate' fetching does not
seem to use this mechanism.



Enrico
