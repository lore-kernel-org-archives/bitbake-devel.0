Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TJ4d4-00054z-LR for bitbake-devel@lists.openembedded.org;
	Tue, 02 Oct 2012 17:43:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q92FUOH0018087;
	Tue, 2 Oct 2012 16:30:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15841-08; Tue,  2 Oct 2012 16:30:19 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q92FUEWL018081
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2012 16:30:15 +0100
Message-ID: <1349191817.18301.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Tue, 02 Oct 2012 16:30:17 +0100
In-Reply-To: <1349186751-22197-1-git-send-email-cristiana.voicu@intel.com>
References: <1349186751-22197-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/settings: alignment and spacing fixes on "Shared state" tab
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
X-List-Received-Date: Tue, 02 Oct 2012 15:43:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-10-02 at 17:05 +0300, Cristiana Voicu wrote:
> -alignment and separation on vertical and horizontal axis
> -change controls width
> [YOCTO #3188]
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py |   72 +++++++++++++++++++++++----------------
>  1 file changed, 43 insertions(+), 29 deletions(-)

This doesn't apply against master, can you please resend?

Cheers,

Richard



