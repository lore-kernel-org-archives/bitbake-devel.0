Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE02E74902
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 18:11:46 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.89577.1696270298309358453
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Oct 2023 11:11:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=nXbPM+BP;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D5CD1C0004;
	Mon,  2 Oct 2023 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696270295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNFar76IYy9FbkNq8/5O2pY8GdrfcWl1G8qfH4bVZE=;
	b=nXbPM+BPu6UqZbCeQlghdr8hKe7D/xh7l6WCFEu09NxOdBF56LA8YMouSGwPgvBiqeZfKJ
	Jqta2ctVoEFUQ9WmNX9STkt0uqgWTbGeSiRx+vmINuwljvHOYJxqfLC203wGGOkGeLC5FT
	IxhMDG+TKMmoE4M44JOkSc0Yf2++dteO//ZK42hVqFJwebpeu2330qBA2n77ZJiEr164p1
	4GF2xIviHQUczFZ+9ab/o/pSU3PtRDplsFuvU2U3VLzXMhnGBa8EvB3YV5r2/kMsZJH2lA
	CyNc4yeNlGWsWE4rvr6hDJNVREFcPi6AMZQka1TV6Jl6VzwVtijS08SXz5duCQ==
Date: Mon, 2 Oct 2023 20:11:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Ben Houcine, Karim" <Karim.benhoucine@landisgyr.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>,
	"OTHACEHE, Mathieu (EXT)" <mathieu.othacehe@landisgyr.com>
Subject: Re: [bitbake-devel] [PATCH] hashserv: Fix read-only mode.
Message-ID: <202310021811351b296815@mail.local>
References: <20230929123706.454384-1-karim.benhoucine@landisgyr.com>
 <20230929131447.455388-1-karim.benhoucine@landisgyr.com>
 <20230930104759d2f9fdf1@mail.local>
 <AM7PR01MB70915A545D83DFBBCBFE5B938CC5A@AM7PR01MB7091.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM7PR01MB70915A545D83DFBBCBFE5B938CC5A@AM7PR01MB7091.eurprd01.prod.exchangelabs.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 18:11:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15156

Hi,

On 02/10/2023 11:45:22+0000, Ben Houcine, Karim wrote:
> Hello Alexandre,
> 
> In fact, the proposed fix is expected to fail the test.
> So the test should be modified if the proposed patch is approved.
> 
> When using the readonly server, the client must be notified of the actual unihash, but if the server  rejects the report message it can’t occur.
> So we propose to allow report messages on the readonly server, but to prohibit the modification of the database.
> Meaning that this report message is used to read the unihash but ont to write it, precisely what is expected of a readonly feature.
> 
> 
> I’ll propose a fix of the patch that corrects the test.

Yes, tests need to pass after applying your patch.

