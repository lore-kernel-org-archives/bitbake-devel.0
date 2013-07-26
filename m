Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C8F456B31D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 14:22:28 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 26 Jul 2013 07:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,751,1367996400"; d="scan'208";a="352212842"
Received: from unknown (HELO helios.localnet) ([10.252.122.182])
	by orsmga001.jf.intel.com with ESMTP; 26 Jul 2013 07:22:24 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Fri, 26 Jul 2013 15:22:22 +0100
Message-ID: <1972381.8tId4Nj9gB@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1374752549-29471-14-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1374752549-29471-14-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2 13/16] bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
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
X-List-Received-Date: Fri, 26 Jul 2013 14:22:28 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Thursday 25 July 2013 14:42:26 Cristiana Voicu wrote:
> Hob retrieves the list of recipes and packages using the IMAGE_INSTALL
> variable, so a custom image should be saved using this variable.
> Changed how the image is saved in a bb file
> 
> [YOCTO #4193]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/cooker.py |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index ad92dea..48be434 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1159,11 +1159,11 @@ class BBCooker:
>                  if topdir in base_image:
>                      base_image = require_line.split()[1]
>                  imagefile.write("require " + base_image + "\n")
> -            package_install = "PACKAGE_INSTALL_forcevariable = \""
> +            image_install = "IMAGE_INSTALL_append = \""
>              for package in package_queue:
> -                package_install += str(package) + " "
> -            package_install += "\"\n"
> -            imagefile.write(package_install)
> +                image_install += str(package) + " "
> +            image_install += "\"\n"
> +            imagefile.write(image_install)
> 
>              description_var = "DESCRIPTION = \"" + description + "\"\n"
>              imagefile.write(description_var)

If this is within the image recipe it should be using IMAGE_INSTALL = rather 
than appending to an existing value. At the moment it looks like you're using 
_append with no leading space which could interact poorly with any previous 
value set, and in any case I'm not entirely sure we need to support having a 
previous value in there within this context.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

