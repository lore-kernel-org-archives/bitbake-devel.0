Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 196C5608BE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 12:26:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5KCWBxa005009; Thu, 20 Jun 2013 13:32:11 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4zFWdWcMddsV; Thu, 20 Jun 2013 13:32:10 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5KCW5cw004997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 20 Jun 2013 13:32:07 +0100
Message-ID: <1371731141.20823.232.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Thu, 20 Jun 2013 13:25:41 +0100
In-Reply-To: <1371723585-27966-4-git-send-email-cristiana.voicu@intel.com>
References: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
	<1371723585-27966-4-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2 3/5] bitbake: call the initConfiguration when reparsing
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
X-List-Received-Date: Thu, 20 Jun 2013 12:26:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-06-20 at 13:19 +0300, Cristiana Voicu wrote:
> As it is implemented now, when parsing the configuration files is
> needed, it also needs an initialization.
> Also, implemented a function to create an extra configuration files
> which can be used as postfile/prefiles when parsing.
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/cooker.py |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index f375a6f..e1b33f1 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -109,7 +109,6 @@ class BBCooker:
>                  sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
>  
>          self.data = None
> -        self.initConfigurationData()
>          self.loadConfigurationData()
>  
>          # Take a lock so only one copy of bitbake can run against a given build
> @@ -155,7 +154,10 @@ class BBCooker:
>      def disableDataTracking(self):
>          self.data.disableTracking()
>  
> -    def loadConfigurationData(self):
> +    def loadConfigurationData(self, tracking = False):
> +        self.initConfigurationData()
> +        if tracking:
> +            self.enableDataTracking()
>          self.databuilder.parseBaseConfiguration()
>          self.data = self.databuilder.data
>          self.data_hash = self.databuilder.data_hash
> @@ -243,6 +245,11 @@ class BBCooker:
>              loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
>              self.data.setVar(var, val, **loginfo)
>  
> +    def createConfigFile(self, name):
> +        path = os.getcwd()
> +        confpath = os.path.join(path, "conf", name)
> +        open(confpath, 'w').close()
> +
>      def parseConfiguration(self):
>  
>          # Set log file verbosity
> @@ -1201,8 +1208,7 @@ class BBCooker:
>  
>      def reset(self):
>          self.state = state.initial
> -        self.initConfigurationData()
> -        self.loadConfigurationData()
> +        self.loadConfigurationData(tracking=True)

I don't like having one default used in some cases yet the reset does
something different by default. Can you set the tracking to enabled from
hob please instead of this default?

Cheers,

Richard



