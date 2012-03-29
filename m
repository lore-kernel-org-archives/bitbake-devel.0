Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDLim-0008N7-8b for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 22:13:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TK4Iqk004417;
	Thu, 29 Mar 2012 21:04:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03712-06; Thu, 29 Mar 2012 21:04:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TK49si004411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 21:04:11 +0100
Message-ID: <1333051449.18082.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 29 Mar 2012 21:04:09 +0100
In-Reply-To: <b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
	<b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 29 Mar 2012 20:13:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-29 at 20:54 +0800, Shane Wang wrote:
> 
> 
> ne.wang@intel.com>
>                                To: 
> bitbake-devel@lists.openembedded.org
>                           Subject: 
> [bitbake-devel] [PATCH 5/8]
> runqueue.py: check results[0] in
> keys of build_pids before being
> used to avoid exceptions
>                              Date: 
> Thu, 29 Mar 2012 20:54:54 +0800
> (29/03/12 13:54:54)
> 
> 
> [Yocto #2186]
> 
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> ---
>  bitbake/lib/bb/runqueue.py |   20 ++++++++++++--------
>  1 files changed, 12 insertions(+), 8 deletions(-)

This kind of change sets off alarm bells. The big question is why are
you seeing exceptions? I suspect you're forking off processes within hob
which are then confusing the waitpid code. I'd have to ask why the UI is
forking processes when a build is running and why we're suddenly started
seeing this...

So can you please explain the problem further so we can fix the real
problem? I did look at #2186 but that doesn't help me either :(

Cheers,

Richard



