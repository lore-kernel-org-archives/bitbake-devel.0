Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGS8-0000rJ-PY for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:56:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFhkZx000344;
	Thu, 27 Sep 2012 16:43:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32240-08; Thu, 27 Sep 2012 16:43:40 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFhco9000338
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:43:39 +0100
Message-ID: <1348760619.11186.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ioana Grigoropol <ioanax.grigoropol@intel.com>
Date: Thu, 27 Sep 2012 16:43:39 +0100
In-Reply-To: <1348661622-32098-1-git-send-email-ioanax.grigoropol@intel.com>
References: <1348661622-32098-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] hob: Buttons width and height are taken for host
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
X-List-Received-Date: Thu, 27 Sep 2012 15:56:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-26 at 15:13 +0300, Ioana Grigoropol wrote:
> - removed all set_size_request calls for buttons in order to:
> 	- force autosizing of buttons with regard to the text length
> 	- use host theme default height for buttons
> - modified buttons on image details page to have the same height (default host one) and the width of the button with the largest text
> - modified Stop button on build details page to have the default height by directly attaching it to the containing table instead of hbox
> 
> Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   10 +-
>  bitbake/lib/bb/ui/crumbs/hig.py                    |    2 +-
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   15 +--
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  101 ++++++++++++++++----
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    2 +-
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
>  6 files changed, 101 insertions(+), 31 deletions(-)

Merged to master, thanks.

Richard



