Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 986936B872
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 14:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 1BDB019DCE;
	Tue,  7 Jan 2014 15:46:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zB+1HNa3tJDN; Tue,  7 Jan 2014 15:46:41 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id B335619DE0;
	Tue,  7 Jan 2014 15:46:39 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 9D52EADD;
	Tue,  7 Jan 2014 15:46:39 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 9237B4B0;
	Tue,  7 Jan 2014 15:46:39 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 900243E06F;
	Tue,  7 Jan 2014 15:46:39 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.255.0; Tue, 7 Jan 2014 15:46:39 +0100
Date: Tue, 7 Jan 2014 15:46:35 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140107144635.GA5566@axis.com>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
	<20140107103602.GP31548@axis.com> <1389102055.6899.25.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1389102055.6899.25.camel@ted>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: bb.fetch2.git: Fix
	_latest_revision function while using tags
Accept-Language: en-US, sv-SE
acceptlanguage: en-US, sv-SE
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
X-List-Received-Date: Tue, 07 Jan 2014 14:46:45 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Language: en-US

On 14-01-07 14:40 +0100, Richard Purdie wrote:
> On Tue, 2014-01-07 at 11:36 +0100, Olof Johansson wrote:
> > On 14-01-05 02:53 +0100, Andrei Gherzan wrote:
> > > When getting the revision we must take into consideration if the name we are
> > > looking for is a tag and in that case we need the dereferenced commit ID in
> > > order to check for it existance in a specific branch.
> > > 
> > > So first search for the reference^{} commit ID and only if that returns nothing
> > > get the name as it is.
> > 
> > I think this is the same issue I've tried to solve in a patch i
> > sent in December (subject: bb.fetch2.git: support resolving both
> > tags and branches). I haven't heard anything about it yet though.
> 
> I put this off as I wanted to spend some time and see if we couldn't
> come up with something simpler. Andrei's patch is simpler, the question
> is whether it covers all the cases and whether we even need the fallback
> code?

I agree with your reasoning with regards to not needing a
fallback for Andrei's patch, but my patch tries to first resolve
refs/tags/<tag> (fully qualified) and then falls back to try
refs/heads/<branch>. The reason for this is that ls-remote will
return things like refs/heads/lalala/<tag> if you only do
ls-remote <tag>.

My attempt was also to break out the tasks into simple,
atomic(-ish) functions that would later be easier to write unit
tests for. You complained on IRC that changes to the fetcher
usually comes back to bite you. I believe increased unit test
coverage on low level functions, as a compliment to the existing
more high level suite, can be beneficial in this regard.


Also, if you are holding things off, I would really appreciate
you letting us know so that we can make appropriate workarounds
if needed (as in this case, where we have had to supsend testing
on master :-().

Regards,
-- 
olofjn

