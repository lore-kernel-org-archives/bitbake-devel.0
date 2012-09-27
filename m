Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGRs-0000py-JY for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:56:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFhTcF000334;
	Thu, 27 Sep 2012 16:43:29 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32587-04; Thu, 27 Sep 2012 16:43:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFhL7k000328
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:43:22 +0100
Message-ID: <1348760602.11186.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Thu, 27 Sep 2012 16:43:22 +0100
In-Reply-To: <1348656248-5807-1-git-send-email-cristiana.voicu@intel.com>
References: <1348656248-5807-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] hob/settings: implement a new tab in settings dialog to show SSTATE_MIRRORS
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
X-List-Received-Date: Thu, 27 Sep 2012 15:56:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-26 at 13:44 +0300, Cristiana Voicu wrote:
> Add a new tab to show correctly SSTATE_MIRRORS variable. Now you can add new
> mirrors or delete mirror. "info" image was also changed( it is smaller, so it
> can be next to labels).
> From "Build environment" tab, SSTATE_DIR and SSTATE_MIRRORS vars were removed.
> 
> [YOCTO #2893]
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py           |    8 +-
>  bitbake/lib/bb/ui/crumbs/hig.py               |  180 +++++++++++++++++++++++--
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py   |    6 +-
>  bitbake/lib/bb/ui/crumbs/template.py          |    2 +-
>  bitbake/lib/bb/ui/icons/info/info_display.png |  Bin 4558 -> 4117 bytes
>  bitbake/lib/bb/ui/icons/info/info_hover.png   |  Bin 4650 -> 4167 bytes
>  6 files changed, 175 insertions(+), 21 deletions(-)

Merged to master, thanks.

Richard



