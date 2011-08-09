Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QqpCB-0000lm-Ki
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 18:30:23 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 09 Aug 2011 09:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,344,1309762800"; d="scan'208";a="36728065"
Received: from unknown (HELO [10.255.13.204]) ([10.255.13.204])
	by azsmga001.ch.intel.com with ESMTP; 09 Aug 2011 09:25:36 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 09 Aug 2011 09:25:31 -0700
In-Reply-To: <1312897403.14274.295.camel@rex>
References: <1312897403.14274.295.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1312907137.2265.2.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake/ui/knotty: Ensure 'No Provider' errors set an exit code
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
X-List-Received-Date: Tue, 09 Aug 2011 16:30:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-09 at 14:43 +0100, Richard Purdie wrote:
> If a No Provider error is shown we need to set the exit code to
> show an error occured too.
> 
> [YOCTO #1322]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index b7abdf8..63b8dc6 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -199,6 +199,7 @@ def main(server, eventHandler):
>                  logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
>                  continue
>              if isinstance(event, bb.event.NoProvider):
> +                return_value = 1
>                  if event._runtime:
>                      r = "R"
>                  else:
> 
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



