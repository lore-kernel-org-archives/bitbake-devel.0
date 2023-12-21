Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD5AC35274
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 04:40:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.45238.1703133634456127358
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Dec 2023 20:40:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=axwiMVAg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0719406ea4=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL4eYlK005257;
	Wed, 20 Dec 2023 20:40:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=MhVx83Oj1pD500fkhdrN7JjPSsOpbSXpWfCL9Rtojvc=; b=
	axwiMVAg+5RPt/pNW13BAcCOg27QeiC28cgSVtJGO0W8WoU129TgcH6Y5N5GQ8xj
	rPFBD6x1q57bBKcjEj59s4zH0o45uFcxd+375n/XfV6x+lOvJTzhd3DczUhtoxWx
	IrZJW41Itg+UCzEL/fo4CfRtn95YdEZu7k6QLQ3qvzb4uZe8sOUHwWuT7q0rhQF1
	9t+MCHhx7SVmshNwjHIetjY6RrSorhkWnCkz8CRfvoqaISuNsQugM4HGDLUZa3bP
	RpgWbN3ke/mp7IgwJV9uTNUDyOyPpZfrjMmdLrBh7tZQpDfl9gqBEZOQwpB8ATks
	CWe6ymSSXNf/TcWvYwLUjw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1c9knd7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 20 Dec 2023 20:40:33 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 20:40:39 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 20:40:39 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] bitbake: event: Improve error message for eventhandler
Date: Wed, 20 Dec 2023 20:40:32 -0800
Message-ID: <2fd4acbc082469c6c665dc5499ea471d9223b42c.1703133461.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703133461.git.liezhi.yang@windriver.com>
References: <cover.1703133461.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XMz0PRqXoArcbmh6Y7tn4xzQz9PhNadC
X-Proofpoint-ORIG-GUID: XMz0PRqXoArcbmh6Y7tn4xzQz9PhNadC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=987 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210031
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Dec 2023 04:40:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15697

From: Robert Yang <liezhi.yang@windriver.com>

* Before the erorr message was:
ERROR: Unable to register event handler 'defaultbase_eventhandler':
  File "/path/to/poky/meta/classes-global/base.bbclass", line 4
    # SPDX-License-Identifier: MIT
           ^^^^^
SyntaxError: invalid syntax

This is hard to debug since the error line number 4 is incorrect, and nothing
is wrong with the code in line 4.

* Now the error message is:
ERROR: Unable to register event handler '/path/to/poky/meta/classes-global/base.bbclass':
  File "defaultbase_eventhandler", line 4
    an error line
       ^^^^^
SyntaxError: invalid syntax

This is much easier to debug.

The filename and code doesn't match since the file usually contains more code
than eventhandler, don't pass filename to compile() can fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/event.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index f8acacd80d1..2fbf1188d45 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -260,15 +260,17 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
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
-                logger.error("Unable to register event handler '%s':\n%s", name,
+                if filename:
+                    err_msg= filename
+                else:
+                    err_msg = name
+                logger.error("Unable to register event handler '%s':\n%s", err_msg,
                              ''.join(traceback.format_exc(limit=0)))
                 _handlers[name] = noop
                 return
-- 
2.42.0


