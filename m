Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TG9up-00049y-2I for bitbake-devel@lists.openembedded.org;
	Mon, 24 Sep 2012 16:45:43 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OEWtJv029789;
	Mon, 24 Sep 2012 15:32:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28950-02; Mon, 24 Sep 2012 15:32:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OEWkCV029779
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2012 15:32:47 +0100
Message-ID: <1348497167.8662.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Mon, 24 Sep 2012 15:32:47 +0100
In-Reply-To: <1347921797-60524-1-git-send-email-jason.wessel@windriver.com>
References: <1347921797-60524-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake, runqueue: Add --no-setscene to skip all setscene tasks
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
X-List-Received-Date: Mon, 24 Sep 2012 14:45:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-09-17 at 17:43 -0500, Jason Wessel wrote:
> Mainly intended for the purpose of debugging or forcing builds
> from source, the --no-setscene will prevent any setscene
> tasks from running.
> 
> (LOCAL REV: NOT UPSTREAM)
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> ---
>  bin/bitbake        |    2 ++
>  lib/bb/runqueue.py |   13 +++++++------
>  2 files changed, 9 insertions(+), 6 deletions(-)

Merged to master, thanks.

Richard



