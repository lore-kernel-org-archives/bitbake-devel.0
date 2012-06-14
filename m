Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sf9ui-0007oA-7t for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 15:16:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5ED63Ag001255;
	Thu, 14 Jun 2012 14:06:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00731-06; Thu, 14 Jun 2012 14:05:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5ED5uRd001249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 14:05:57 +0100
Message-ID: <1339679156.24333.78.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Thu, 14 Jun 2012 14:05:56 +0100
In-Reply-To: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] fetch2: fixes and optimizations
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
X-List-Received-Date: Thu, 14 Jun 2012 13:16:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-06-13 at 22:09 -0500, Jason Wessel wrote:
> * The fetcher logging is broken in a way where it doesnt return errors.

I merged this.

> * There is a regression in the URI handling

I've merged an alternative patch for this that was being discussed which
fixes another part of the problem.

> * Local git mirrors do not work correctly as PRE-MIRRORS

This isn't the correct fix for this problem IMO, this needs needs a bit
more work. I'll try and take a look at this problem.

> * The fall back fetch can be optimized to use clone -s
>   if it is a local file url with a PRE-MIRROR

I've replied to this.

Cheers,

Richard




