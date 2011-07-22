Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QkJBg-0000G7-C5 for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:06:56 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6MH2jAD030120;
	Fri, 22 Jul 2011 18:02:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28913-10; Fri, 22 Jul 2011 18:02:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6MH2aOt030114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jul 2011 18:02:36 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <e4f33dab9ad77edd3ae123ea2dc6d2f70a5be037.1311351396.git.josh@linux.intel.com>
References: <cover.1311351396.git.josh@linux.intel.com>
	<e4f33dab9ad77edd3ae123ea2dc6d2f70a5be037.1311351396.git.josh@linux.intel.com>
Date: Fri, 22 Jul 2011 18:02:32 +0100
Message-ID: <1311354152.2344.148.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake|cooker: save a copy of the environment when BitBake is started
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
X-List-Received-Date: Fri, 22 Jul 2011 17:06:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-22 at 09:27 -0700, Joshua Lock wrote:
> Create a data store in the cooker containing the values of the environment
> from when BitBake is launched such that child processes can replicate
> (and/or use values from) the host environment, rather than the cleaned up
> environment that the main BitBake process uses.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  bin/bitbake      |    5 ++++-
>  lib/bb/cooker.py |   11 ++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/bin/bitbake b/bin/bitbake
> index 206d97b..a9dd67e 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -197,6 +197,9 @@ Default BBFILES are the .bb files in the current directory.""")
>      handler = bb.event.LogHandler()
>      logger.addHandler(handler)
>  
> +    # Before we start modifying the environment we should take a pristine
> +    # copy for possible later use
> +    initialenv = os.environ.copy()
>      # Clear away any spurious environment variables. But don't wipe the
>      # environment totally. This is necessary to ensure the correct operation
>      # of the UIs (e.g. for DISPLAY, etc.)
> @@ -207,7 +210,7 @@ Default BBFILES are the .bb files in the current directory.""")
>      server.initServer()
>      idle = server.getServerIdleCB()
>  
> -    cooker = bb.cooker.BBCooker(configuration, idle)
> +    cooker = bb.cooker.BBCooker(configuration, idle, initialenv)
>      cooker.parseCommandLine()
>  
>      server.addcooker(cooker)
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 0326b8c..079b6d3 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -78,7 +78,7 @@ class BBCooker:
>      Manages one bitbake build run
>      """
>  
> -    def __init__(self, configuration, server_registration_cb):
> +    def __init__(self, configuration, server_registration_cb, savedenv=None):

def __init__(self, configuration, server_registration_cb, savedenv={}):

>          self.status = None
>          self.appendlist = {}
>          self.skiplist = {}
> @@ -87,6 +87,15 @@ class BBCooker:
>  
>          self.configuration = configuration
>  
> +        # Keep a datastore of the initial environment variables and their
> +        # values from when BitBake was launched to enable child processes
> +        # to use environment variables which have been cleaned from the
> +        # BitBake processes env
> +        if savedenv:
> +            self.savedenv = bb.data.init()
> +            for k in savedenv:
> +                self.savedenv.setVar(k, savedenv[k])
> +

Then you can drop the if and we'd just create an empty dictionary which
is likely going to lead to saner code in future...

Cheers,

Richard





