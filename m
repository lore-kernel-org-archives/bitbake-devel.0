Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA13C46CD4
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 15:11:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.82628.1703603484402369371
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Dec 2023 07:11:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pr/8P+dC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=072481253f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQEwVpN031514
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 07:11:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=bszbiN/+qziIo7A4zqLsPfjtJhGHMwjt7zYmH88kqP8=; b=
	pr/8P+dCwM3qxjbIIxcQ5Ci7XhgYuiq3ipLDDOZAmqFr4i1dfASvo/g7bAStyprA
	ZMULAk8IkgNtM77vLYLK5pP62PJKKSo3yW/DVpilb98U/fKZJTmCF7bm4y9BMt8G
	bTzsblOxrZEsrKu7cGAy+JQ92Tx4wixwW6XsWa+AHQgmGbrRE62/0GnyoZ8nyn3v
	Y499qSNy8K9Jgxy9p09/o4Iw3T+EcMEg4nwLfGfKZFYrJ7iMjESHGT1paTnz/1cY
	s+d1HvdHtJx7XUwp1bHjcKx9cSJFhRvBAMBOr9Ory8IcNqesFEVYBoY23MbpCWLA
	unEKMGK1YVOopSUa87KlIw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5yxm23wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 07:11:23 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 07:11:27 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 07:11:27 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 1/1] bitbake: event: Improve error message for eventhandler
Date: Tue, 26 Dec 2023 07:11:23 -0800
Message-ID: <fc7836bc2ab8d8eded60098081d74d427091ad74.1703602054.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703602054.git.liezhi.yang@windriver.com>
References: <cover.1703602054.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UlB9ksXVVHu3-4ktSNLDNtwcrgIgp16U
X-Proofpoint-ORIG-GUID: UlB9ksXVVHu3-4ktSNLDNtwcrgIgp16U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=990
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260115
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 15:11:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15703

From: Robert Yang <liezhi.yang@windriver.com>

* In python 3.10.9, the error message was:
  ERROR: Unable to register event handler 'defaultbase_eventhandler':
    File "/path/to/poky/meta/classes-global/base.bbclass", line 4
      # SPDX-License-Identifier: MIT
             ^^^^^
  SyntaxError: invalid syntax

  This is hard to debug since the error line number 4 is incorrect, but nothing
  is wrong with the code in line 4.

* In python 3.8.10, the error message was:
  ERROR: Unable to register event handler 'defaultbase_eventhandler':
    File "/path/to/poky/meta/classes-global/base.bbclass", line 4
      an error line
         ^
  SyntaxError: invalid syntax

* Now the error message and lineno is correct:
  ERROR: Unable to register event handler 'defaultbase_eventhandler':
  File "/path/to/poky/meta/classes-global/base.bbclass", line 256
      an error line
         ^^^^^
  SyntaxError: invalid syntax

* Fixed it via:
- Don't pass filename to compile() to make it can report error code correctly
  in both python 3.8.10 and 3.10.9.

- Fix the lineno offset and filename in traceback message.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/event.py | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index f8acacd80d1..9eecb141379 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -260,16 +260,29 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
             try:
                 code = bb.methodpool.compile_cache(tmp)
                 if not code:
-                    if filename is None:
-                        filename = "%s(e, d)" % name
-                    code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
+                    code = compile(tmp, name, "exec", ast.PyCF_ONLY_AST)
                     if lineno is not None:
                         ast.increment_lineno(code, lineno-1)
-                    code = compile(code, filename, "exec")
+                    code = compile(code, name, "exec")
                     bb.methodpool.compile_cache_add(tmp, code)
             except SyntaxError:
+                exc_lines = traceback.format_exc(limit=0).splitlines()
+                # Fix lineno offset manually since compile() cannot handle it correctly
+                if filename and lineno:
+                    line_first = exc_lines[0]
+                    if 'File ' in line_first and ' line ' in line_first:
+                        lineno_new = line_first.split(' line ')[-1]
+                        if lineno_new:
+                            lineno_new = int(lineno_new)
+                        lineno_new += lineno - 1
+                        line_first = 'File "%s", line %d' % (filename, lineno_new)
+                        # Fix filename
+                        exc_lines[0] = line_first.replace(name, filename)
+                    else:
+                        logger.warning('Failed to fix lineno for %s:%s' % (filename, name))
+
                 logger.error("Unable to register event handler '%s':\n%s", name,
-                             ''.join(traceback.format_exc(limit=0)))
+                             '\n'.join(exc_lines))
                 _handlers[name] = noop
                 return
             env = {}
-- 
2.42.0


