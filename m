Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8A9227FED2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jan 2020 19:10:49 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id z26so9934357lfg.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jan 2020 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dd2Ecp8uiTzYtibEJaRXH8EfrkHKqDacvRbz64meeWY=;
	b=ikTs/xORb2kCsxGrrfkKq73fH0YkcPtq1UnUARBvefbEhtmZRAsv/1kmDRLTk5XRiA
	GEpVYqf+TRC1USvKJ/zze8MEC2RLuV/OZIsSfjuo+nru20BIPhmeSdP0e3V9XrnLxgI1
	TKRMcaqPn3Weh/CvtzVn8WlXVBIj1KKb6hVrfHcoP0g9mb3poUmHHV1X1eAtsloc6ajH
	A2G7Psz2dBP4KDL1G7tnTY0bJ0Pci2D3bcJZhhZQ8ATt4tSl+KvakY5i8UCsLB8rNHrN
	eT93qwfaLeYI4U0RCtc1G4Cy0znnx1CL4yq9jmTpD7blPE4ByrCw9T/wTFKJTNVzEWfy
	4deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dd2Ecp8uiTzYtibEJaRXH8EfrkHKqDacvRbz64meeWY=;
	b=o2I8bdnA9cKw8UN4yLh6s3t8fQAw1pcpTgfT30mA73bc7hSmAiVd5tfX4e8RtZLH5z
	t0ADDVPyzzH2jzeTWVl4ROWlcAWeu3ns7Q1FQalRLcSKITt+bPo9PFZpG/KJtRICSkpU
	JOQHVGx9BCjQLEQtlBR02oLxrlDqWwdzyEOtj+5hIgC73KChYka0igkoCYP2pjP9U650
	Csf2zRx+2EfZpYjyix59IIiI/xQHue4IZkuw5Fy/GEJJ5V0mJSKBhxhvN1QiPyRfZMHE
	qyLIWXchj2etRSk7Bq9AQMlRmRNpbeMEn/ALArVlSqVxhOxZZ6BibsW0KL0IXMy08t5m
	17SQ==
X-Gm-Message-State: APjAAAXEdbmtu3fYqO8kJYtqWieR+3nmCoTZ901il99CNqu1IyeHtSSn
	nbXAYABFr6GpIC5V6VmiT/3wpn5K
X-Google-Smtp-Source: APXvYqweQtuOn8fN/tmvfad+nRciIwKL+cMKDjtE7E1FpOtY9+IIE1IGlhdIh5raI+oRxJ2Vzboq4Q==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr3227007lfl.64.1580238649791;
	Tue, 28 Jan 2020 11:10:49 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
	[37.247.29.68]) by smtp.gmail.com with ESMTPSA id
	v12sm3176676ljc.94.2020.01.28.11.10.48
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 28 Jan 2020 11:10:49 -0800 (PST)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jan 2020 20:10:29 +0100
Message-Id: <20200128191029.33319-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Subject: [PATCH] bitbake-user-manual: immediate-variable-expansion: Correct description
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 28 Jan 2020 19:10:49 -0000
Content-Transfer-Encoding: 8bit

References to undefined variables are preserved as is and do not
expand to nothing as in GNU Make.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 .../bitbake-user-manual-metadata.xml          | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 421364c2..0104b174 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -291,22 +291,10 @@
             <para>
                 The ":=" operator results in a variable's
                 contents being expanded immediately,
-                rather than when the variable is actually used:
-                <literallayout class='monospaced'>
-     T = "123"
-     A := "${B} ${A} test ${T}"
-     T = "456"
-     B = "${T} bval"
-     C = "cval"
-     C := "${C}append"
-                </literallayout>
-                In this example, <filename>A</filename> contains
-                "test 123" because <filename>${B}</filename> and
-                <filename>${A}</filename> at the time of parsing are undefined,
-                which leaves "test 123".
-                And, the variable <filename>C</filename>
-                contains "cvalappend" since <filename>${C}</filename> immediately
-                expands to "cval".
+                rather than when the variable is actually used.
+                In contrast to how GNU Make handles immediate expansion,
+                references to undefined variables are preserved as is,
+                instead of evaluating to nothing.
             </para>
         </section>
 
-- 
2.24.1


