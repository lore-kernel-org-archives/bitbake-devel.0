Return-Path: <rich.tollerton@ni.com>
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
	by mail.openembedded.org (Postfix) with ESMTP id 0AED9728B3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 23:47:07 +0000 (UTC)
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod2.natinst.com (8.14.5/8.14.5) with ESMTP id
	sBINl6Y7007832; Thu, 18 Dec 2014 17:47:06 -0600
Received: from weregild ([130.164.14.198])
	by us-aus-mgwout1.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014121817470665-238595 ;
	Thu, 18 Dec 2014 17:47:06 -0600 
From: Richard Tollerton <rich.tollerton@ni.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1418941736.13316.4.camel@linuxfoundation.org>
References: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
	<1418898565.5106.19.camel@linuxfoundation.org>
	<87tx0su2ys.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
	<1418941736.13316.4.camel@linuxfoundation.org>
User-Agent: Notmuch/0.18.1 (http://notmuchmail.org) Emacs/24.4.1
	(x86_64-unknown-linux-gnu)
Date: Thu, 18 Dec 2014 17:47:06 -0600
Message-ID: <87r3vwttad.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/18/2014 05:47:06 PM,
	Serialize by Router on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/18/2014 05:47:06 PM,
	Serialize complete at 12/18/2014 05:47:06 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68, 1.0.33,
	0.0.0000
	definitions=2014-12-18_07:2014-12-18, 2014-12-18,
	1970-01-01 signatures=0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data: Avoid attempting to assign readonly shell vars
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
X-List-Received-Date: Thu, 18 Dec 2014 23:47:11 -0000
Content-Type: text/plain

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> On Thu, 2014-12-18 at 14:18 -0600, Richard Tollerton wrote:
>> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>> > There must be a better way to do this?
>> 
>> Not unless we rewrite how we set up the environment. My reading of POSIX
>> is that no query facility exists for determining the read-only status of
>> a variable [1] [2], and that the only permitted action for attempting to
>> set a read-only variable is to exit [3] [4].
>> 
>> I suppose that enforcing a hard dependency on bash (via #!/usr/bin/env
>> bash) could work around this, since this only seems to appear in POSIX
>> mode; but I'm not yet convinced that the bash execution behavior when
>> run as bash (vs sh) won't change in the future. Should I bring this up
>> on bug-bash?
>
> It might be an idea, it seems crazy that scripts can't tell if a given
> action is going to result in their termination.

Looks like bash's behavior of not exiting on readonly assignment
attempts is fairly longstanding and explicit, although not particularly
well documented [1]. So yes, switching from sh to bash would work around
this.

[1] http://article.gmane.org/gmane.comp.shells.bash.bugs/18756/


> As for addressing the problem, from my reading of the bash environment
> variables, there looks like a finite list of them which could cause
> problems, so a blacklist may be an option, albeit an annoying one.
>
> There is a correctness issue here since if we set something, we really
> do want it set or an error in many cases.

What do you think about this for a fix:

This only appears to be an issue with code that's using bb.data as a
part of a shell script generation, which AFAIK is only done from
terminal.py to build a run.do_terminal. (Otherwise, nothing would be
building right now.) What if we run e.g. `env -i run.do_terminal`
instead of `run.do_terminal`? That will completely clear the environment
prior to execution.

I'll try to take a stab at implementing this.

> Cheers,
>
> Richard

-- 
Richard Tollerton <rich.tollerton@ni.com>

