Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 442676A99C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 07:37:12 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5K7hIfw022198; Thu, 20 Jun 2013 08:43:18 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 39uGtgzdpIQA; Thu, 20 Jun 2013 08:43:18 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5K7hEYJ022193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 20 Jun 2013 08:43:16 +0100
Message-ID: <1371713811.20823.216.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Thu, 20 Jun 2013 08:36:51 +0100
In-Reply-To: <1371651387-20886-3-git-send-email-cristiana.voicu@intel.com>
References: <1371651387-20886-1-git-send-email-cristiana.voicu@intel.com>
	<1371651387-20886-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/5] bitbake: add a new command and modify others
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
X-List-Received-Date: Thu, 20 Jun 2013 07:37:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-06-19 at 17:16 +0300, Cristiana Voicu wrote:
> This patch adds a new command to create an extra configuration
> file, in order to create it from Hob.
> Also, it removes 2 commands used to enable and disable the tracking
> history for variables, because it will be called in the body of each
> command when needed.

I'm not sure I like the idea of hard coding in when the tracking gets
turned on/off. Can we not do this at the correct points in hob?

The rest of the patch series looks good but the removal of these
commands is giving me some concern.

Cheers,

Richard




> Modified the prefiles and postfiles variables because the cooker
> expects some lists.
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/command.py |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 5f696c2..9ddb96d 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -174,18 +174,6 @@ class CommandsSync:
>          value = str(params[1])
>          setattr(command.cooker.configuration, varname, value)
>  
> -    def enableDataTracking(self, command, params):
> -        """
> -        Enable history tracking for variables
> -        """
> -        command.cooker.enableDataTracking()
> -
> -    def disableDataTracking(self, command, params):
> -        """
> -        Disable history tracking for variables
> -        """
> -        command.cooker.disableDataTracking()
> -
>      def initCooker(self, command, params):
>          """
>          Init the cooker to initial state with nothing parsed
> @@ -217,10 +205,22 @@ class CommandsSync:
>          return command.cooker.generateNewImage(image, base_image, package_queue)
>  
>      def setVarFile(self, command, params):
> +        """
> +        Save a variable in a file; used for saving in a configuration file
> +        """
>          var = params[0]
>          val = params[1]
>          default_file = params[2]
> +        command.cooker.enableDataTracking()
>          command.cooker.saveConfigurationVar(var, val, default_file)
> +        command.cooker.disableDataTracking()
> +
> +    def createConfigFile(self, command, params):
> +        """
> +        Create an extra configuration file
> +        """
> +        name = params[0]
> +        command.cooker.createConfigFile(name)
>  
>  class CommandsAsync:
>      """
> @@ -390,11 +390,11 @@ class CommandsAsync:
>          """
>          Parse the configuration files
>          """
> -        prefiles = params[0]
> -        postfiles = params[1]
> +        prefiles = params[0].split()
> +        postfiles = params[1].split()
>          command.cooker.configuration.prefile = prefiles
>          command.cooker.configuration.postfile = postfiles
> -        command.cooker.loadConfigurationData()
> +        command.cooker.loadConfigurationData(tracking=True)
>          command.finishAsyncCommand()
>      parseConfigurationFiles.needcache = False
>  



