Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShkAO-0003Qe-Oe for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 18:23:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LGCkGi024309;
	Thu, 21 Jun 2012 17:12:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23390-08; Thu, 21 Jun 2012 17:12:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LGCaiZ024302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 17:12:38 +0100
Message-ID: <1340295159.1640.132.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Thu, 21 Jun 2012 17:12:39 +0100
In-Reply-To: <4FE34628.5060009@windriver.com>
References: <1339685898-24757-1-git-send-email-jason.wessel@windriver.com>
	<1339685898-24757-2-git-send-email-jason.wessel@windriver.com>
	<1340294106.1640.129.camel@ted> <4FE34628.5060009@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] process.py, build.py: Fix log truncation problems with flush()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Jun 2012 16:23:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-21 at 11:04 -0500, Jason Wessel wrote:
> On 06/21/2012 10:55 AM, Richard Purdie wrote:
> > On Thu, 2012-06-14 at 09:58 -0500, Jason Wessel wrote:
> >> There are two problems with the _logged_communicate that are both
> >> caused as a result of buffering I/O, instead of flushing it out to the
> >> log files as it arrives.
> >>
> >> 1) log truncation when python dumps
> >>    I have seen the task logs missing data that was not flushed when
> >>    bitbake crashes.
> >>
> >> 2) While a bitbake task is running it is impossible to see what is
> >>    going on if it is only writing a small incremental log that is
> >>    smaller than the buffer, or you get only a partial log, up until
> >>    the task exists.  It is worse in the case that stderr and stdout
> >>    are separate file handles, because previous code blocks on the read
> >>    of stdout and then stderr, serially.
> >>
> >> The right approach is simply to use select() to determine if there is
> >> data available and then to flush the log buffers as they arrive.  This
> >> still makes use of buffering in the cases where there is more than 1
> >> byte of data, but the buffers are much more dynamic.
> >>
> >> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> >> ---
> >>  lib/bb/build.py   |    3 ++-
> >>  lib/bb/process.py |   29 +++++++++++++++++++++++++++--
> >>  2 files changed, 29 insertions(+), 3 deletions(-)
> > For what its worth I'm seeing a small but consistent increase in real,
> > sys and user times with this patch which is why I'm pausing to look at
> > it a little further :(
> 
> 
> In my experience, it varied quite a bit.  If need be, we simply allow
> allow a config variable like BB_FORCE_LOG_FLUSH = "1", and get rid of
> the flushes by default.
> 
> At the distro level, I'll turn this on, but still allow users to
> override it, because timely logging of builds is critical, and loss of
> data due to a python crash is completely unacceptable, it just makes
> build failures even harder to diagnose.

Python has some better tools to handle things like this, such as
something like:

try:
    <normal case>
finally:
    x.flush()

so it would be interesting to see if that helps.

Cheers,

Richard



