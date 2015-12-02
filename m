Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id 6A9A460616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:51 +0000 (UTC)
Received: by pfnn128 with SMTP id n128so1138285pfn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=fzLga+jfzYJeDj8oy6t9bIlLlMZuppIZ6NWTv9zPmvA=;
	b=Yz9zBWSJnx6AGKMijZzQ2T4YTxOZUljUr7cp8tVMnSnMIsev3KOQQa7BYMzpIYcihB
	t/KZE5fCw90pt2IdXlpJwdts1EmAZrPkK+JPKX5OEj/5jXLby1+iEOw0rIywi7pwQwWJ
	0z5SaXnM9EvPDL/tE8fsF+l1M+hKF69pzSXkYZ1+orlx73m8KYAla2LzLJqipaV9hq4S
	ycoHCEqjjL1bbQd7vAcvttBpd9oQwBp6xjXi5m9SlP5aj1Ws6sV8VuhZHfEVmPUO/vBX
	p9VAwQDPGvQWGs/+HFnvd0dIRQT4+BD/qIlXll+VME6CMtNSCBCy+mCh3V4v1gpDAo6k
	Jyig==
X-Received: by 10.98.2.18 with SMTP id 18mr6513661pfc.5.1449079192971;
	Wed, 02 Dec 2015 09:59:52 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:51 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:51 -0800
Message-Id: <3f8c2e7a5553c4d1f59ee200f8aa7e79ef665f4e.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 19/30] toaster: do not create duplicate HelpText objects
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:52 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

buildinfohelper code expects only one HelpText object per
build/variable/description.
Current code creates more than one such an object, which causes
toastergui to crash with this exception:
 MultipleObjectsReturned: get() returned more than one HelpText -- it returned 2!

Used git_or_create API to ensure that only one HelpText object is
created.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 43c243e..2b9302d 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -700,7 +700,6 @@ class ORMWrapper(object):
     def save_build_variables(self, build_obj, vardump):
         assert isinstance(build_obj, Build)
 
-        helptext_objects = []
         for k in vardump:
             desc = vardump[k]['doc']
             if desc is None:
@@ -711,10 +710,9 @@ class ORMWrapper(object):
             if desc is None:
                 desc = ''
             if len(desc):
-                helptext_objects.append(HelpText(build=build_obj,
-                    area=HelpText.VARIABLE,
-                    key=k,
-                    text=desc))
+                HelpText.objects.get_or_create(build=build_obj,
+                                               area=HelpText.VARIABLE,
+                                               key=k, text=desc)
             if not bool(vardump[k]['func']):
                 value = vardump[k]['v']
                 if value is None:
@@ -734,8 +732,6 @@ class ORMWrapper(object):
                 if len(varhist_objects):
                     VariableHistory.objects.bulk_create(varhist_objects)
 
-        HelpText.objects.bulk_create(helptext_objects)
-
 
 class MockEvent(object):
     """ This object is used to create event, for which normal event-processing methods can
-- 
1.9.1


