Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 0D7ED610FC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Oct 2013 16:30:40 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id c11so1202191wgh.30
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Oct 2013 09:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=j9X7rnK+QFzhF80n8IJ7rlL3A1kRsHlhRkfpWi+FgN0=;
	b=HAHKadJY1yxEe+uRvcR4ukKlXTiLKnHhClAFxpvfoD+jNhvtPEd/NOZ1b3FuvBAEtZ
	FcHQrj7ZqythGdsa+7yXrnXGbmZRUfzJs0uBd/Sb+aBNRCuve9nKLhBvnhLwo3ZrPLvu
	Pbfodlq5ai5FPmgATkijeKE+wpZ9eJk70g84huefUUWR23bbf4isvWIKUejJuVkNuYWX
	gVzjjZ6XI82CE2n5WC2ooQP8nCcmSA6mog8ruCRYNiBbnvvyZST3VAgiS1Wd+St0LPDf
	053nnzdi6Jr5xs8liavxw1uoAl/OISZn5/Ky4za/q2B0KUK8+XOP19ojodMnISz8GM6z
	GF2g==
X-Gm-Message-State: ALoCoQnrI+4pWLZTOVPGsE0hydAR8rjr6CH0imtj1yWO0ysuEkDpUD69Ox7jqv4v+H9NDr9FhA3J
X-Received: by 10.180.211.206 with SMTP id ne14mr2920893wic.30.1380731442538; 
	Wed, 02 Oct 2013 09:30:42 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id c4sm5104211wiz.0.1969.12.31.16.00.00
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 02 Oct 2013 09:30:41 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Oct 2013 17:30:31 +0100
Message-Id: <1380731431-1010-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] utils: use bb.warn instead of print in copyfile
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
X-List-Received-Date: Wed, 02 Oct 2013 16:30:41 -0000

print disappears into the ether, so use bb.warn and clean up the messages.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index ae3ef10..64a2b5b 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -724,7 +724,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         if not sstat:
             sstat = os.lstat(src)
     except Exception as e:
-        print("copyfile: Stating source file failed...", e)
+        bb.warn("copyfile: stat of %s failed (%s)" % (src, e))
         return False
 
     destexists = 1
@@ -751,7 +751,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             #os.lchown(dest,sstat[stat.ST_UID],sstat[stat.ST_GID])
             return os.lstat(dest)
         except Exception as e:
-            print("copyfile: failed to properly create symlink:", dest, "->", target, e)
+            bb.warn("copyfile: failed to create symlink %s to %s (%s)" % (dest, target, e))
             return False
 
     if stat.S_ISREG(sstat[stat.ST_MODE]):
@@ -766,7 +766,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             shutil.copyfile(src, dest + "#new")
             os.rename(dest + "#new", dest)
         except Exception as e:
-            print('copyfile: copy', src, '->', dest, 'failed.', e)
+            bb.warn("copyfile: copy %s to %s failed (%s)" % (src, dest, e))
             return False
         finally:
             if srcchown:
@@ -777,13 +777,13 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         #we don't yet handle special, so we need to fall back to /bin/mv
         a = getstatusoutput("/bin/cp -f " + "'" + src + "' '" + dest + "'")
         if a[0] != 0:
-            print("copyfile: Failed to copy special file:" + src + "' to '" + dest + "'", a)
+            bb.warn("copyfile: failed to copy special file %s to %s (%s)" % (src, dest, a))
             return False # failure
     try:
         os.lchown(dest, sstat[stat.ST_UID], sstat[stat.ST_GID])
         os.chmod(dest, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
     except Exception as e:
-        print("copyfile: Failed to chown/chmod/unlink", dest, e)
+        bb.warn("copyfile: failed to chown/chmod %s (%s)" % (dest, e))
         return False
 
     if newmtime:
-- 
1.7.10.4


