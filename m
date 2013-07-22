Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id CF71C6B1FB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Jul 2013 16:44:57 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 22 Jul 2013 09:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,720,1367996400"; d="scan'208";a="335096976"
Received: from unknown (HELO helios.localnet) ([10.252.122.69])
	by azsmga001.ch.intel.com with ESMTP; 22 Jul 2013 09:44:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Mon, 22 Jul 2013 17:44:52 +0100
Message-ID: <7051553.R5duHUB8NY@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1374057344-19708-2-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
	<1374057344-19708-2-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 01/14] hob: labelling changes in Hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 22 Jul 2013 16:44:58 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Wednesday 17 July 2013 13:35:31 Cristiana Voicu wrote:
> When the design document for templates in Hob was created, we've noticed
> that some labels need to change.
> 
> [YOCTO #4193]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    2 +-
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    2 +-
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   16 ++++++----------
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |    5 +++++
>  4 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py index 8788083..ebcb846 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -174,7 +174,7 @@ class HobHandler(gobject.GObject):
>                  targets.append(self.toolchain)
>              if targets[0] == "hob-image":
>                  hobImage = self.runCommand(["matchFile", "hob-image.bb"])
> -                if self.base_image != "Create your own image":
> +                if self.base_image != "Create a new base image":

I've been talking with Belen today, and it seems like we have a bit of a 
terminology problem here. What we're dealing with here are "image recipes" 
rather than "base images". (The "base" part was just in context for the 
initial selection when we're selecting what to base our custom image on and 
then modify its contents.). Could you work with Belen to get the appropriate 
minor changes for this solidified?

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

