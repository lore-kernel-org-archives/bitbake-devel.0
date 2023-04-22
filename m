Return-Path: <bluelightning@bluelightning.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF93C77B7C
	for <webhook@archiver.kernel.org>; Sat, 22 Apr 2023 03:05:36 +0000 (UTC)
Received: from mail2.g23.pair.com (mail2.g23.pair.com [66.39.132.40])
 by mx.groups.io with SMTP id smtpd.web10.1115.1682132734091310266
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 20:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 66.39.132.40, mailfrom: bluelightning@bluelightning.org)
Received: from mail2.g23.pair.com (localhost [127.0.0.1])
	by mail2.g23.pair.com (Postfix) with ESMTP id 51582E5DEF;
	Fri, 21 Apr 2023 23:05:33 -0400 (EDT)
Received: from linc.fritz.box (unknown [161.29.131.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail2.g23.pair.com (Postfix) with ESMTPSA id 648D1E5DEE;
	Fri, 21 Apr 2023 23:05:32 -0400 (EDT)
From: Paul Eggleton <bluelightning@bluelightning.org>
To: bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: [PATCH 2/3] bitbake-user-manual: add addpylib and BB_GLOBAL_PYMODULES
Date: Sat, 22 Apr 2023 15:05:22 +1200
Message-Id: <577da6f51365daf0f04b21db1914044e617e6c63.1682131637.git.bluelightning@bluelightning.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682131637.git.bluelightning@bluelightning.org>
References: <cover.1682131637.git.bluelightning@bluelightning.org>
MIME-Version: 1.0
X-Scanned-By: mailmunge 3.11 on 66.39.132.40
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Apr 2023 03:05:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14737

New directive and variable for 2.4.

Signed-off-by: Paul Eggleton <bluelightning@bluelightning.org>
---
 .../bitbake-user-manual-metadata.rst           | 18 ++++++++++++++++++
 .../bitbake-user-manual-ref-variables.rst      |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ba8129afab..b35c332c82 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1972,6 +1972,24 @@ looking at the source code of the ``bb`` module, w=
hich is in
 the commonly used functions ``bb.utils.contains()`` and
 ``bb.utils.mkdirhier()``, which come with docstrings.
=20
+Extending Python Library Code
+-----------------------------
+
+If you wish to add your own Python library code (e.g. to provide
+functions/classes you can use from Python functions in the metadata)
+you can do so from any layer using the ``addpylib`` directive.
+This directive is typically added to your layer configuration (
+``conf/layer.conf``) although it will be handled in any ``.conf`` file.
+
+Usage is of the form::
+
+   addpylib <directory> <namespace>
+
+Where <directory> specifies the directory to add to the library path.
+The specified <namespace> is imported automatically, and if the imported
+module specifies an attribute named ``BBIMPORTS``, that list of
+sub-modules is iterated and imported too.
+
 Testing and Debugging BitBake Python code
 -----------------------------------------
=20
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 1cf37d5fcd..fc7cb88238 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -348,6 +348,14 @@ overview of their function and contents.
=20
       For example usage, see :term:`BB_GIT_SHALLOW`.
=20
+   :term:`BB_GLOBAL_PYMODULES`
+      Specifies the list of Python modules to place in the global namesp=
ace.
+      It is intended that only the core layer should set this and it is =
meant
+      to be a very small list, typically just ``os`` and ``sys``.
+      :term:`BB_GLOBAL_PYMODULES` is expected to be set before the first
+      ``addpylib`` directive.
+      See also ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:e=
xtending python library code`".
+
    :term:`BB_HASHCHECK_FUNCTION`
       Specifies the name of the function to call during the "setscene" p=
art
       of the task's execution in order to validate the list of task hash=
es.
--=20
2.34.1


