Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SD0Yr-00057p-CH for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 23:37:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2SLSfAl024253;
	Wed, 28 Mar 2012 22:28:41 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24067-04; Wed, 28 Mar 2012 22:28:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2SLSVYY024247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Mar 2012 22:28:32 +0100
Message-ID: <1332970110.28414.209.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Date: Wed, 28 Mar 2012 22:28:30 +0100
In-Reply-To: <1332875243-16798-1-git-send-email-kergoth@gmail.com>
References: <1332875243-16798-1-git-send-email-kergoth@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Christopher Larson <chris_larson@mentor.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb.build: use relative log links, not absolute
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
X-List-Received-Date: Wed, 28 Mar 2012 21:37:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-03-27 at 14:07 -0500, Christopher Larson wrote:
> From: Christopher Larson <chris_larson@mentor.com>
> 
> Using symlinks to absolute paths isn't gaining us anything, and can cause
> problems in situations such as automated build systems when they try to
> resolve the link, depending on the mechanism used to pull the build artifacts
> (e.g. nfs).
> 
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/build.py |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Merged to master, thanks. That has been annoying me too...

Cheers,

Richard



