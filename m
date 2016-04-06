Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 975347713C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:41 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id v188so29625873wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=WqYZm3ubgEs/AHcNdLkh5L03529F9DYUWdIdIApJCJQ=;
	b=RaouTreBC1AxH3YK8TEylXErz6ob5pZ6Af3o7c0rBwsnIrCDBvznhxbifCSn2qh+j2
	PEVaW2mZWcOJ/Kq3fMGEPv3NbwQuwyWkwqO+VcnnS9oHqeSZNHni+xMjrFcAac6emBcX
	CVqeNHvmh0mgguvPhQ8FFLHKwXGEIZvR6bV61INlkkZBa2Kq8QBrHra4HL0pl8GhqdjB
	0GgNp6jZz/BotL5SJwtJZEVdV4T99Uy3ut7E57eh8X85UCRrV3t8UvU2Wg661eNvYf8V
	b+RwEBNW/m88G+OYfc2DxVLHuWJvoCaTH45SYQcbfLK7lgcHvNikdPEkcL7w6tP0J7Q0
	Ci9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WqYZm3ubgEs/AHcNdLkh5L03529F9DYUWdIdIApJCJQ=;
	b=ZejnwWC+8i53gyLNI4FqvDzDF9W8qBGUahrhuWzlRY7jTDlGlXF1DF+JHuHB1rKg6E
	Gt6VV7BxKZb+4fg8L3Qpiya8gN4NNwuyz+naSNl1GRuxKONlLCSdEl9gJOdxX2NFK0ZT
	Na1PnJLcnRqOf2jy+63bw60ye6dKTZyRLU73t5EN2/MXypQ078bToykBswWsKJ98yYNy
	B6/9hHyYo8tvAxd+8xbGSOp+3uXc6QXzVEU6akJmErY218f5gvGl4m1luskt1lv3m8Hk
	j45amL19WA+XcwjvWrgdlZ4Iam/k7Z+NGKOq2VX1hoFCQg0cqtQDp4PQ7TRgn1xOgCWN
	uu3g==
X-Gm-Message-State: AD7BkJLLyDGvMjUqoc0JQlQA8kbLWYNh80943IscQAI+FJ9L0sRlazbBt7dVAUFVuWaajCzb
X-Received: by 10.194.71.46 with SMTP id r14mr33394658wju.100.1459961262205;
	Wed, 06 Apr 2016 09:47:42 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:41 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:48 +0100
Message-Id: <bd6ad8ee9b61b586dd8d78ab5994165cebe308b9.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 38/38] toasterui: update build in internal state
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:42 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

buildinfohelper stores current Build object in its internal
state. Any changes to Build object will be lost if internal
state is not updated as current buildinfohelper code
saves Build object from internal state when build is
completed.

This bug causes incorrect build state when build is cancelled.
Updating internal state should fix it.

Note, that this commit updates internal state after status of
the build is changed to Build.CANCELLED. There are several other
places in the code where Build object is updated without updating
internal state. They should be carefully analyzed and fixed.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 93456c3..9397905 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1422,6 +1422,7 @@ class BuildInfoHelper(object):
             logger.info("Build cancelled")
             br.build.outcome = Build.CANCELLED
             br.build.save()
+            self.internal_state['build'] = br.build
             errorcode = 0
 
         if errorcode == 0:
-- 
2.1.4


