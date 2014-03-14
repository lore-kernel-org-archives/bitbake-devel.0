Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1C9B66EFA9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 14:19:13 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2014 07:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,655,1389772800"; d="scan'208";a="499901092"
Received: from ssaevars-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.62])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2014 07:19:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 14:19:10 +0000
Message-ID: <1506140.b6PKZPtaPd@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.3 (Linux/3.13.6-200.fc20.x86_64; KDE/4.12.3; x86_64; ; )
In-Reply-To: <1394625829-11427-1-git-send-email-marius.avram@intel.com>
References: <1394625829-11427-1-git-send-email-marius.avram@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: cooker: some IMAGE_FEATURES not recognized
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 14 Mar 2014 14:19:16 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 March 2014 14:03:49 Marius Avram wrote:
> Fixes an issue in hob which happened when the local.conf file was
> modified externally by appending "eclipse-debug" to the IMAGE_FEATURES
> variable. The reason of the problem is that some IMAGE_FEATURES are
> not available in the image.bbclass file and they are declared in the
> core-image.bbclass. Now a default hob image will inherit core-image.
> 
> [YOCTO #5711]
> 
> Signed-off-by: Marius Avram <marius.avram@intel.com>
> ---
>  bitbake/lib/bb/cooker.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 96f05b5..4de6a51 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1220,7 +1220,7 @@ class BBCooker:
> 
>          with open(dest, "w") as imagefile:
>              if base_image is None:
> -                imagefile.write("inherit image\n")
> +                imagefile.write("inherit core-image\n")
>              else:
>                  topdir = self.data.getVar("TOPDIR")
>                  if topdir in base_image:

Acked-by: Paul Eggleton <paul.eggleton@linux.intel.com>

-- 

Paul Eggleton
Intel Open Source Technology Centre

