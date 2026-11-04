Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6703.1793789813559963155
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Nov 2026 02:56:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1p/AcweW;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 75B5FC8F46F;
	Wed,  4 Nov 2026 10:57:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 812E160770;
	Wed,  4 Nov 2026 10:56:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C518103291FC;
	Wed,  4 Nov 2026 11:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g3xNLidjnblnJYyQQHA3rg26g4CcFhSrCT9Kx91iUcE=;
	b=1p/AcweW5rkaxDYj8of+w7W3lErFBj4UzEkF5Y5/zaMVG4cVn7IXwlnXpvXSUb6mQ8g4sD
	Uc5SHRtAxCp1B211dGmiFNHu/3UEnpfrNWwZAm9LrCrstchy2JZQyi5ebGdcbobXfkzwEi
	sNXkcsX3hG1ZlgqdcpvHhr/TyPbGkQsQmJqmfqWIHi5whfjFVP5xXJdkfBXf5XGYf7L/nE
	yf3QXXlV3fsR+Btn3/dMURWGpju343m0A8qxxImoYch+J9UgEYWfCxoh1/Faj6qUKMISmg
	TY6HMPigrxINLDtEeLvdTZm5nJgtyIyZQOwfOXmcYq0dRS/tgdgZvsguGB2GmA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Nov 2026 11:56:39 +0100
Subject: [PATCH 2/2] doc: xref occurrences of datastore to the new term
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-terms-doc-v1-2-0ded0b9e1623@bootlin.com>
References: <20261104-terms-doc-v1-0-0ded0b9e1623@bootlin.com>
In-Reply-To: <20261104-terms-doc-v1-0-0ded0b9e1623@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13425;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=GLQ8LJtTQYqjah4W1lIZMgvgP8nD+u9xkItY1FGxxkU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBq6w9nvmuJkNr32VyElQ9Ppv7oxC16C2ILrAEkH
 f3OnRRQiNuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCausPZwAKCRDRgEFAKaOo
 NhqmD/9JrYE9FiaNxIn0CFV3NrTMXU2ciNXNhjNNzLXunsWqSH2mEJQ8WQyt+U+AfO6gxl5kdv8
 UUHyZT/ogkUJUy8vi5Yqc4/g5Bs7YmJ/dY6zvYuFck8KOHsSHxomDWbtyYpsHIXGsrLbl+z8b8R
 LpwWdSSHQWEnB0rvBnOFsjcllWhQenS8seDsuweAnPB7M9uObQEFHP4po1hCTe+rcgMvTKFUrXo
 y/V2+O0cDcXxWpGO6+x6o+J4xz4zpMHZKNw3lXCEzEKcJPvX2fsQUa1nnISwaYAGHjqfVFHkkWo
 kpw4uAqd/Bwvk79lZfRMw9Ug9kwpyDLNFz9X+cppkdELUtTnDcaoJ0LfFibjnNheJMN8SUvgtei
 aUcTLMY90XsNv5xZBNMctXhUk/DmHADsDz7wDpVA/wVZr36YoHZUlNu6e+FJ4+fi7h+82OmU1ia
 4Ur2etNI0/gPEjVP/rg7CSh4MFsoj0RyBpVqQtqiaNOhtlLaSolG3aX13RGHSdiCz0UQMuvDJzR
 ueF0VKhuFYJu0aO4h+bZ7Jmo1f+xSZ2FXQg9mqJIi/la/AMKEiSGDaI4l3iIixN8R4pPAU06wpX
 iEqn6kTkA/7J+ug8Zc2HT9gP3ezLBcXRUu38xYtQf9Cx1qcIm6JeOEBrCIhkfWuFZDqLTasTeBL
 +tq0QsGBWq7F9lg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 04 Nov 2026 10:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20392

The previous commit added a term to define the datastore, which is
used in many places of the documentation. Cross-reference to this new
term in the documentation.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-execution.rst              |  2 +-
 .../bitbake-user-manual-metadata.rst               | 50 +++++++++++-----------
 .../bitbake-user-manual-ref-variables.rst          | 18 ++++----
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 1638a8f5cc0..95f040e446c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -191,7 +191,7 @@ supports wildcards. An example would be::
 
 BitBake parses each
 recipe and append file located with :term:`BBFILES` and stores the values of
-various variables into the datastore.
+various variables into the :term:`datastore`.
 
 .. note::
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 621aab2535a..27711b2c849 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -633,7 +633,7 @@ variable.
 
    Internally, this is implemented by prepending the task (e.g.
    "task-compile:") to the value of
