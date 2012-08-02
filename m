Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Swy6S-0004xF-Ov for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 18:18:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72G6cOP009436;
	Thu, 2 Aug 2012 17:06:38 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05174-08; Thu,  2 Aug 2012 17:06:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72G6VUk009430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2012 17:06:32 +0100
Message-ID: <1343923593.9756.86.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 02 Aug 2012 17:06:33 +0100
In-Reply-To: <1343777621-27958-1-git-send-email-Martin.Jansa@gmail.com>
References: <1343732491-12072-1-git-send-email-Martin.Jansa@gmail.com>
	<1343777621-27958-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCHv2] fetch2: print checksums when they are different then expected
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
X-List-Received-Date: Thu, 02 Aug 2012 16:18:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-08-01 at 01:33 +0200, Martin Jansa wrote:
> * in form which can be copied into a recipe without modification
> * like oe-classic did since:
>   http://git.openembedded.org/openembedded/commit/?id=68abc465559a68e9201c9525be3c4acc6297eaed
> * it shows them in right form when they are missing completely, but in
>   more verbose form when different
> * it needs to print that only when checksums were requested, e.g.
>   fetching from sstate mirror sets both md5mismatch and sha256mismatch,
>   but your checksums shouldn't be shown
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Merged to master, thanks.

Richard



