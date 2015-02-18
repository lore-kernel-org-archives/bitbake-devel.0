Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id C0A73735C7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:06 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id a1so3057054wgh.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=QuJAoxSDkzxoplytF6IZpYtQwldUn+ZXl30oO4L+bww=;
	b=OAe27x0KWCpgKq7dV977TcmsclbdhL0msjN5B2tAS4pAIiYChLlJ8Xw9pd3yE6g0vl
	bj8ruYORWaK05ZovyVEhWsWd41bxWfWaHYjh6Qcwg28qSsK1DcjKcxoeWuBiY4GrKk6D
	ep56eY5QvyTkg6slqG4leslao/oNsZH5g6n2hPv8x9msmYIyfb79lQTe5LUz/cL74LbM
	eSkrFvhC1W/aqXdes9zjhYMcSp6eFofB7ElmK8uQ3ZZiMfvO82Jlo0S2Fpxtl4e0yU4v
	Jo9S6bKxeBMyV/hMCuTtfofV/jxS87PfZjxRpuyG0uqbKIlXrvw3J2JqThusPV8ORwHb
	TL2g==
X-Gm-Message-State: ALoCoQmMx6FrEtIdGs2NJjVkJ+cCXiwWQOmX9y+GxuyjVzVvjjJbo+AP0e6PDYFw42cXXOJqtHpF
X-Received: by 10.194.79.226 with SMTP id m2mr1715656wjx.60.1424286667784;
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm26747398wib.8.2015.02.18.11.11.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4B91E561F96; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:11:01 +0000
Message-Id: <34397e585df0fc04ea53046347856e8cddb8f8e1.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 07/10] toaster: layerdetails Don't show None type in description/summary
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:10 -0000

From: Michael Wood <michael.g.wood@intel.com>

When the result for the summary or description is None don't output the
result as the string version of None, use an empty value so that the
"Not set" mechanism works.

[YOCTO #7244]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 465d633..c162c8b 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -453,7 +453,7 @@
                 </dt>
                 <dd>
                   <span class="muted" style="display:none">Not set</span>
-                  <span class="current-value">{{layerversion.layer.summary}}</span>
+                  <span class="current-value">{{layerversion.layer.summary|default_if_none:''}}</span>
                   <form style="display:none; margin-bottom:20px">
                     <textarea class="span12" rows="2">{% if layerversion.layer.summary %}{{layerversion.layer.summary}}{% endif %}</textarea>
                     <button class="btn change-btn" data-layer-prop="summary" type="button">Save</button>
@@ -467,7 +467,7 @@
                 </dt>
                 <dd>
                   <span class="muted" style="display:none">Not set</span>
-                  <span class="current-value">{{layerversion.layer.description}}</span>
+                  <span class="current-value">{{layerversion.layer.description|default_if_none:''}}</span>
                   <form style="display:none; margin-bottom:20px">
                     <textarea class="span12" rows="6">{% if layerversion.layer.description %}{{layerversion.layer.description}}{% endif %}</textarea>
                     <button class="btn change-btn" data-layer-prop="description" type="button" >Save</button>
-- 
1.9.1


