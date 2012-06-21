Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShgUl-0001fZ-Kn for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 14:28:19 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LCHX1R022123;
	Thu, 21 Jun 2012 13:17:33 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22083-01; Thu, 21 Jun 2012 13:17:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LCHQvo022117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 13:17:27 +0100
Message-ID: <1340281048.1640.97.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Thu, 21 Jun 2012 13:17:28 +0100
In-Reply-To: <8a6196c93278c9272e44420f190eff1cb2357e73.1340098628.git.kai.kang@windriver.com>
References: <cover.1340098628.git.kai.kang@windriver.com>
	<8a6196c93278c9272e44420f190eff1cb2357e73.1340098628.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] ui/depexp.py: use the new progressbar in Hob
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
X-List-Received-Date: Thu, 21 Jun 2012 12:28:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-06-19 at 17:39 +0800, Kang Kai wrote:
> [Yocto 2149]
> 
> Use the new progressbar in Hob, so that we can reduce the maintenance
> burden of the multiple GUIs.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/ui/depexp.py |   29 ++++++++++++++++++-----------
>  1 files changed, 18 insertions(+), 11 deletions(-)

Merged to master, thanks.

Richard



