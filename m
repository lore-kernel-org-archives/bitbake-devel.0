Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGSo-0000wn-E0 for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:57:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFiOQu000372;
	Thu, 27 Sep 2012 16:44:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32587-06; Thu, 27 Sep 2012 16:44:20 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFiFHd000365
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:44:16 +0100
Message-ID: <1348760656.11186.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Constantin Musca <constantinx.musca@intel.com>
Date: Thu, 27 Sep 2012 16:44:16 +0100
In-Reply-To: <1348742952-9110-1-git-send-email-constantinx.musca@intel.com>
References: <1348742952-9110-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/runningbuild: Add missing logging level argument
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
X-List-Received-Date: Thu, 27 Sep 2012 15:57:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-09-27 at 13:49 +0300, Constantin Musca wrote:
> [YOCTO #3170]
> 
> Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/runningbuild.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Merged to master, thanks.

Richard



