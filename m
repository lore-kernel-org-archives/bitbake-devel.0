Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web08.51994.1629278939149822902
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Aug 2021 02:29:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=CDtYUt77;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17I9Srfb489522
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Aug 2021 11:28:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629278933;
	bh=LuOV/s95zYof3wFy6m/Ssqy+45i7lPscUcYRTMWqV3w=; l=724;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=CDtYUt77+8CdxNfUMWFbVjENqwEdvDA5iJKpOlGzrHRv4xfn02vL7bqzG6Th4U1Sb
	 bU4T7IGwowGiborPsqMvM4GEuPdD90pg8E2brvB0+Tp/3gM+oxqVkCHrSy9cMTgNxz
	 2QKQ8ljQvhzcgFpPpcqZTqIsytmSPfWSThMyxDMI=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17I9Sk8Z1269694
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 18 Aug 2021 11:28:46 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 572543694E3; Wed, 18 Aug 2021 11:28:45 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17I9Si58588969
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Aug 2021 11:28:44 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mGHsK-00DewC-II; Wed, 18 Aug 2021 11:28:44 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Ross Burton" <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 3/4] fetch2/wget: ensure all variables are set when calling urllib
References: <20210810165509.19121-1-ross.burton@arm.com>
	<20210810165509.19121-3-ross.burton@arm.com>
	<ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de>
Date: Wed, 18 Aug 2021 11:28:44 +0200
In-Reply-To: <ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de> (Enrico
	Scholz via lists openembedded org's message of "Tue, 17 Aug 2021
	19:39:03 +0200")
Message-ID: <lywnojqeyb.fsf@ensc-virt.intern.sigma-chemnitz.de>
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

| --- a/bitbake/lib/bb/fetch2/wget.py
| +++ b/bitbake/lib/bb/fetch2/wget.py
| ...
| +        with bb.utils.environment(**newenv):
| +            import ssl
|          ...
|          try:
|              uri = ud.url.split(";")[0]

Moving this 'try' block (with the `opener.open(r)` call) into the 'with'
context seems to solve the problem.



Enrico
