Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web08.25918.1605713797269006728
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 07:36:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: cedric_hombourger@mentor.com)
IronPort-SDR: y4Egb7x7QGC8MoIcfcsC6DvC9OLqSlyevtKEg582QV8hfSDwQAACYYtvJx+uOhIAwFigidK3Wk
 Dk42Lv39fvcQrv0vVkT/hxGYrp342QHtW+19oBYt1sGjMqRivxcKGbmHibT34n3gwMcc2vk1mq
 TIcTd6qKo51GfE7tiE/G8rTTmCHFWcwrg5woiFfllSpT5VULoa+pHLQ++bqKIT81BqGbuzMWb6
 SwCjdG/Klm/ZVxAhapuiXEpw8+L+/TWiOUlqwwhyUTTt/9hbh9OVAqeySapPD1Ei+rltXeupFK
 6nk=
X-IronPort-AV: E=Sophos;i="5.77,486,1596528000"; 
   d="scan'208";a="55226046"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 18 Nov 2020 07:36:37 -0800
IronPort-SDR: hZNNtgZ79xG29lrYpdQIHMhYQGYCs+5GrF6QPOmCEVdD8eCMw9q3VaZgxm7dWKzprJmJFGpYVw
 G7UIh5ZMlmduoWbFSObTqvokuT4WaRqj1zX58mRFrCgE2LciB2pcxcxGsHv4+gCf1C+xlbj8dV
 0g6Qc4bOc3zYLrUzcouEKq9XAbYqv30BnYoeg/DZql10KWwONCxaU443T4VbN3NKErY4aie6VS
 bhD1nXkPiPmQNzpW1kpgjHTykDsoeRVHhLDHZiVc97aN5MtkHUOi3A2dHaZYMko1BA2KO37tGh
 uVQ=
From: "Hombourger, Cedric" <Cedric_Hombourger@mentor.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Cedric Hombourger <Cedric_Hombourger@mentor.com>, Chris Larson
	<Chris_Larson@mentor.com>
Subject: [PATCH] fetch2: use relative symlinks for anything pulled from PREMIRRORS
Date: Wed, 18 Nov 2020 16:36:13 +0100
Message-ID: <20201118153613.811-1-Cedric_Hombourger@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Return-Path: Cedric_Hombourger@mentor.com
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

try_mirror_url() creates a symlink named as the original file to make
everything look like files specified in SRC_URI were downloaded from
their original location. The link is however created as an absolute
reference, this makes DL_DIR non-relocatable. This also causes issues
with the Isar project since it bind mounts DL_DIR to /downloads to
perform some of its build tasks in a chrooted environment (rendering
all symbolic links from DL_DIR invalid). Modify ensure_symlink() to
take an optional "relative" argument and have that function use
os.path.relpath() to produce a relative symlink.

Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com>
Cc: Chris Larson <Chris_Larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ca81bd52..e090cd86 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1026,7 +1026,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
-        ensure_symlink(ud.localpath, origud.localpath)
+        ensure_symlink(ud.localpath, origud.localpath, relative=True)
+
         update_stamp(origud, ld)
         return ud.localpath
 
@@ -1060,7 +1061,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             bb.utils.unlockfile(lf)
 
 
-def ensure_symlink(target, link_name):
+def ensure_symlink(target, link_name, relative=False):
     if not os.path.exists(link_name):
         if os.path.islink(link_name):
             # Broken symbolic link
@@ -1071,6 +1072,8 @@ def ensure_symlink(target, link_name):
         # same time, in which case we do not want the second task to
         # fail when the link has already been created by the first task.
         try:
+            if relative is True:
+                target = os.path.relpath(target, os.path.dirname(link_name))
             os.symlink(target, link_name)
         except FileExistsError:
             pass
-- 
2.25.1

