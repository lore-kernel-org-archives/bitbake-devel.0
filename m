Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SmQ2I-0002IZ-4x for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jul 2012 15:54:30 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64DhOvU023816;
	Wed, 4 Jul 2012 14:43:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23521-02; Wed,  4 Jul 2012 14:43:20 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64DhHYm023809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 14:43:18 +0100
Message-ID: <1341409397.3906.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Wed, 04 Jul 2012 14:43:17 +0100
In-Reply-To: <1341084896-29686-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1341084896-29686-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] git: do not execute 'git remote prune'
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
X-List-Received-Date: Wed, 04 Jul 2012 13:54:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-06-30 at 21:34 +0200, Enrico Scholz wrote:
> 'git remote prune' at this location does not make much sense because
> the following 'git remote rm' will prune stale and non-stale branches.
> 
> The 'prune' can cause trouble because it will access the network
> bypassing the no-network code in bitbake. When this operation fails and
> throws an exception, the next command (--> 'git remote rm') will be
> skipped.  This in turn, will make all the following operations fail,
> because they assume that the remote does not exist yet.
> 
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  lib/bb/fetch2/git.py |    1 -
>  1 file changed, 1 deletion(-)

Merged to master, thanks.

Richard



