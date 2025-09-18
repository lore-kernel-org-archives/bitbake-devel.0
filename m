Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D16CAC59A
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 12:16:53 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.12289.1758197803425685222
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Sep 2025 05:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=UMbkENkK;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6C1674E40D0C;
	Thu, 18 Sep 2025 12:16:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4309B6062C;
	Thu, 18 Sep 2025 12:16:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63EC2102F1D0C;
	Thu, 18 Sep 2025 14:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758197800; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=LydseaT8Cbfcdtki992r2785nx86vuls3q7E4HPhoPg=;
	b=UMbkENkKt9Hfn3PB6zQ3TvXgg3xcnlo4LPlG0jBwzRsDi51jQ0GRyGBe15BmtTuetjUZ9C
	1kkOJyOhRhxEfBxxTFz1dgdpJpEjqOnQOqilkt+cfhgQpilpCJZP6a4ZU60hm0RwBFLlrh
	rs3HVbz40+A8epcsZgQhdoZpbQBjusF/AK3MiRCfg9Qf9eKVWUPovbVon7LbbH/Yn5RQMs
	aeOdjA2EEbUHaVCkjvRTI9AiqPYwkG6G45j3iH8U+WQxafmIINK+si4sdKoiOcvTeyDiWQ
	9JpkbOH9XfMtAR44XjfdWplj3ac4bXj98QDd66pUlYm7eKV6bM/DiVC5UhENMQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 18 Sep 2025 14:16:25 +0200
Subject: [PATCH] doc: extend classes and include/require documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-classes-order-v1-1-3b8b75e9cf10@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABj4y2gC/yXMQQ6CMBBG4auQWdOkNALiVYiL0v7AGANmBg1Jw
 92puvwW7yVSCEPpViQSfFh5XTKqsqAw+2WC4ZhNzrradlVrwtOrQs0qEWLiJXYejXX+OlJuXoK
 R99+vv/+t7+GBsH0ndBwnEyblPXEAAAA=
X-Change-ID: 20250917-classes-order-d4d9ae602a8f
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10195;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=gtdrqzPbKIJUP0zbJtZbsSqK+b4MO4GCS7DP5Q1HLHU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoy/gnLxAlJj4wcaC1DWdLbZQGZXH4QUSCW5eD9
 NZFpALsiTqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMv4JwAKCRDRgEFAKaOo
 NvTcD/9zMouHxjj5lU1N/wN8fL5Fo52KVKtmnFHAOj+wmf318oaLx2SR8KOGYknGdpfXR0utvHL
 261Ir+G3rweNVMn6Kez3PzvQRwYZ1kFYh7X95G+nJFPbjhuuD3RxBPINrab1qDAjN5Q5N3F5jZe
 Xp1fX81Dedkt5nJI4p7o8GTzjjyIJJQwOdpGtZZR2vOpgJWB/A3enZulGaIpYuMbqSB1H2oAgVh
 +XUccrKgSVceN2Eg6NI7GtAHZD5txdsDmmEwuKxhg1+seCk3fT3/lPIyfn38h1PUAekHNsnRBbW
 fmxWfVPSIyk9XqiEm44aQZ0fcvkSZxJE6D5BP+ojzjyIHOTj3UrUaSvYGSXqw7WppeZPsT+UHS/
 A2sMpb3pLOD6Uir2nTfOyOEyuc92eruCc7hnwqoye+dcHNOnR2JoYVXHgsqAN1jswtUDL0qRgDF
 WEw1PNKRZpSrLNJFdgpwZM9ez9dnqQsZ4K8dN1H7htS/XnUkPFjFukMHuHQPa2CMJc3Ffee75vQ
 VpnfyZyM9X5t5B7HM8BXxLFA+OjYyvdl9QaeHfEqcxe8kLiuMgQetUzY8mZxwwGdLqgZ5p4POJK
 c581ijrB0KbZPi+ql/VmzsPphNNkfawp/VPIrmtrCXRL/w9hDgF3Hi0VbwZt9I4D2NTTjQL4h6L
 hEXIe9GDdb8MF0g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Sep 2025 12:16:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18061

The current documentation is lacking details on the different kinds of
directories for putting classes as well as the order in which BitBake
includes files (classes or include files).

This patch does the following changes:

