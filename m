Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RjCBU-0000o2-R4 for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 16:58:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q06Fp074022664;
	Fri, 6 Jan 2012 15:51:00 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22389-03; Fri,  6 Jan 2012 15:50:56 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q06FooVA022658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jan 2012 15:50:50 GMT
Message-ID: <1325865050.20759.132.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Fri, 06 Jan 2012 15:50:50 +0000
In-Reply-To: <15703ec8d9b0560b0db97069426c1916e3896a63.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
	<15703ec8d9b0560b0db97069426c1916e3896a63.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 12/16] bitbake: add -B option to bind with interface
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
X-List-Received-Date: Fri, 06 Jan 2012 15:58:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-01-06 at 17:02 +0800, Dongxiao Xu wrote:
> When start bitbake as a server only process, we need to assign certain
> interface to it.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  bin/bitbake             |   17 ++++++++++++-----
>  lib/bb/server/xmlrpc.py |    6 +++---
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/bin/bitbake b/bin/bitbake
> index c2e6822..4bf1335 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -168,6 +168,8 @@ Default BBFILES are the .bb files in the current directory.""")
>      parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
>                 action = "store_true", dest = "server_only", default = False)
>  
> +    parser.add_option("-B", "--bind", help = "Bind bitbake server with certain address",

I find these help messages confusing. How about "The name/address for
the bitbake server to bind to"?

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
> @@ -211,9 +210,17 @@ Default BBFILES are the .bb files in the current directory.""")
>      # of the UIs (e.g. for DISPLAY, etc.)
>      bb.utils.clean_environment()
>  
> -    server = server.BitBakeServer()
> +    if configuration.server_only:
> +        if configuration.servertype != "xmlrpc":
> +            sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
> +        if not configuration.bind:
> +            sys.exit("FATAL: If '--server-only' is defined, we need to bind the server with certain address'.\n")

How about "FATAL: The '--server-only' option requires a name/address to
bind to with the --bind option"?

To be honest, I'd also expect --bind to work without --server-only,
defaulting to "localhost" if it wasn't set but using the address/name
specified if it was. The usecase would be to attach a secondary UI to
the bitbake server during the build process for monitoring/control
purposes.

Cheers,

Richard





