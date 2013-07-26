Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id CC2376B31D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 14:22:05 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 26 Jul 2013 07:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,751,1367996400"; d="scan'208";a="337354025"
Received: from unknown (HELO helios.localnet) ([10.252.122.182])
	by azsmga001.ch.intel.com with ESMTP; 26 Jul 2013 07:21:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Fri, 26 Jul 2013 15:21:53 +0100
Message-ID: <49104416.fdFscICMXV@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1374752549-29471-7-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1374752549-29471-7-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2 06/16] hob & bitbake: append a value to a variable from hob throught bitbake
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
X-List-Received-Date: Fri, 26 Jul 2013 14:22:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Thursday 25 July 2013 14:42:19 Cristiana Voicu wrote:
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -440,6 +440,7 @@ class Builder(gtk.Window):
>          self.handler.connect("recipe-populated",        
> self.handler_recipe_populated_cb) self.handler.connect("package-populated",
>        self.handler_package_populated_cb)
> 
> +        self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/*bb")

Shoudn't this be /*.bb ?


>          self.initiate_new_build_async()
> 
>          signal.signal(signal.SIGINT, self.event_handle_SIGINT)
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py index 42fd0b9..e13ebe7 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -471,9 +471,22 @@ class HobHandler(gobject.GObject):
> 
>      def set_var_in_file(self, var, val, default_file=None):
>          self.runCommand(["enableDataTracking"])
> -        self.server.runCommand(["setVarFile", var, val, default_file])
> +        self.server.runCommand(["setVarFile", var, val, default_file,
> "set"]) self.runCommand(["disableDataTracking"])
> 
> +    def append_var_in_file(self, var, val, default_file=None):
> +        self.server.runCommand(["setVarFile", var, val, default_file,
> "append"]) +
> +    def append_to_bbfiles(self, val):
> +        bbfiles = self.runCommand(["getVariable", "BBFILES"]) or ""
> +        bbfiles = bbfiles.split()
> +        # replace TOPDIR in val, if necessary
> +        if "${TOPDIR}" in val:
> +            topdir = self.get_topdir()
> +            val = val.replace("${TOPDIR}", topdir)
> +        if val not in bbfiles:
> +            self.append_var_in_file("BBFILES",
> "${TOPDIR}/recipes/images/*bb", "local.conf") +

1) We should not be expanding ${TOPDIR} using direct string replacement. Do we 
even need to do this?

2) In any case it appears to be using a hardcoded value instead of val when it 
calls append_var_in_file()

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

