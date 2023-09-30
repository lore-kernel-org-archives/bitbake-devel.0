Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F1E7736D
	for <webhook@archiver.kernel.org>; Sat, 30 Sep 2023 10:48:10 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.38715.1696070882470083586
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Sep 2023 03:48:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=T5aj/IOh;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 324EC40006;
	Sat, 30 Sep 2023 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696070880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NehXmDGci3f33hgmBvgHuKoid3/mEtkCyUYrokGUoJ4=;
	b=T5aj/IOhwAsHLxjHMkZ/QgUDORx2lLObsZeRgQ72L6iiNtUpgyXi8hS69kaOfcdjJjnT5I
	VtzLr14WUwtjkrkagbEkv+6M/bIll04rdOi0kcN5EOWf4/K2sB7tLVE8Ke8QJc3cOLHD0n
	HtlZpClRW7DK38M2qGdbovForbtZscYc8c2QRGWneee3RxwZoKo1d+4Ib/L3UAyGXPZuKW
	TahyMPVGQgUhyLbAraT+QQZkOKkKeaXqqExLEtXOMRboLivHOOiAPTxEERuJlJo0NwYHHT
	xnSucnBnkJ1KiYXkRqbSNtHfh2nUh+8fknW692uqWFYrAsIGaJbdkLH8Le3IFQ==
Date: Sat, 30 Sep 2023 12:47:59 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Ben Houcine, Karim" <Karim.benhoucine@landisgyr.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] hashserv: Fix read-only mode.
Message-ID: <20230930104759d2f9fdf1@mail.local>
References: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
 <20230929131447.455388-1-karim.benhoucine@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929131447.455388-1-karim.benhoucine@landisgyr.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Sep 2023 10:48:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15151

Hello,

This causes bitbake selftest failures:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5830/steps/12/logs/stdio

======================================================================
FAIL: test_ro_server (hashserv.tests.TestHashEquivalenceTCPServer.test_ro_server)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/hashserv/tests.py", line 320, in test_ro_server
    with self.assertRaises(ConnectionError):
AssertionError: ConnectionError not raised

======================================================================
FAIL: test_ro_server (hashserv.tests.TestHashEquivalenceUnixServer.test_ro_server)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/hashserv/tests.py", line 320, in test_ro_server
    with self.assertRaises(ConnectionError):
AssertionError: ConnectionError not raised

On 29/09/2023 15:14:47+0200, Ben Houcine, Karim wrote:
> TCP read-only hash equivalence server is not working: the connection is prematurely closed without even notifying the value of the unihash.
> Expected behaviour is:
>     1. the client sends a ‘report’ message indicating the 'taskhash', 'method', 'outhash' and a proposed value of 'unihash'.
>     2.the server sends back the 'taskhash', 'method' and actual value of 'unihash' to use.
> The problem is that in read-only mode, the server rejects 'report' messages (connexion is closed).
> 
> The proposed fix consists in enabling ‘report’ messages in read-only mode using a specific handler that doesn’t modify the hash equivalence database.
> 
> Signed-off-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
> ---
>  lib/hashserv/server.py | 55 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index d40a2ab8..56d76f1f 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -180,7 +180,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
>              'get-stats': self.handle_get_stats,
>          })
>  
> -        if not read_only:
> +        if read_only:
> +            self.handlers.update({    
> +                'report': self.handle_readonly_report,
> +            })
> +        else:
>              self.handlers.update({
>                  'report': self.handle_report,
>                  'report-equiv': self.handle_equivreport,
> @@ -453,6 +457,55 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
>  
>          self.write_message(d)
>  
> +
> +    async def handle_readonly_report(self, data):
> +        with closing(self.db.cursor()) as cursor:
> +            outhash_data = {
> +                'method': data['method'],
> +                'outhash': data['outhash'],
> +                'taskhash': data['taskhash'],
> +                'created': datetime.now()
> +            }
> +
> +            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
> +                if k in data:
> +                    outhash_data[k] = data[k] 
> +
> +            # Check if outhash is known
> +            cursor.execute(
> +                '''
> +                SELECT outhashes_v2.taskhash AS taskhash, unihashes_v2.unihash AS unihash FROM outhashes_v2
> +                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
> +                -- Select any matching output hash
> +                WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
> +                -- Pick the oldest hash
> +                ORDER BY outhashes_v2.created ASC
> +                LIMIT 1
> +                ''',
> +                {
> +                    'method': data['method'],
> +                    'outhash': data['outhash'],
> +                    'taskhash': data['taskhash'],
> +                }
> +            )
> +            row = cursor.fetchone()
> +            if row is not None: 
> +                # outhash is known => corrects unihash
> +                unihash = row['unihash'] 
> +            else:
> +                # outhash is unknown => nothing to do
> +                unihash = outhash_data['taskhash'] 
> +            
> +
> +            d = {
> +                'taskhash': data['taskhash'],
> +                'method': data['method'],
> +                'unihash': unihash,
> +            }
> +
> +        self.write_message(d)
> +        
> +
>      async def handle_equivreport(self, data):
>          with closing(self.db.cursor()) as cursor:
>              insert_data = {
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15150): https://lists.openembedded.org/g/bitbake-devel/message/15150
> Mute This Topic: https://lists.openembedded.org/mt/101656393/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

