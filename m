Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.42727.1629221957427067926
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Aug 2021 10:39:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=i3X3LlsY;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17HHdCjC522239
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Aug 2021 19:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629221952;
	bh=+orMEh5oEK02Bq12Sfb9iNBdoPGE5rsNLEfrPZVyPf0=; l=1584;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=i3X3LlsYpWIfyZMJp37cYFiYaPFpqC0rPO9ti7yWQpKiG4C48a9Oerzyiv4spWqf+
	 0jplWH8iYh7VOKnXSiS2/0DUzfOc0PrzSHICeweOh4/BxqXjZ16OmwFwoyhwQ5F9IY
	 fZYLWntJToIBKI+5nnaXdNd5fCZr7FkEscKjxtWU=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17HHd5Sg1257359
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Tue, 17 Aug 2021 19:39:05 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.73]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 481A5BFA224; Tue, 17 Aug 2021 19:39:04 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 17HHd4Jq557339
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Aug 2021 19:39:04 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mG33H-00A6CN-ND; Tue, 17 Aug 2021 19:39:03 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Ross Burton" <ross@burtonini.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 3/4] fetch2/wget: ensure all variables are set when calling urllib
References: <20210810165509.19121-1-ross.burton@arm.com>
	<20210810165509.19121-3-ross.burton@arm.com>
Date: Tue, 17 Aug 2021 19:39:03 +0200
In-Reply-To: <20210810165509.19121-3-ross.burton@arm.com> (Ross Burton's
	message of "Tue, 10 Aug 2021 17:55:08 +0100")
Message-ID: <ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Ross Burton" <ross@burtonini.com> writes:

> Instead of just exporting the proxy variables when calling into urllib,
> use bb.utils.environment() to export all of the known variables that are
> needed for proper connectivity.

This patch breaks fetching from sstate servers[1].

We have

|  PREMIRRORS="\
|    ftp://.*/.*    https://sstate.intern.sigma-chemnitz.de:30011/api/v1/download/irdjqumJ5ImHIGG5/source/defaultpkgname/ \n
|    https?://.*/.* https://sstate.intern.sigma-chemnitz.de:30011/api/v1/download/irdjqumJ5ImHIGG5/source/defaultpkgname/ \n
|    git://.*/.*    https://sstate.intern.sigma-chemnitz.de:30011/api/v1/download/irdjqumJ5ImHIGG5/scm/defaultpkgname/INVALID \n"

      [lines splitted for readability]
      [there is no secret in the log... token is not reusable]

and

| https_proxy=http://www-cache:3128/
| no_proxy='.sigma-chemnitz.de,sigma-chemnitz.de,cvg.de,.cvg.de,andto.de,.andto.de,localhost,<local>'

Before this patch, the sstate server was connected directly but now, the
proxy is tried.


I can reproduce it here e.g. by

| $ bitbake gettext-minimal-native -ccleansstate
| $ bitbake gettext-minimal-native
| ERROR: gettext-minimal-native-0.21-r0 do_populate_lic_setscene: No suitable staging package found
|
| DEBUG: checkstatus() urlopen failed: <urlopen error Tunnel connection failed: 403 Forbidden>

  (proxy logs show a 'CONNECT' to 'sstate.intern.sigma-chemnitz.de'
   which is reject with 403)



'git bisect' points to this commit.



Enrico

Footnotes:
[1]  fwiw, https://gitlab-ext.sigma-chemnitz.de/ensc/sstate-server

