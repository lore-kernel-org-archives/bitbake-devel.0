Return-Path: <gmstima@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7CC4E60770
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 16:23:12 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id 133so4268455wmq.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=X3o/qY9pdG7A2/MQRDAjfCCVWq0kT6urVi1s5p9gBog=;
	b=KC8Ghrs/wkkCzK0MZkrCkjUfiQqhcGZNUu9mq12I8XQ1z0HWF7kN0g3J/nBrl56MI1
	lTBuxOv5+Rl8Rtj6Eqvd4N4SM+psESfcB1rrZl+t8AVVllU29oHfhNwzgMcTt+6nhmj6
	tiOBvmmcRNQVnsWr/1jMN6OB3oWQQX+7iUhp1FI/Tv+G3knCVcCv1yXFebMnUMY5NgNz
	VZNCYc1vkDBtZG5IWSJlhN8TA13K4C4k1VO1w/5d7tmtb+5TX76Y865xoS1WUV+KIN0X
	GUGc6rtv5Yc3oeVk2uXMUVGyYNP9kmNqfpGhSWukoVFCHF2SQN9m6F00mwM0OuZFf6dv
	89CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=X3o/qY9pdG7A2/MQRDAjfCCVWq0kT6urVi1s5p9gBog=;
	b=mQKeY6+lawlQzVoWdK0jydZSpvKNbUKb2vJ36++gaKM2tXsuC3VmaZ6RmD8IaZ7WGc
	18HwJuL5REMJNF4VrbFHpLHBM+DhJ+iMCEXGNkE3DR7exglEajxdWvxpcyB+rwhDTyyR
	NHb+kmieOWbmBpjtv8MpSAyEf+kPkqyo0gpCehmCgOUeG0QigEVYnNy0E0++RJtoH8cL
	eSXKvxnGygy/Q04+P8nd/nDDr+2SFCTok+Iex9IicbjIseu/bvEP9fsBa6s4AZOHSPLI
	fsNcbTQq13UGgd3rRdKDHu3sN28GMRVuUcPLYV+HtYqVrJ7nPHIyXo5NACCVTUhpRYsl
	0lHQ==
X-Gm-Message-State: AE9vXwOgiV5dy5t5NVXez0QKmUaxOPM6ZeCyybamZchMLtAjNSDjKk/vqLFxCgTCa902KA==
X-Received: by 10.28.94.85 with SMTP id s82mr3908848wmb.24.1474388593616;
	Tue, 20 Sep 2016 09:23:13 -0700 (PDT)
Received: from work.int.attocapital.com ([80.64.81.111])
	by smtp.googlemail.com with ESMTPSA id
	vs7sm28756187wjb.10.2016.09.20.09.23.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 20 Sep 2016 09:23:13 -0700 (PDT)
From: Roman Savchenko <gmstima@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2016 19:23:08 +0300
Message-Id: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] bitbake: Correct broken symlink behaviour
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
X-List-Received-Date: Tue, 20 Sep 2016 16:23:13 -0000

From: Roman Savchenko <roman.savchenko@attocapital.com>

Unlink broken symlink.

Signed-off-by: Roman Savchenko <gmstima@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6ef0c6f..a752c6c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):
     bb.utils.movefile(ud.localpath, new_localpath)
 
 
+def try_symlink(source, link_name):
+    """
+    Tries to make link to passed source if link name does not
+    exist.
+    """
+    if not os.path.exists(link_name):
+        if os.path.islink(link_name):
+            os.unlink(link_name)
+
+        os.symlink(source, link_name)
+
 def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
@@ -962,20 +973,14 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
                 open(ud.donestamp, 'w').close()
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
-            if not os.path.exists(dest):
-                os.symlink(ud.localpath, dest)
+            try_symlink(ud.localpath, dest)
             if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
                 if hasattr(origud.method,"build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
-        if not os.path.exists(origud.localpath):
-            if os.path.islink(origud.localpath):
-                # Broken symbolic link
-                os.unlink(origud.localpath)
-
-            os.symlink(ud.localpath, origud.localpath)
+        try_symlink(ud.localpath, origud.localpath)
         update_stamp(origud, ld)
         return ud.localpath
 
-- 
2.7.4


