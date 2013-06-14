Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B917360E12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 13:33:56 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5EDdbpt026747; Fri, 14 Jun 2013 14:39:37 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Lc8uNQkY-57D; Fri, 14 Jun 2013 14:39:37 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5EDdXRh026740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 14 Jun 2013 14:39:34 +0100
Message-ID: <1371216822.20823.83.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Damian <alex.r.damian@gmail.com>
Date: Fri, 14 Jun 2013 14:33:42 +0100
In-Reply-To: <51B9E3E1.8020905@gmail.com>
References: <1370619726-22780-1-git-send-email-alexandru.damian@intel.com>
	<1371042680.20823.24.camel@ted> <51B9E3E1.8020905@gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] knotty, xmlrpc: add observer-only mode
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
X-List-Received-Date: Fri, 14 Jun 2013 13:33:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-06-13 at 16:23 +0100, Alex Damian wrote:
> On 06/12/2013 02:11 PM, Richard Purdie wrote:
> > On Fri, 2013-06-07 at 16:42 +0100, Alex DAMIAN wrote:
> >> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >>
> >> I add an observer only mode for the knotty UI and
> >> the XMLRPC server that will allow the UI to register
> >> a callback with a server in order to receive events.
> >>
> >> The observer-UI will not send any commands to the
> >> server apart from registering as an event handler.
> >>
> >> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> >> ---
> >>   bin/bitbake             |  8 +++++++-
> >>   lib/bb/server/xmlrpc.py | 18 ++++++++++++------
> >>   lib/bb/ui/knotty.py     | 29 +++++++++++++++++------------
> >>   lib/bb/ui/uievent.py    |  1 +
> >>   4 files changed, 37 insertions(+), 19 deletions(-)
> >>

You responded to one of my comments but not the other.

To put my concern succinctly, I think even in observer mode the UIs
should still be able to query variables. I do not think they should be
writing to things though, or running any of the async commands. The
whole token business isn't working quite right yet.

My worry is the architecture you're building here isn't quite right, its
limiting the clients unnecessarily and complicating the handover between
clients. I appreciate this patch in itself isn't too problematic,
however if I merge it, you will continue down this path and we will end
up adding code that is problematic. I therefore don't think I can take
this patch until we better figure out what we need to do with the token
handling, I do know we can do better than what is here.

Cheers,

Richard




