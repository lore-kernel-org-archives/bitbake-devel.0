Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 720E971188
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:50 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id l18so516177wgh.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=aYK+dJH9blWxh7ZQTByIVdPc6Lj+V19nFZANYHcBZX4=;
	b=I33Nw9RWeEW+pQN/hzgXQvGH60wmZQtJ7ZDAnDFaYtW7jwMuGflv+KWh7Gv6HGa4kt
	mHOcawT4lMzjHrmQe71BMERsrTgNnfhWUkmhw15VxcJhbXDZguMXU/j2TA0xITOfg46H
	PuLD48IkQDasTsVcpiZ3JyvApFlfUAB0QIfaFTpAvYBVHbrgzOY+KKQ0u7uW7rBwUYw5
	F1Y4e4VooYSbHD93L0Yux2g8GWtLL+7KaRRoIQ4+5blytRs1Mxk+qz5Ds2DjmIt8skbo
	+IqOziSMry+vmWpWjfpHjWY6lMbtg1CVE8NvKLCU7dF2GkY04uqBmGT/BF1HzxXsttHh
	8N0A==
X-Gm-Message-State: ALoCoQmumeeV1RfECC/mj62tw+yRj+YlKrFvW76ggaFsdh95mY3b1ztvRKnbMg/3w+3M1cVCLT9J
X-Received: by 10.194.80.71 with SMTP id p7mr39065668wjx.21.1409160232082;
	Wed, 27 Aug 2014 10:23:52 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ys5sm2645045wjc.25.2014.08.27.10.23.49
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:51 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C7BD85611F0; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:42 +0100
Message-Id: <57a6b5b96b616774754133e71aec3485dafab12b.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 10/11] buildinfohelper: BuildRequest project file update soft linked
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e1ef16d..7017305 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -69,7 +69,7 @@ class ORMWrapper(object):
             from bldcontrol.models import BuildEnvironment, BuildRequest
             br, be = brbe.split(":")
             buildrequest = BuildRequest.objects.get(pk = br)
-            build.project = buildrequest.project
+            build.project_id = buildrequest.project_id
             build.save()
 
         return build
-- 
1.9.1


