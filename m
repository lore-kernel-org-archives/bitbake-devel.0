Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 31DD360FDF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 14:53:04 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DF6m7D032664; Fri, 13 Sep 2013 16:06:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id b0wHUKGIFO9D; Fri, 13 Sep 2013 16:06:48 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DF6js8032658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 13 Sep 2013 16:06:46 +0100
Message-ID: <1379083966.3484.267.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Fri, 13 Sep 2013 15:52:46 +0100
In-Reply-To: <a1812224527bb7669488131821eb6989fcda6917.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
	<a1812224527bb7669488131821eb6989fcda6917.1378743829.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 07/13] bitbake: cooker, command: add a command to return global data
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
X-List-Received-Date: Fri, 13 Sep 2013 14:53:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-09 at 17:40 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Adding the 'getDataDump' read-only command that will
> return a dump of the global data state.
> 
> This will be used by the DSI to store the build configuration.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/command.py |  7 +++++++
>  bitbake/lib/bb/cooker.py  | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 3527ad0..4d36c4b 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -145,6 +145,13 @@ class CommandsSync:
>          """
>          command.cooker.stop()
>  
> +    def getDataDump(self, command, params):
> +        """
> +        Returns a dump of the global state.
> +        """
> +        return command.cooker.getGlobalExpandedData()
> +    getDataDump.readonly = True
> +
>      def getVariable(self, command, params):
>          """
>          Read the value of a variable from data
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 9fd3417..383c9c4 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1117,6 +1117,19 @@ class BBCooker:
>  
>          self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
>  
> +
> +    def getGlobalExpandedData(self):
> +        dump = {}
> +        for k in self.data.keys():
> +            try:
> +                v = self.data.getVar(k, True)
> +                if not k.startswith("__") and not bool(self.data.getVarFlag(k, 'func')) and not isinstance(v, bb.data_smart.DataSmart):
> +                    dump[k] = { 'v' : v, 'd' : self.data.getVarFlag(k, 'doc') }
> +            except:
> +                pass
> +        return dump

There is a 'doc' hardcoded into there, perhaps this should be a better
named command and take a parameter?

Cheers,

Richard


