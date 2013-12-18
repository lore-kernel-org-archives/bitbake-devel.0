Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id CB0C660CDD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 11:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 777983F21D2;
	Wed, 18 Dec 2013 12:51:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZaRxHApiXlDn; Wed, 18 Dec 2013 12:51:21 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id C8CC63F2161;
	Wed, 18 Dec 2013 12:51:21 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id B25675FA;
	Wed, 18 Dec 2013 12:51:21 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id A6A49B35;
	Wed, 18 Dec 2013 12:51:21 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id A537C3E086;
	Wed, 18 Dec 2013 12:51:21 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.255.0;
	Wed, 18 Dec 2013 12:51:21 +0100
Date: Wed, 18 Dec 2013 12:51:20 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20131218115120.GM31548@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
	<1386866938-5932-4-git-send-email-olof.johansson@axis.com>
	<1387367036.6402.37.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1387367036.6402.37.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
X-List-Received-Date: Wed, 18 Dec 2013 11:51:27 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 13-12-18 12:43 +0100, Richard Purdie wrote:
> > +import unittest
> > +from mock import Mock, patch
> 
> This is going to cause some headaches since we don't have Mock listed in
> and of the prerequisite documentation, nor is it present in our prebuilt
> tools tarball or do we have a recipe for it.
> 
> This is probably enough to block the patch until we can find someone to
> look at fixing that :(

Ah, yeah, I see. It is a very useful testing library, but I could
take a look at rolling my own alternative. Unless there's a way
to make it acceptable for us with bitbake. Would creating a
recipe for it be enough? Or just skip the tests if mock isn't
available?

> Would it be possible to separate out the tests from the other changes?

Yes. I was planning to do that after our discussions on IRC, but
haven't gotten around to it yet. Will hopefully do that before
going on vacation on friday.


Thanks,
-- 
olofjn

