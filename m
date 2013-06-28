Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 128046023E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2013 17:04:55 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5SHBsuG010950; Fri, 28 Jun 2013 18:11:54 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id t7_2dtwNVic9; Fri, 28 Jun 2013 18:11:54 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5SHBkbb010944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 28 Jun 2013 18:11:48 +0100
Message-ID: <1372439079.9930.276.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Fri, 28 Jun 2013 18:04:39 +0100
In-Reply-To: <51CDC119.1080306@windriver.com>
References: <1372431907-10142-1-git-send-email-joe.macdonald@windriver.com>
	<1372431907-10142-2-git-send-email-joe.macdonald@windriver.com>
	<1372438595.9930.274.camel@ted> <51CDC119.1080306@windriver.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake][oe-core][RFC PATCH 1/2] fetch2: Add an extra check for sstate_mirrors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 28 Jun 2013 17:04:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-06-28 at 12:00 -0500, Mark Hatle wrote:
> On 6/28/13 11:56 AM, Richard Purdie wrote:
> > On Fri, 2013-06-28 at 11:05 -0400, Joe MacDonald wrote:
> >> BB_NO_NETWORK disables any fetching, however if we're using an external
> >> sstate cache, we may want to be able to fetch those objects even if we are
> >> not fetching the upstream sources.
> >>
> >> Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
> >> ---
> >>   bitbake/lib/bb/fetch2/__init__.py |   18 +++++++++++++-----
> >>   1 file changed, 13 insertions(+), 5 deletions(-)
> >
> >
> > Bitbake's fetch module knows nothing about sstate right now and I don't
> > see any reason to teach it about it. Why can't you just change
> > BB_NO_NETWORK in sstate.bbclass before we call into the fetcher?
> 
> We considered that, but won't that then change the value potentially for other 
> things that could be running in parallel?  Or is the namespace protection good 
> enough for that?
> 
> I.e. in sstate.bbclass do a d.setVar ... call the fetch .. d.setVar (restore)?

If you look carefully you'll see sstate.bbclass does a
bb.data.createCopy() of the datastore and only changes that before
calling into the fetcher module. The change is only local to that copy
and the copy only lives as long as its referenced so it should all be
fine.

Cheers,

Richard




