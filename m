Received: from [93.97.173.237] (helo=tim.rpsys.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QpNdJ-00069q-W3 for bitbake-devel@lists.openembedded.org;
	Fri, 05 Aug 2011 18:52:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p75GlxkE014580;
	Fri, 5 Aug 2011 17:47:59 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14496-01; Fri,  5 Aug 2011 17:47:55 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p75GlrVK014574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Aug 2011 17:47:54 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1312497858.git.josh@linux.intel.com>
References: <cover.1312497858.git.josh@linux.intel.com>
Date: Fri, 05 Aug 2011 17:47:30 +0100
Message-ID: <1312562850.14274.143.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] More hob bug fixes
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
X-List-Received-Date: Fri, 05 Aug 2011 16:52:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-08-04 at 15:45 -0700, Joshua Lock wrote:
> The first patch is a glaring omission in my code, apologies for that. The
> second, aiui, should fix cache invalidation to work as expected.
> 
> Please review.
> 
> Thanks,
> Joshua
> 
> The following changes since commit 5f079f11ca626a4a11ad728c56bde21009ddd7c8:
> 
>   bb/ui/hob: be clear that the image contents are an estimate (2011-08-03 18:19:54 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (2):
>   bb/ui/hob: reset event handler once build complete
>   bb/cooker: mark parsed conf files as potential cache invalidators

Merged to master, thanks.

Richard



