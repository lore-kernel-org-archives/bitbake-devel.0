Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rqov6-0000hu-1U for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jan 2012 17:45:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0RGbB1f011249;
	Fri, 27 Jan 2012 16:37:11 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10168-07; Fri, 27 Jan 2012 16:37:02 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0RGaxYN011238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jan 2012 16:37:00 GMT
Message-ID: <1327682221.19643.490.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Adrien Bustany <adrien@bustany.org>
Date: Fri, 27 Jan 2012 16:37:01 +0000
In-Reply-To: <20120119164907.5BA773E8BA@mail.mymadcat.com>
References: <20120119164907.5BA773E8BA@mail.mymadcat.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/lib/bb/fetch2: Fix stderr handling when running commands
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
X-List-Received-Date: Fri, 27 Jan 2012 16:45:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-01-19 at 17:49 +0200, Adrien Bustany wrote:
> stderr would previously be appended to stdout, corrupting the result
> when something was outputed to stderr but exit code was still 0
> (non-fatal warning messages). This commit makes the code parse only
> stdout, but output stderr if an error happened.
> 
> Signed-off-by: Adrien Bustany <adrien.bustany@nokia.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |   35 ++++++++++++++++-------------------
>  1 files changed, 16 insertions(+), 19 deletions(-)

Just for reference, I tried to apply this but couldn't as it conflicts
with other changes in that area.

If you have time to rebase it, I'll likely apply it sooner, else I'll
need to find time to do that.

Cheers,

Richard



