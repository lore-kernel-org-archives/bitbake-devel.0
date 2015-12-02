Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 17CC660667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:41 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48539161pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=ktXxsQuLfRo4iKz90VJwv+Pw5Ju5vOoP/+vu2+pagzk=;
	b=QD5/XCCONb8wT4Czf0noGQDL74cG2WD2YDj6nFYWCiSGvu2DWZOjVambO0BgOiS8ET
	u19umK7zK9JW5gTC+qMBpxe4i0wZESL3DKs88GniWUCfwRJsYRE+AZr9YI3y2o91N6yG
	uIqhkhWHwU8dKNs1uNwVuchdnTsTlXbKK7A357Vu5xxEiLWegBlko1MovNvYwqrsaRq2
	zdYuXgG3xu33Nvp9aZyqt4mvxcKJ+2KFmhGxBkSWcBSaz8nTezGIr36OfGUAAtb4rSv4
	PdebcarBKFRVFJBYTo9J+ZxZX2dx6+emJ3m8J6sX+xt63aEUSTrQAaLo7e7WE5MUcGKt
	Z0Ug==
X-Received: by 10.66.255.10 with SMTP id am10mr6478979pad.79.1449079182126;
	Wed, 02 Dec 2015 09:59:42 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:41 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:42 -0800
Message-Id: <c114fe7801cf1ef51327aed13ec1cece5ca458df.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 10/30] toaster: update brbe and project attributes
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:41 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Updated attributes of buildinfohelper object as they can
be changed for every build. For example brbe is set by
runbuilds for every build triggered by Toaster UI.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 78f1e92..43c243e 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -796,6 +796,8 @@ class BuildInfoHelper(object):
         build_info['cooker_log_path'] = build_log_path
         build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
+        build_info['brbe'] = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
+        build_info['project'] = self.project = self.server.runCommand(["getVariable", "TOASTER_PROJECT"])[0]
 
         return build_info
 
@@ -938,6 +940,10 @@ class BuildInfoHelper(object):
         assert '_pkgs' in vars(event)
         build_information = self._get_build_information(build_log_path)
 
+        # Update brbe and project as they can be changed for every build
+        self.brbe = build_information['brbe']
+        self.project = build_information['project']
+
         build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
 
         self.internal_state['build'] = build_obj
-- 
1.9.1


