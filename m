Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SWTQb-0004jU-00 for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:17:41 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4LE7Yo2025674;
	Mon, 21 May 2012 15:07:34 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23836-09; Mon, 21 May 2012 15:07:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4LE7ORJ025668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 May 2012 15:07:25 +0100
Message-ID: <1337609243.22747.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Mon, 21 May 2012 15:07:23 +0100
In-Reply-To: <1337527267-2196-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1337527267-2196-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: added -j option
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
X-List-Received-Date: Mon, 21 May 2012 14:17:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-05-20 at 17:21 +0200, Enrico Scholz wrote:
> This patch adds an -j option which overrides/sets BB_NUMBER_THREADS.
> For some use cases like '-c fetchall' it might be useful to modify
> temporarily the number of parallel running tasks without editing
> bitbake.conf.
> 
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  bin/bitbake      |    4 ++++
>  doc/bitbake.1    |    4 ++++
>  lib/bb/cooker.py |    7 +++++++
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/bin/bitbake b/bin/bitbake
> index 478ac06..b29fae9 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -171,6 +171,10 @@ Default BBFILES are the .bb files in the current directory.""")
>  
>      parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
>                 action = "store", dest = "bind", default = False)
> +
> +    parser.add_option("-j", "--jobs", help = "The number of threads BitBake should run at once",
> +                      action = "store", dest = "number_threads", default = None)
> +
>      options, args = parser.parse_args(sys.argv)
>  
>      configuration = BBConfiguration(options)


I think in this case you may as well just whitelist BB_NUMBER_THREADS
from the environment and set that variable there. I'm not seeing a huge
need for the specific commandline option...

Cheers,

Richard




