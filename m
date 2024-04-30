Return-Path: <dl9pf@gmx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AB9C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 20:31:52 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web11.26341.1714509109748975742
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 13:31:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=dl9pf@gmx.de header.s=s31663417 header.b=fUp2Ill7;
 spf=pass (domain: gmx.de, ip: 212.227.17.22, mailfrom: dl9pf@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714509108; x=1715113908; i=dl9pf@gmx.de;
	bh=fznD6ZawxtlqLbQLMFbE5tl4wjCHppU/QF9xup85eJg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fUp2Ill73e4rkAO0EC+HklxK4mEggYfandd5SztY/VJ0+jIZQTykoTg2s6DKfGw/
	 xBrbe5oGYHStUjt73IqwPq7ZtbefBdi4Se24rhWcRv4Ed+UMxxp5d07NLux6Nw+uI
	 rdkBT9gHLncSTrkyT3KrtwflmdEorq5S5uakzgXIYy3+Y1h7dFXSDMMoVit5yiadM
	 MIGTte6VCwubz+mi7YBLyoOpM8k24MSMlnncn6cboao4RNFQcsqUD++AZMRYm7ix0
	 irwsRIlnsm+N2ai+PpLucVmkPMJAqZ3XcPUxinZ4pRbuCTgb4apHINLzQoHRqqk2m
	 uTallQV7yuBSF+1Svg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from monster.localnet ([77.23.168.18]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6lpG-1s1LNC0URS-008Fl9; Tue, 30
 Apr 2024 22:31:48 +0200
From: Jan-Simon Moeller <dl9pf@gmx.de>
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Subject: 
 Re: [bitbake-devel] [PATCH v6 0/8] prserv: add support for an "upstream"
 server
Date: Tue, 30 Apr 2024 22:31:47 +0200
Message-ID: <5793552.DvuYhMxLoT@monster>
In-Reply-To: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
References: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:QTjQyIppUO0FGkBUKGmlOnrIaw7mpQMWXuSEg7XgiU00HivYgcN
 Kp1SiXhMhrkck3nRypA9E8XW60T6B9pWSfZKWUC+u35w5nSHKi5qLDTc+pLeL4vrKVjnLpe
 GaosJOwHvFBAcE2j1hsao3zPq4N5DS9xA5qVrWCtsfu9CHRmY+2wu7QEWiXtkjlFBSpfSuB
 ixKmx0rWeqKtJGtvkh7Tw==
UI-OutboundReport: notjunk:1;M01:P0:hdbxjIUxKYI=;NX4czcR5L1aB18EEX43eQqA+LQs
 QEC9lnwEBdlz73v8sZk8QfwR0/sd75U4PLqlKDNqbt9sw9O7TTNYMrdwxrZ3NK+k0XDYUjxBM
 Qg3rUWb+fR7J0WVSWY14gD5TjAtrG0tCCHSs/0j30rnvTng+xTo61rrwOdZVma+2V70RLvXr0
 l3jg4qt0FaFyjmK9ffZ2ClHPiHjwOVX3jWDauR3UxE2bOKxweg38+IkE7Ztj5jgUB1l6cfLTP
 bJUW+824BfnGz5Hb2NLEyNIHM7EmEXaazJnYeAhxhUG5HuxCkdqX0qY4qNwXfbDsgtS4NMDSE
 RYftE0STRWb0l+kuN3rAvPdv6IkRexy4pi0sXWLOgXNN1ZlhUyR/ck403qrLv+jDhht4wn0il
 9KD0RCiBl0zWiptBh6V6QIC8f/lOGvM+tTWURFoq+X+diK80AwXODFscEnZBsVFDLAJMW1Iy/
 iARzfQwFVEUEelXsqdkybNO244JCJ9L5JSk24jHR/B2fRHOqYSm6H1eeIw7MDAsOJS87YO0kf
 VlGM4IHDLJy63BnuQaSOhE05bHC9oTAwKSNslJ9WxSfQX5WMUrdMO2gtLVuoZfXvwrowuTnQ6
 0L7SldjK0pBQjM1fwuzYMuoSdWXs5Bryt+UpV4CMvQmtMonGKIOXZSz4JUF8BZ/Ap34bnt6VX
 +SBdQeTwAC36I73XCQrOt0dSL2KjaBbdbIakyyPAHkI4Q9J7iG0TCR9M1FjZ4SFSFzaCmuHZl
 1MfznHEsR9xnkrDqsTzaS5AfqPJRkqliyIrRJcZlGUm//O3bqSpVM05Wz8FR6Q/jcpCvr2kiy
 vSmtRwDHcoRlC/Gz/ckNQHUm7rqUOdu2EVpKtNHrwl9Jk=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 20:31:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16175

Reviewed-by: Jan-Simon M=F6ller <dl9pf@gmx.de>

Am Dienstag, 30. April 2024, 19:15:04 CEST schrieb Michael Opdenacker via=20
lists.openembedded.org:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
> This makes it possible to customize an "upstream" distribution
> by modifying local packages. If the "upstream" package bears
> revision "x", the local one will have revision "x.y", this
> having priority over the upstream one.
>=20
> Multiple levels of upstream servers are supported, so "x.y.z" revisions
> are possible too.
>=20
> This version also supports multiple servers sharing the same database.
>=20
> This also includes BitBake selftests to check the expected
> functionality and detect future regressions.
>=20
> Note that database import and export functions aren't tested yet.
>=20
> ---
>=20
> Changes in V6:
>=20
> - Harden the store_value() code to protect
>   it against storing the same value twice.
>=20
> - Simplify the importone() hook, removing
>   its unnecessary "history" parameter.
>=20
> - This fixes all errors in "oe-selftest -r prservice",
>   once this OE-core patch is merged:
> =20
> https://lore.kernel.org/openembedded-core/20240429194656.655509-1-michael=
=2Eo
> pdenacker@bootlin.com/T/#u
>=20
> - Make tests work in temporary directories.
>   Suggested by Joshua Watt
>=20
> - Remove first version of readonly server tests
>   which depended on the output of a previous test.
>   One implementation of readonly server tests remains.
>=20
> - Merge the upstream and read-only tests so that
>   the read-only test part can reuse the databases
>   and servers from the upstream one. Initially thought
>   that the setUp (and tearDown) hooks were called only
>   once for each test class, instead of for each test.
>   Thanks to Joshua Watt for making me understand this.
>=20
> - Merged two more tests and simplified their naming
>   as, with one exception, the order of tests doesn't
>   matter any more.
>=20
> - Avoid a possible race condition at database
>   creation time. Suggested by Joshua Watt.
>=20
> Changes in V5:
>=20
> - Change the way the database is accessed and modified.
>   As done in the Hash Server code, the database is not
>   accessed through the cursor API.
>=20
>   This makes it possible to have multiple servers accessing
>   the same database, typically one read-write server that
>   is fed by the build machine, and one read-only server that
>   is used to publish PR data to downstream users.
>=20
>   This switched sqlite3 to "WAL" journaling mode, and to
>   "OFF" synchronous mode.
>=20
> - Fix revision ordering issues, now computing the min and max
>   values through dedicated Python functions, instead of letting
>   the database do this with just string comparison, which
>   was wrong in our case. Typically, "1.20" is greater for us
>   than "1.3".
>=20
> - Add BitBake selftests, in particular to make sure revision
>   ordering is correct and the maximum and minimum values are
>   correctly computed.
>=20
> - An issue remains: the BitBake selftests that test database
>   access through a read-only server while a read-write server
>   is still running, still fail, because the database changes
>   are apparently not stored to disk.
>=20
>   FAIL: test_3b_readonly (prserv.tests.PRUpstreamTests)
>=20
> Changes in V4:
>=20
> - Add BitBake selftests for the legacy and new PR server features
>   (database, client, server, support for upstream server, read-only mode,
> "history" and "no history" modes) To run only these tests:
>   bitbake-selftest prserv.tests
>=20
> - Pass the "history" mode through the client requests, instead
>   of storing it (globally) in the database name.
>=20
>   The PR database is now called "PRMAIN" instead of "PRMAIN_nohist".
>   This should cause a regression for builds which already
>   have a PR database.
>=20
> - Fixes for "history" modes:
>   - Allow to store multiple PR values for the same checksum,
>     needed for the "no history" mode.
>   - Make the "history" mode return the minimum stored
>     PR value.
>=20
> - Fixes and code reorganization for issues uncovered by the tests.
>=20
> - Update the server version to "2.0.0"
>=20
> Changes in V3:
>=20
> - Revert the commit removing the so far unused "hist" mode, which
>   we wish to keep for binary reproducibility sake.
>=20
> - Simplification of get_value() function to take
>   both "hist" and "nohist" modes with the same shared code.
>=20
> - Add "history" parameter to the "getPR" request,
>   so that the client can ask for the mode of its choice.
>   This will also make it possible to implement tests
>   for both modes.
>=20
>   Note that more requests ("export", "import"...)
>   will also need a "history" parameter, in a future version,
>   after the first tests are implemented.
>=20
> - Several bug fixes.
>=20
> - Put all the new features at the tip of the branch,
>   to make the cleanup commits easier to merged.
>=20
> Changes in V2:
>=20
> - Add this new commit:
>   prserv: remove unused "hist" mode in the database backend
>=20
> - Squash commit "prserv: fix read_only test" into
>   commit "prserv: simplify the PRServerClient() interface"
>   (Reported by Richard Purdie)
>=20
> - Fix the code to support increasing "x.y.z" values, thus
>   supporting several levels of upstream servers.
>=20
> - db.py: remove duplicate definition of find_max_value() function in db.py
>=20
> - prserv.py: remove tabs before comments (Python didn't complain)
>=20
> - db.py: now stores the revision ("value") as TEXT.
>   This way we can store "1.0" without having it transformed to "1"
>   when the default type was INTEGER.
>=20
> - This allows to fix a regression when the first packages were created
>   with 'r0.1' instead of 'r0.0' initially.
>=20
> - find_max_value: now returns None instead of '0' when no value is found
>   Before we couldn't tell the difference between a '0'
>   max value and the absence of such a value.
>=20
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
>=20
> Michael Opdenacker (8):
>   prserv: declare "max_package_pr" client hook
>   prserv: move code from __init__ to bitbake-prserv
>   prserv: add "upstream" server support
>   prserv: enable database sharing
>   prserv: avoid possible race condition in database code
>   prserv: store_value() improvements
>   prserv: import simplification
>   prserv: add bitbake selftests
>=20
>  bin/bitbake-prserv     |  26 ++-
>  bin/bitbake-selftest   |   2 +
>  lib/prserv/__init__.py |  97 ++++++++-
>  lib/prserv/client.py   |  15 +-
>  lib/prserv/db.py       | 452 ++++++++++++++++++-----------------------
>  lib/prserv/serv.py     | 139 ++++++++++---
>  lib/prserv/tests.py    | 386 +++++++++++++++++++++++++++++++++++
>  7 files changed, 816 insertions(+), 301 deletions(-)
>  create mode 100644 bitbake/lib/prserv/tests.py





