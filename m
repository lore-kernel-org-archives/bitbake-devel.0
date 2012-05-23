Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXFJy-0002es-RH for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 19:26:03 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NHFr1g014881;
	Wed, 23 May 2012 18:15:53 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13374-08; Wed, 23 May 2012 18:15:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NHFiC0014875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 18:15:45 +0100
Message-ID: <1337793343.8248.83.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Wed, 23 May 2012 18:15:43 +0100
In-Reply-To: <1337787916-591-1-git-send-email-mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
	<1337787916-591-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/4] build.py: Add a log to capture task execution order
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
X-List-Received-Date: Wed, 23 May 2012 17:26:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-23 at 10:45 -0500, Mark Hatle wrote:
> The new log.task_order contains an ordered list of the tasks as they
> were executed in any given recipe.  The format of the lines is
> <task> <pid>: <log file>
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/build.py |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



