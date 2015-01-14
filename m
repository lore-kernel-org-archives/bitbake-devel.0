Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
	[209.85.192.181])
	by mail.openembedded.org (Postfix) with ESMTP id BBEC471F1B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 12:46:57 +0000 (UTC)
Received: by mail-pd0-f181.google.com with SMTP id v10so9582359pde.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 04:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=aKL4f2VQY8GyRhzrTksgu18yIb6Ov5hSq55oG+mtR+g=;
	b=RXS6GMGxNvao7WigAlwbuTLoK9rd7EstS4yZkqARcvqf1Cl5+Rffo+LJ88Ep2hrrex
	C7Htkw/IjHWvFuwF+6HdXTo+0hPSb1varli+wOuwQD1igcnhHN8VOLKpBPdyRyENSccn
	3x8wm7tn/z6Z9yfC38C9SN/nY7HRmhsEPoqPxFyYJ1Ng+AxA6uYj8FSOMho6IZ8pAmk/
	bwyCvSL1EIA4RnRbZW88BvxynamIbS7QORf5yNQePfX4eWbJ7+GYiO7o7YmkXO8P8//y
	GL3KFdvq/Sh/JNhCGjDZekA3dZnc4ReV2Zmyk1Q64rjVuTwJtVEen3Ql/iXZWF8Bh2N1
	HTsw==
X-Gm-Message-State: ALoCoQmxXPWfYYAhhedCM/yJQQLfsE9mS5sjjBj2UQnATzUM0lhhcq9Iz8EkA0cDf1CqeAFj+5ah
X-Received: by 10.68.69.106 with SMTP id d10mr5529674pbu.60.1421239618444;
	Wed, 14 Jan 2015 04:46:58 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id i5sm19884296pat.6.2015.01.14.04.46.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Jan 2015 04:46:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F0FC0562267; Wed, 14 Jan 2015 12:46:56 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jan 2015 12:46:55 +0000
Message-Id: <b0699643d83120262896a980d69dc99bb64475a6.1421239131.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
References: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421239131.git.alexandru.damian@intel.com>
References: <cover.1421239131.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/4] toasterui: fix variable data error
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
X-List-Received-Date: Wed, 14 Jan 2015 12:47:01 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

A bug slipped in the toaster ui that prevented saving of
build configuration despite the data being retrieved
from the server. This patch fixes the shaming mistake.

[YOCTO #7117]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index f825b57..9e801ac 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -757,7 +757,7 @@ class BuildInfoHelper(object):
 
         # Save build configuration
         data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
-        self.orm_wrapper.save_build_variables(build_obj, [])
+        self.orm_wrapper.save_build_variables(build_obj, data)
 
         return self.brbe
 
-- 
1.9.1


