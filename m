Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f175.google.com (mail-wj0-f175.google.com
	[209.85.210.175])
	by mail.openembedded.org (Postfix) with ESMTP id 75B6971B86
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:05 +0000 (UTC)
Received: by mail-wj0-f175.google.com with SMTP id xy5so19447897wjc.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Pdk8sNZmNNj+wXJ/eceCOh7ZdXpppMj5cGFSFIZkNEU=;
	b=c76Nnf7tR467LW7zyU44905c4chfCzFF8pYa7xlXZpu9vsA6WMXcXtZyalsu+C84d4
	NmWXB5LCQ4vqr4MjpC86BBhfiULNz9cAF4rJYTgUEZ1ffU3QIywglyRTaSkNS6zem0gE
	P+QMGxepJY/omtvNcLL9G82snZh6pvnJ0AqBS67HItOPvQ39zkjOM0WMl2VFMePSlmhE
	smIzgfooVmU2LQPOhhpwhbbtgtVnPsqGFIqeXRgCsidhu1ZjR/MXc8RfUsdt0DMU/8HZ
	jpUVHc6dAIHSlTPHMl1fAaTHNaaLZUkS7KIxSIZCdQnAK/1ZVxHNrR41M5jXyqoASp37
	Jwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Pdk8sNZmNNj+wXJ/eceCOh7ZdXpppMj5cGFSFIZkNEU=;
	b=Rsy0SjpHE7WwEK4IzY1/SwdR+5Li891ydlP/uDFGrKN/FkTiSXIHeBroVRzc+Rv3r8
	utV2Uuvj0z25Ig8MpJufiYPwl+Jz0f7BbKTWWFQx6cO09tU9i3XcZBYGcslIB9WVhFGc
	3FhDnipoIvsQgYrp7MO7wvOvlcuyfQaB2kiA0lJqM4NVdty6jsgkVJ2ySUYL+vwFfOIy
	eW1eYw0q8fDTr8AAslhzfmWQgXZ5gBvguUHFhPikhPyG61+Knpm/SpeP1524kkAu1SKo
	bcV+iAAQDK0/2H2JYJhOpVS4bkqaYy0zfsqzfnL/kyMxYeH/yN6Oi37p4XjTKT//amIJ
	Eplg==
X-Gm-Message-State: AKaTC03C6ZLO7WRllpw96TJxoVpc1xWY0BFa9wk3XAcZKenVFc00x4aNbEfIpE71w4bDl1Wt
X-Received: by 10.194.5.165 with SMTP id t5mr35050542wjt.107.1481302386196;
	Fri, 09 Dec 2016 08:53:06 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:05 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:44 +0000
Message-Id: <1481302375-7985-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 03/14] toaster: models Layer_Version get_detailspage_url optional project_id
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:05 -0000

Allow passing none as the project id, this is convenient for layers
which belong to projects already and therefore have their own project
field.

Add documentation string to function

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4cd6683..98745d6 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1493,7 +1493,13 @@ class Layer_Version(models.Model):
             return self.commit
         return 'N/A'
 
-    def get_detailspage_url(self, project_id):
+    def get_detailspage_url(self, project_id=None):
+        """ returns the url to the layer details page uses own project
+        field if project_id is not specified """
+
+        if project_id is None:
+            project_id = self.project.pk
+
         return reverse('layerdetails', args=(project_id, self.pk))
 
     def get_alldeps(self, project_id):
-- 
2.7.4


