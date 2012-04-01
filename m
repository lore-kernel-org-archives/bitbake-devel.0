Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEDcj-0005zx-Uo
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 07:46:46 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 31 Mar 2012 22:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="136147439"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2012 22:37:37 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1333209061.18082.245.camel@ted>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
	<9135f6b93e4fe1665f3bdc56eba150d67582d8e1.1333108781.git.dongxiao.xu@intel.com>
	<4F75DADC.7070909@linux.intel.com>
	<1333153931.27459.5.camel@dongxiao-osel>
	<1333171790.4073.9.camel@dongxiao-osel>
	<1333209061.18082.245.camel@ted>
Date: Sun, 01 Apr 2012 13:35:12 +0800
Message-ID: <1333258512.4073.14.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
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
X-List-Received-Date: Sun, 01 Apr 2012 05:46:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-03-31 at 16:51 +0100, Richard Purdie wrote:
> On Sat, 2012-03-31 at 13:29 +0800, Xu, Dongxiao wrote:
> > On Sat, 2012-03-31 at 08:32 +0800, Xu, Dongxiao wrote:
> > > On Fri, 2012-03-30 at 09:10 -0700, Joshua Lock wrote:
> > > > 
> > > > On 30/03/12 05:01, Dongxiao Xu wrote:
> > > > > For layers defined in bblayers.conf, we treat them as default layers
> > > > > and users are not allowed to remove them.
> > > > 
> > > > Can you explain the rationale behind this change? I see what you're 
> > > > doing but it's not entirely clear why.
> > > > 
> > > > I think this is a bad idea. Early on in the design of Hob we decided we 
> > > > didn't want configuration made for non-Hob builds to affect builds made 
> > > > with Hob, and vice versa.
> > > 
> > > The issue I am going to solve is that, with current local.conf
> > > (DISTRO="poky") and bblayers.conf (bblayers="meta meta-yocto"), we are
> > > not able to delete the meta-yocto layer in Hob since it will meet
> > > local.conf parsing error since it could not find where "poky" is
> > > defined.
> > > 
> > > This patch is to set those layers define in bblayers.conf as default
> > > layers and they could not be removed. For example, in Yocto Project,
> > > "meta", "meta-yocto", and "meta-hob" are not removable. For pure OE-Core
> > > environment, "meta" and "meta-hob" are not removable.
> > > 
> > 
> > Just discussed with Josh on this problem.
> > 
> > He suggested that meta-yocto should be still removable. If user met the
> > error after deleting the meta-yocto layer, he/she should change the
> > DISTRO setting in "Setting" dialog to "defaultsetup".
> > 
> > Current code to handle the distro setting is:
> > 
> >     def set_distro(self, distro):  
> >         if distro != "defaultsetup":   
> >             self.server.runCommand(["setVariable", "DISTRO", distro])
> > 
> > Therefore even if user has selected defaultsetup, it will not set any
> > value to bitbake server, and then DISTRO ?= "poky" will take effect
> > while parsing local.conf.
> > 
> > To make DISTRO ?= "poky" doesn't take effect, we need to change the code
> > to be:
> > 
> >     def set_distro(self, distro):  
> >         if distro == "defaultsetup":   
> >             distro = ""
> >         self.server.runCommand(["setVariable", "DISTRO", distro])
> > 
> > However Richard ever worried about this approach.
> > See:
> > http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-March/002438.html
> > 
> > In summary, there are two solutions now:
> > 
> > 1) Set those layers defined in bblayers.conf as default, and don't allow
> > users to delete them, like this [PATCH 3/7] does.
> > 2) Use the empty string "" as the value of DISTRO variable for
> > "defaultsetup", and set this value before parsing configuration files,
> > making the DISTRO ?= "poky" in local.conf doesn't take effect.
> > 
> > Welcome for comments on this issue.
> 
> I'd be happy if you change the above code to do:
> 
>         self.server.runCommand(["deleteVariable", "DISTRO"])
> 
> which is subtly different but consistent with what we really want. I
> have no idea if we have a deleteVariable command but if we don't, we
> should add one.

I ever tried this approach with the following patch, however it didn't
work. The setting of DISTRO ?= "poky" will still take effect.

It seems that delVar(DISTRO) is different from setting DISTRO="".


diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 73aaca0..a7b41ce 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -160,6 +160,13 @@ class CommandsSync:
         value = params[1]
         command.cooker.configuration.data.setVar(varname, value)

+    def delVariable(self, command, params):
+        """
+        Delete the variable in configuration.data
+        """
+        varname = params[0]
+        command.cooker.configuration.data.delVar(varname)
+
     def initCooker(self, command, params):
         """
         Init the cooker to initial state with nothing parsed
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8909e01..d236a72 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -265,7 +265,9 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "IMAGE_FSTYPES",
image_fstypes])

     def set_distro(self, distro):
-        if distro != "defaultsetup":
+        if distro == "defaultsetup":
+            self.server.runCommand(["delVariable", "DISTRO"])
+        else:
             self.server.runCommand(["setVariable", "DISTRO", distro])

     def set_package_format(self, format):

Thanks,
Dongxiao
> 
> Cheers,
> 
> Richard
> 




