Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9D73B6A9C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 21:40:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2JLeTEv004185; Wed, 19 Mar 2014 21:40:29 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PnsCHslpFGNm; Wed, 19 Mar 2014 21:40:29 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2JLeP0X004162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Mar 2014 21:40:26 GMT
Message-ID: <1395265219.3808.139.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 19 Mar 2014 21:40:19 +0000
In-Reply-To: <CABcZANmHKR0EFDaKVq4nFQUUxb=NWeSCT=O6QKPSaPkHKcKc-A@mail.gmail.com>
References: <1395183532.3808.99.camel@ted>
	<CABcZANmHKR0EFDaKVq4nFQUUxb=NWeSCT=O6QKPSaPkHKcKc-A@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Really fix sigchld handling
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
X-List-Received-Date: Wed, 19 Mar 2014 21:40:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-03-19 at 14:30 -0700, Chris Larson wrote:
> 
> On Tue, Mar 18, 2014 at 3:58 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         +                        bb.warn("Unknown process (%s) exited
>         unexpectedly (%s), shutting down..." % (pid, str(status)))
>         
> 
> 
> This says it's shutting down, but the commit message and code imply
> that it isn't for these. I'm guessing this message needs adjustment
> from a copy/paste? :)
> 
Yes, indeed.

This signal handler stuff has been a mess and that patch and others have
just been making things worse.

Basically there are bugs in python 2.7.3 which expose problems which are
addressed in 2.7.4 and onwards. The whole signal handler approach was
flawed due to the toxic mix with subprocess anyway.

I've pushed some further patches basically reverting the signal handler
and we've ended up polling. Hopefully this stops things hanging and gets
us back to some kind of stability, I think I do understand all the
facets of the issues we've been hitting finally.

Cheers,

Richard




