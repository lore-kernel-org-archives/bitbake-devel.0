Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E6C4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 13:29:30 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.7146.1698845361148370322
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 06:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=T4VS5A4Y;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C0DA1C0005;
	Wed,  1 Nov 2023 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698845358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNcgAJJW38sIHTrltR4G2wB3ZKeNlnuw/3YzMmgLlxI=;
	b=T4VS5A4YQJC8pfC3lVB0caAc5WaGgf6ZD/NBlppDoC0n5J1g+7yZFCUFlq9G6d1aXi1XDv
	wAI6P0WTcAHE7BdTS3AfgrBof4JEX2Qnc7nilzZi4cJOP8YvM2ZLIFx9P9UfU9lUITGqbW
	g26UF26zdVYGKOESfBZQ5w7SqxyNfJEhbPo8UDyCvjD1QYyDGFX1osh+YhTV++cARtP/4Z
	3eafqCIxY+Xsa67U/tZpkFZ7GMpeW1qEbP8dbBgzYTXGFja7LXbQTViP/25Y3pxdvdfCmn
	nLbL7QKQewvR5cb+frmdJ/yqZ65+7AAzWkw0IXZ5aVed1YTnllNNjW/GlmHIgQ==
Date: Wed, 1 Nov 2023 14:29:17 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH v4 00/22] Bitbake Hash Server WebSockets,
 Alternate Database Backend, and User Management
Message-ID: <202311011329176f09d9b3@mail.local>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101131706602cf071@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101131706602cf071@mail.local>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 13:29:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15381

Replying with more failures :( :

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5983/steps/14/logs/stdio

ERROR: PRservice localhost:44747 not available
ERROR: Unable to start PR Server, exiting, check the bitbake-cookerdaemon.log

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5983/steps/11/logs/stdio

WARNING: default:a1 do_packagedata: Error contacting Hash Equivalence Server unix:///tmp/runqueuetesteux28xpz/hashserve.sock: [Errno 104] Connection reset by peer

Error talking to server: [Errno 104] Connection reset by peer
Error talking to server: [Errno 104] Connection reset by peer
Error talking to server: [Errno 104] Connection reset by peer

RecursionError: maximum recursion depth exceeded


https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5933/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5933/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/2357/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/2357/steps/11/logs/stdio



On 01/11/2023 14:17:07+0100, Alexandre Belloni wrote:
> Hello Joshua,
> 
> This is causing warning on the AB:
> 
> WARNING: Error contacting Hash Equivalence Server hashserv.yocto.io:8686: Expecting value: line 1 column 1 (char 0)
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/122/builds/3522/steps/12/logs/warnings
> https://autobuilder.yoctoproject.org/typhoon/#/builders/122/builds/3523/steps/17/logs/warnings
> https://autobuilder.yoctoproject.org/typhoon/#/builders/23/builds/8384/steps/14/logs/warnings
> https://autobuilder.yoctoproject.org/typhoon/#/builders/73/builds/7990/steps/13/logs/warnings
> https://autobuilder.yoctoproject.org/typhoon/#/builders/59/builds/7987/steps/12/logs/warnings
> https://autobuilder.yoctoproject.org/typhoon/#/builders/73/builds/7991/steps/13/logs/warnings
> https://autobuilder.yoctoproject.org/typhoon/#/builders/59/builds/7988/steps/12/logs/warnings
> 
> 
> 
> 
> 
> On 31/10/2023 11:21:16-0600, Joshua Watt wrote:
> > This patch series reworks the bitbake asyncrpc API to add a WebSockets
> > implementation for both the client and server. The hash equivalence
> > server is updated to allow using this new API (the PR server can also be
> > updated in the future if desired).
> > 
> > In addition, the database backed for the hash equivalence server is
> > abstracted so that sqlalchemy can optionally be used instead of sqlite.
> > This allows using "big metal" databases as the backend, which allows the
> > hash equivalence server to scale to a large number of queries.
> > 
> > Note that both websockets and sqlalchemy require 3rd party python
> > modules to function. However, these modules are optional unless the user
> > desires to use the APIs.
> > 
> > Also, user management is added. This allows user accounts to be
> > registered with the server and users can be given permissions to do
> > certain operations on the server. Users are not (necessarily) required
> > to login to access the server, as permissions can granted to anonymous
> > users. The default permissions will give anonymous users the same
> > permissions that they would have before user accounts were added so as
> > to retain backward compatibility, but server admins will likely want to
> > change this.
> > 
> > V3: Remove RFC status; patches are ready for review
> > V4: Fixed protocol breakage with mixing older and newer clients/servers
> > 
> > Joshua Watt (22):
> >   asyncrpc: Abstract sockets
> >   hashserv: Add websocket connection implementation
> >   asyncrpc: Add context manager API
> >   hashserv: tests: Add external database tests
> >   asyncrpc: Prefix log messages with client info
> >   bitbake-hashserv: Allow arguments from environment
> >   hashserv: Abstract database
> >   hashserv: Add SQLalchemy backend
> >   hashserv: Implement read-only version of "report" RPC
> >   asyncrpc: Add InvokeError
> >   asyncrpc: client: Prevent double closing of loop
> >   asyncrpc: client: Add disconnect API
> >   hashserv: Add user permissions
> >   hashserv: Add become-user API
> >   hashserv: Add db-usage API
> >   hashserv: Add database column query API
> >   hashserv: test: Add bitbake-hashclient tests
> >   bitbake-hashclient: Output stats in JSON format
> >   bitbake-hashserver: Allow anonymous permissions to be space separated
> >   hashserv: tests: Allow authentication for external server tests
> >   hashserv: Allow self-service deletion
> >   hashserv: server: Add owner if user is logged in
> > 
> >  bin/bitbake-hashclient        | 145 +++++-
> >  bin/bitbake-hashserv          | 132 ++++-
> >  lib/bb/asyncrpc/__init__.py   |  33 +-
> >  lib/bb/asyncrpc/client.py     | 120 ++---
> >  lib/bb/asyncrpc/connection.py | 146 ++++++
> >  lib/bb/asyncrpc/exceptions.py |  21 +
> >  lib/bb/asyncrpc/serv.py       | 356 ++++++++-----
> >  lib/hashserv/__init__.py      | 190 +++----
> >  lib/hashserv/client.py        | 147 +++++-
> >  lib/hashserv/server.py        | 951 +++++++++++++++++++++-------------
> >  lib/hashserv/sqlalchemy.py    | 427 +++++++++++++++
> >  lib/hashserv/sqlite.py        | 391 ++++++++++++++
> >  lib/hashserv/tests.py         | 736 +++++++++++++++++++++++++-
> >  lib/prserv/client.py          |   8 +-
> >  lib/prserv/serv.py            |  37 +-
> >  15 files changed, 3034 insertions(+), 806 deletions(-)
> >  create mode 100644 lib/bb/asyncrpc/connection.py
> >  create mode 100644 lib/bb/asyncrpc/exceptions.py
> >  create mode 100644 lib/hashserv/sqlalchemy.py
> >  create mode 100644 lib/hashserv/sqlite.py
> > 
> > -- 
> > 2.34.1
> > 
> 
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#15350): https://lists.openembedded.org/g/bitbake-devel/message/15350
> > Mute This Topic: https://lists.openembedded.org/mt/102302326/3617179
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 
> 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

