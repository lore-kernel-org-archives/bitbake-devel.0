Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TgdVU-0006rg-OA for bitbake-devel@lists.openembedded.org;
	Thu, 06 Dec 2012 16:37:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB6FMW2d030148;
	Thu, 6 Dec 2012 15:22:32 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29258-06; Thu,  6 Dec 2012 15:22:28 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB6FMNZd030141
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Dec 2012 15:22:24 GMT
Message-ID: <1354807333.12928.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Thu, 06 Dec 2012 15:22:13 +0000
In-Reply-To: <1354799706-9226-1-git-send-email-cristiana.voicu@intel.com>
References: <1354799706-9226-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/bitbake: custom image is now using the base image
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
X-List-Received-Date: Thu, 06 Dec 2012 15:37:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-12-06 at 15:15 +0200, Cristiana Voicu wrote:
> Till now, a custom image made in Hob was using only the packages from
> the base image. Now it is using everything declared in the base image.
> Also next to hob-image.bb, it creates another .bb file which is used
> in building process. Those images are ignored by git.
> 
> [YOCTO #2601]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  .gitignore                                  |    1 +
>  bitbake/lib/bb/command.py                   |    8 +++++--
>  bitbake/lib/bb/cooker.py                    |   31 +++++++++++++++++++++++++--
>  bitbake/lib/bb/ui/crumbs/builder.py         |    3 +++
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 +++--
>  5 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 88c91f6..003f09a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -15,3 +15,4 @@ meta-*
>  *~
>  !meta-yocto
>  !meta-yocto-bsp
> +hob-image-*.bb
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 3f28bca..48b09e4 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -220,8 +220,12 @@ class CommandsAsync:
>          """
>          pkgs_to_build = params[0]
>          task = params[1]
> -
> -        command.cooker.buildTargets(pkgs_to_build, task)
> +        if len(params) > 2:
> +            base_image = params[2]
> +            package_queue = params[3]
> +            command.cooker.buildTargets(pkgs_to_build, task, base_image, package_queue)
> +        else:
> +            command.cooker.buildTargets(pkgs_to_build, task)
>      buildTargets.needcache = True
>  
>      def generateDepTreeEvent(self, command, params):
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 6b58f91..22d8bd1 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -23,7 +23,7 @@
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  
>  from __future__ import print_function
> -import sys, os, glob, os.path, re, time
> +import sys, os, glob, os.path, re, time, shutil
>  import atexit
>  import itertools
>  import logging
> @@ -1127,11 +1127,14 @@ class BBCooker:
>  
>          self.server_registration_cb(buildFileIdle, rq)
>  
> -    def buildTargets(self, targets, task):
> +    def buildTargets(self, targets, task, base_image=None, package_queue=None):
>          """
>          Attempt to build the targets specified
>          """
>  
> +        if base_image != None and targets[0] == "hob-image":
> +            self.prepareHobImage(base_image, package_queue)
> +
>          # Need files parsed
>          self.updateCache()
>  
> @@ -1188,6 +1191,30 @@ class BBCooker:
>  
>          self.server_registration_cb(buildTargetsIdle, rq)

This looks good, I'd just ask for one tweak.

Rather than overload "buildTargets", lets add a new command say
"generateNewImage" which generates the this. Lets also not make this
"hob" specific, lets pass in the necessary parameters.

This may mean we need to also add a command to run "matchFile" on the
server so we can call the "generateNewImage" command with the right
options.

Cheers,

Richard


> +    def prepareHobImage(self, base_image, package_queue):
> +        '''
> +        Create a new hob-image with a "require" base_image statement
> +        '''
> +        hob_image = self.matchFile("hob-image.bb")
> +        base_image = self.matchFile(str(base_image) + ".bb")
> +        with open(hob_image, "a") as hobimagefile:
> +            hobimagefile.write("require " + base_image + "\n")
> +            package_install = "PACKAGE_INSTALL_forcevariable = \""
> +            for package in package_queue:
> +                package_install += str(package) + " "
> +            package_install += "\"\n"
> +            hobimagefile.write(package_install)
> +
> +        dir_hob_image = os.path.dirname(hob_image)
> +        timestr = time.strftime("%Y%m%d-%H%M%S")
> +        dest = dir_hob_image + "/hob-image-" + str(timestr) + ".bb"
> +        shutil.copyfile(hob_image, dest)
> +
> +        self.parser.reparse(hob_image)
> +
> +        with open(hob_image, "w") as hobimagefile:
> +            hobimagefile.write("inherit image\n")
> +
>      def updateCache(self):
>          if self.state == state.running:
>              return
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 2f3d6d0..663c322 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -611,15 +611,18 @@ class Builder(gtk.Window):
>          # Build image
>          self.set_user_config()
>          toolchain_packages = []
> +        base_image = None
>          if self.configuration.toolchain_build:
>              toolchain_packages = self.package_model.get_selected_packages_toolchain()
>          if self.configuration.selected_image == self.recipe_model.__custom_image__:
>              packages = self.package_model.get_selected_packages()
>              image = self.hob_image
> +            base_image = self.configuration.initial_selected_image
>          else:
>              packages = []
>              image = self.configuration.selected_image
>          self.handler.generate_image(image,
> +                                    base_image,
>                                      self.hob_toolchain,
>                                      packages,
>                                      toolchain_packages,
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index 8a2ac5f..1583f76 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -166,7 +166,7 @@ class HobHandler(gobject.GObject):
>              if self.toolchain_packages:
>                  self.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
>                  targets.append(self.toolchain)
> -            self.runCommand(["buildTargets", targets, self.default_task])
> +            self.runCommand(["buildTargets", targets, self.default_task, self.base_image, self.package_queue])
>  
>      def display_error(self):
>          self.clear_busy()
> @@ -386,8 +386,9 @@ class HobHandler(gobject.GObject):
>          self.commands_async.append(self.SUB_BUILD_RECIPES)
>          self.run_next_command(self.GENERATE_PACKAGES)
>  
> -    def generate_image(self, image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
> +    def generate_image(self, image, base_image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
>          self.image = image
> +        self.base_image = base_image
>          self.toolchain = toolchain
>          self.package_queue = image_packages
>          self.toolchain_packages = toolchain_packages




