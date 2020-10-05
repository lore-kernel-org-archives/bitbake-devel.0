Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.35155.1601904597696994854
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 06:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=np/RUs9i;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 095DTqwv408437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Mon, 5 Oct 2020 15:29:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1601904593;
	bh=K45T+2hLd7EFtH7fBnDnW13+/1fXlfjcLT4vAupBcBQ=; l=645;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=np/RUs9ihvUbx1cAGGxaKK9dJT12xfFxCSbgb3/aTvL5rx0WsCebEXKUBjEtRhq7P
	 0s6pG7YdOln+uYT74c/yVJN4TGJ6bN4ZB7ZCexlcekVeI/P9ZYcdswGWpw/uectj/g
	 oQPYBFy09YOAVna9Xl8BfuiqbYMOe+1i7hIjE78c=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 095DToLx1169891
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Mon, 5 Oct 2020 15:29:50 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 5EB8A2ED376; Mon, 5 Oct 2020 15:29:48 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 095DTk8D465504
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 5 Oct 2020 15:29:48 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1kPQYj-001LEw-RQ; Mon, 05 Oct 2020 15:29:45 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
Cc: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] fetch2: fix handling of `\` in file:// SRC_URI
References: <ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
	<20200923161832.235619-1-leif.middelschulte@klsmartin.com>
Date: Mon, 05 Oct 2020 15:29:45 +0200
In-Reply-To: <20200923161832.235619-1-leif.middelschulte@klsmartin.com> (Leif
	Middelschulte's message of "Wed, 23 Sep 2020 18:18:33 +0200")
Message-ID: <lyd01wby2e.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Leif Middelschulte" <leif.middelschulte@klsmartin.com> writes:

> -                cmd = 'cp -fpPRH %s %s' % (file, destdir)
> +                # do not rely on Shell's glob expansion.
> +                file = ' '.join("'{}'".format(file_path) for file_path in glob.glob(file))
> +                cmd = 'cp -fpPRH %s "%s"' % (file, destdir)

Why single quotes in "file" but double quotes in the cmd?


Would it make sense to implement this correctly from the beginning.  E.g.

- avoid manual quoting but use "pipes.quote()"

- do not use a shell command string but an array which is given directly
  to execve()?

Else, next patchset will deal with single/double quotes...



Enrico
