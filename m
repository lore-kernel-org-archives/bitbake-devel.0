Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TG6pG-0000Bf-OP for bitbake-devel@lists.openembedded.org;
	Mon, 24 Sep 2012 13:27:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OBErNJ028137;
	Mon, 24 Sep 2012 12:14:53 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27712-06; Mon, 24 Sep 2012 12:14:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OBEhkZ028126
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2012 12:14:45 +0100
Message-ID: <1348485280.8662.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 24 Sep 2012 12:14:40 +0100
In-Reply-To: <1348406065-8828-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1348406065-8828-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] lib/bb/runqueue.py: fix exceptions with -k and failed targets
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
X-List-Received-Date: Mon, 24 Sep 2012 11:27:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-09-23 at 14:14 +0100, Paul Eggleton wrote:
> If a target dependency is marked as failed and yet we are continuing on
> because -k has been specified, don't try to access the dependency's data
> in taskData.build_targets since it will have been removed. This fixes
> "IndexError: list index out of range" errors in this situation.
> 
> Also, do not print the "unhandled exception" message when SystemExit is
> raised since we will have reported the actual error already in this
> case (e.g. when -k has been specified and some targets failed).
> 
> Fixes [YOCTO #3133].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Merged to master, thanks.

Richard



