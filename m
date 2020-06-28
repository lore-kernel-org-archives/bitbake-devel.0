Received: from mail.cvg.de (mail.cvg.de [193.158.56.148])
 by mx.groups.io with SMTP id smtpd.web11.25406.1593337691130666691
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Jun 2020 02:48:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=DdORiSC+;
 spf=pass (domain: sigma-chemnitz.de, ip: 193.158.56.148, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-0.intern.sigma-chemnitz.de (mail-mta-0.intern.sigma-chemnitz.de [192.168.12.76])
	by mailout-1.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05S9m7Md025819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2020 11:48:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1593337688;
	bh=kCEPk+D/7M8rwuClk8d5EmqMHmd2JRo6KkdHcMC8CmQ=; l=1282;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=DdORiSC+k5vCIyAl9JR4iQb/itl0MvehIb3y7ZVnWToVse4B5Qz7Ulp+shyOprZbg
	 b/iZtjmGXax0XJTnWSNjzfOVe0WJyngPtKINdRCvc0rinPkIcfaxcO+o0TUHGbRDSK
	 wfTRM7bqoyzI4NlF2SkyYBs/Zu5SNbaN8QUU2Hok=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05S9m4KS010176
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Sun, 28 Jun 2020 11:48:05 +0200
Received: from mail-msa-0.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 3757F8A33A4; Sun, 28 Jun 2020 11:48:04 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05S9m3uZ010173
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jun 2020 11:48:03 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1jpTut-001Suk-Eq; Sun, 28 Jun 2020 11:48:03 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Support for git+https://foo.example.com like URIs
References: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<099ddfc8784d7760adb9b1fdd8207325d29895dc.camel@linuxfoundation.org>
Date: Sun, 28 Jun 2020 11:48:03 +0200
In-Reply-To: <099ddfc8784d7760adb9b1fdd8207325d29895dc.camel@linuxfoundation.org>
	(Richard Purdie's message of "Sun, 28 Jun 2020 08:51:43 +0100")
Message-ID: <lyy2o7cyi4.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Richard Purdie" <richard.purdie@linuxfoundation.org> writes:

>> > PROJECT_BASE_URI = "git+https://foo.example.com/project"
>>
>> Is there some generic interest in this functionality so that I can
>> create and send a patch for bitbake?  Or is this too special and
>> people are happy with altering ${MIRROR}?
>
> I didn't (and don't) like writing special cases into general code.

mmmh... In my original report you complained that code is not generic
enough and works for git only.  Now, that is has been generalized, you
say it is too generic...


> My intent has always been (and still is) to see if a more generic
> solution is possible which not only addresses your use case but the
> ones others have as well.
>
> That will likely mean using the mirrors variable to remap things which
> will be slightly more complex but will also enable others.

I do not think, that bothering around with mirrors (or better PREMIRRORS)
is any helpful for this cases.  In 99% of cases, people want to set http://
or perhaps ssh:// as a transport protocol.

People want to completely rewrite an uri; they do not want to try another
one first and then another one.  This is nothing which can be solved by
mirrors; especially when you start to use AUTOREV.


Enrico
