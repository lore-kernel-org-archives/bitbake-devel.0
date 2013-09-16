Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 12B6F6C873
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 13:54:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GE8mAq014470; Mon, 16 Sep 2013 15:08:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BbqTkDB5FjBT; Mon, 16 Sep 2013 15:08:48 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GE8fO4014466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 15:08:42 +0100
Message-ID: <1379339665.3484.307.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 14:54:25 +0100
In-Reply-To: <6614ca8b4786486ae3a58e78ca0c40b131c6ff57.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<6614ca8b4786486ae3a58e78ca0c40b131c6ff57.1379338189.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 5/7] bitbake: cooker, command: add a command to return global data
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
X-List-Received-Date: Mon, 16 Sep 2013 13:54:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Adding the 'getAllKeysWithFlags' read-only command that will
> return a dump of the global data state, together with specified
> flags for each key. The flag list is passed in as the first
> parameter to the command.
> 
> This will be used by UI clients to get the build configuration.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/command.py |  8 ++++++++
>  bitbake/lib/bb/cooker.py  | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index f1abaf7..5d359e7 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -145,6 +145,14 @@ class CommandsSync:
>          """
>          command.cooker.shutdown(True)
>  
> +    def getAllKeysWithFlags(self, command, params):
> +        """
> +        Returns a dump of the global state. Call with
> +        variable flags to be retrieved as params.
> +        """
> +        return command.cooker.getAllKeysWithFlags(params[0])
> +    getAllKeysWithFlags.readonly = True

Please match the style of the other commands, i.e.:

+        flaglist = params[0]
+
+        return command.cooker.getAllKeysWithFlags(flaglist)

which then indicates what params[0] actually is. We spell this out in
the functions so people can look at the commands and get some idea of
how to use them without having to look at the code itself.

>      def getVariable(self, command, params):
>          """
>          Read the value of a variable from data
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index cb0e3e5..981379b 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1134,6 +1134,21 @@ class BBCooker:
>  
>          self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
>  
> +
> +    def getAllKeysWithFlags(self, flaglist):
> +        dump = {}
> +        for k in self.data.keys():
> +            try:
> +                v = self.data.getVar(k, True)
> +                if not k.startswith("__") and not bool(self.data.getVarFlag(k, 'func')) and not isinstance(v, bb.data_smart.DataSmart):

Please get rid of the "not bool(self.data.getVarFlag(k, 'func')" and
filter your results on the other side of the connection if you need to
do that (you can request the func flag too).

> +                    dump[k] = { 'v' : v }
> +                    for d in flaglist:
> +                        dump[k][d] = self.data.getVarFlag(k, d)
> +            except:

which exceptions are we worried about here? Lets be specific please.

> +                pass
> +        return dump
> +
> +
>      def generateNewImage(self, image, base_image, package_queue, timestamp, description):
>          '''
>          Create a new image with a "require"/"inherit" base_image statement



