Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 59D1A7289A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 22:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBIMSWOY016118; Thu, 18 Dec 2014 22:28:32 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dZoyK93Lbbof; Thu, 18 Dec 2014 22:28:32 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBIMSJ2x016115
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Dec 2014 22:28:30 GMT
Message-ID: <1418941736.13316.4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Richard Tollerton <rich.tollerton@ni.com>
Date: Thu, 18 Dec 2014 22:28:56 +0000
In-Reply-To: <87tx0su2ys.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
References: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
	<1418898565.5106.19.camel@linuxfoundation.org>
	<87tx0su2ys.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
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
X-List-Received-Date: Thu, 18 Dec 2014 22:29:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-12-18 at 14:18 -0600, Richard Tollerton wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> > On Wed, 2014-12-17 at 19:11 -0600, Richard Tollerton wrote:
> >> The fix is to attempt to modify the variable in a subshell before doing
> >> the assignment.
> >
> > Isn't this going to involve fork() calls for every single shell
> > variable?
> 
> Yes :(
> 
> I'm not quite sure how to rigorously check the performance difference;
> is there a decent test case that exercises this and only this?
> 
> > There must be a better way to do this?
> 
> Not unless we rewrite how we set up the environment. My reading of POSIX
> is that no query facility exists for determining the read-only status of
> a variable [1] [2], and that the only permitted action for attempting to
> set a read-only variable is to exit [3] [4].
> 
> I suppose that enforcing a hard dependency on bash (via #!/usr/bin/env
> bash) could work around this, since this only seems to appear in POSIX
> mode; but I'm not yet convinced that the bash execution behavior when
> run as bash (vs sh) won't change in the future. Should I bring this up
> on bug-bash?

It might be an idea, it seems crazy that scripts can't tell if a given
action is going to result in their termination.

As for addressing the problem, from my reading of the bash environment
variables, there looks like a finite list of them which could cause
problems, so a blacklist may be an option, albeit an annoying one.

There is a correctness issue here since if we set something, we really
do want it set or an error in many cases.

Cheers,

Richard


