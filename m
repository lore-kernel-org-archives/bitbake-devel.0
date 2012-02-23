Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0hSI-00064D-FA for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 23:48:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1NMdh2a030002;
	Thu, 23 Feb 2012 22:39:43 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26703-05; Thu, 23 Feb 2012 22:39:39 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1NMdYUF029996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Feb 2012 22:39:35 GMT
Message-ID: <1330036774.22167.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Thu, 23 Feb 2012 22:39:34 +0000
In-Reply-To: <cover.1330018579.git.paul.eggleton@linux.intel.com>
References: <cover.1330018579.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] A couple of fixes to error handling v2
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
X-List-Received-Date: Thu, 23 Feb 2012 22:48:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-23 at 17:38 +0000, Paul Eggleton wrote:
> A couple of patches to fix/improve error handling during parsing.
> 
> Since v1, remove changes to general exception handling that weren't
> necessary and bypassed the ability for the UI to format the exception.
> 
> The patches (against poky, but apply cleanly with -p2 against bitbake
> master) are available at:
>   git://git.yoctoproject.org/poky-contrib paule/bitbake-errors2
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-errors2
> 
> Paul Eggleton (2):
>   bitbake: fix parse errors not being reported
>   bitbake: add file and line number to ParseError

These look like they improve the current situation a lot, merged to
master, thanks.

Richard



