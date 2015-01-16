Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id B98B472BF2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 17:54:50 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id bs8so5846912wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 09:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=DE1hDROIQUKI2gLx3QXGSuwBrWKzn+OBkqT15q9DVLA=;
	b=YSDtAWfLCJrEgzmRAu+l7x7VGmt6aEnOgdTUZ0s3vZDEEGJWduA8utqYkP2jhLujIr
	SIbg3INb2sH+qVDxh72tRuiup883TyVofcJEsMc+raEwaevKmUEsD1GddlQZJZqVISTT
	gBKgQeN84c9xJ/FpOabG+kYX6/kazNRwF5cQ97M96smCZPVvrqegVpcFfrcB4Og4Vy0+
	DwLyP8KndElCD4G3wnxlcHYqMclG6sGShL2sMJuiNmrQ7Kie69vt/ax4Et99CNZLEDD+
	VG1C6+SFBnNGcC/mBfaOgobTNUjR7mgFnC5aMsHi3WIuEiF+/thcmJD1AS/UbtjdwfFX
	u6Ag==
X-Gm-Message-State: ALoCoQkzxysmct6NeYmRZ2pEWI2cV4AWOM0RgpPsksEYfCuzwbD4XBsLLy0fGgBMDjSyskx/lA6p
X-Received: by 10.181.27.199 with SMTP id ji7mr8623638wid.76.1421430890821;
	Fri, 16 Jan 2015 09:54:50 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by mx.google.com with ESMTPSA id jr4sm6958742wjc.20.2015.01.16.09.54.49
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Jan 2015 09:54:50 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Jan 2015 17:53:23 +0000
Message-Id: <1421430803-4432-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH][V2] fetcher: use os.path.splitext() instead of string.split()
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
X-List-Received-Date: Fri, 16 Jan 2015 17:54:55 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 190de9e..4f95a16 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1199,9 +1199,9 @@ class FetchMethod(object):
             bb.fatal("Invalid value for 'unpack' parameter for %s: %s" %
                      (file, urldata.parm.get('unpack')))
 
-        dots = file.split(".")
-        if dots[-1] in ['gz', 'bz2', 'Z', 'xz', 'lz']:
-            efile = os.path.join(rootdir, os.path.basename('.'.join(dots[0:-1])))
+        base, ext = os.path.splitext(file)
+        if ext in ['.gz', '.bz2', '.Z', '.xz', '.lz']:
+            efile = os.path.join(rootdir, os.path.basename(base))
         else:
             efile = file
         cmd = None
-- 
1.7.10.4


