Return-Path: <jacob.kroon@gmail.com>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6E92060B24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Mar 2020 23:17:51 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id z12so73519wmf.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Mar 2020 16:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=1Elc2j0gbW1pLvK8aGGTum3w+6/1H9iZpaVExfXst10=;
	b=hRtYk/rKEyfnh62hLCaQvWFwuZAS3CYvOBECuIpapd6L8U0IT2cNacL1aRQFT7t1qy
	5r1bWC+G7dTvGq3oIV1sXANskIo6rvm/F50gEmRfx0I0cU2qynwg50g/DjZUHGdgVd1v
	vwfyScchO95pyO+kKNU7a+HtMl1Zhxe7SfbNoz0z3BlM6gmgmsZfRJ0Em/g6FDiPliXR
	e+1VjfYHRLMkRjlxQidj23xyY7kx1/hRgebJanBy9Rbp9gCZd+Ug3U0f356dTysjByL9
	3j4RkpDJcjcz9DvWi5j2Wwqhr46rszKQwYF2CrRmR3ki9liValRyT7jwxzZjSuJdIGfT
	QCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=1Elc2j0gbW1pLvK8aGGTum3w+6/1H9iZpaVExfXst10=;
	b=Nhg+kr22xcrGy2UA6jaSe3JS0RqnJWfXplhqkmlQeVTOmWOB+Y4MX0x9hrxJMaUdvO
	d8NIBPuQ6teuRq+y5qImGkMdPXLzvGVPzgxrypOn9mCfi836b4eRBS/hyOXVMWpR1Kmd
	a9BMb/8oGp8+aoEszCOi+p1roQyWrg17Yjm68RFgKS0kRk9es32RcZxlNxkw40j5rTls
	P4M11dkHcvh+q+Hd+faGMvExMsBLVD/FMQ6PLzZaZ6VOtSRRTvS0eFlxFtgaD/BkNiA3
	EuWZy1GGgxWq5wtF8T4uP2Rrbv6HoilWoY5/yCEVZNsmfBwcJbUp6QPRM4SM1Jkzxkt1
	3MKw==
X-Gm-Message-State: ANhLgQ1UfUDfWIymN4Xa0qLluRu0EoCKnTRVecEjwXAXsvC5jKHeoHB9
	h77GG3O7EP8vGM3lm0vWQVfN/fPS
X-Google-Smtp-Source: ADFU+vshDnZwX047EgAPiY362Y8+8ybRECkc4DjfkvSf6wrsu5vhFDg5voADo/Gi42d6+OBA/Nr7IA==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr98938wmb.58.1584573471743;
	Wed, 18 Mar 2020 16:17:51 -0700 (PDT)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
	[37.247.29.68])
	by smtp.gmail.com with ESMTPSA id l26sm393080wmi.37.2020.03.18.16.17.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Mar 2020 16:17:50 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Mar 2020 00:17:36 +0100
Message-Id: <20200318231737.1169597-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake-user-manual: Fix order of end tags
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
X-List-Received-Date: Wed, 18 Mar 2020 23:17:51 -0000
Content-Transfer-Encoding: 8bit

Fixes commit e22565968828c86983162e67f52ebb106242ca76.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-execution.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 3b31f748..6c5234ed 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -976,7 +976,7 @@
                     <filename>False</filename>, that logger will be completely
                     replaced by user configuration. In this case, no other
                     rules will apply to that logger.
-                </listitem></para>
+                </para></listitem>
                 <listitem><para>
                     All user defined <filename>filter</filename> and
                     <filename>handlers</filename> properties for a given logger
@@ -987,7 +987,7 @@
                     configuration adds a filter called
                     <filename>BitBake.defaultFilter</filename>, both filters
                     will be applied to the logger
-                </listitem></para>
+                </para></listitem>
             </itemizedlist>
         </para>
 
-- 
2.25.1


