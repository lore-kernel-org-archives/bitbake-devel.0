Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 337586041D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 07:30:02 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4V7YOeS031084; Fri, 31 May 2013 08:34:26 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m4DTwEyu5o5h; Fri, 31 May 2013 08:34:24 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4V7YH8u031080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 31 May 2013 08:34:19 +0100
Message-ID: <1369985383.14887.341.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, Peter Seebach
	<peter.seebach@windriver.com>, Jeff Polk <jeff.polk@windriver.com>
Date: Fri, 31 May 2013 08:29:43 +0100
In-Reply-To: <1369799698-1417-1-git-send-email-mark.hatle@windriver.com>
References: <1369799698-1417-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: Remove explicit build targets from the ignored list
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
X-List-Received-Date: Fri, 31 May 2013 07:30:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-05-28 at 22:54 -0500, Mark Hatle wrote:
> From: Peter Seebach <peter.seebach@windriver.com>
> 
> If something is in ASSUMED_PROVIDED, and a user tries to build it
> explicitly, Nothing Happens. Bitbake just says it ran 0 out of 0
> tasks. No diagnostics or explanations are offered.
> 
> In practice, the right thing is probably to assume that explicit
> targets are intentional. So far as I can tell, cooker.buildTargets
> is called only from the command line or from command.py, and both
> cases seem to be explicit user actions.
> 
> Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
> Signed-off-by: Jeff Polk <jeff.polk@windriver.com>
> 
> Rename 'status' to 'recipecache' to match recent changes.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/cooker.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 2ae3e9d..8f0e90c 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1067,6 +1067,11 @@ class BBCooker:
>          universe = ('universe' in targets)
>          targets = self.checkPackages(targets)
>  
> +        # Explicitly disignore things that have been requested.
> +        for target in targets:
> +            if target in self.recipecache.ignored_dependencies:
> +                self.recipecache.ignored_dependencies.remove(target)
> +
>          def buildTargetsIdle(server, rq, abort):
>              if abort or self.state == state.stop:
>                  rq.finish_runqueue(True)

I'm not sure this is the right thing to do, the reason being
determinism. I don't expect different results for X in the different
cases:

bitbake X Y

bitbake X

(assuming Y is ASSUME_PROVIDED)

For example, X will rebuild between these two commands since the sstate
and task checksums will be different between the two. This really needs
more thought to make a consistent user experience...

Cheers,

Richard


