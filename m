Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TEg7h-0000Sr-Ho for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 14:44:53 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8KCW7gV011891;
	Thu, 20 Sep 2012 13:32:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01250-10; Thu, 20 Sep 2012 13:32:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8KCW0xD011884
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Sep 2012 13:32:01 +0100
Message-ID: <1348144319.25163.47.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Trevor Woerner <twoerner@gmail.com>
Date: Thu, 20 Sep 2012 13:31:59 +0100
In-Reply-To: <1348023634-5915-1-git-send-email-twoerner@gmail.com>
References: <1348023634-5915-1-git-send-email-twoerner@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH cooker] cooker: Clarify package/recipe wording
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
X-List-Received-Date: Thu, 20 Sep 2012 12:44:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-09-18 at 23:00 -0400, Trevor Woerner wrote:
> From: Trevor Woerner <twoerner@gmail.com>
> 
> When the '-s' option is run, change the heading above the list of recipes
> to say "Recipe Name" instead of "Package Name".
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  lib/bb/cooker.py |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good catch, we need to fix these up! Merged to master, thanks.

Richard



