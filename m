Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R5c3s-0001Mg-QY for bitbake-devel@lists.openembedded.org;
	Mon, 19 Sep 2011 13:30:56 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBVnSI013170; Mon, 19 Sep 2011 12:31:50 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AGoZfetn76bI; Mon, 19 Sep 2011 12:31:49 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBVcZj013163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Sep 2011 12:31:42 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 19 Sep 2011 12:25:25 +0100
In-Reply-To: <1316419121-30931-1-git-send-email-Martin.Jansa@gmail.com>
References: <20110919073802.GA19168@jama.jama.net>
	<1316419121-30931-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316431532.14488.1.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git: fix logger.debug
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
X-List-Received-Date: Mon, 19 Sep 2011 11:30:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-09-19 at 09:58 +0200, Martin Jansa wrote:
> * logging/logger typo was fixed in 38a598731b49c8a0ba0ede570adc33eb1e848235
>   but debug level is still missing
> 
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/fetch2/git.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



