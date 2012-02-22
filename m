Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0JeD-00080L-Ff
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 22:22:49 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 22 Feb 2012 13:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120240063"
Received: from unknown (HELO helios.localnet) ([10.252.123.16])
	by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2012 13:14:27 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2012 21:14:25 +0000
Message-ID: <1472904.fEsuyk6NFK@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <b0e42ae76c528cf90d3a78acfe8b4cd6b8552d42.1329133148.git.paul.eggleton@linux.intel.com>
References: <cover.1329133148.git.paul.eggleton@linux.intel.com>
	<b0e42ae76c528cf90d3a78acfe8b4cd6b8552d42.1329133148.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] bitbake/knotty: ensure we return non-zero exit code on Ctrl+C
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
X-List-Received-Date: Wed, 22 Feb 2012 21:22:49 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 13 February 2012 11:41:32 Paul Eggleton wrote:
> If the user uses Ctrl+C to exit out of the build, then ensure we return
> a non-zero exit code since the entire build was not completed
> successfully.
> 
> If nothing else, this is useful to avoid continuing in the bitbake
> wrapper script in OE-Core if the initial pseudo build is interrupted.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/ui/knotty.py |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index e1d42f7..2693a78 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -296,4 +296,9 @@ def main(server, eventHandler):
>      if summary:
>          print(summary)
> 
> +    if shutdown:
> +        print("Execution was interrupted, returning a non-zero exit code.")
> +        if return_value == 0:
> +            return_value = 1
> +
>      return return_value

Seems I didn't test this well enough. Working on a fix right now.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


