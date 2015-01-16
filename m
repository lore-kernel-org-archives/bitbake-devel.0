Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id E2A3971637
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 17:49:42 +0000 (UTC)
Received: by mail-wg0-f52.google.com with SMTP id x12so21766075wgg.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 09:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=LbNwF8KN349jn6bHWQYHoorwNEp+UGEQj+x5HMb2Itw=;
	b=bt+8oOcVkKGniHG8NsD2yWCzfMnsBweL6YFHxKbp092JGdsSwYWe2ujKB/VF/8qNZI
	RNyScdNprHZq0FYEII43XdxY8+FxFZ+ikERSXApWqGwNSgOt52K4W04Abog2RJPBUVDU
	X8vyR/b398uSbNrpOM3/SatJwiy2P6X8di7xYPirS+e+WtpbsIddVrFTeBAXVDsAFIBk
	AewhsnXBiZYp/XheCoY5ouRWSqYPxAzwTWcZn4gsPgPoJbWpJr9tMDPPJAnGRpCkMczE
	lrWxzvLynQr2aePhAEs9MXPlI3iGgzdmAcfeBhfsjWlqkTdPUat5s1650Fdcxce7V7TU
	DVJg==
X-Gm-Message-State: ALoCoQm0odgPdiepMGymTOmjWtsWbhC4aDG1LTdrBDL2zdXnN1NaZKSd7Ez9YePhRK3Sa+Etr4im
X-Received: by 10.194.58.19 with SMTP id m19mr31627351wjq.52.1421430581808;
	Fri, 16 Jan 2015 09:49:41 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by mx.google.com with ESMTPSA id gy8sm3833605wib.23.2015.01.16.09.49.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Jan 2015 09:49:41 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Jan 2015 17:48:12 +0000
Message-Id: <1421430492-1847-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] fetcher: use os.path.splitext() instead of string.split()
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
X-List-Received-Date: Fri, 16 Jan 2015 17:49:44 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index c0a4763..ed7c59c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1197,9 +1197,9 @@ class FetchMethod(object):
             bb.fatal("Invalid value for 'unpack' parameter for %s: %s" %
                      (file, urldata.parm.get('unpack')))
 
-        dots = file.split(".")
-        if dots[-1] in ['gz', 'bz2', 'Z', 'xz']:
-            efile = os.path.join(rootdir, os.path.basename('.'.join(dots[0:-1])))
+        base, ext = os.path.splitext(file)
+        if ext in ['.gz', '.bz2', '.Z', '.xz']:
+            efile = os.path.join(rootdir, os.path.basename(base))
         else:
             efile = file
         cmd = None
-- 
1.7.10.4


