Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8967EB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 16:49:08 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.16806.1687452538410978196
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jun 2023 09:48:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: theobroma-systems.com, ip: 217.70.183.198, mailfrom: quentin.schulz@theobroma-systems.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF3F1C0004;
	Thu, 22 Jun 2023 16:48:55 +0000 (UTC)
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: bitbake-devel@lists.openembedded.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH] docs: bitbake-user-manual: bitbake-user-manual-hello: add links and highlights for variables
Date: Thu, 22 Jun 2023 18:48:45 +0200
Message-ID: <20230622-typos-202306-v1-1-dce56bcb2f37@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jun 2023 16:49:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14854

Some variables are described in the glossary so add a term role to the
references. For the others, highlight them by surrounding them with
two backticks.

Cc: Quentin Schulz <foss+yocto@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-hello.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index c8251d2a0..654196ca2 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -209,12 +209,12 @@ Following is the complete "Hello World" example.
 
     .. note::
 
-       Without a value for PN , the variables STAMP , T , and B , prevent more
-       than one recipe from working. You can fix this by either setting PN to
+       Without a value for :term:`PN`, the variables :term:`STAMP`, :term:`T`, and :term:`B`, prevent more
+       than one recipe from working. You can fix this by either setting :term:`PN` to
        have a value similar to what OpenEmbedded and BitBake use in the default
-       bitbake.conf file (see previous example). Or, by manually updating each
-       recipe to set PN . You will also need to include PN as part of the STAMP
-       , T , and B variable definitions in the local.conf file.
+       ``bitbake.conf`` file (see previous example). Or, by manually updating each
+       recipe to set :term:`PN`. You will also need to include :term:`PN` as part of the :term:`STAMP`,
+       :term:`T`, and :term:`B` variable definitions in the ``local.conf`` file.
 
     The ``TMPDIR`` variable establishes a directory that BitBake uses
     for build output and intermediate files other than the cached
@@ -319,9 +319,9 @@ Following is the complete "Hello World" example.
 
     .. note::
 
-       We are setting both LAYERSERIES_CORENAMES and LAYERSERIES_COMPAT in this particular case, because we
+       We are setting both ``LAYERSERIES_CORENAMES`` and :term:`LAYERSERIES_COMPAT` in this particular case, because we
        are using bitbake without OpenEmbedded.
-       You should usually just use LAYERSERIES_COMPAT to specify the OE-Core versions for which your layer
+       You should usually just use :term:`LAYERSERIES_COMPAT` to specify the OE-Core versions for which your layer
        is compatible, and add the meta-openembedded layer to your project.
 
     You need to create the recipe file next. Inside your layer at the

---
base-commit: 0556c7bdc82cf665faa141989f2e07dd59517735
change-id: 20230622-typos-202306-00945b0f2a25

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