-   :term:`OVERRIDES` for the local datastore of the
+   :term:`OVERRIDES` for the local :term:`datastore` of the
    ``do_compile`` task.
 
    You can also use this syntax with other combinations (e.g.
@@ -654,7 +654,7 @@ variable.
 Key Expansion
 -------------
 
-Key expansion happens when the BitBake datastore is finalized. To better
+Key expansion happens when the BitBake :term:`datastore` is finalized. To better
 understand this, consider the following example::
 
    A${B} = "X"
@@ -1295,7 +1295,7 @@ An example BitBake function is::
 
 Because the
 Python "bb" and "os" modules are already imported, you do not need to
-import these modules. Also in these types of functions, the datastore
+import these modules. Also in these types of functions, the :term:`datastore`
 ("d") is a global variable and is always automatically available.
 
 .. note::
@@ -1355,7 +1355,7 @@ Here are some things to know about Python functions:
 
 -  Python functions can take parameters.
 
--  The BitBake datastore is not automatically available. Consequently,
+-  The BitBake :term:`datastore` is not automatically available. Consequently,
    you must pass it in as a parameter to the function.
 
 -  The "bb" and "os" Python modules are automatically available. You do
@@ -1684,20 +1684,20 @@ Consequently, if you do want something to get passed into the build task
 environment, you must take these two steps:
 
 #. Tell BitBake to load what you want from the environment into the
-   datastore. You can do so through the
+   :term:`datastore`. You can do so through the
    :term:`BB_ENV_PASSTHROUGH` and
    :term:`BB_ENV_PASSTHROUGH_ADDITIONS` variables. For
    example, assume you want to prevent the build system from accessing
    your ``$HOME/.ccache`` directory. The following command adds the
    the environment variable ``CCACHE_DIR`` to BitBake's passthrough
-   list to allow that variable into the datastore::
+   list to allow that variable into the :term:`datastore`::
 
       export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS CCACHE_DIR"
 
-#. Tell BitBake to export what you have loaded into the datastore to the
+#. Tell BitBake to export what you have loaded into the :term:`datastore` to the
    task environment of every running task. Loading something from the
-   environment into the datastore (previous step) only makes it
-   available in the datastore. To export it to the task environment of
+   environment into the :term:`datastore` (previous step) only makes it
+   available in the :term:`datastore`. To export it to the task environment of
    every running task, use a command similar to the following in your
    local configuration file ``local.conf`` or your distribution
    configuration file::
@@ -1716,9 +1716,9 @@ Sometimes, it is useful to be able to obtain information from the
 original execution environment. BitBake saves a copy of the original
 environment into a special variable named :term:`BB_ORIGENV`.
 
-The :term:`BB_ORIGENV` variable returns a datastore object that can be
-queried using the standard datastore operators such as
-``getVar(, False)``. The datastore object is useful, for example, to
+The :term:`BB_ORIGENV` variable returns a :term:`datastore` object that can be
+queried using the standard :term:`datastore` operators such as
+``getVar(, False)``. The :term:`datastore` object is useful, for example, to
 find the original ``DISPLAY`` variable. Here is an example::
 
    origenv = d.getVar("BB_ORIGENV", False)
@@ -1731,7 +1731,7 @@ Variable Flags
 ==============
 
 Variable flags (varflags) help control a task's functionality and
-dependencies. BitBake reads and writes varflags to the datastore using
+dependencies. BitBake reads and writes varflags to the :term:`datastore` using
 the following command forms::
 
    variable = d.getVarFlags("variable")
@@ -1915,17 +1915,17 @@ set so that the handler only sees the "BuildStarted" and
 event matching the eventmask is triggered. A global variable "e" is
 defined, which represents the current event. With the ``getName(e)``
 method, you can get the name of the triggered event. The global
-datastore is available as "d". In legacy code, you might see "e.data"
-used to get the datastore. However, realize that "e.data" is deprecated
+:term:`datastore` is available as "d". In legacy code, you might see "e.data"
+used to get the :term:`datastore`. However, realize that "e.data" is deprecated
 and you should use "d" going forward.
 
-The context of the datastore is appropriate to the event in question.
+The context of the :term:`datastore` is appropriate to the event in question.
 For example, "BuildStarted" and "BuildCompleted" events run before any
-tasks are executed so would be in the global configuration datastore
+tasks are executed so would be in the global configuration :term:`datastore`
 namespace. No recipe-specific metadata exists in that namespace. The
 "BuildStarted" and "BuildCompleted" events also run in the main
 cooker/server process rather than any worker context. Thus, any changes
-made to the datastore would be seen by other cooker/server events within
+made to the :term:`datastore` would be seen by other cooker/server events within
 the current build but not seen outside of that build or in any worker
 context. Task events run in the actual tasks in question consequently
 have recipe-specific and task-specific contents. These events run in the
@@ -1939,9 +1939,9 @@ might have an interest in viewing:
    consists of ``bitbake.conf``, ``base.bbclass`` and any global
    :term:`INHERIT` statements; has been parsed. You can see multiple such
    events when each of the workers parse the base configuration or if
-   the server changes configuration and reparses. Any given datastore
+   the server changes configuration and reparses. Any given :term:`datastore`
    only has one such event executed against it, however. If
-   :term:`BB_INVALIDCONF` is set in the datastore by the event
+   :term:`BB_INVALIDCONF` is set in the :term:`datastore` by the event
    handler, the configuration is reparsed and a new event triggered,
    allowing the metadata to update configuration.
 
@@ -2183,8 +2183,8 @@ mentions where to find others.
 Functions for Accessing Datastore Variables
 -------------------------------------------
 
-It is often necessary to access variables in the BitBake datastore using
-Python functions. The BitBake datastore has an API that allows you this
+It is often necessary to access variables in the BitBake :term:`datastore` using
+Python functions. The BitBake :term:`datastore` has an API that allows you this
 access. Here is a list of available operations:
 
 .. list-table::
@@ -2205,7 +2205,7 @@ access. Here is a list of available operations:
      - Adds "value" to the start of the variable "X". Acts like
        ``d.setVar("X","value")`` if the variable "X" does not exist.
    * - ``d.delVar("X")``
-     - Deletes the variable "X" from the datastore. Does nothing if the variable
+     - Deletes the variable "X" from the :term:`datastore`. Does nothing if the variable
        "X" does not exist.
    * - ``d.renameVar("X", "Y")``
      - Renames the variable "X" to "Y". Does nothing if the variable "X" does
@@ -2223,7 +2223,7 @@ access. Here is a list of available operations:
      - Prepends "value" to the named flag on the variable "X". Acts like
        ``d.setVarFlag("X", flag, "value")`` if the named flag does not exist.
    * - ``d.delVarFlag("X", flag)``
-     - Deletes the named flag on the variable "X" from the datastore.
+     - Deletes the named flag on the variable "X" from the :term:`datastore`.
    * - ``d.setVarFlags("X", flagsdict)``
      - Sets the flags specified in the ``flagsdict()``
        parameter. ``setVarFlags`` does not clear previous flags. Think of this
@@ -2268,7 +2268,7 @@ Testing and Debugging BitBake Python code
 -----------------------------------------
 
 The OpenEmbedded build system implements a convenient ``pydevshell`` target which
-you can use to access the BitBake datastore and experiment with your own Python
+you can use to access the BitBake :term:`datastore` and experiment with your own Python
 code. See :yocto_docs:`Using a Python Development Shell
 </dev-manual/python-development-shell.html#using-a-python-development-shell>` in the Yocto
 Project manual for details.
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index fd75275bb41..0e889ea330e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -294,7 +294,7 @@ overview of their function and contents.
 
    :term:`BB_ENV_PASSTHROUGH`
       Specifies the internal list of variables to allow through from
-      the external environment into BitBake's datastore. If the value of
+      the external environment into BitBake's :term:`datastore`. If the value of
       this variable is not specified (which is the default), the following
       list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`, and
       :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
@@ -306,7 +306,7 @@ overview of their function and contents.
 
    :term:`BB_ENV_PASSTHROUGH_ADDITIONS`
       Specifies an additional set of variables to allow through from the
-      external environment into BitBake's datastore. This list of variables
+      external environment into BitBake's :term:`datastore`. This list of variables
       are on top of the internal list set in
       :term:`BB_ENV_PASSTHROUGH`.
 
@@ -458,7 +458,7 @@ overview of their function and contents.
       which is used to determine if the cache can be reused.
 
       One of the ways BitBake determines whether to re-parse the main
-      metadata is through checksums of the variables in the datastore of
+      metadata is through checksums of the variables in the :term:`datastore` of
       the base configuration data. There are variables that you typically
       want to exclude when checking whether or not to re-parse and thus
       rebuild the cache. As an example, you would usually exclude ``TIME``
@@ -594,16 +594,16 @@ overview of their function and contents.
       Contains a copy of the original external environment in which BitBake
       was run. The copy is taken before any variable values configured to
       pass through from the external environment are filtered into BitBake's
-      datastore.
+      :term:`datastore`.
 
       .. note::
 
-         The contents of this variable is a datastore object that can be
-         queried using the normal datastore operations.
+         The contents of this variable is a :term:`datastore` object that can be
+         queried using the normal :term:`datastore` operations.
 
    :term:`BB_PRESERVE_ENV`
       Disables environment filtering and instead allows all variables through
-      from the external environment into BitBake's datastore.
+      from the external environment into BitBake's :term:`datastore`.
 
       .. note::
 
@@ -780,8 +780,8 @@ overview of their function and contents.
 
    :term:`BB_SIGNATURE_EXCLUDE_FLAGS`
       Lists variable flags (varflags) that can be safely excluded from
-      checksum and dependency data for keys in the datastore. When
-      generating checksum or dependency data for keys in the datastore, the
+      checksum and dependency data for keys in the :term:`datastore`. When
+      generating checksum or dependency data for keys in the :term:`datastore`, the
       flags set against that key are normally included in the checksum.
 
       For more information on varflags, see the

-- 
2.55.0

