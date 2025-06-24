Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA6C77B7C
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 12:25:28 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.6947.1750767920704579212
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Jun 2025 05:25:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=QK3VTpKu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB08544251;
	Tue, 24 Jun 2025 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750767919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aXdmhqLlbIKH8I3q+gqrUP/AvLhFJRkPswnQ2GT++nE=;
	b=QK3VTpKuHnDtLtRLb0tyYaqRRIKvVuemLomtqdJ+K9+z1Z/s96VBUEJYmTSOGKzU8/RTCq
	FU1HggPPj+VTcGocXzjJ1DgfgpLgU42M07IP4Qs1AfLhO/xGs50K4grsPwEs/lXPfWJ0Gg
	zIn+eOQSD2Icg2K2iq7ZCQ+/LtRIzy+uVoCSyBQ1vjIY6ZabElhy4SHEs5vJ1naEhPkj4N
	7epVH2oKV4EZu6BI2GZ5uFq0baXMHwbsXMxbx4Nq5jiY77vZdiB9MHzjkA94/o+lAB5NoW
	U90MyInKtbfA5RG5LHXqEQ5WKm4D9kXiBeg72skEl7EAEw4y/Nu6+Gl/pNPWTw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 24 Jun 2025 14:25:02 +0200
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: improve
 BB_PRESSURE_* doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-improve-pressure-doc-v1-1-37170e441fc9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAB2ZWmgC/x2MMQqAMAwAvyKZDbShOvgVcRBNNYNtSVAE8e8Wx
 +O4e8BYhQ2G5gHlS0xyquDbBpZ9ThujrJWBHHWup4ByFM0XY1E2O5VxzQsS+0hddMFFDzWtMsr
 9b8fpfT8LNA5FZgAAAA==
X-Change-ID: 20250624-improve-pressure-doc-2e1f25f040f1
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6416;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=tC8MbeZceCMUq9Zt1xwDUCWRGKOOll0bIETF5B6VVwc=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoWpkuuFAP+/j02Vy1t4/UW8T9Xoko+/+R5JO00
 LvxLZc6yYyJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFqZLgAKCRDRgEFAKaOo
 Nn3AD/9hbvOaTrOOI9CMeseHdn7ftHCBeZ2nGnnowe05f/PqsC1exkEJK63H641hD1NKQw0Asvh
 /YWlE3D7C8lI4LUnnOyUqruPZ/aDxTXo9+44mFUdTzIkR1pLb2AtBWp+AeJe8vSWcqaYcRXA4Gw
 +T9Kfb49pooSpaVqUgsXvf9FAukQx7aFHln21VhjPu+Tju5Ai42WZo3Kiq4S1OfsdQ9TqQclpmi
 Md8UxaikrVjXJFat11tusxBtUpS1Ohu+YIWv3hqbemrBQEW77MdXrXOox5WfduJBbt+PQjQvrKe
 Fz4+A1UWg6gwEoB6x9RyOoo83MSqWdDJ1D716/DdTFzKgAm2YAUETYfRXnFtC6oSQJpTgk6kwgT
 dBo6ubH487n9tznelG/xiKCfz2hGVKXmHlUUDqLu9YVftJp73T4cUgHBraz6dBwkalTN4Sxn7oZ
 BIGfMjBvMYl/+40FsLsKxclm/W71Pj8uJRXPOvTxosLODaGcF2PZHAWNMaZttm0FkFoT2DdLd+w
 D8P7A0YDLc2kGA0mNA2PQXrLSZ2ohGMxwuz2MQ9RYzn6VKov0SFb0M3ZK/ok7+pDKFj26JDLpmz
 8tYuaAYXYAU2EdRo5ufyE8i0Biq/Ez+JCJYqoSfSrPrWt3hoDXqp9A+PMbX0BppJyy0VbGdTMwX
 Dcfpn60fCjyDAag==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdegteehlefgheegvddufeevheehveeijedvfeduvdefvdekueduuedvjeelteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpr
 hgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 12:25:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17714

The current default value for BB_PRESSURE_MAX_CPU is 500, which is
really low for most systems. Provide a value of 15000 which limits the
load average without being extremely slow either.

Provide similar values for BB_PRESSURE_MAX_IO and
BB_PRESSURE_MAX_MEMORY. Mention that these should be adjusted depending
on the need, and warn about the potential spam of messages when the
value is too low.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst          | 70 ++++++++++++++++++++--
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 477443e228..f73e96f168 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -533,11 +533,28 @@ overview of their function and contents.
       version 4.20 expose under ``/proc/pressure``. The threshold represents
       the difference in "total" pressure from the previous second. The
       minimum value is 1.0 (extremely slow builds) and the maximum is
