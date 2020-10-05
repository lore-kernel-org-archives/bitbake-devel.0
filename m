Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.35811.1601907311757756082
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 07:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=UZh2t9ko;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 095EF9Kw408792
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Mon, 5 Oct 2020 16:15:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1601907309;
	bh=CFth+edhoVjPgj3iVav8umMQ1WxQppWeQPhZcelA/Y4=; l=1308;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=UZh2t9koZFPMARl4Fc3RjONSaswQiTax18o/29UCJXDvbyWru5t8Q7ZdrIXkU7t3N
	 usgY6u9RbZFJ2h/IqwpvxTGUNRPfWNu1Ql/UCYniRgzJjAqM9+pkQKBv0+I05HltT9
	 ZZ2kjQZMZd96kreaBcwagbWzNWTYxZwtdZryXz1c=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 095EF6bi1170919
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Mon, 5 Oct 2020 16:15:07 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 132FB452059; Mon, 5 Oct 2020 16:15:05 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 095EF5ua466030
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 5 Oct 2020 16:15:05 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1kPRGb-001Qth-8R; Mon, 05 Oct 2020 16:15:05 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] fetch2: fix handling of `\` in file:// SRC_URI
References: <ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
	<20200923161832.235619-1-leif.middelschulte@klsmartin.com>
	<lyd01wby2e.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<3c1dfb2c2535dcb98bd82a6c1405a1d378b79270.camel@klsmartin.com>
Date: Mon, 05 Oct 2020 16:15:05 +0200
In-Reply-To: <3c1dfb2c2535dcb98bd82a6c1405a1d378b79270.camel@klsmartin.com>
	(Leif Middelschulte's message of "Mon, 5 Oct 2020 13:42:06 +0000")
Message-ID: <ly7ds4bvyu.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com> writes:

>> > +                file = ' '.join("'{}'".format(file_path) for file_path in glob.glob(file))
>> > +                cmd = 'cp -fpPRH %s "%s"' % (file, destdir)
>> 
>> Why single quotes in "file" but double quotes in the cmd?
>
> You are correct. It should be double quotes too, to allow variable
> expansion by the shell.

Is it really allowed/expected to have environment variables in SRC_URI?
E.g. is it expected that

| SRC_URI = "file://$HOME/foo"

works?  This fails here because other parts of bitbake (lookup in
${FILESPATH} or in MIRRORS) use this string directly.


>> Would it make sense to implement this correctly from the beginning.  E.g.
>> 
>> - avoid manual quoting but use "pipes.quote()"
> I assume this would be shlex.quotes?

ok; yes.  It is shlex in python3


>> - do not use a shell command string but an array which is given directly
>>   to execve()?
>
> AFAII it's desired to be able to reuse other environment variables in
> `SRC_URI`s.  What's more is that once https://bugs.python.org/issue38893
> is fixed, one might want to use python

But native python operations do not expand environment variables
either.  Resp. expansion must be done manually which is possible with
the "execve([])" way too.



Enrico