> 
> Best regards,
> 
> Karim Ben Houcine
> 
> De : Alexandre Belloni <alexandre.belloni@bootlin.com>
> Envoyé : samedi 30 septembre 2023 12:48
> À : Ben Houcine, Karim <Karim.benhoucine@landisgyr.com>
> Cc : bitbake-devel@lists.openembedded.org
> Objet : Re: [bitbake-devel] [PATCH] hashserv: Fix read-only mode.
> 
> Hello, This causes bitbake selftest failures: https: //urldefense. com/v3/__https: //autobuilder. yoctoproject. org/typhoon/*/builders/79/builds/5830/steps/12/logs/stdio__;Iw!!EEzGOCEfvrF80k8sMoAmtYTD!IUFhiS5Htu4x_xUcJbW2daiPP2vntMXgX5HseX1OyW2wauGwM2hV_LKRlYwRjcJbtp1zrTNhBeADPZSEo5Zp98D0LpthbVPQFPeA$
> ZjQcmQRYFpfptBannerStart
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
> ZjQcmQRYFpfptBannerEnd
> 
> Hello,
> 
> 
> 
> This causes bitbake selftest failures:
> 
> 
> 
> https://urldefense.com/v3/__https://autobuilder.yoctoproject.org/typhoon/*/builders/79/builds/5830/steps/12/logs/stdio__;Iw!!EEzGOCEfvrF80k8sMoAmtYTD!IUFhiS5Htu4x_xUcJbW2daiPP2vntMXgX5HseX1OyW2wauGwM2hV_LKRlYwRjcJbtp1zrTNhBeADPZSEo5Zp98D0LpthbVPQFPeA$<https://urldefense.com/v3/__https:/autobuilder.yoctoproject.org/typhoon/*/builders/79/builds/5830/steps/12/logs/stdio__;Iw!!EEzGOCEfvrF80k8sMoAmtYTD!IUFhiS5Htu4x_xUcJbW2daiPP2vntMXgX5HseX1OyW2wauGwM2hV_LKRlYwRjcJbtp1zrTNhBeADPZSEo5Zp98D0LpthbVPQFPeA$>
> 
> 
> 
> ======================================================================
> 
> FAIL: test_ro_server (hashserv.tests.TestHashEquivalenceTCPServer.test_ro_server)
> 
> ----------------------------------------------------------------------
> 
> Traceback (most recent call last):
> 
>   File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/hashserv/tests.py", line 320, in test_ro_server
> 
>     with self.assertRaises(ConnectionError):
> 
> AssertionError: ConnectionError not raised
> 
> 
> 
> ======================================================================
> 
> FAIL: test_ro_server (hashserv.tests.TestHashEquivalenceUnixServer.test_ro_server)
> 
> ----------------------------------------------------------------------
> 
> Traceback (most recent call last):
> 
>   File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/lib/hashserv/tests.py", line 320, in test_ro_server
> 
>     with self.assertRaises(ConnectionError):
> 
> AssertionError: ConnectionError not raised
> 
> 
> 
> On 29/09/2023 15:14:47+0200, Ben Houcine, Karim wrote:
> 
> > TCP read-only hash equivalence server is not working: the connection is prematurely closed without even notifying the value of the unihash.
> 
> > Expected behaviour is:
> 
> >     1. the client sends a ‘report’ message indicating the 'taskhash', 'method', 'outhash' and a proposed value of 'unihash'.
> 
> >     2.the server sends back the 'taskhash', 'method' and actual value of 'unihash' to use.
> 
> > The problem is that in read-only mode, the server rejects 'report' messages (connexion is closed).
> 
> >
> 
> > The proposed fix consists in enabling ‘report’ messages in read-only mode using a specific handler that doesn’t modify the hash equivalence database.
> 
> >
> 
> > Signed-off-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com<mailto:karim.benhoucine@landisgyr.com>>
> 
> > ---
> 
> >  lib/hashserv/server.py | 55 +++++++++++++++++++++++++++++++++++++++++-
> 
> >  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> >
> 
> > diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> 
> > index d40a2ab8..56d76f1f 100644
> 
> > --- a/lib/hashserv/server.py
> 
> > +++ b/lib/hashserv/server.py
> 
> > @@ -180,7 +180,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
> 
> >              'get-stats': self.handle_get_stats,
> 
> >          })
> 
> >
> 
> > -        if not read_only:
> 
> > +        if read_only:
> 
> > +            self.handlers.update({
> 
> > +                'report': self.handle_readonly_report,
> 
> > +            })
> 
> > +        else:
> 
> >              self.handlers.update({
> 
> >                  'report': self.handle_report,
> 
> >                  'report-equiv': self.handle_equivreport,
> 
> > @@ -453,6 +457,55 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
> 
> >
> 
> >          self.write_message(d)
> 
> >
> 
> > +
> 
> > +    async def handle_readonly_report(self, data):
> 
> > +        with closing(self.db.cursor()) as cursor:
> 
> > +            outhash_data = {
> 
> > +                'method': data['method'],
> 
> > +                'outhash': data['outhash'],
> 
> > +                'taskhash': data['taskhash'],
> 
> > +                'created': datetime.now()
> 
> > +            }
> 
> > +
> 
> > +            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
> 
> > +                if k in data:
> 
> > +                    outhash_data[k] = data[k]
> 
> > +
> 
> > +            # Check if outhash is known
> 
> > +            cursor.execute(
> 
> > +                '''
> 
> > +                SELECT outhashes_v2.taskhash AS taskhash, unihashes_v2.unihash AS unihash FROM outhashes_v2
> 
> > +                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
> 
> > +                -- Select any matching output hash
> 
> > +                WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
> 
> > +                -- Pick the oldest hash
> 
> > +                ORDER BY outhashes_v2.created ASC
> 
> > +                LIMIT 1
> 
> > +                ''',
> 
> > +                {
> 
> > +                    'method': data['method'],
> 
> > +                    'outhash': data['outhash'],
> 
> > +                    'taskhash': data['taskhash'],
> 
> > +                }
> 
> > +            )
> 
> > +            row = cursor.fetchone()
> 
> > +            if row is not None:
> 
> > +                # outhash is known => corrects unihash
> 
> > +                unihash = row['unihash']
> 
> > +            else:
> 
> > +                # outhash is unknown => nothing to do
> 
> > +                unihash = outhash_data['taskhash']
> 
> > +
> 
> > +
> 
> > +            d = {
> 
> > +                'taskhash': data['taskhash'],
> 
> > +                'method': data['method'],
> 
> > +                'unihash': unihash,
> 
> > +            }
> 
> > +
> 
> > +        self.write_message(d)
> 
> > +
> 
> > +
> 
> >      async def handle_equivreport(self, data):
> 
> >          with closing(self.db.cursor()) as cursor:
> 
> >              insert_data = {
> 
> > --
> 
> > 2.25.1
> 
> >
> 
> 
> 
> >
> 
> > 
> 
> >
> 
> 
> 
> 
> 
> --
> 
> Alexandre Belloni, co-owner and COO, Bootlin
> 
> Embedded Linux and Kernel engineering
> 
> https://urldefense.com/v3/__https://bootlin.com__;!!EEzGOCEfvrF80k8sMoAmtYTD!IUFhiS5Htu4x_xUcJbW2daiPP2vntMXgX5HseX1OyW2wauGwM2hV_LKRlYwRjcJbtp1zrTNhBeADPZSEo5Zp98D0Lpthbahu1TC1$<https://urldefense.com/v3/__https:/bootlin.com__;!!EEzGOCEfvrF80k8sMoAmtYTD!IUFhiS5Htu4x_xUcJbW2daiPP2vntMXgX5HseX1OyW2wauGwM2hV_LKRlYwRjcJbtp1zrTNhBeADPZSEo5Zp98D0Lpthbahu1TC1$>
> 
> 
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
> 
> This e-mail (including any attachments) is confidential and may be legally privileged. If you are not an intended recipient or an authorized representative of an intended recipient, you are prohibited from using, copying or distributing the information in this e-mail or its attachments. If you have received this e-mail in error, please notify the sender immediately by return e-mail and delete all copies of this message and any attachments. Thank you.

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15154): https://lists.openembedded.org/g/bitbake-devel/message/15154
> Mute This Topic: https://lists.openembedded.org/mt/101656393/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

