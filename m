Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2FCF34C7
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:47 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8912.1763564264796495499
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 06:57:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=cQxxecU5;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dvL7fO0RN5rKlxQ4/VE3+8wrI8bW88zZLBmsLNKOvpM=; b=cQxxecU5DjwZ9ksa+Hu0ZnnCtg
	mrbMM+M5jVqUjjouG1QBa1Va+rAgQ2Ffn24RIEVW/mvg6dTe6lY0oemtpEJPS1E1pD66qHnuNaZYh
	/NVZk90fPuhMBlLWnziXLBBAgMLQn6etRh4NfTjnZo42kyExVjAKtJ4xgFp7gLnZJrrn5HDSBMRAV
	PciaI1y1eaMuku/x6AoMg01fysr4p5fPgLcYBn7pdXDvcwTNFl3aBDjjl7FYARegj1PdzZakYP40s
	LxFFhb7lbEVPcaBa7vPYIzk01Z3h7Ao55VudFis9glWWu+iScYHuhsVIGGn7TA67xVwovsJ8y/qdp
	fwSBRYZg==;
Received: from [147.129.179.166] (port=60790 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vLjcq-00000003NnQ-2H1N
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Nov 2025 09:57:43 -0500
Date: Wed, 19 Nov 2025 09:58:19 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: why is "bitbake-setup list" trying to *create* bitbake-builds
 directory?
Message-ID: <42bcc23e-27ae-8bf4-486d-3e552d58c701@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel10.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel10.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel10.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 14:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18458


  i'm confused about why "bitbake-setup list" is not just attempting
to "list" stuff, but is actively creating a "bitbake-builds" directory
in my current location.

  if i have no bitbake-builds in my home directory and i'm *in* that
directory, then:

$ bitbake-setup list
Bitbake-setup is using /home/rpjday/bitbake-builds as top directory
("bitbake-setup settings --help" shows how to change it).


Available configurations:
poky-master     Poky - The Yocto Project testing distribution
configurations and hardware test platforms
oe-nodistro     OpenEmbedded - 'nodistro' basic configuration

Run 'init' with one of the above configuration identifiers to set up a
build.
$

  and suddenly i have a bitbake-builds directory -- that is not at all
intuitive since all i asked for was a "list", i did not ask for
anything to be initialized or created.

  this causes unexpected behaviour if you happen to be in a
non-writable directory, say /etc, and run the same command, which then
blows up since it can't create that directory:

$ bitbake-setup list
Bitbake-setup is using /etc/bitbake-builds as top directory
("bitbake-setup settings --help" shows how to change it).

Traceback (most recent call last):
  File "/home/rpjday/oe/layers/bitbake/bin/bitbake-setup", line 963,
in <module>
    main()
    ~~~~^^
  File "/home/rpjday/oe/layers/bitbake/bin/bitbake-setup", line 955,
in main
    d = init_bb_cache(top_dir, all_settings, args)
  File "/home/rpjday/oe/layers/bitbake/bin/bitbake-setup", line 52, in
init_bb_cache
    bb.fetch.fetcher_init(d)
    ~~~~~~~~~~~~~~~~~~~~~^^^
  File "/home/rpjday/oe/layers/bitbake/lib/bb/fetch2/__init__.py",
line 516, in fetcher_init
    _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
    ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/rpjday/oe/layers/bitbake/lib/bb/cache.py", line 824, in
init_cache
    bb.utils.mkdirhier(cachedir)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/home/rpjday/oe/layers/bitbake/lib/bb/utils.py", line 943, in
mkdirhier
    raise e
  File "/home/rpjday/oe/layers/bitbake/lib/bb/utils.py", line 940, in
mkdirhier
    os.makedirs(directory)
    ~~~~~~~~~~~^^^^^^^^^^^
  File "<frozen os>", line 218, in makedirs
  File "<frozen os>", line 218, in makedirs
  File "<frozen os>", line 228, in makedirs
PermissionError: [Errno 13] Permission denied: '/etc/bitbake-builds'



  that is not intuitive behaviour.

rday

