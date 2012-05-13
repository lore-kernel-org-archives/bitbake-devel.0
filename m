Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1STeDb-000780-6i for bitbake-devel@lists.openembedded.org;
	Sun, 13 May 2012 21:12:35 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DJ2aGV019816;
	Sun, 13 May 2012 20:02:36 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12124-06; Sun, 13 May 2012 20:02:32 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DInTSl019704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 May 2012 20:02:28 +0100
Message-ID: <1336935747.2711.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 13 May 2012 20:02:27 +0100
In-Reply-To: <1336805867-25625-1-git-send-email-Martin.Jansa@gmail.com>
References: <1336805867-25625-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] setup.py: fix path for bitbake-selftest
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
X-List-Received-Date: Sun, 13 May 2012 19:12:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-05-12 at 08:57 +0200, Martin Jansa wrote:
> * currently fails with:
>   running build_scripts
>   creating build/scripts-2.7
>   copying and adjusting bin/bitbake -> build/scripts-2.7
>   copying and adjusting bin/bitbake-layers -> build/scripts-2.7
>   copying and adjusting bin/bitbake-diffsigs -> build/scripts-2.7
>   copying and adjusting bin/bitbake-prserv -> build/scripts-2.7
>   error: file '/tmp/tmpfs/portage/dev-embedded/bitbake-9999/work/bitbake-9999/bitbake-selftest' does not exist
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  setup.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



