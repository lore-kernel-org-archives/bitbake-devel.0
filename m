Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id B5C1A60EA8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Sep 2013 07:29:53 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 Sep 2013 00:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1006,1371106800"; d="scan'208";a="301166966"
Received: from cvoicu-vostro-460.rb.intel.com (HELO [10.237.105.65])
	([10.237.105.65])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Sep 2013 00:29:54 -0700
Message-ID: <52492975.20408@intel.com>
Date: Mon, 30 Sep 2013 10:34:13 +0300
From: "cristiana.voicu" <cristiana.voicu@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130804 Thunderbird/17.0.8
MIME-Version: 1.0
To: Valentin Popa <valentin.popa@intel.com>
References: <1380291041-11238-1-git-send-email-valentin.popa@intel.com>
In-Reply-To: <1380291041-11238-1-git-send-email-valentin.popa@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] HOB: MACHINE should be saved in conf files using ?=
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
X-List-Received-Date: Mon, 30 Sep 2013 07:29:53 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/27/2013 05:10 PM, Valentin Popa wrote:
> MACHINE var is saved using early assignment operator.
> Calling  MACHINE=x bitbake core-image-... works properly.
> Comment "#added by bitbake" is replaced with "#added by hob".
>
> [YOCTO #5070]
> Signed-off-by: Valentin Popa <valentin.popa@intel.com>
> ---
>   bitbake/lib/bb/cooker.py                    | 17 ++++++++++-------
>   bitbake/lib/bb/ui/crumbs/builder.py         |  2 +-
>   bitbake/lib/bb/ui/crumbs/hobeventhandler.py |  7 ++++++-
>   3 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index ff2af69..ce7ca43 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -193,7 +193,10 @@ class BBCooker:
>           if op == "append":
>               self.appendConfigurationVar(var, val, default_file)
>           elif op == "set":
> -            self.saveConfigurationVar(var, val, default_file)
> +            self.saveConfigurationVar(var, val, default_file, "=")
> +        elif op == "earlyAssign":
> +            self.saveConfigurationVar(var, val, default_file, "?=")
> +
>   
>       def appendConfigurationVar(self, var, val, default_file):
>           #add append var operation to the end of default_file
> @@ -207,7 +210,7 @@ class BBCooker:
>           for c in contents:
>               total += c
>   
> -        total += "#added by bitbake"
> +        total += "#added by hob"
>           total += "\n%s += \"%s\"\n" % (var, val)
>   
>           with open(default_file, 'w') as f:
> @@ -218,7 +221,7 @@ class BBCooker:
>           loginfo = {"op":append, "file":default_file, "line":total.count("\n")}
>           self.data.appendVar(var, val, **loginfo)
>   
> -    def saveConfigurationVar(self, var, val, default_file):
> +    def saveConfigurationVar(self, var, val, default_file, op):
>   
>           replaced = False
>           #do not save if nothing changed
> @@ -260,8 +263,8 @@ class BBCooker:
>                       #check if the variable was saved before in the same way
>                       #if true it replace the place where the variable was declared
>                       #else it comments it
> -                    if contents[begin_line-1]== "#added by bitbake\n":
> -                        contents[begin_line] = "%s = \"%s\"\n" % (var, val)
> +                    if contents[begin_line-1]== "#added by hob\n":
> +                        contents[begin_line] = "%s %s \"%s\"\n" % (var, op, val)
>                           replaced = True
>                       else:
>                           for ii in range(begin_line, end_line):
> @@ -290,8 +293,8 @@ class BBCooker:
>                   total += c
>   
>               #add the variable on a single line, to be easy to replace the second time
> -            total += "\n#added by bitbake"
> -            total += "\n%s = \"%s\"\n" % (var, val)
> +            total += "\n#added by hob"
> +            total += "\n%s %s \"%s\"\n" % (var, op, val)
>   
>               with open(default_file, 'w') as f:
>                   f.write(total)
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 86fdbfe..f9fd15a 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -197,7 +197,7 @@ class Configuration:
>           handler.set_var_in_file("BBLAYERS", self.layers, "bblayers.conf")
>           # local.conf
>           if not defaults:
> -            handler.set_var_in_file("MACHINE", self.curr_mach, "local.conf")
> +            handler.early_assign_var_in_file("MACHINE", self.curr_mach, "local.conf")
>           handler.set_var_in_file("DISTRO", self.curr_distro, "local.conf")
>           handler.set_var_in_file("DL_DIR", self.dldir, "local.conf")
>           handler.set_var_in_file("SSTATE_DIR", self.sstatedir, "local.conf")
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index ef74e56..3f5beba 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -315,7 +315,7 @@ class HobHandler(gobject.GObject):
>   
>       def set_machine(self, machine):
>           if machine:
> -            self.set_var_in_file("MACHINE", machine, "local.conf")
> +            self.early_assign_var_in_file("MACHINE", machine, "local.conf")
>   
>       def set_sdk_machine(self, sdk_machine):
>           self.set_var_in_file("SDKMACHINE", sdk_machine, "local.conf")
> @@ -472,6 +472,11 @@ class HobHandler(gobject.GObject):
>           self.server.runCommand(["setVarFile", var, val, default_file, "set"])
>           self.runCommand(["disableDataTracking"])
>   
> +    def early_assign_var_in_file(self, var, val, default_file=None):
> +        self.runCommand(["enableDataTracking"])
> +        self.server.runCommand(["setVarFile", var, val, default_file, "earlyAssign"])
> +        self.runCommand(["disableDataTracking"])
> +
>       def append_var_in_file(self, var, val, default_file=None):
>           self.server.runCommand(["setVarFile", var, val, default_file, "append"])
>   
Looks good to me.
Cristiana