-      1000000 (a pressure value unlikely to ever be reached).
+      1000000 (a pressure value unlikely to ever be reached). See
+      https://docs.kernel.org/accounting/psi.html for more information.
 
-      This threshold can be set in ``conf/local.conf`` as::
+      A default value to limit the CPU pressure to be set in ``conf/local.conf``
+      could be::
 
-         BB_PRESSURE_MAX_CPU = "500"
+         BB_PRESSURE_MAX_CPU = "15000"
+
+      Multiple values should be tested on the build host to determine what suits
+      best, depending on the need for performances versus load average during
+      the build.
+
+      .. note::
+
+         You may see numerous messages printed by BitBake in the case the
+         :term:`BB_PRESSURE_MAX_CPU` is too low:
+
+            Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
+
+         This means that the :term:`BB_PRESSURE_MAX_CPU` should be increased to
+         a reasonable value for limiting the CPU pressure on the system.
+         Monitor the varying value after ``IO:`` above to set a sensible value.
 
    :term:`BB_PRESSURE_MAX_IO`
       Specifies a maximum I/O pressure threshold, above which BitBake's
@@ -549,14 +566,34 @@ overview of their function and contents.
       version 4.20 expose under ``/proc/pressure``. The threshold represents
       the difference in "total" pressure from the previous second. The
       minimum value is 1.0 (extremely slow builds) and the maximum is
-      1000000 (a pressure value unlikely to ever be reached).
+      1000000 (a pressure value unlikely to ever be reached). See
+      https://docs.kernel.org/accounting/psi.html for more information.
 
       At this point in time, experiments show that IO pressure tends to
       be short-lived and regulating just the CPU with
       :term:`BB_PRESSURE_MAX_CPU` can help to reduce it.
 
-   :term:`BB_PRESSURE_MAX_MEMORY`
+      A default value to limit the IO pressure to be set in ``conf/local.conf``
+      could be::
+
+         BB_PRESSURE_MAX_IO = "15000"
+
+      Multiple values should be tested on the build host to determine what suits
+      best, depending on the need for performances versus I/O usage during the
+      build.
+
+      .. note::
+
+         You may see numerous messages printed by BitBake in the case the
+         :term:`BB_PRESSURE_MAX_IO` is too low::
 
+            Pressure status changed to CPU: None, IO: True, Mem: False (CPU: 2236.0/None, IO: 153.6/2.0, Mem: 0.0/2.0) - using 19/64 bitbake threads
+
+         This means that the :term:`BB_PRESSURE_MAX_IO` should be increased to
+         a reasonable value for limiting the I/O pressure on the system.
+         Monitor the varying value after ``IO:`` above to set a sensible value.
+
+   :term:`BB_PRESSURE_MAX_MEMORY`
       Specifies a maximum memory pressure threshold, above which BitBake's
       scheduler will not start new tasks (providing there is at least
       one active task). If no value is set, memory pressure is not
@@ -566,7 +603,8 @@ overview of their function and contents.
       version 4.20 expose under ``/proc/pressure``. The threshold represents
       the difference in "total" pressure from the previous second. The
       minimum value is 1.0 (extremely slow builds) and the maximum is
-      1000000 (a pressure value unlikely to ever be reached).
+      1000000 (a pressure value unlikely to ever be reached). See
+      https://docs.kernel.org/accounting/psi.html for more information.
 
       Memory pressure is experienced when time is spent swapping,
       refaulting pages from the page cache or performing direct reclaim.
@@ -574,6 +612,26 @@ overview of their function and contents.
       might be useful as a last resort to prevent OOM errors if they are
       occurring during builds.
 
+      A default value to limit the memory pressure to be set in
+      ``conf/local.conf`` could be::
+
+         BB_PRESSURE_MAX_MEMORY = "15000"
+
+      Multiple values should be tested on the build host to determine what suits
+      best, depending on the need for performances versus memory consumption
+      during the build.
+
+      .. note::
+
+         You may see numerous messages printed by BitBake in the case the
+         :term:`BB_PRESSURE_MAX_MEMORY` is too low::
+
+            Pressure status changed to CPU: None, IO: False, Mem: True (CPU: 29.5/None, IO: 0.0/2.0, Mem: 2553.3/2.0) - using 17/64 bitbake threads
+
+         This means that the :term:`BB_PRESSURE_MAX_MEMORY` should be increased to
+         a reasonable value for limiting the memory pressure on the system.
+         Monitor the varying value after ``Mem:`` above to set a sensible value.
+
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the

---
base-commit: f1175778108a559e1dd0d55cb68f42816c86f393
change-id: 20250624-improve-pressure-doc-2e1f25f040f1

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


