Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB93C369CF
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 15:16:01 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.14186.1744989353813309719
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Apr 2025 08:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U5hq/zZe;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5491743AD0;
	Fri, 18 Apr 2025 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744989352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ3gN2MlpUb2opCLoEply5GwxB2YdzZ7rcm0UjPfwCE=;
	b=U5hq/zZe8PXtYh4W09n7pVfzN7Q5vtU/4YKWw1H/F56l8hJ3SjErKami6a2F/BCUdUe9tI
	4w9cMpXPq/rZQ0Rh30bh5ZuDAz+C0wL8t0AD/+dhyoEVzPVE7VpzLPs5jeYOLMJbH9aYGl
	+MJwU69hKJ6IKY5P6JrP6VkGa01dwwX3eVBoUloov+no4H4vUgP+SSAOuUhxskClFL8Egh
	lJ2OD+BpJSv9/WfqU0T/pbb5s9uhmCjDPjPFG3JAiJ6+wfEv3Fc7i1Z32CeFC85Kcz2r5h
	e7hhajFFWd4gK9LBr5P0xaMwxbRHxbxzvQRuIRbizMczVzXuwI1ZuuBgfYyMrg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 18 Apr 2025 17:15:26 +0200
Subject: [PATCH 2/4] lib/bb: format and improve logging docstrings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-library-functions-v1-2-3bbb836149d7@bootlin.com>
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
In-Reply-To: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=cyr/JIsfvl2vDq1i34V++RURYpRa0bArcWk/GRvSavA=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoAmymNUt+mz/4fU5R+fIXCffgv/TFRiUxKryXH
 q6a78U8+O2JAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaAJspgAKCRDRgEFAKaOo
 NrnFD/9dkOUEdkAcQ8Dg6R+W5ozeFXodAg4R5vjR665FtRe4+Z9/A3ejtSpwacC6JSkk4hBGbAl
 qaVphvQDSfTaQUdlSXS+QHMeq5iSBxy4MPimBq8AkLKk92Omq/NXV/2eoIiy3s59iupzxBw1Lfd
 LI6pdGd636evTiqlxsQJSW+2H02UPJIJMrV1BHwANFy9H25edVPaSwDmUpxcrgnulK28AringtW
 ydqRskFRxTyx/0gKaQC0EJ9oP2IixrtkATPHPnplGqTuAXlZTpSZP2FtCim/SRoKsi/vBS5tN3h
 Q+I5e8bGhMcJMfhR0rX51/IQsaWV1bTfpGOGPDJtCU1V8ravxpBR7Ft1kiRp+XjfqJCoSDzUVvx
 ychuOLH/dqk3DxFfbX+SaNkd+hmhITXfHQqzqI5dashW5vl37fCuP3gPE6dgTIb/sq877jyPh4w
 k3uyByDche+vDIwfSAU/05X5kVD7sFNBFWGLBay4v3klXooHehVriA0KJf3hcate7jSnnuFHYLU
 XlzBIXbt5Z2SKjLfg4B+bG/r4xjXQkDqQvAQ9Je+EWP/Bj+gSQlqR5VqtHJqFQ4AEXMl1MTpSbS
 DrZQ5FUkYcNnY++niV4JN3aasnmwdQXJfaDGVg4XVZP9qpZtzOxgXj03GY3c7bVmrGuiKh3Ze3G
 dLEIj8czIChhJ9w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedujegtvdemfeekjegrmehfieehmeehvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudejtgdvmeefkeejrgemfheiheemhedvfeehpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhoj
 hgvtghtrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Apr 2025 15:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17534

Format the docstrings of the utils modules to be automatically
documented with the autodoc Sphinx extensions.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/__init__.py | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 566835573..c95c91a4c 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -129,9 +129,25 @@ sys.modules['bb.fetch'] = sys.modules['bb.fetch2']
 
 # Messaging convenience functions
 def plain(*args):
+    """
+    Prints a message at "plain" level (higher level than a ``bb.note()``).
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.plain(''.join(args))
 
 def debug(lvl, *args):
+    """
+    Prints a debug message.
+
+    Arguments:
+
+    -  ``lvl``: debug level. Higher value increases the debug level
+       (determined by ``bitbake -D``).
+    -  ``args``: one or more strings to print.
+    """
     if isinstance(lvl, str):
         mainlogger.warning("Passed invalid debug level '%s' to bb.debug", lvl)
         args = (lvl,) + args
@@ -139,33 +155,81 @@ def debug(lvl, *args):
     mainlogger.bbdebug(lvl, ''.join(args))
 
 def note(*args):
+    """
+    Prints a message at "note" level.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.info(''.join(args))
 
-#
-# A higher prioity note which will show on the console but isn't a warning
-#
-# Something is happening the user should be aware of but they probably did
-# something to make it happen
-#
 def verbnote(*args):
+    """
+    A higher priority note which will show on the console but isn't a warning.
+
+    Use in contexts when something is happening the user should be aware of but
+    they probably did something to make it happen.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.verbnote(''.join(args))
 
 #
 # Warnings - things the user likely needs to pay attention to and fix
 #
 def warn(*args):
+    """
+    Prints a warning message.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.warning(''.join(args))
 
 def warnonce(*args):
+    """
+    Prints a warning message like ``bb.warn()``, but only prints the message
+    once.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.warnonce(''.join(args))
 
 def error(*args, **kwargs):
+    """
+    Prints an error message.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.error(''.join(args), extra=kwargs)
 
 def erroronce(*args):
+    """
+    Prints an error message like ``bb.error()``, but only prints the message
+    once.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.erroronce(''.join(args))
 
 def fatal(*args, **kwargs):
+    """
+    Prints an error message and stops the BitBake execution.
+
+    Arguments:
+
+    -  ``args``: one or more strings to print.
+    """
     mainlogger.critical(''.join(args), extra=kwargs)
     raise BBHandledException()
 

-- 
2.47.0


