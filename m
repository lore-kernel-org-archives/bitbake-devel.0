Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4B39378298
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 May 2017 13:30:47 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 May 2017 06:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,397,1491289200"; d="scan'208";a="266732798"
Received: from lsandov1-mobl2.zpn.intel.com ([10.219.128.119])
	by fmsmga004.fm.intel.com with ESMTP; 26 May 2017 06:30:47 -0700
Message-ID: <1495805955.26945.13.camel@linux.intel.com>
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
To: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
Date: Fri, 26 May 2017 08:39:15 -0500
In-Reply-To: <1495765159-172739-1-git-send-email-rebecca.swee.fun.chang@intel.com>
References: <1495765159-172739-1-git-send-email-rebecca.swee.fun.chang@intel.com>
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: Phoong Stanley Cheong Kwan <stanley.cheong.kwan.phoong@intel.com>,
	Bitbake dev Mailing List <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake-layers: check layer dependencies before adding
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
X-List-Received-Date: Fri, 26 May 2017 13:30:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-05-26 at 10:19 +0800, Chang Rebecca Swee Fun wrote:

> +                    self.tinfoil.parseRecipes()
> +                except bb.tinfoil.TinfoilUIException:
> +                    # Restore the back up copy of bblayers.conf
> +                    shutil.copy2(backup, bblayers_conf)
> +                    bb.fatal("Parse failure with the specified layer added")

AFAIK, bb.fatal raises an exception, so the return 1 is not needed.

> +                    return 1
> +            else:
> +                for item in notadded:
> +                    sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
> +        finally:
> +            # Remove the back up copy of bblayers.conf
> +            shutil.rmtree(tempdir)
>  
>      def do_remove_layer(self, args):
>          """Remove a layer from bblayers.conf."""
> -- 
> 2.7.4
> 



