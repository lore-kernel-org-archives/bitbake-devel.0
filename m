Return-Path: <denis@denix.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86B1C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 02:16:43 +0000 (UTC)
Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web11.2798.1699064196423802300
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 19:16:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 6DBEF40CDD;
	Sat,  4 Nov 2023 02:16:35 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1R6wTl9M75es; Sat,  4 Nov 2023 02:16:35 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-87-159.washdc.fios.verizon.net [100.15.87.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 4F8B640CD1;
	Sat,  4 Nov 2023 02:16:34 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 32F81163D2B; Fri,  3 Nov 2023 22:16:33 -0400 (EDT)
Date: Fri, 3 Nov 2023 22:16:33 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Steve Sakoman <steve@sakoman.com>
Subject: Re: [bitbake-devel] [kirkstone][PATCH] runqueue: convert deferral
 messages from bb.note to bb.debug
Message-ID: <20231104021633.GP2408@denix.org>
References: <179211EB2D3696F8.3183@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179211EB2D3696F8.3183@lists.openembedded.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Nov 2023 02:16:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15448

Steve,

FYI, sorry I missed copying you initially...


On Fri, Oct 27, 2023 at 08:48:19PM +0000, Denys Dmytriyenko wrote:
> Using multiconfig to target baremetal pieces of the system and building
> corresponding toolchains for them results in hundreds and hundreds of
> "Deferring %s after %s" and "Deferred task %s now buildable".
> 
> To clean up the output and to reduce risk of missing important warnings,
> convert these notice messages to debug messages.
> 
> Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 64bc00a46d1aacc23fe7e8d9a46a126f3a4bc318)
> Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> ---
>  lib/bb/runqueue.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 46ff30a7..8605c46c 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1980,12 +1980,12 @@ class RunQueueExecute:
>                  # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
>                  # We shouldn't allow all to run at once as it is prone to races.
>                  if not found:
> -                    bb.note("Deferred task %s now buildable" % t)
> +                    bb.debug(1, "Deferred task %s now buildable" % t)
>                      del self.sq_deferred[t]
>                      update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
>                      found = t
>                  else:
> -                    bb.note("Deferring %s after %s" % (t, found))
> +                    bb.debug(1, "Deferring %s after %s" % (t, found))
>                      self.sq_deferred[t] = found
>  
>      def task_complete(self, task):
> @@ -2892,7 +2892,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
>                  sqdata.hashes[h] = tid
>              else:
>                  sqrq.sq_deferred[tid] = sqdata.hashes[h]
> -                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
> +                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
>  
>      update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
>  
> -- 
> 2.25.1
> 

