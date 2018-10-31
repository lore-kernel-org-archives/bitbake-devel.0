Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 04A4979C05
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 07:52:46 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w9V7qk0W025554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 31 Oct 2018 07:52:47 GMT
Message-ID: <a744bfa29698aa5d63dbd4c6725dd3035ea88773.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joe Slater <joe.slater@windriver.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 31 Oct 2018 07:52:46 +0000
In-Reply-To: <20181030233304.214025-1-joe.slater@windriver.com>
References: <20181030233304.214025-1-joe.slater@windriver.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [oe-core][PATCH 1/1] cooker.py: no bb.fatal() for pr server
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
X-List-Received-Date: Wed, 31 Oct 2018 07:52:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-10-30 at 16:33 -0700, Joe Slater wrote:
> Calls to bb.fatal() will block at this point of initialization.
> 
> Signed-off-by: Joe Slater <joe.slater@windriver.com>
> ---
>  lib/bb/cooker.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 71a0eba..2a3721b 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -383,7 +383,8 @@ class BBCooker:
>          try:
>              self.prhost = prserv.serv.auto_start(self.data)
>          except prserv.serv.PRServiceConfigError as e:
> -            bb.fatal("Unable to start PR Server, exitting")
> +            logger.error("Unable to start PR Server.  Continuing anyway...")
> +            self.prhost = None
>  

Shouldn't we fix the blocking?

Cheers,

Richard


