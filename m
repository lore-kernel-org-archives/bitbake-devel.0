Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id D454A606B2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 16:49:01 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id l132so101544557wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=wsOlT3gQky5Z5oksgdcc1V4lOlWoP3NN8Nh0RQTUgAs=;
	b=L1Lcw4Cbt2M4a3DYizfUBJoUFVIlQlkSExE0NXVpkir+coRlunRQYiT9JPTE0lpy5R
	1o82N8HeTx5TRuB8b1IZXVk8uIz0HD7OEydxHsX6Z36W2HXZjT1hCZ9KF9pMit6lMJUR
	kNY5eosgPe8WfwrWbBK0ZwsYJOYCL1UevUub3sNImP/QcK4oPVgy2gdBJjH+Jd8r9sUG
	SG5+zzUCeXPcK02keE+8DOJlyCsperpI77XjqqdJHPqWl+liPKqUlhAMAXdQHzCcm5um
	EUgrnY57jksKE0TuryuLAhmf1FJQ+4PCWtBuI6wSTq+RRu8mHxRXElhZZvIbSHI5UC6m
	0C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=wsOlT3gQky5Z5oksgdcc1V4lOlWoP3NN8Nh0RQTUgAs=;
	b=kZgmFF6yeOXuHM3xhOJG0MYfxU2ts2oeTmksKZggGX8lxA9Ij7sDw5Bsrg9x3AruVR
	kBerTnhU7IWv16lp5etdMhRdj91pIMEzAhv5TofLiBKXhMkS2UJZlKNk5aWgJY1piWYF
	i0oeYv/sXY/63v0/vbyzbJzuedP0i7ncUcxUIUnE6zItYQv4rOTtlX7sepP7/RPr7+MN
	APrZ0JfPVMEod89Weq7LBBlwzgMfWLOnIVDotpVzx555QAKs4RaUPc85vHL2tD7UHqHn
	F0pAY8UUtD8bDIk01c0hYwFqnH3TLOcOxtzLykr5d2DMbSR11AABxg6VIraUC73zlUk8
	P6VA==
X-Gm-Message-State: AE9vXwN61S29WZgvS1uXvtQ56jr17Y2/yXupGbWE6YpQ9vXpQB0HRtLyzuC0yUn0BRFRU3Zx
X-Received: by 10.194.114.100 with SMTP id jf4mr33419383wjb.87.1474476542262; 
	Wed, 21 Sep 2016 09:49:02 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	b8sm10260505wmb.18.2016.09.21.09.49.01
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 21 Sep 2016 09:49:01 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Sep 2016 17:48:55 +0100
Message-Id: <1474476535-22713-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] fetch2: handle absolute paths in subdir
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
X-List-Received-Date: Wed, 21 Sep 2016 16:49:02 -0000

Currently if you use the subdir parameter in a SRC_URI and pass an absolute path
then it gets appended to the unpack directory instead of being used directly.
This is inconvenient as it may be useful to use ${S} when you want to unpack a
file into the source tree.

Change this behaviour so that absolute paths are used directly instead of being
appended to the root directory.  To ensure that recipes cannot write files to an
arbitrary location enforce that the subdir starts with the unpack root.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 8 +++++++-
 bitbake/lib/bb/tests/fetch.py     | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 06f1eb4..cd7362c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1420,7 +1420,13 @@ class FetchMethod(object):
 
         # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
         if 'subdir' in urldata.parm:
-            unpackdir = '%s/%s' % (rootdir, urldata.parm.get('subdir'))
+            subdir = urldata.parm.get('subdir')
+            if os.path.isabs(subdir):
+                if not os.path.realpath(subdir).startswith(os.path.realpath(rootdir)):
+                    raise UnpackError("subdir argument isn't a subdirectory of unpack root %s" % rootdir, urldata.url)
+                unpackdir = subdir
+            else:
+                unpackdir = os.path.join(rootdir, subdir)
             bb.utils.mkdirhier(unpackdir)
         else:
             unpackdir = rootdir
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index d7c73dd..0fd2c02 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -508,6 +508,15 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack(['file://dir/subdir/e;subdir=bar'])
         self.assertEqual(tree, ['bar/dir/subdir/e'])
 
+    def test_local_absolutedir(self):
+        # Unpacking to an absolute path that is a subdirectory of the root
+        # should work
+        tree = self.fetchUnpack(['file://a;subdir=%s' % os.path.join(self.unpackdir, 'bar')])
+
+        # Unpacking to an absolute path outside of the root should fail
+        with self.assertRaises(bb.fetch2.UnpackError):
+            self.fetchUnpack(['file://a;subdir=/bin/sh'])
+
 class FetcherNetworkTest(FetcherTest):
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-- 
2.8.1


