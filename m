Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDYFw-0008Pr-Kd for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 11:36:28 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2U9RM9t011701;
	Fri, 30 Mar 2012 10:27:22 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11041-08; Fri, 30 Mar 2012 10:27:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2U9RCtj011695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Mar 2012 10:27:13 +0100
Message-ID: <1333099632.18082.49.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Wang, Shane" <shane.wang@intel.com>
Date: Fri, 30 Mar 2012 10:27:12 +0100
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AFEFBD@SHSMSX102.ccr.corp.intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
	<b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
	<1333051449.18082.10.camel@ted>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AFEFBD@SHSMSX102.ccr.corp.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 5/8] runqueue.py: check results[0] in keys of build_pids before being used to avoid exceptions
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
X-List-Received-Date: Fri, 30 Mar 2012 09:36:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-30 at 06:10 +0000, Wang, Shane wrote:
> Richard Purdie wrote on 2012-03-30:
> 
> > On Thu, 2012-03-29 at 20:54 +0800, Shane Wang wrote:
> >> 
> >> 
> >> ne.wang@intel.com>
> >>                                To:
> >> bitbake-devel@lists.openembedded.org
> >>                           Subject:
> >> [bitbake-devel] [PATCH 5/8]
> >> runqueue.py: check results[0] in
> >> keys of build_pids before being
> >> used to avoid exceptions
> >>                              Date:
> >> Thu, 29 Mar 2012 20:54:54 +0800
> >> (29/03/12 13:54:54)
> >> 
> >> 
> >> [Yocto #2186]
> >> 
> >> Signed-off-by: Shane Wang <shane.wang@intel.com>
> >> ---
> >>  bitbake/lib/bb/runqueue.py |   20 ++++++++++++--------
> >>  1 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > This kind of change sets off alarm bells. The big question is why are
> > you seeing exceptions? I suspect you're forking off processes within hob
> > which are then confusing the waitpid code. I'd have to ask why the UI is
> > forking processes when a build is running and why we're suddenly started
> > seeing this...
> The steps I did is to "Force stop" a build and click "build packages" to rebuild. Then I saw the exceptions.
> In the command mode, there is no issue because the process exits.

Ok, so what it sounds like is that waitpid() is not being called in the
"force stop" mode to collect the exit values of the processes. We should
fix the code to collect the exit values even in force stop mode.

Cheers,

Richard (resisting the urge to talk about reaping and zombies)



