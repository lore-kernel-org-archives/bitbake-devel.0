Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EFC433FE
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 02:14:06 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web08.21884.1647224044035250454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Mar 2022 19:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=P6Q2IENf;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224045; x=1678760045;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MrIrzVqYt7XfYHBi7gKTAKO9IF3ipbxPUhBt3hOoDW0=;
  b=P6Q2IENfCrOBzGTbo6aoybt1owLuB7SlwWup9k+OUeRABcG8N0igrV+j
   Xl8wM7UngK6jS2jE/R52w/21D2A4PNbMZvdElpIOEMxbbDwudOSWLYwnJ
   vXGjN9pA7Oqm58+lXtisKOv3At0MxQue3yVlXrbI8Mfsb8qPw1pTl8EQe
   FUNkA0vBCdDopozKELrEsQl4XVqJf41TLJ4YkgkxcQ74M8NzXIU5F5KBa
   l95+5SQLdiAF5LHYxmvmFxS3T36q0al9mQYN87PUyCnJvbCdoNVon5VtU
   3TfROS5qAdWNHARWPQT0vhUirPC07/d6JVCKkexPmBWoyQY1TqSfKPVrN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342344738"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="342344738"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="818562537"
Received: from lsim7-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.229.232])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:03 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/5] contrib: Fix hash server Dockerfile dependencies
Date: Mon, 14 Mar 2022 10:13:53 +0800
Message-Id: 
 <e5188cb170eb66d244a9b0ad1b9edd5483e6ae4b.1647223687.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647223687.git.anuj.mittal@intel.com>
References: <cover.1647223687.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Mar 2022 02:14:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13477

From: Daniel Gomez <daniel@qtec.com>

When building the Hash Equivalence server Dockerfile, some
dependencies are missing in order to run the hash server properly:

Traceback errors:

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
ModuleNotFoundError: No module named 'bb'

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
  File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
    from bb import fetch2 as fetch
  File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1930, in <module>
    from . import git
  File "/opt/bbhashserv/lib/bb/fetch2/git.py", line 70, in <module>
    import bb.progress
  File "/opt/bbhashserv/lib/bb/progress.py", line 14, in <module>
    import bb.build
  File "/opt/bbhashserv/lib/bb/build.py", line 27, in <module>
    from bb import data, event, utils
  File "/opt/bbhashserv/lib/bb/data.py", line 36, in <module>
    from bb import data_smart
  File "/opt/bbhashserv/lib/bb/data_smart.py", line 23, in <module>
    import bb, bb.codeparser
  File "/opt/bbhashserv/lib/bb/codeparser.py", line 26, in <module>
    import codegen
ModuleNotFoundError: No module named 'codegen'

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
  File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
    from bb import fetch2 as fetch
  File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1930, in <module>
    from . import git
  File "/opt/bbhashserv/lib/bb/fetch2/git.py", line 70, in <module>
    import bb.progress
  File "/opt/bbhashserv/lib/bb/progress.py", line 14, in <module>
    import bb.build
  File "/opt/bbhashserv/lib/bb/build.py", line 27, in <module>
    from bb import data, event, utils
  File "/opt/bbhashserv/lib/bb/data.py", line 36, in <module>
    from bb import data_smart
  File "/opt/bbhashserv/lib/bb/data_smart.py", line 23, in <module>
    import bb, bb.codeparser
  File "/opt/bbhashserv/lib/bb/codeparser.py", line 32, in <module>
    from bb.pysh import pyshyacc, pyshlex
  File "/opt/bbhashserv/lib/bb/pysh/pyshyacc.py", line 13, in <module>
    import bb.pysh.pyshlex as pyshlex
  File "/opt/bbhashserv/lib/bb/pysh/pyshlex.py", line 17, in <module>
    from ply import lex
ModuleNotFoundError: No module named 'ply'

Traceback (most recent call last):
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 61, in <module>
    ret = main()
  File "/opt/bbhashserv/bin/bitbake-hashserv", line 54, in main
    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
  File "/opt/bbhashserv/lib/hashserv/__init__.py", line 120, in create_server
    from . import server
  File "/opt/bbhashserv/lib/hashserv/server.py", line 14, in <module>
    import bb.asyncrpc
  File "/opt/bbhashserv/lib/bb/__init__.py", line 128, in <module>
    from bb import fetch2 as fetch
  File "/opt/bbhashserv/lib/bb/fetch2/__init__.py", line 1935, in <module>
    from . import wget
  File "/opt/bbhashserv/lib/bb/fetch2/wget.py", line 30, in <module>
    from   bs4 import BeautifulSoup
ModuleNotFoundError: No module named 'bs4'

Signed-off-by: Daniel Gomez <daniel@qtec.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0bd637acfcba5a44230c291889d2a5ff571cb8c6)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 contrib/hashserv/Dockerfile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index d6fc728f..74b4a3be 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 #
 # Copyright (c) 2021 Joshua Watt <JPEWhacker@gmail.com>
-# 
+#
 # Dockerfile to build a bitbake hash equivalence server container
 #
 # From the root of the bitbake repository, run:
@@ -15,5 +15,9 @@ RUN apk add --no-cache python3
 
 COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
 COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
+COPY lib/bb /opt/bbhashserv/lib/bb/
+COPY lib/codegen.py /opt/bbhashserv/lib/codegen.py
+COPY lib/ply /opt/bbhashserv/lib/ply/
+COPY lib/bs4 /opt/bbhashserv/lib/bs4/
 
 ENTRYPOINT ["/opt/bbhashserv/bin/bitbake-hashserv"]
-- 
2.35.1


