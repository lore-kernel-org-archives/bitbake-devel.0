Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TR7Uc-00014a-5y for bitbake-devel@lists.openembedded.org;
	Wed, 24 Oct 2012 22:23:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKASC3007331;
	Wed, 24 Oct 2012 21:10:28 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06391-06; Wed, 24 Oct 2012 21:10:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKAIuR007325
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2012 21:10:19 +0100
Message-ID: <1351109418.22340.125.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Wed, 24 Oct 2012 21:10:18 +0100
In-Reply-To: <1350044986-21937-1-git-send-email-cristiana.voicu@intel.com>
References: <1350044986-21937-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: change behavior for "cancel" button from the Recipe selection page
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
X-List-Received-Date: Wed, 24 Oct 2012 20:23:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-10-12 at 15:29 +0300, Cristiana Voicu wrote:
> -when returned to the Image configuration page, after canceling on the
> Recipe selection page, the image selected previously is now shown corectly
> 
> [YOCTO #3205}
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py                |    1 +
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    1 +
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    3 +++
>  3 files changed, 5 insertions(+)

Merged to master, thanks.

Richard



