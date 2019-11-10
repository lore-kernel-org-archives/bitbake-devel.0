Return-Path: <b.shehter@inango-systems.com>
X-Greylist: delayed 434 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 10 Nov 2019 08:12:11 UTC
Received: from mail.inango-sw.com (mail.inango-systems.com [213.136.71.184])
	by mail.openembedded.org (Postfix) with ESMTP id 57B897F99A
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Nov 2019 08:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id 7BB7A7A2410;
	Sun, 10 Nov 2019 10:04:58 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qy0ZFjvNJfrp; Sun, 10 Nov 2019 10:04:51 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id 26D587A23EE;
	Sun, 10 Nov 2019 10:04:51 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 26D587A23EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1573373091;
	bh=2lhpqCsg8/KSr2IBH2YOIe9+B2RfJ1yx0PscVd7QW3E=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=HO0TTTlzU/NAGmV4JS41YCZ6z5f+FgVem4aWkRSqE872SzsuIYozsJEqh+DE6DBJz
	roP78JHFL1mnJXl+nBW+LA6Qbsgz1lE5wCfUEDJZUhFuqztNdnPjD1dCKw3I56JNoS
	GFWGZqOitSqByLM7XFYfMG8PfWHV9aAY/UIHmTG5o6Zjp0XAiV+c9lKHSSn52CBehd
	Sh8cepoXPFnk5MTqG76F0ZfctDdZhKPwrleTebpRWnmqi4W8sozSjy4ocAN3KlRROy
	sLwj59fjdoUkycmpvZgmJro+tQvKVQPvHpKVcIvav1b2CTyN9BtuXZUUKpmM1EgJTq
	KOMPrLHkPcB7Q==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NmEJB2JIwbP6; Sun, 10 Nov 2019 10:04:50 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
	by mail.inango-sw.com (Postfix) with ESMTP id B255C7A23E0;
	Sun, 10 Nov 2019 10:04:50 +0200 (IST)
Date: Sun, 10 Nov 2019 10:04:50 +0200 (IST)
From: Boris Shehter <b.shehter@inango-systems.com>
To: Ivan Efimov <i.efimov@inango-systems.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <227567679.138464.1573373090025.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <1469739070.33402.1573188489180.JavaMail.zimbra@inango-systems.com>
References: <20191105140735.8204-1-i.efimov@inango-systems.com>
	<c080c0f1-426e-e40a-c4f5-3e66c6f7fd86@mvista.com>
	<1370792230.5885.1573108512017.JavaMail.zimbra@inango-systems.com>
	<be08b56117e97f23007b6984a0a98999f2644063.camel@linuxfoundation.org>
	<1469739070.33402.1573188489180.JavaMail.zimbra@inango-systems.com>
MIME-Version: 1.0
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.9_GA_3006 (ZimbraWebClient - GC78 (Win)/8.8.9_GA_3006)
Thread-Topic: bitbake-worker child process create group before registering
	SIGTERM handler
Thread-Index: M1jVFBSZcvB9J0eFtPfThAPxpSBX1mtly48h
X-Mailman-Approved-At: Sun, 10 Nov 2019 09:07:12 +0000
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 10 Nov 2019 08:12:11 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Richard 
We intensive are using yocto daisy and morty and we will be happy to test this fix on those version . Let say - we already tested. How can we integrate fix in relevant versions or only maintainer can do this  ? 


--------
Boris Shehter
(c) +972-54-6604528

----- Original Message -----
From: "Ivan Efimov" <i.efimov@inango-systems.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: "akuster" <akuster@mvista.com>, "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Sent: Friday, November 8, 2019 6:48:09 AM
Subject: Re: [bitbake-devel] [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler

Thanks a lot, Richard.

Best regards,
Ivan

[ https://inango.com/ |    ] 
Ivan Efimov 
Software Architect, Arch Group 
i.efimov@inango-systems.com 
T +7 343 298 0147 C +7 904 9 888 350 
[ https://inango.com/ | inango.com ] [ https://www.linkedin.com/company/inango ]

----- Original Message -----
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Ivan Efimov" <i.efimov@inango-systems.com>, "akuster" <akuster@mvista.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Sent: Friday, November 8, 2019 12:50:13 AM
Subject: Re: [bitbake-devel] [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler

On Thu, 2019-11-07 at 08:35 +0200, Ivan Efimov via bitbake-devel wrote:
> Hi Armin,
> 
> I've rechecked that this issue is relevant to next branches besides
> 1.32 and master:
> 
> 1.26
> 1.28
> 1.30
> 1.34
> 1.36
> 1.38
> 1.40
> 1.42
> 1.44
> 
> Could you please tell me what of them are still supported by BitBake
> community?

I think 1.40 onwards are still supported. I've just applied to patch to
those branches since its a clear/obvious fix and a clean backport. I
think I can do that in my capacity as bitbake maintainer! I also added
it to 1.38 since it helps with some other experiments I'm doing. I'm
reluctant to go further back as we have no testing capacity for the
older releases right now.

Cheers,

Richard

