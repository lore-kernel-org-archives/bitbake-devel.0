Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 821586CBAC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Oct 2013 16:47:32 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id z12so1188876wgg.34
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Oct 2013 09:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=VJ/jkb4p4hGocbtNE2yXKA++0m77UPfdUY30EGJ1/+g=;
	b=E22Z4T/X3WboWbtlUzefuGSdlpJrnKazwuQhPzM5ZlcSCcm0HhPkm8bh2gK4lZ3tbe
	x8pXntsePFlZj/s4qeXKfHoFznH2iK0p0Dk3vnAri6ydH3IXhjt6OEyh9gi/TRtigkJ8
	tPkk4PjwwMHgVJ3qOf9VVpyVf27+kl+Woo5bXfYLsp5/e/+iPYrop7Fzvkqe647yxuQa
	9DTnjBU1hZbAhNTPTevy60w8MGuWhwQnXZGj6YJeRRA4aumcitXglu4eiluc+9WJCN3P
	naQmHJaTiptHXaWC7ACG6qMitwR6FcmE5qQ9n96T+3ImztLz2ZOvW8S2VEZeW5C9xvRk
	sUEQ==
X-Gm-Message-State: ALoCoQn7I4Z3VlUyS2B3H634C10iC+IVUyja3As1Fi3LOSUkAzvvBXDd4Jal7LDuYVLNYYUVoiQ/
X-Received: by 10.180.93.166 with SMTP id cv6mr2910407wib.37.1380732453991;
	Wed, 02 Oct 2013 09:47:33 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id i8sm5270496wiy.6.1969.12.31.16.00.00
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 02 Oct 2013 09:47:33 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Oct 2013 17:47:28 +0100
Message-Id: <1380732448-1725-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH][V3] utils: use logger.warn instead of print in copyfile
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
X-List-Received-Date: Wed, 02 Oct 2013 16:47:32 -0000

print disappears into the ether, so use logger.warn and clean up the messages.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index ae3ef10..f9ee4f1 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -724,7 +724,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         if not sstat:
             sstat = os.lstat(src)
     except Exception as e:
-        print("copyfile: Stating source file failed...", e)
+        logger.warn("copyfile: stat of %s failed (%s)" % (src, e))
         return False
 
     destexists = 1
@@ -751,7 +751,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             #os.lchown(dest,sstat[stat.ST_UID],sstat[stat.ST_GID])
             return os.lstat(dest)
         except Exception as e:
-            print("copyfile: failed to properly create symlink:", dest, "->", target, e)
+            logger.warn("copyfile: failed to create symlink %s to %s (%s)" % (dest, target, e))
             return False
 
     if stat.S_ISREG(sstat[stat.ST_MODE]):
@@ -766,7 +766,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             shutil.copyfile(src, dest + "#new")
             os.rename(dest + "#new", dest)
         except Exception as e:
-            print('copyfile: copy', src, '->', dest, 'failed.', e)
+            logger.warn("copyfile: copy %s to %s failed (%s)" % (src, dest, e))
             return False
         finally:
             if srcchown:
@@ -777,13 +777,13 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         #we don't yet handle special, so we need to fall back to /bin/mv
         a = getstatusoutput("/bin/cp -f " + "'" + src + "' '" + dest + "'")
         if a[0] != 0:
-            print("copyfile: Failed to copy special file:" + src + "' to '" + dest + "'", a)
+            logger.warn("copyfile: failed to copy special file %s to %s (%s)" % (src, dest, a))
             return False # failure
     try:
         os.lchown(dest, sstat[stat.ST_UID], sstat[stat.ST_GID])
         os.chmod(dest, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
     except Exception as e:
-        print("copyfile: Failed to chown/chmod/unlink", dest, e)
+        logger.warn("copyfile: failed to chown/chmod %s (%s)" % (dest, e))
         return False
 
     if newmtime:
-- 
1.7.10.4


