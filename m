Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THcuZ-0002Os-C0 for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 17:55:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8SFgaYb012590;
	Fri, 28 Sep 2012 16:42:36 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10054-10; Fri, 28 Sep 2012 16:42:32 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8SFgRda012584
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Sep 2012 16:42:28 +0100
Message-ID: <1348846949.15753.53.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
Date: Fri, 28 Sep 2012 16:42:29 +0100
In-Reply-To: <1348844766-6549-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1348844766-6549-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] [hob] Fix bad merge of #2162
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
X-List-Received-Date: Fri, 28 Sep 2012 15:55:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-28 at 18:06 +0300, Bogdan Marinescu wrote:
> This patch fixes the bad merge of #2162 fixes on master.
> 
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py |   23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)

Merged to master, thanks.

Richard



