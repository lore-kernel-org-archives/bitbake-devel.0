Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 3E4506B728
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:54 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id cc10so1337872wib.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/IF39PUcYmsRjIvkYxIgu6fpSw2nweKAcwemWLktbEE=;
	b=i06nFKM8qL4gZFBZ6cx/h+BOXSysDYrVyI12/fccFTv0XQhm7IOdDVmDcNPPHzdc40
	ysXaysmPTJ9Vjcx/9CmNC+abqIj83V6sJic+xO2hoQSp6k2SA8HIJi/YtNmeEMKxUPon
	JYtNKmArxQFnEDdifldAL6BdfycyffK5kesJsgqWv5qR/aIZgZ0DOqIKTHOLvg/gWwQI
	nOuZhNNvR5pWnxJ7GAXGi2a6H+oK861KoFV9AoHP5HLujoBeZ1sGLVt9TJbwZKxcy7ch
	rLvhT1HwJqIndDzCTCvrU1eDcJcoO5h8yNODO9vaOW3nQ/sXb5IHQoBZtZvraG0d5ZWl
	uG7Q==
X-Gm-Message-State: ALoCoQk3WGIladAVPoxsAFoDVD44soJRVlNwxwRmCW5tYsU7hHJyT3tNW/REL6M7ARna2n4aoI46
X-Received: by 10.180.11.239 with SMTP id t15mr4812622wib.51.1396620655717;
	Fri, 04 Apr 2014 07:10:55 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	vp5sm12613995wjc.31.2014.04.04.07.10.54 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:54 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 83D6B56035A; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:42 +0100
Message-Id: <8ab63a668e94e4179850e4e8d901e719d071d3bc.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/14] toaster: do not load all available timezones
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch makes sure that we only load pytz-recognized
timezones. Pytz is used to transform the timezone information
for the database queries, and needs to be able to deal with
the TIME_ZONE value that we set up.

[YOCTO #6093]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index e26ee3c..e39b4cb 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -64,7 +64,13 @@ else:
     for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
         for fn in filenames:
             filepath = os.path.join(dirpath, fn)
-            zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = filepath.lstrip(ZONEINFOPATH).strip()
+            try:
+                import pytz
+                zonename = filepath.lstrip(ZONEINFOPATH).strip()
+                if pytz.timezone(zonename) is not None:
+                    zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+            except Exception:
+                pass
 
     TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
 
-- 
1.9.1


