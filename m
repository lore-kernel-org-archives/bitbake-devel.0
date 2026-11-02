Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12221.1793625883111836481
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2026 05:24:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2bDNR9LI;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E5F381A1410;
	Mon,  2 Nov 2026 13:24:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B43EB60750;
	Mon,  2 Nov 2026 13:24:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3024F1032909D;
	Mon,  2 Nov 2026 14:24:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793625880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4AmrTwpfCW+IJ2r1D8GtKDbdZOa/dYIhuXt2oUX1s3w=;
	b=2bDNR9LIRJGeWTVOgXLNqMyXiK8cTScHKFelOz0YrYNOoi9LS4y/jnlxRQpHads3XukNeK
	8sfiFmPCI+JK5qYI/6xfzKogAlCAc4XsNe33L41RSJ4SuH4iWnNcQdwvB0tLr16UK83dUN
	rT31RZbi8fhaZRM37JHJtYbho/aGa/4YLm+inGotxNT8iJMIiZ+6g9SbDjeQmgKMZjVBOl
	RnbVGrmIF+6/fhkLLM5sNORU/sUpoXWS+DKzAGRaBP81v4C1oq6pzcBRQ7owyOQPejDKbs
	MMD3PYNXjIk58yvzjzvG3t7Del1gremca4Eux60A3uacuhsLcSJzadrbgg2MWg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 02 Nov 2026 14:24:35 +0100
Subject: [PATCH] doc/bitbake-user-manual-library-functions.rst: document
 public API bb.build functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-doc-bb-build-funcs-v1-1-5bc87caa6505@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORvYquuoryIeTJptEemkWUUYe
 3erHr/D/29gklUMzs0GWV5quqSK7tAAz7c0CWqsBtc63wZ3wrgwEiEVfUQcS2LDrvdCgY9DDB5
 q+Mwy6vs3vVz/tkJ34fV7gn3/AMlPI1x2AAAA
X-Change-ID: 20260924-doc-bb-build-funcs-156eb9c37d96
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=9Y+jn9whCzpV77bDUzNzwyPPKpIuQILeGsBqU4woQ9k=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBq6I8Tvurneu+VEEjeKlouE6WMQcl2DgvzAIdc9
 V4fFptXRoiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCauiPEwAKCRDRgEFAKaOo
 NhqFD/0QvilOH1RZ5y6TNDub3MUiSG1saRlVNdy+goQCR0AScg8ZiS4BG+zlLyslrKJVP999GKJ
 M8+LeJuNX7epB1xMLdql/Y3qca5UM62NHnKNGUdhT2G8jLuke5Rd7afGBSFLW4lbuYOtO4GX1ek
 sZT7h6wEqBkzT7FwSXr5V5wG9mqt3rIeC5m73Y/oBAgtMTL7JCnlcdSZw2fotngTtAeJWGQGRKN
 qppsB2InTnoE2qyTjlxtb3saKRQXoRD1ZKaoIL/QHOjj7EKCExpzdeS9TI9mzjgkDLX5tZ8Vm5F
 loLN8/x3PfQgRcfXicK7TTP1uqIdGMOfHNZUYcAmlrDomSK4quMV4ijCAgc9FBrDZHtOOoLERj9
 /urltD2Ba6I2NsizMRdrEqhqT1pLXA0A639l91GNPxy8/2rb5/SUnlW/wuohLiIM5ok9eBdB0Qg
 hpgdjnxDI6S+AAdWg8s3sUhZ5BYDb3sh7JBVvVDTk4HfYwTeEiN1kj3T4jGopvRbcyWDnR5HDwd
 lqUQ7QWQ9u5ve0z9oFX78trm6MhtaCMd7p3dHIopK90Z9Q8YfQs+/6MjXkaKta1zOcTu6YEJDnX
 kD4Sw98atm1NIctzp6jlnhEyC/PEK7e54iCWEPA5aGs8PKRBNduJxYKcwFm7jXYLDy19WOZ8lo8
 eQpsduMNgWG5bgg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 02 Nov 2026 13:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20389

Document functions in bb.build that are public API using the automodule
Sphinx extension, which generates documentation from docstrings.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
This is limited to those three functions, as Richard those were the only
public ones on IRC:
https://libera.catirclogs.org/yocto/2026-09-24#40518068;
---
 .../bitbake-user-manual-library-functions.rst      |  9 +++++
 lib/bb/build.py                                    | 40 +++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
index 09e353945bb..71fb8eb813e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
@@ -46,6 +46,15 @@ Python f-strings may also be used::
       warn,
       warnonce,
 
+``bb.build``
+============
+
+.. automodule:: bb.build
+   :members:
+      addtask,
+      deltask,
+      exec_func
+
 ``bb.utils``
 ============
 
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 8b49721d60f..b38936fc360 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -183,7 +183,19 @@ class StdoutNoopContextManager:
 
 
 def exec_func(func, d, dirs = None):
-    """Execute a BB 'function'"""
+    """Execute a function or a task.
+
+    Arguments:
+
+    -  ``func``: name of the function/task to execute.
+    -  ``d``: the data store.
+    -  ``dirs``: list of directories to create before executing the task.
+
+    If ``dirs`` is ``None``, this function will look at the value of the ``dirs``
+    varflag defined for ``func`` and create directories using this list instead.
+
+    No return value.
+    """
 
     try:
         oldcwd = os.getcwd()
@@ -938,6 +950,20 @@ def ensure_task_prefix(name):
     return name
 
 def addtask(task, before, after, d):
+    """Adds a task to the task graph. If called from a recipe, the task is added
+    in the scope of the recipe. If called from an :ref:`Anonymous Python function
+    <bitbake-user-manual/bitbake-user-manual-metadata:anonymous python functions>`,
+    the task is added in the global scope, so for each recipe being built.
+
+    Arguments:
+
+    -  ``task``: name of the task to add to the graph.
+    -  ``before``: task to depend on (optional, can be ``None``).
+    -  ``after``: tasks that depend on the task being added (optional, can be ``None``).
+    -  ``d``: the data store.
+
+    No return value.
+    """
     task = ensure_task_prefix(task)
 
     d.setVarFlag(task, "task", 1)
@@ -963,6 +989,18 @@ def addtask(task, before, after, d):
                 d.setVarFlag(entry, "deps", [task] + existing)
 
 def deltask(task, d):
+    """Deletes a task from the task graph. If called from a recipe, the task is
+    removed within the scope of the recipe. If called from an :ref:`Anonymous Python
+    function <bitbake-user-manual/bitbake-user-manual-metadata:anonymous python functions>`,
+    the task is removed globally, so for each recipe being built.
+
+    Arguments:
+
+    -  ``task``: name of the task to add.
+    -  ``d``: the data store.
+
+    No return value.
+    """
     task = ensure_task_prefix(task)
 
     bbtasks = d.getVar('__BBTASKS', False) or []

---
base-commit: 74128534302fbf8164ade07b200b90b731caa0ad
change-id: 20260924-doc-bb-build-funcs-156eb9c37d96

