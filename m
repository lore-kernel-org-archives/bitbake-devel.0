Return-Path: <gmstima@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 25CD860778
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 07:46:05 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id 133so1338475wmq.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=iT1i9f4KKRHe4GBq6n47ZtTZ6WN7lBuD3n+O1kgbXwY=;
	b=amOzBr9I5KnhdDCbOKz/V4bp1Qu8DjLHXfJFKOHQyhW8aflVHpgCKp+vs5U8RuoYpB
	rSmOoaWcAMwzkD1IDU7UyrO0lXMP6e9UgSv2LuPyLP1r1K/w40CtVuI1bz3Wczy1xQoj
	JVh6tSRAJN4Tfc+F1t9PFN9cEg7FqS4yD9X75eXslj2r5uchOsNFxpapiJzcTA8IHI+j
	6KX557WVShuQezXdPKJHMUM2eGT/HjJGTaKK6VaxwBKymIrNOIiCcexMMpgKdEDvhKY1
	w0pmuV1tvkZzkdD9NJ2FLJ1w37Ek9NLYq5Z7yOgfM4igXGHzre5xgsYRoT+nroILG3ji
	/R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=iT1i9f4KKRHe4GBq6n47ZtTZ6WN7lBuD3n+O1kgbXwY=;
	b=V7U3NFJzmxwie/7XNE81oY2g13ABLs3aRdq70KjgMqskntaqZTz+hRO2f+1HcKCLuy
	wvD608+Ewt8+KeICCHEstVo1/WtHdGhfaxqJi/dJn7uyzOgu9AnHPqVRHZHyzIJIqZi+
	LYfFZDtfiCOme//ITzPVicareFMz3Gfg5hB8wNKb1d6+sgvM3r4iDDtLsdpTVtwod7LF
	dt+KDBgdnm7AdHW0PAgoE/5BqKVl5cZmvxq4qOQnypOzrAHeNH806+Jj40+dKDOBVLrB
	HkPFxvz+/ZgkjYQG5CMSGPJtZcX8q52q/wtf5vThu0hRZHwPexeAJeBP0pBDU0dQAsjr
	ZGZA==
X-Gm-Message-State: AA6/9RmqE/hA3dZdLVhxxNSk0LnX+qpjFN3+JT9k2lxfv1F/M/aaZSDLmaxQ0WQe8zThQQ==
X-Received: by 10.28.186.68 with SMTP id k65mr1486157wmf.57.1474616766692;
	Fri, 23 Sep 2016 00:46:06 -0700 (PDT)
Received: from work.int.attocapital.com ([80.64.81.111])
	by smtp.googlemail.com with ESMTPSA id
	188sm1759873wmo.1.2016.09.23.00.46.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 23 Sep 2016 00:46:06 -0700 (PDT)
From: Roman Savchenko <gmstima@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2016 10:45:53 +0300
Message-Id: <1474616753-26510-1-git-send-email-gmstima@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
References: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
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
X-List-Received-Date: Fri, 23 Sep 2016 07:46:08 -0000

From: Roman Savchenko <roman.savchenko@attocapital.com>

When making new symlink in case when link name does not exist
possible broken symlink behaviour should be taken into account.

Signed-off-by: Roman Savchenko <gmstima@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6ef0c6f..d8a3b96 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):
     bb.utils.movefile(ud.localpath, new_localpath)
 
 
+def try_symlink(source, link_name):
+    """
+    Tries to make link to passed source if link name does not
+    exist or it is the invalid symlink.
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


