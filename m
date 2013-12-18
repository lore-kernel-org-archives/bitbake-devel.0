Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A725660D39
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 12:26:13 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBICQ1Rs001914; Wed, 18 Dec 2013 12:26:01 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DsrueHyDVv9D; Wed, 18 Dec 2013 12:26:01 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBICPt4O001881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Dec 2013 12:25:56 GMT
Message-ID: <1387369550.6402.38.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Wed, 18 Dec 2013 12:25:50 +0000
In-Reply-To: <20131218115120.GM31548@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
	<1386866938-5932-4-git-send-email-olof.johansson@axis.com>
	<1387367036.6402.37.camel@ted> <20131218115120.GM31548@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC 3/5] bb.tests.fetch_git: initial set of tests for git fetcher
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
X-List-Received-Date: Wed, 18 Dec 2013 12:26:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-12-18 at 12:51 +0100, Olof Johansson wrote:
> On 13-12-18 12:43 +0100, Richard Purdie wrote:
> > > +import unittest
> > > +from mock import Mock, patch
> > 
> > This is going to cause some headaches since we don't have Mock listed in
> > and of the prerequisite documentation, nor is it present in our prebuilt
> > tools tarball or do we have a recipe for it.
> > 
> > This is probably enough to block the patch until we can find someone to
> > look at fixing that :(
> 
> Ah, yeah, I see. It is a very useful testing library, but I could
> take a look at rolling my own alternative. Unless there's a way
> to make it acceptable for us with bitbake. Would creating a
> recipe for it be enough? Or just skip the tests if mock isn't
> available?

How about we check mock into the bitbake tree? Looking at
https://pypi.python.org/pypi/mock it seems we can get away with a 75kb
file from the tarball assuming I understand things correctly...

> > Would it be possible to separate out the tests from the other changes?
> 
> Yes. I was planning to do that after our discussions on IRC, but
> haven't gotten around to it yet. Will hopefully do that before
> going on vacation on friday.

Ok, thanks.

Cheers,

Richard


