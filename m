Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rkwci-0005Yw-Aw for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 12:45:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BBcE1T023354;
	Wed, 11 Jan 2012 11:38:14 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22821-04; Wed, 11 Jan 2012 11:38:10 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0BBc4Xw023345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2012 11:38:05 GMT
Message-ID: <1326281886.23315.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Wed, 11 Jan 2012 11:38:06 +0000
In-Reply-To: <2b70816adeae4c278747d52654f3184f5e5a15a3.1326249301.git.dongxiao.xu@intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
	<2b70816adeae4c278747d52654f3184f5e5a15a3.1326249301.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 5/8] bitbake: add -B option to bind with interface
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
X-List-Received-Date: Wed, 11 Jan 2012 11:45:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-01-11 at 11:03 +0800, Dongxiao Xu wrote:
> When start bitbake as a server only process, we need to assign certain
> interface to it.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  bin/bitbake             |   15 ++++++++++-----
>  lib/bb/server/xmlrpc.py |    6 +++---
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/bin/bitbake b/bin/bitbake
> index c2e6822..6e661ce 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -168,6 +168,8 @@ Default BBFILES are the .bb files in the current directory.""")
>      parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
>                 action = "store_true", dest = "server_only", default = False)
>  
> +    parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
> +               action = "store", dest = "bind", default = False)
>      options, args = parser.parse_args(sys.argv)
>  
>      configuration = BBConfiguration(options)
> @@ -189,9 +191,6 @@ Default BBFILES are the .bb files in the current directory.""")
>          sys.exit("FATAL: Invalid server type '%s' specified.\n"
>                   "Valid interfaces: xmlrpc, process [default], none." % servertype)
>  
> -    if configuration.server_only and configuration.servertype != "xmlrpc":
> -        sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
> -
>      # Save a logfile for cooker into the current working directory. When the
>      # server is daemonized this logfile will be truncated.
>      cooker_logfile = os.path.join(os.getcwd(), "cooker.log")
> @@ -211,9 +210,15 @@ Default BBFILES are the .bb files in the current directory.""")
>      # of the UIs (e.g. for DISPLAY, etc.)
>      bb.utils.clean_environment()
>  
> -    server = server.BitBakeServer()
> +    if configuration.server_only:
> +        if configuration.servertype != "xmlrpc":
> +            sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
> +        server = server.BitBakeServer()
> +        server.initServer((configuration.bind, 0))
> +    else:
> +        server = server.BitBakeServer()
> +        server.initServer()

This looks like it will silently ignore configuration.bind in the non
server-only case. Don't you need something like:


+    if configuration.server_only:
+        if configuration.servertype != "xmlrpc":
+            sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
+        server = server.BitBakeServer()
+        server.initServer((configuration.bind, 0))
+    elif configuration.bind:
+        server = server.BitBakeServer()
+        server.initServer((configuration.bind, 0))
+    else:
+        server = server.BitBakeServer()
+        server.initServer()

?

Cheers,

Richard