- Mention the missing classes-recipe and classes-global when applicable.
- Add a Class Types section detailed the three different directories for
  putting classes.
- Move the existing section on locating classes/include files below the
  documentation on the different directives (include/require/inherit).
- Extend the documentation on locating files with include/require and
  inherit to give proper examples, hopefully demystifying this
  mechanism a bit.

[YOCTO #15724]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-execution.rst              |  10 +-
 .../bitbake-user-manual-intro.rst                  |  34 ++++--
 .../bitbake-user-manual-metadata.rst               | 116 ++++++++++++++++++---
 3 files changed, 131 insertions(+), 29 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d58fbb32ea..d407f59c0d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -64,11 +64,11 @@ data itself is of various types:
    together.
 
 The ``layer.conf`` files are used to construct key variables such as
-:term:`BBPATH` and :term:`BBFILES`.
-:term:`BBPATH` is used to search for configuration and class files under the
-``conf`` and ``classes`` directories, respectively. :term:`BBFILES` is used
-to locate both recipe and recipe append files (``.bb`` and
-``.bbappend``). If there is no ``bblayers.conf`` file, it is assumed the
+:term:`BBPATH` and :term:`BBFILES`. :term:`BBPATH` is used to search for
+configuration files under the ``conf`` directory and class files under the
+``classes-global``, ``classes-recipe`` and ``classes`` directories.
+:term:`BBFILES` is used to locate both recipe and recipe append files (``.bb``
+and ``.bbappend``). If there is no ``bblayers.conf`` file, it is assumed the
 user has set the :term:`BBPATH` and :term:`BBFILES` directly in the environment.
 
 Next, the ``bitbake.conf`` file is located using the :term:`BBPATH` variable
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index d941e212bf..9837b009ea 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -206,17 +206,33 @@ installing (empty by default) and packaging (empty by default). These
 tasks are often overridden or extended by other classes added during the
 project development process.
 
-.. note::
+Class Types
+~~~~~~~~~~~
+
+BitBake supports class files installed in three different directories:
+
+-  ``classes-global/``: these classes must be inherited globally through the
+   :term:`INHERIT` variable in a :ref:`configuration file
+   <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`.  These
+   classes are included for every recipe being built. For example, you would use
+   the global class named ``myclass`` like so::
+
+      INHERIT += "myclass"
+
+-  ``classes-recipe/``: these classes must be inherited from a recipe using the
+   :ref:`inherit <ref-bitbake-user-manual-metadata-inherit>` directive. They do
+   not support being inherited globally. For example, you would use the recipe
+   class named ``myclass`` like so::
+
+      inherit myclass
 
-   While BitBake comes with just the one ``base.bbclass`` file in the
-   ``classes`` directory, it supports class files also being installed
-   in related directories ``classes-global`` and ``classes-recipe`` and
-   will automatically search all three directories for a selected class
-   file.
+-  ``classes/``: this final directory is meant for classes that can be used in
+   the two contexts explain above. In other words, they can be inherit either
+   globally or in a recipe.
 
-   This means that, in this documentation, when you see a reference to
-   class files being in the ``classes`` directory, you can interpret that
-   as meaning in any one of the above three directories.
+For details on how BitBake locates class files, see the
+:ref:`bitbake-user-manual/bitbake-user-manual-metadata:Locating Class Files`
+section of the Bitbake User Manual.
 
 Layers
 ------
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 9d4f426bf7..4dadf0bc7b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -758,21 +758,6 @@ directives. There is also a higher-level abstraction called
 ``configuration fragments`` that is enabled with ``addfragments``
 directive.
 
-Locating Include and Class Files
---------------------------------
-
-BitBake uses the :term:`BBPATH` variable to locate
-needed include and class files. Additionally, BitBake searches the
-current directory for ``include`` and ``require`` directives.
-
-.. note::
-
-   The BBPATH variable is analogous to the environment variable PATH .
-
-In order for include and class files to be found by BitBake, they need
-to be located in a "classes" subdirectory that can be found in
-:term:`BBPATH`.
-
 .. _ref-bitbake-user-manual-metadata-inherit:
 
 ``inherit`` Directive
@@ -874,6 +859,8 @@ becomes a no-op.
 See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
 ``inherit`` calls to ``inherit_defer``.
 
+.. _ref-include-directive:
+
 ``include`` Directive
 ---------------------
 
@@ -908,6 +895,8 @@ if the file cannot be found.
    If you need to include all matching files, you need to use the
    ``include_all`` directive, explained below.
 
+.. _ref-include-all-directive:
+
 ``include_all`` Directive
 -------------------------
 
@@ -1062,6 +1051,103 @@ bitbake will treat that as direct value assignment in its configuration::
 
   SOMEVARIABLE = "somevalue"
 
+Locating Include Files
+----------------------
+
+BitBake uses the :term:`BBPATH` variable to locate needed include files.
+Additionally, BitBake searches the current directory for :ref:`include
+<ref-include-directive>` and :ref:`require <require-inclusion>` directives.
+
+.. note::
+
+   The BBPATH variable is analogous to the environment variable PATH .
+
+For these two directives, BitBake includes the first file it finds.
+
+.. note::
+
+   It is also possible to include *all* occurences of a file with the same name
+   with the :ref:`include_all <ref-include-all-directive>` directive.
+
+Let's consider the following statement called from a recipe file located in
+``/layers/meta-custom2/recipes-example/example_0.1.bb``::
+
+   require myfile.inc
+
+Where ``myfile.inc`` is located in ``/layers/meta-custom2/recipes-example/``.
+
+And let's assume that the value of :term:`BBPATH` is
+``/layers/meta-custom1:/layers/meta-custom2``. Then BitBake will try to find
+``myfile.inc`` in this order::
+
+   /layers/meta-custom2/recipes-example/example/myfile.inc
+   /layers/meta-custom1/myfile.inc
+   /layers/meta-custom2/myfile.inc
+
+In this case the first path of the list matches and BitBake includes this file
+in ``example_0.1.bb``.
+
+Another common example would be::
+
+   require recipes-other/other/otherfile.inc
+
+Where ``otherfile.inc`` is located in
+``/layers/meta-custom1/recipes-other/other/``.
+
+In this case, the following paths would be searched::
+
+   /layers/meta-custom2/recipes-example/example/recipes-other/other/otherfile.inc
+   /layers/meta-custom1/recipes-other/other/otherfile.inc
+   /layers/meta-custom2/recipes-other/other/otherfile.inc
+
+This time, the second item of this list would be matched.
+
+.. note::
+
+   In the above examples, the exact same search order applies for the
+   :ref:`include <ref-include-directive>` directive.
+
+Locating Class Files
+--------------------
+
+Like include files, class files are located using the :term:`BBPATH` variable.
+The classes can be included in the ``classes-recipe``, ``classes-global`` and
+``classes`` directories, as explained in the
+:ref:`bitbake-user-manual/bitbake-user-manual-intro:Class types` section of the
+Bitbake User Manual. Like for the :ref:`include <ref-include-directive>` and
+:ref:`require <require-inclusion>` directives, BitBake stops and inherits the
+first class that it finds.
+
+For classes inherited with the :ref:`inherit
+<ref-bitbake-user-manual-metadata-inherit>` directive, BitBake will try to
+locate the class under each ``classes-recipe`` directory for each path in
+:term:`BBPATH`, and then do the same for each ``classes`` directory for each
+path in :term:`BBPATH`.
+
+For example, if the value :term:`BBPATH` is
+``/layers/meta-custom1:/layers/meta-custom2`` then the ``hello`` class
+would be searched in this order::
+
+   /layers/meta-custom1/classes-recipe/hello.bbclass
+   /layers/meta-custom2/classes-recipe/hello.bbclass
+   /layers/meta-custom1/classes/hello.bbclass
+   /layers/meta-custom2/classes/hello.bbclass
+
+.. note::
+
+   Note that the order of the list above does not depend on where the class in
+   inherited from.
+
+Likewise, for classes inherited with the :term:`INHERIT` variable, the
+``classes-global`` directory is searched first, and the ``classes`` directory is
+searched second. Taking the above example, this would result in the following
+list::
+
+   /layers/meta-custom1/classes-global/hello.bbclass
+   /layers/meta-custom2/classes-global/hello.bbclass
+   /layers/meta-custom1/classes/hello.bbclass
+   /layers/meta-custom2/classes/hello.bbclass
+
 Functions
 =========
 

---
base-commit: 546b347b4d3d82c01ecc99f45296f66e44638adc
change-id: 20250917-classes-order-d4d9ae602a8f

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


