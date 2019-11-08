Return-Path: <i.efimov@inango-systems.com>
Received: from mail.inango-sw.com (mail.inango-systems.com [213.136.71.184])
	by mail.openembedded.org (Postfix) with ESMTP id C3FC97FA47
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2019 04:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id 746607A0C78;
	Fri,  8 Nov 2019 06:48:19 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aamSqfgXJXgw; Fri,  8 Nov 2019 06:48:12 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-sw.com (Postfix) with ESMTP id 8C8EF7A0C77;
	Fri,  8 Nov 2019 06:48:11 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 8C8EF7A0C77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1573188491;
	bh=+BSvhigHSy6A3txjDTUVQew8FPcs7JoKCnFReeNgJj0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Sm3D8COAJi5Q6ZYHvsfruQHZPCAbMgesjDjUOGFlCyCYPNGlFKnhODHWbgZqPr8GE
	QB6hyyL37sFiqyGY081idrSo/UjYV8fD0RQSkeYDWTDoeixZnQjb9w7re0zBq8nHk1
	FQyfrHWAzWwN0R59vJvD1o7ttwhILmNiQD+ACjgfNoP9iax0CFG55C6IMMxxgGHXJa
	TG2Kt63omscREBFthPLVxjzWVa38SgMrGEUEA6lDD9FX8Oh3cAoUFMa60/MYui0upy
	MUvY/18UCR2wUJKnseQrp34TSaWaP8xfU8ZrmbpEIUkAB1WGM9/Q6huAekVlYG/q6n
	3lJdODAo4CGuA==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
	by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LmFJ6Qv0b-rJ; Fri,  8 Nov 2019 06:48:11 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
	by mail.inango-sw.com (Postfix) with ESMTP id 4A0437A0C72;
	Fri,  8 Nov 2019 06:48:11 +0200 (IST)
Date: Fri, 8 Nov 2019 06:48:09 +0200 (IST)
From: Ivan Efimov <i.efimov@inango-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <1469739070.33402.1573188489180.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <be08b56117e97f23007b6984a0a98999f2644063.camel@linuxfoundation.org>
References: <20191105140735.8204-1-i.efimov@inango-systems.com>
	<c080c0f1-426e-e40a-c4f5-3e66c6f7fd86@mvista.com>
	<1370792230.5885.1573108512017.JavaMail.zimbra@inango-systems.com>
	<be08b56117e97f23007b6984a0a98999f2644063.camel@linuxfoundation.org>
MIME-Version: 1.0
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.9_GA_3006 (ZimbraWebClient - GC77 (Linux)/8.8.9_GA_3006)
Thread-Topic: bitbake-worker child process create group before registering
	SIGTERM handler
Thread-Index: M1jVFBSZcvB9J0eFtPfThAPxpSBX1g==
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
X-List-Received-Date: Fri, 08 Nov 2019 04:48:20 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

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

