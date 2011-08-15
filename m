Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QssMG-0006qr-Mj for bitbake-devel@lists.openembedded.org;
	Mon, 15 Aug 2011 10:17:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8Ccu6015014;
	Mon, 15 Aug 2011 09:12:38 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14300-04; Mon, 15 Aug 2011 09:12:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8CRUj014994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Aug 2011 09:12:29 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Denys Dmytriyenko <denis@denix.org>
In-Reply-To: <1313179034-23154-1-git-send-email-denis@denix.org>
References: <1313179034-23154-1-git-send-email-denis@denix.org>
Date: Mon, 15 Aug 2011 09:12:24 +0100
Message-ID: <1313395944.14274.541.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Denys Dmytriyenko <denys@ti.com>
Subject: Re: [PATCH] lib/bb/providers: make "checking PREFERRED_PROVIDER_%s" a debug message
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
X-List-Received-Date: Mon, 15 Aug 2011 08:17:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 15:57 -0400, Denys Dmytriyenko wrote:
> From: Denys Dmytriyenko <denys@ti.com>
> 
> In verbose mode there are hundreds of these "checking PREFERRED_PROVIDER_%s"
> messages, cluttering the output and obscuring the more important resulting
> "selecting %s to satisfy runtime %s due to %s" messages. Individual "checking"
> lines are more suited for debug mode, similar to "sorted providers for %s
> are: %s", hence convert logger.verbose() to logger.debug().
> 
> Signed-off-by: Denys Dmytriyenko <denys@ti.com>
> ---
>  lib/bb/providers.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-) 

Merged to master, thanks.

Richard



