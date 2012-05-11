Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SSlxV-000166-Hp for bitbake-devel@lists.openembedded.org;
	Fri, 11 May 2012 11:16:27 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4B96QFk002757;
	Fri, 11 May 2012 10:06:26 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18550-04; Fri, 11 May 2012 10:06:22 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4B96Gol002750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2012 10:06:17 +0100
Message-ID: <1336727175.2494.183.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Date: Fri, 11 May 2012 10:06:15 +0100
In-Reply-To: <1336606548-2482-1-git-send-email-kergoth@gmail.com>
References: <1336606548-2482-1-git-send-email-kergoth@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Christopher Larson <chris_larson@mentor.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] runqueue: drop unnecessary keys() in runqueue_process_waitpid
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
X-List-Received-Date: Fri, 11 May 2012 09:16:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-09 at 18:35 -0500, Christopher Larson wrote:
> From: Christopher Larson <chris_larson@mentor.com>
> 
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/runqueue.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Merged to master along with the previous patch, thanks.

Richard



