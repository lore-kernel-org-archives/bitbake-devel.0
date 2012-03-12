Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6v1Q-0003xj-Dn for bitbake-devel@lists.openembedded.org;
	Mon, 12 Mar 2012 03:30:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2C2LLEP009756;
	Mon, 12 Mar 2012 02:21:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09683-03; Mon, 12 Mar 2012 02:21:15 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2C2LDiv009750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 02:21:14 GMT
Message-ID: <1331518873.15192.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 12 Mar 2012 02:21:13 +0000
In-Reply-To: <799f88e78f46b5a7eab5932060b4c2bf27ee1a95.1331012089.git.liezhi.yang@windriver.com>
References: <cover.1331012089.git.liezhi.yang@windriver.com>
	<799f88e78f46b5a7eab5932060b4c2bf27ee1a95.1331012089.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] siggen.py: Use basehash if no taskhash
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
X-List-Received-Date: Mon, 12 Mar 2012 02:30:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-03-06 at 14:04 +0800, Robert Yang wrote:
> The bitbake-runtask doesn't work since there is no taskhash (it worked
> in the past, but seems recent changes made it doesn't work again), use
> the basehash when there is no taskhash, just like what dump_sigtask
> does.
> 
> [YOCTO #1229]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/siggen.py |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



