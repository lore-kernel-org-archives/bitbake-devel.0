Return-Path: <trevor.woerner@linaro.org>
Received: from mail-oa0-f50.google.com (mail-oa0-f50.google.com
	[209.85.219.50])
	by mail.openembedded.org (Postfix) with ESMTP id 3C4886F7E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 17:01:06 +0000 (UTC)
Received: by mail-oa0-f50.google.com with SMTP id i7so4774095oag.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 10:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qcCR/C6rsDbgX1DOQMaDom3IppfIhGSFet1KT8/+5bs=;
	b=kHne99H9Tl4U+jmAK69NfC5755O9dPVcN0y1e8YIG1kUIWpO9ib34cB2InauMRnpde
	t4WjBb4QfyMawDzS/vngD4NjBDJ/cwIBKex9Z+Lr7lXddWCG0iKGtG6JMzHT0xFpKZdB
	Etj1hfNfKghJUDzho/l9/FcP8UAzrJSyJs6earDo5gR5lF/6Y2WPKJg+/U/gkCks0IsB
	MRBMOzXymJZ4dyF3B3M38RuGSKB1BSMXIc5SdAOY5dwzZEBuPshm0lr+s+nGFpMNwv3P
	nBJ7Tu8NLoBoqSBFw0pA/z2kf+rxaxjxgG8/UrDwGZsxB0PNzFK2Oo8Y4k1mmw0By2a4
	ai5g==
X-Gm-Message-State: ALoCoQniip8nBzYQ5z1Gp0I8kT0Oo1WEpSZ+L+wcqUW0fd+P3+J6JgElg7RYK8sNop/vuYwjpxl0
X-Received: by 10.182.117.195 with SMTP id kg3mr2315016obb.17.1395939667316;
	Thu, 27 Mar 2014 10:01:07 -0700 (PDT)
Received: from openSUSE-i7.site (69-165-220-158.dsl.teksavvy.com.
	[69.165.220.158])
	by mx.google.com with ESMTPSA id x3sm10448801oek.3.2014.03.27.10.01.06
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Mar 2014 10:01:06 -0700 (PDT)
From: Trevor Woerner <trevor.woerner@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 13:00:51 -0400
Message-Id: <1395939651-31508-1-git-send-email-trevor.woerner@linaro.org>
X-Mailer: git-send-email 1.9.0
Cc: patches@linaro.org
Subject: [PATCH] .gitignore: update documentation directory name
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
X-List-Received-Date: Thu, 27 Mar 2014 17:01:09 -0000

In the yocto-docs repository, the documentation is stored in a directory
called "documentation". In this repository the documentation is stored in
"doc".

This update allows git to properly ignore generated documentation.

Signed-off-by: Trevor Woerner <trevor.woerner@linaro.org>
---
 .gitignore | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index d64f6f8..ba767de 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,6 +7,6 @@ pyshtables.py
 /bin/bitbakec
 *.swp
 tags
-documentation/user-manual/user-manual.html
-documentation/user-manual/user-manual.pdf
-documentation/user-manual/user-manual.tgz
+doc/user-manual/user-manual.html
+doc/user-manual/user-manual.pdf
+doc/user-manual/user-manual.tgz
-- 
1.9.0


