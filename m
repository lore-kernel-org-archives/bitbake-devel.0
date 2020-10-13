Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.9155.1602586297917257072
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2020 03:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=nVV3e6ib;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 09DApYLW485550
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2020 12:51:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1602586295;
	bh=nEPN7aw+6cIR124wzurcg2beuNglNcfzqrDQHOk5gZA=; l=818;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=nVV3e6ibSKbVsyi3pr+cTxR+5oVQimr6MiPVkNSf9d9vVtiU5rZdRACpo9CAVVDnl
	 QCJXFzjIhn+SiX9nF6iCZ2MXdQ9rWs/3q01ryRT87lWzV5IBHyFs0NmMfaJG0duvp1
	 5VMyAoOxllWFyHBdvYuFd9O0K3Zp49esDLhGDtX4=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 09DApWOC1382182
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Tue, 13 Oct 2020 12:51:33 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 5BEB2314FB4; Tue, 13 Oct 2020 12:51:28 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 09DApRVg554592
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 13 Oct 2020 12:51:27 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1kSHtv-008zmH-9g; Tue, 13 Oct 2020 12:51:27 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Steve Sakoman" <steve@sakoman.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 1/2] bitbake: fetch/git: add support for SRC_URI containing spaces in url
References: <cover.1602515077.git.steve@sakoman.com>
	<0a8a13131b2d520a405877cb9d39f3eae7d6882a.1602515077.git.steve@sakoman.com>
Date: Tue, 13 Oct 2020 12:51:27 +0200
In-Reply-To: <0a8a13131b2d520a405877cb9d39f3eae7d6882a.1602515077.git.steve@sakoman.com>
	(Steve Sakoman's message of "Mon, 12 Oct 2020 05:07:52 -1000")
Message-ID: <lyo8l69z68.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Steve Sakoman" <steve@sakoman.com> writes:

> This commit adds support for such urls by implementing two changes.
> Firstly, when bitbake makes a git command line call the url is
> surrounded by quotes so that the url, regardless of spaces, is
> treated as one argument. Secondly, additional parsing of various
> filepath variables, which are based off of the url, are now
> completed with any spaces in the url replaced with underscores.
>
> -            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, repourl, ud.clonedir)
> +            clone_cmd = "LANG=C %s clone --bare --mirror \"%s\" %s --progress" % (ud.basecmd, repourl, ud.clonedir)

Why do you quote it manually (and with double instead of single quote))
instead of using shlex.quote() or making the clone_cmd an array?


Enrico
