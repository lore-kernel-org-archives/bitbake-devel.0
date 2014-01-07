Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 48F116BF4E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 15:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 184E63F8009;
	Tue,  7 Jan 2014 16:52:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id credTDaQUbgO; Tue,  7 Jan 2014 16:52:54 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 52F7D19F3C;
	Tue,  7 Jan 2014 16:48:09 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 3C9DA618;
	Tue,  7 Jan 2014 16:48:09 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 30DAE1DA;
	Tue,  7 Jan 2014 16:48:09 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 2F30C3404E;
	Tue,  7 Jan 2014 16:48:09 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.255.0; Tue, 7 Jan 2014 16:48:08 +0100
Date: Tue, 7 Jan 2014 16:48:03 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140107154802.GA12425@axis.com>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
	<20140107103602.GP31548@axis.com> <1389102055.6899.25.camel@ted>
	<20140107144635.GA5566@axis.com> <1389106946.6899.38.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1389106946.6899.38.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Fix _latest_revision function while using tags
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
X-List-Received-Date: Tue, 07 Jan 2014 15:52:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-01-07 16:02 +0100, Richard Purdie wrote:
> On Tue, 2014-01-07 at 15:46 +0100, Olof Johansson wrote:
> > I agree with your reasoning with regards to not needing a
> > fallback for Andrei's patch, but my patch tries to first resolve
> > refs/tags/<tag> (fully qualified) and then falls back to try
> > refs/heads/<branch>. The reason for this is that ls-remote will
> > return things like refs/heads/lalala/<tag> if you only do
> > ls-remote <tag>.
> 
> Can we somehow anchor the expression instead e.g. refs/*/<xxx>^{}

Sure, we can do ls-remote without any arguments and parse the
output. But this won't make the patch easier in any way. One less
fork though.

> > My attempt was also to break out the tasks into simple,
> > atomic(-ish) functions that would later be easier to write unit
> > tests for. You complained on IRC that changes to the fetcher
> > usually comes back to bite you. I believe increased unit test
> > coverage on low level functions, as a compliment to the existing
> > more high level suite, can be beneficial in this regard.
> 
> I believe that my complaint could also be addressed by ensuring the high
> level tests had more coverage of the variety of supported use cases. In
> this case a range of tags of differing types, branches and hanging
> commits would have helped ensure the changes to the fetcher didn't break
> things.

Yes, that probably possible. *I* find low level unit tests easier
to work with, and I wanted to do what I could to alleviate the
situation; making sure that (at least) our use cases are covered
by automated tests.

> I'm less keen on forcing an atom like set of functions on the fetcher
> just for the purposes of the test suite. Sorry I was unclear on that, I
> guess different people have different understandings of what increased
> coverage would mean.

I find it easier to work in functions with limited scopes, with
clear purposes --- with or without unittests (unittests being
preferable, obviously). But then again, I'm not the maintainer,
so your preferences are more important :-).

> > Also, if you are holding things off, I would really appreciate
> > you letting us know so that we can make appropriate workarounds
> > if needed (as in this case, where we have had to supsend testing
> > on master :-().
> 
> Well, it wasn't a conscious decision so much as the holidays came along
> and I ran out of time to look at it. I'm trying to get this resolved now
> since obviously various people are hitting the problem cases.

I really appreciate the hard work you are doing :-).


Regards,
-- 
olofjn

