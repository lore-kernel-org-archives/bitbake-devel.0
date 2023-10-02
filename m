Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98019E74911
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 18:46:26 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.90721.1696272381573294560
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Oct 2023 11:46:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=g8TDEyh4;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A8B21BF204;
	Mon,  2 Oct 2023 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696272379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ycMjqmZLLC9FHY02aabedQuzWzJhoO9uaBrmXdpXDI=;
	b=g8TDEyh4cDEpObLZITfjA7700BQBpuQQt1miajbzVSnL9qmRK0eHOR3ArGWcDZeWCsJ1E3
	wku5AbURP6XEpT3ODDSoxcjWH1d54k6lWzy1Ex7CfBPLodYwE2/FtNxHXU/8pJY9Agpmz9
	iB8tknAhv1yNlFSquvGZEy0Ammuyd3d12nJb73QbFNDhMdMwFlkj5ub1znvaZY0s7vK5QI
	LUQhjrDdEAmZGS9em2E2D/Jj51bS98ZlklNdCJpjvBodY9nbievFijnCeZJsIEtrYuuI1/
	oyemB+NrCVBy1pFvvwcd1L0jGzo10wwqOouN/8ne2molWBgKzZvKOpvpPQTOTg==
Date: Mon, 2 Oct 2023 20:46:19 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Ben Houcine, Karim" <Karim.benhoucine@landisgyr.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] hashserv: Fix read-only mode
Message-ID: <2023100218461936c48f03@mail.local>
References: <178A47C70519CAC1.9230@lists.openembedded.org>
 <20231002115641.1717054-1-karim.benhoucine@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002115641.1717054-1-karim.benhoucine@landisgyr.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 18:46:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15157

Hello,

This doesn't apply on bitbake master, can you rebase and fix?

On 02/10/2023 13:56:41+0200, Ben Houcine, Karim wrote:
> TCP read-only hash equivalence server is not working: the connection is prematurely closed without even notifying the value of the unihash.
> Expected behaviour is:
>     1. the client sends a ‘report’ message indicating the 'taskhash', 'method', 'outhash' and a proposed value of 'unihash'.
>     2.the server sends back the 'taskhash', 'method' and actual value of 'unihash' to use.
> The problem is that in read-only mode, the server rejects 'report' messages (connexion is closed).
> hashserv.tests.TestHashEquivalenceUnixServer.test_ro_server test modified accordingly
> 
> Signed-off-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
> ---
>  bitbake/lib/hashserv/server.py | 14 +++++++-------
>  bitbake/lib/hashserv/tests.py  |  4 +---
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
> index 56d76f1f81..a12937e25f 100644
> --- a/bitbake/lib/hashserv/server.py
> +++ b/bitbake/lib/hashserv/server.py
> @@ -181,7 +181,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
>          })
>  
>          if read_only:
> -            self.handlers.update({    
> +            self.handlers.update({
>                  'report': self.handle_readonly_report,
>              })
>          else:
> @@ -469,7 +469,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
>  
>              for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
>                  if k in data:
> -                    outhash_data[k] = data[k] 
> +                    outhash_data[k] = data[k]
>  
>              # Check if outhash is known
>              cursor.execute(
> @@ -489,13 +489,13 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
>                  }
>              )
>              row = cursor.fetchone()
> -            if row is not None: 
> +            if row is not None:
>                  # outhash is known => corrects unihash
> -                unihash = row['unihash'] 
> +                unihash = row['unihash']
>              else:
>                  # outhash is unknown => nothing to do
> -                unihash = outhash_data['taskhash'] 
> -            
> +                unihash = outhash_data['taskhash']
> +
>  
>              d = {
>                  'taskhash': data['taskhash'],
> @@ -504,7 +504,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
>              }
>  
>          self.write_message(d)
> -        
> +
>  
>      async def handle_equivreport(self, data):
>          with closing(self.db.cursor()) as cursor:
> diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
> index 8d997c1ae4..5bf8809214 100644
> --- a/bitbake/lib/hashserv/tests.py
> +++ b/bitbake/lib/hashserv/tests.py
> @@ -312,13 +312,11 @@ class HashEquivalenceCommonTests(object):
>          # Check the hash via the read-only server
>          self.assertClientGetHash(ro_client, taskhash, unihash)
>  
> -        # Karim removed : # Ensure that reporting via the read-only server fails
> -        # Karim added : # Ensure that reporting via the read-only server doesn't modify the database
> +        # Ensure that reporting via the read-only server doesn't modify the database
>          taskhash2 = 'c665584ee6817aa99edfc77a44dd853828279370'
>          outhash2 = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
>          unihash2 = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
>  
> -        # Karim removed : with self.assertRaises(ConnectionError):
>          ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
>  
>          # Ensure that the database was not modified
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15155): https://lists.openembedded.org/g/bitbake-devel/message/15155
> Mute This Topic: https://lists.openembedded.org/mt/101709922/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

