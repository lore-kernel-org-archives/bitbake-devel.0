Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T9yqo-0007C1-IQ
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 15:44:02 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 07 Sep 2012 06:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,385,1344236400"; d="scan'208";a="198919781"
Received: from unknown (HELO helios.localnet) ([10.252.121.175])
	by orsmga002.jf.intel.com with ESMTP; 07 Sep 2012 06:31:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 07 Sep 2012 14:31:34 +0100
Message-ID: <20412309.fRarBkGYyG@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-30-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <1347023891-9237-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1347023891-9237-1-git-send-email-paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH] fetch2: fix fetcher looping due to self-referential entries
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
X-List-Received-Date: Fri, 07 Sep 2012 13:44:02 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 07 September 2012 14:18:11 Paul Eggleton wrote:
> Ensure that if all a MIRRORS entry does is add a slash, this does not
> result in a circular loop.
> 
> Fixes [YOCTO #3073].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py index 12ebce2..a90249f 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -178,6 +178,7 @@ def encodeurl(decoded):
>          url += "@"
>      if host and type != "file":
>          url += "%s" % host
> +    path = path.replace("//", "/")
>      url += "%s" % urllib.quote(path)
>      if p:
>          for parm in p:

Actually I'll tweak this a bit with a different shortlog, ignore this.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


