Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TEeYU-0007SM-A3 for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 13:04:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8KApgrv011282;
	Thu, 20 Sep 2012 11:51:42 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01232-08; Thu, 20 Sep 2012 11:51:38 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8KAn7w1011256
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Sep 2012 11:50:48 +0100
Message-ID: <1348138143.25163.38.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Thu, 20 Sep 2012 11:49:03 +0100
In-Reply-To: <1348050342-5402-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1348050342-5402-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: report event handler failures
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
X-List-Received-Date: Thu, 20 Sep 2012 11:04:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-19 at 11:25 +0100, Paul Eggleton wrote:
> If an event handler failed we were not recieving an error message -
> parsing just "froze" at 99%. This is because we were expecting a
> CommandFailure event and this never happened in the case of
> RequestPackageInfo which is where the failure was occurring.
> 
> This also required tweaking the error formatting slightly, taking the
> return value of the format function rather than the message property
> since the latter only seems to contain the first line without the
> traceback in the case of event handler failure. Other error cases were
> tested and their message formatting is unaffected by this change.
> 
> Final part of the fix for [YOCTO #2651].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Merged to master, thanks.

Richard



