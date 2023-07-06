Return-Path: <denis@denix.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558AEB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 19:23:32 +0000 (UTC)
Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web11.33721.1688671403672487151
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jul 2023 12:23:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id DB20940C16;
	Thu,  6 Jul 2023 19:23:22 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIyp1lV7jDZn; Thu,  6 Jul 2023 19:23:22 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-88-116.washdc.fios.verizon.net [100.15.88.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id A7BB440A2F;
	Thu,  6 Jul 2023 19:23:20 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id E2C6E163BEE; Thu,  6 Jul 2023 15:23:19 -0400 (EDT)
Date: Thu, 6 Jul 2023 15:23:19 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Denys Dmytriyenko <denys@konsulko.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: convert deferral messages
 from bb.note to bb.debug
Message-ID: <20230706192319.GF1518@denix.org>
References: <20230705215533.327107-1-denis@denix.org>
 <1b3ad9fe0c72c03275ec31e74bfd32750b6f3d2c.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3ad9fe0c72c03275ec31e74bfd32750b6f3d2c.camel@linuxfoundation.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jul 2023 19:23:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14877

On Thu, Jul 06, 2023 at 09:16:14AM +0100, Richard Purdie wrote:
> On Wed, 2023-07-05 at 21:55 +0000, Denys Dmytriyenko wrote:
> > Using multiconfig to target baremetal pieces of the system and building
> > corresponding toolchains for them results in hundreds and hundreds of
> > "Deferring %s after %s" and "Deferred task %s now buildable".
> > 
> > To clean up the output and to reduce risk of missing important warnings,
> > convert these notice messages to debug messages.
> > 
> > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
> > ---
> >  lib/bb/runqueue.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > index 241a746e..a5164c9e 100644
> > --- a/lib/bb/runqueue.py
> > +++ b/lib/bb/runqueue.py
> > @@ -1997,12 +1997,12 @@ class RunQueueExecute:
> >                  # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
> >                  # We shouldn't allow all to run at once as it is prone to races.
> >                  if not found:
> > -                    bb.note("Deferred task %s now buildable" % t)
> > +                    bb.debug(1, "Deferred task %s now buildable" % t)
> >                      del self.sq_deferred[t]
> >                      update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
> >                      found = t
> >                  else:
> > -                    bb.note("Deferring %s after %s" % (t, found))
> > +                    bb.debug(1, "Deferring %s after %s" % (t, found))
> >                      self.sq_deferred[t] = found
> >  
> >      def task_complete(self, task):
> > @@ -2940,7 +2940,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
> >                  sqdata.hashes[h] = tid
> >              else:
> >                  sqrq.sq_deferred[tid] = sqdata.hashes[h]
> > -                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
> > +                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
> >  
> >      update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
> >  
> 
> You realise that we've had a long standing bug in this code, which you
> have run into and asked me about fixing. The only reason we were able
> to fix it is due to these kinds of debug messages? Hiding them isn't
> going to make that any easier in future :(.

Hey, you should be off this week! That means no mailing lists either :)

Seriously though, I do realize the irony here - on one hand, I really 
appreciate you finally being able to root cause and fix this long standing 
issue with the help of those debug messages, thank you! But on the other 
hand, there were already a lot of "Deferring %s after %s" messages before, 
and now the amount has doubled with "Deferred task %s now buildable" being 
added, resulting in a very clutterred output. Not every scrollback buffer 
can hold them, easily losing early parse warnings.

Yes, these messages are very useful for debugging purposes and I'm not 
suggesting to remove or hide them, simply redirect them to the debug output 
instead of default stdout, just a -D flag away. But since it's a cosmetic 
change and if you feel strongly against it, that should be fine too.

-- 
Denys

