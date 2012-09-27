Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGTi-00014D-5d for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:58:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFjKL1000462;
	Thu, 27 Sep 2012 16:45:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00384-02; Thu, 27 Sep 2012 16:45:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFj75q000408
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:45:08 +0100
Message-ID: <1348760709.11186.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
Date: Thu, 27 Sep 2012 16:45:09 +0100
In-Reply-To: <1348755225-454-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1348755225-454-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] [hob] Multiple user interface fixes in settings
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
X-List-Received-Date: Thu, 27 Sep 2012 15:58:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-09-27 at 17:13 +0300, Bogdan Marinescu wrote:
> 1. Move the "Others" tab from advanced settings to simple settings
> 2. Organize content of tabs into headings
> 3. Match various labels in the settings with the design
> 4. Clean up config_md5 in both simple and advanced settings
> 
> This patch implements a part of the changes requested by Belen in the settings dialogs.
> The second version of the patch addresses all the UI changes requested by Belen (more
> details are in the bug description): alphabetical ordering of the image types and
> warnings if no image type is selected.
> 
> [YOCTO #2162]
> 
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py |    1 +
>  bitbake/lib/bb/ui/crumbs/hig.py     |  292 ++++++++++++++++++-----------------
>  2 files changed, 152 insertions(+), 141 deletions(-)

Could you rebase this against master and resend please? I couldn't get
it to apply with all the other changes that were made to hig.py.

Cheers,

Richard



