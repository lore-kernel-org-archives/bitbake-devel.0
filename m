Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id F341478412
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Mar 2018 17:35:41 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id h21so6352892wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Mar 2018 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=IjBP2MwfHmwemd48k3lLLNnOymHOqrl6zaSUkOScExM=;
	b=scGKKq06bmw8KVuIOIUJidG3ha4Ih1NsU0LG8Zu558zJ+2ESpjatXG++QQHZMa9V0p
	5qEMPh7ZTlHCzjS0qzS8z8+KcDX+2GMZjN41ni5NPrEiP4Eo2EyunIcs6whoHsCCg3of
	TslPxQQdOyWYTGR9B4Y1D1ANOLRBkBCGyNm4VxL32KY+DpKiBDopzju4kgoPLHjiPwjq
	Z+x1VCdwsmrOhF8Sz+SJyMQv6h3W6worSSa04xtvdO/2T3SF86slbjq7DXFI78f9vxwW
	/MNALjkbslZarhMiNq7c4w0HnHrXA9n3kZu6AWikFjqwEdeNUAb6PyrW9eDQt9Um5FKw
	eUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=IjBP2MwfHmwemd48k3lLLNnOymHOqrl6zaSUkOScExM=;
	b=X8Mkiurkd/LEgDROMvf8kRRiFE5lRzxI8jwQxFxCRRfwrKmTDAViMKQW61SyXYdfkN
	TG3F7DA0/IYEofJPXiJEGZYooSF5PrEKowev/qdvLqi/mwI4Mcd7VOhHmjI0UOL+8IUV
	e3BLe4zqCq53NOx4QkB4GqoikH1+DPlT1o96h8wcmSRBQaHhOhf7HRG4jYC1U9mHOD16
	MwqRdAGb7Jn7+zRoFNRqoaMePNnqmII65zAtbOlpZUAqOGNgqGrgYItgIOTZztbOPct9
	+NKnHfV+x1iPgvWzTWPFmMlo8xnB+mU3LpjFuKrXHbZkjO3z4318jGBrj0BPgiUHuhoq
	sKHA==
X-Gm-Message-State: AElRT7ERN+Kqit08751SociSxlPMvPxBVkSAbPGDkhi9wb43/0Spumbg
	UMnE/2C8OYtG8YylwftmxX1pZqdl
X-Google-Smtp-Source: AG47ELtKERQzWrA/IAtVRBi6R0TqBEVsFXW0+SUoDT8onYtBbgvVZwBndz5pZFO3VRMU7+oREeSpRA==
X-Received: by 10.28.228.131 with SMTP id b125mr14316056wmh.153.1520444142333; 
	Wed, 07 Mar 2018 09:35:42 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	31sm14894410wrr.59.2018.03.07.09.35.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 07 Mar 2018 09:35:41 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Mar 2018 17:35:38 +0000
Message-Id: <20180307173538.14911-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] data: show value in -e when unexported
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
X-List-Received-Date: Wed, 07 Mar 2018 17:35:42 -0000

When a value has been unexported it still has a value, so write it out in a
comment to keep the output shell-like.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/data.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 80a7879cb66..62fef18c40d 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -156,10 +156,6 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
     varExpanded = d.expand(var)
 
-    if unexport:
-        o.write('unset %s\n' % varExpanded)
-        return False
-
     if val is None:
         return False
 
@@ -178,15 +174,19 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))
         return 1
 
-    if export:
-        o.write('export ')
-
     # if we're going to output this within doublequotes,
     # to a shell, we need to escape the quotes in the var
     alter = re.sub('"', '\\"', val)
     alter = re.sub('\n', ' \\\n', alter)
     alter = re.sub('\\$', '\\\\$', alter)
-    o.write('%s="%s"\n' % (varExpanded, alter))
+
+    if unexport:
+        o.write('unset %s # "%s"\n' % (varExpanded, alter))
+    elif export:
+        o.write('export %s="%s"\n' % (varExpanded, alter))
+    else:
+        o.write('%s="%s"\n' % (varExpanded, alter))
+
     return False
 
 def emit_env(o=sys.__stdout__, d = init(), all=False):
-- 
2.11.0


