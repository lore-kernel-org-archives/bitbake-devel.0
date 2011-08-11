Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qrawj-0001Th-82 for bitbake-devel@lists.openembedded.org;
	Thu, 11 Aug 2011 21:29:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7BJP5te000921;
	Thu, 11 Aug 2011 20:25:05 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32461-07; Thu, 11 Aug 2011 20:25:01 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7BJP0m8000899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Aug 2011 20:25:00 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <4E40FDFD.3060809@windriver.com>
References: <4E40FDFD.3060809@windriver.com>
Date: Thu, 11 Aug 2011 20:24:22 +0100
Message-ID: <1313090662.14274.466.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: About bitbake-runtask
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
X-List-Received-Date: Thu, 11 Aug 2011 19:29:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-09 at 17:29 +0800, Robert Yang wrote:
> Hi Richard,
> 
> The bitbake-runtask doesn't work currently, it seems that we have decommissioned it:
> 
> commit 1f3e313fd5cc5ae8ea838bf8fcdedace3cb72584
> Author: Richard Purdie <rpurdie@linux.intel.com>
> Date:   Wed Dec 8 00:08:04 2010 +0000
> 
>      bitbake Revert bitbake exec() and go back to fork() for performace wins 
> (first draft)
> 
> But it is still in bitbake/bin/bitbake-runtask. There is a bug for tracking
> this, what shall we do for it? Remove the bitbake-runtask or fix it and make
> it work?
> 
> Bug 1229 - bitbake-runtask doesn't work in both 1.0.1 and 1.1

Since I know that script has user and a valid use case we need to:

a) Fix this to work after the fork() changes
b) Include it in bitbake upstream

b) never happened due to a).

Cheers,

Richard





