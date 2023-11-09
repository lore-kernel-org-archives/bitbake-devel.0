Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6011EC4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 10:23:24 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.118262.1699525393633876027
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 02:23:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MMIAWS73;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A1DA1C0009;
	Thu,  9 Nov 2023 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699525391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BJElcao1CdCYyFqIO6fwcsYj1cHxv1nl7SszyvEEKM=;
	b=MMIAWS73poavYb/SUi0Cj46DJ/e1wbU4guMx433GSpgEX5sodz5EkJMmsu5Z7MamAumdDp
	vQw4wh0nfGJjGhRuTm8rSXeqDZ09tWPK27xKIl7yh5pQWUKg6en3u2BSG3SgNnGDPpgSlQ
	+qVzAl29N2FT8cpw8isbx3okPlWRXL7BT6iWS2qsSCWu1Jd7hkqPdCEFLsC4o8kXiWDaOt
	xl10X9dISy7lTith+GkcYAsBpem4EYzOWcWTU67i6DqYHwF/iQB9jnk12XpeLUXSB2buSz
	00/NVKmU7hQDWRMOeAQylVIhX+/Le1/fjJYm/Ay16s4ywto2M1BtJ1Qs60pc2A==
Date: Thu, 9 Nov 2023 11:23:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH v6 00/22] Bitbake Hash Server WebSockets,
 Alternate Database Backend, and User Management
Message-ID: <2023110910231011b66424@mail.local>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 10:23:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15456

Hello,

I missed it earlier but I got this:
https://autobuilder.yoctoproject.org/typhoon/#/builders/82/builds/5673/steps/12/logs/stdio

On 03/11/2023 08:26:18-0600, Joshua Watt wrote:
> This patch series reworks the bitbake asyncrpc API to add a WebSockets
> implementation for both the client and server. The hash equivalence
> server is updated to allow using this new API (the PR server can also be
> updated in the future if desired).
> 
> In addition, the database backed for the hash equivalence server is
> abstracted so that sqlalchemy can optionally be used instead of sqlite.
> This allows using "big metal" databases as the backend, which allows the
> hash equivalence server to scale to a large number of queries.
> 
> Note that both websockets and sqlalchemy require 3rd party python
> modules to function. However, these modules are optional unless the user
> desires to use the APIs.
> 
> Also, user management is added. This allows user accounts to be
> registered with the server and users can be given permissions to do
> certain operations on the server. Users are not (necessarily) required
> to login to access the server, as permissions can granted to anonymous
> users. The default permissions will give anonymous users the same
> permissions that they would have before user accounts were added so as
> to retain backward compatibility, but server admins will likely want to
> change this.
> 
> V3: Remove RFC status; patches are ready for review
> V4: Fixed protocol breakage with mixing older and newer clients/servers
> V5: Fixed compatibility with Python 3.8
> V6: Fixed protocol incompatibility when exiting stream state that broke
>     mixing older and new clients/servers
> 
> Joshua Watt (22):
>   asyncrpc: Abstract sockets
>   hashserv: Add websocket connection implementation
>   asyncrpc: Add context manager API
>   hashserv: tests: Add external database tests
>   asyncrpc: Prefix log messages with client info
>   bitbake-hashserv: Allow arguments from environment
>   hashserv: Abstract database
>   hashserv: Add SQLalchemy backend
>   hashserv: Implement read-only version of "report" RPC
>   asyncrpc: Add InvokeError
>   asyncrpc: client: Prevent double closing of loop
>   asyncrpc: client: Add disconnect API
>   hashserv: Add user permissions
>   hashserv: Add become-user API
>   hashserv: Add db-usage API
>   hashserv: Add database column query API
>   hashserv: test: Add bitbake-hashclient tests
>   bitbake-hashclient: Output stats in JSON format
>   bitbake-hashserver: Allow anonymous permissions to be space separated
>   hashserv: tests: Allow authentication for external server tests
>   hashserv: Allow self-service deletion
>   hashserv: server: Add owner if user is logged in
> 
>  bin/bitbake-hashclient        | 145 +++++-
>  bin/bitbake-hashserv          | 132 ++++-
>  lib/bb/asyncrpc/__init__.py   |  33 +-
>  lib/bb/asyncrpc/client.py     | 120 ++---
>  lib/bb/asyncrpc/connection.py | 146 ++++++
>  lib/bb/asyncrpc/exceptions.py |  21 +
>  lib/bb/asyncrpc/serv.py       | 365 ++++++++-----
>  lib/hashserv/__init__.py      | 190 +++----
>  lib/hashserv/client.py        | 147 +++++-
>  lib/hashserv/server.py        | 952 +++++++++++++++++++++-------------
>  lib/hashserv/sqlalchemy.py    | 427 +++++++++++++++
>  lib/hashserv/sqlite.py        | 408 +++++++++++++++
>  lib/hashserv/tests.py         | 736 +++++++++++++++++++++++++-
>  lib/prserv/client.py          |   8 +-
>  lib/prserv/serv.py            |  37 +-
>  15 files changed, 3060 insertions(+), 807 deletions(-)
>  create mode 100644 lib/bb/asyncrpc/connection.py
>  create mode 100644 lib/bb/asyncrpc/exceptions.py
>  create mode 100644 lib/hashserv/sqlalchemy.py
>  create mode 100644 lib/hashserv/sqlite.py
> 
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15421): https://lists.openembedded.org/g/bitbake-devel/message/15421
> Mute This Topic: https://lists.openembedded.org/mt/102364903/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

