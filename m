Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 647AE7F808
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 15:37:45 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x9NFbg44020464
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Wed, 23 Oct 2019 10:37:43 -0500
To: Ross Burton <ross.burton@intel.com>, bitbake-devel@lists.openembedded.org
References: <20191023153339.2313-1-ross.burton@intel.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <359289f7-5c0a-1a8f-3584-1b0914fef1a2@kernel.crashing.org>
Date: Wed, 23 Oct 2019 10:37:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023153339.2313-1-ross.burton@intel.com>
Subject: Re: [PATCH] bitbake/runqueue: don't shout about hash updates
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
X-List-Received-Date: Wed, 23 Oct 2019 15:37:45 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

This was from a patch the other day:

-                bb.warn("Deferring %s after %s" % (tid, sqdata.hashes[h]))
+                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))

Is that also debug, or is it really something to be displayed?  (Same file.)

--Mark

On 10/23/19 10:33 AM, Ross Burton wrote:
> With hash equivalency enabled the runqueue logs at level info quite heavily,
> which spams the console.
> 
> Reduce the log level down to debug so it's there if needed but doesn't get in
> the way.
> 
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>  bitbake/lib/bb/runqueue.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 18049436fd5..e1eaf49b8cd 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -2361,7 +2361,7 @@ class RunQueueExecute:
>              if tid in self.build_stamps:
>                  del self.build_stamps[tid]
>  
> -            logger.info("Setscene task %s now valid and being rerun" % tid)
> +            logger.debug(2, "Setscene task %s now valid and being rerun" % tid)
>              self.sqdone = False
>              update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
>  
> 

