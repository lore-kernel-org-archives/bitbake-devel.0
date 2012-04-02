Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SEgjB-00037R-FZ for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 14:51:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q32CgBv3012360;
	Mon, 2 Apr 2012 13:42:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 07587-05; Mon,  2 Apr 2012 13:42:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q32Cg1sU012354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 13:42:03 +0100
Message-ID: <1333370521.647.33.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Date: Mon, 02 Apr 2012 13:42:01 +0100
In-Reply-To: <1333258512.4073.14.camel@dongxiao-osel>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
	<9135f6b93e4fe1665f3bdc56eba150d67582d8e1.1333108781.git.dongxiao.xu@intel.com>
	<4F75DADC.7070909@linux.intel.com>
	<1333153931.27459.5.camel@dongxiao-osel>
	<1333171790.4073.9.camel@dongxiao-osel>
	<1333209061.18082.245.camel@ted>
	<1333258512.4073.14.camel@dongxiao-osel>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/7] Hob: Make layers define in bblayers.conf as default
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
X-List-Received-Date: Mon, 02 Apr 2012 12:51:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-04-01 at 13:35 +0800, Xu, Dongxiao wrote:
> On Sat, 2012-03-31 at 16:51 +0100, Richard Purdie wrote:
> > I'd be happy if you change the above code to do:
> > 
> >         self.server.runCommand(["deleteVariable", "DISTRO"])
> > 
> > which is subtly different but consistent with what we really want. I
> > have no idea if we have a deleteVariable command but if we don't, we
> > should add one.
> 
> I ever tried this approach with the following patch, however it didn't
> work. The setting of DISTRO ?= "poky" will still take effect.
>
> It seems that delVar(DISTRO) is different from setting DISTRO="".

It is different but it is what setting up OE-Core without DISTRO set
does and that is known to work.

We need to understand why this isn't working as it should...

Cheers,

Richard


> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 73aaca0..a7b41ce 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -160,6 +160,13 @@ class CommandsSync:
>          value = params[1]
>          command.cooker.configuration.data.setVar(varname, value)
> 
> +    def delVariable(self, command, params):
> +        """
> +        Delete the variable in configuration.data
> +        """
> +        varname = params[0]
> +        command.cooker.configuration.data.delVar(varname)
> +
>      def initCooker(self, command, params):
>          """
>          Init the cooker to initial state with nothing parsed
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index 8909e01..d236a72 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -265,7 +265,9 @@ class HobHandler(gobject.GObject):
>          self.server.runCommand(["setVariable", "IMAGE_FSTYPES",
> image_fstypes])
> 
>      def set_distro(self, distro):
> -        if distro != "defaultsetup":
> +        if distro == "defaultsetup":
> +            self.server.runCommand(["delVariable", "DISTRO"])
> +        else:
>              self.server.runCommand(["setVariable", "DISTRO", distro])
> 
>      def set_package_format(self, format):




