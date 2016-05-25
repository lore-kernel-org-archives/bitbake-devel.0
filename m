Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id EF4F165CC2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 04:47:12 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 24 May 2016 21:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,363,1459839600"; d="scan'208";a="973981980"
Received: from ismailm-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.14])
	by fmsmga001.fm.intel.com with ESMTP; 24 May 2016 21:47:12 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 16:46:44 +1200
Message-Id: <633d0396fe294c0961d60b1b9447afae0a571c1f.1464151580.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1464151580.git.paul.eggleton@linux.intel.com>
References: <cover.1464151580.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1464151580.git.paul.eggleton@linux.intel.com>
References: <cover.1464151580.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] fetch2: fix unpacking of deb packages
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
X-List-Received-Date: Wed, 25 May 2016 04:47:13 -0000

deb packages in modern Debian versions have the data tarball compressed
with xz rather than gzip, and thus explicitly extracting data.tar.gz
fails. Unfortunately ar doesn't support wildcards matching items to
extract, so we have to find out what the name of the file is first and
then extract it, relying on tar to figure out how to unpack it based on
the filename rather than doing it with pipes and making that
determination ourselves.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7d2f350..879a125 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1398,7 +1398,18 @@ class FetchMethod(object):
                 else:
                     cmd = 'rpm2cpio.sh %s | cpio -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
-                cmd = 'ar -p %s data.tar.gz | zcat | tar --no-same-owner -xpf -' % file
+                output = subprocess.check_output('ar -t %s' % file, preexec_fn=subprocess_setup, shell=True)
+                datafile = None
+                if output:
+                    for line in output.splitlines():
+                        if line.startswith('data.tar.'):
+                            datafile = line
+                            break
+                    else:
+                        raise UnpackError("Unable to unpack deb/ipk package - does not contain data.tar.* file", urldata.url)
+                else:
+                    raise UnpackError("Unable to unpack deb/ipk package - could not list contents", urldata.url)
+                cmd = 'ar x %s %s && tar --no-same-owner -xpf %s && rm %s' % (file, datafile, datafile, datafile)
             elif file.endswith('.tar.7z'):
                 cmd = '7z x -so %s | tar xf - ' % file
             elif file.endswith('.7z'):
-- 
2.5.5


