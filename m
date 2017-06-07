Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 9EEDD7198A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 09:03:29 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id b184so4196556ioe.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Jun 2017 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=K/+BAfJmqMOwkrT5ic0+KObYBaUW6J1urA0kaoJHWuU=;
	b=NzPr376B2WUdwEjC+frJIY2HRToTnZ6KXbzUubNmNnri5x6gFcVeqiJVW9ZNomXXAg
	bNxlVMgzLzl/5uaDKuPoqHRvMZ2eRsJjKCaAghhu5rW8Ak9D9bmY/oSxxYwJ2J4gE/q4
	vJfrqC1yXrDE69mSiWpRssShKmqIC50AOHaJpuNxsHQ4f7jV70ql4u1SFhCQK1rZO4kI
	OgrBqb0KvH3912xVdhIe2lN5fDMJmCvJ7QELOhtRyOVYnnQN9Ni2hYB/0JaWc6NiW47I
	h8w33eguFoI5CsN6DXYmv9IFyUEoaMMCyMAS/SS9d1X7fp7WpihO0Rxc40HmBYZ1FR6O
	Cwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=K/+BAfJmqMOwkrT5ic0+KObYBaUW6J1urA0kaoJHWuU=;
	b=Ch3ze5wL2g2xVGM9z7w3mjnWnbtpIoPD+sapF9z24oFV1sNlABcfkUQy9dAR9+dESk
	Rm9OiIorVdriUJlQQ2z8sp30fxLuRPCQ3AVnEbnZDuVUcM/JloIbL1yluZZh4ruVeBcK
	WICct/SfOEr7LXMAOW7wcaRwPIt6A5V7q/cEU5i4jKNZEOMwCImFAsSpUDwd3EdtIGy/
	AjQ+E3LCKruAHUffaHQdgYBOrrZISK0ZsJg5kqJVTs0JCm/QhYFeaEUngWCuLZAkWWfv
	K9LIyg0/uMDmgBGoLaf/XWGpE3S74X24d/hT8mxnEjN/bAJmUF8FeAG4yA1QFfEfWxKX
	fHRw==
X-Gm-Message-State: AODbwcC6cqrazRbdMU1y+deH5O+WbHBVNVG/os3J0NlMWgB5rqkjxZ86
	y0mRhB+YnF9JdlvwaBA=
X-Received: by 10.107.32.197 with SMTP id g188mr8135342iog.146.1496826210587; 
	Wed, 07 Jun 2017 02:03:30 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8FFF1.dip0.t-ipconnect.de.
	[93.232.255.241])
	by smtp.gmail.com with ESMTPSA id h63sm834326itd.10.2017.06.07.02.03.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 07 Jun 2017 02:03:29 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 11:03:18 +0200
Message-Id: <cf2bf9a0b0d9380025f61c7e7a39e6e19b46a7a1.1496826075.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1496408295.6630.95.camel@linuxfoundation.org>
References: <1496408295.6630.95.camel@linuxfoundation.org>
Subject: [PATCH] cookerdata: Add support for BBFILES_DYNAMIC
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
X-List-Received-Date: Wed, 07 Jun 2017 09:03:32 -0000

BBFILES_DYNAMIC can be used to activate content only when some other
layers are present. The other layers are identified by the collections
that they define.

The main use case is to avoid .bbappends without the corresponding .bb
file in layers that want to modify other layers via .bbappends without
introducing a hard dependency on those other layers. .bb files could
also be handled via BBFILES_DYNAMIC.

Entries in BBFILES_DYNAMIC must have the form <collection
name>:<filename pattern>. Example usage:
 BBFILES_DYNAMIC += " \
     clang-layer:${LAYERDIR}/bbappends/meta-clang/*/*/*.bbappend \
     core:${LAYERDIR}/bbappends/openembedded-core/meta/*/*/*.bbappend \
 "

Parsing is aborted when invalid entries are found with an error
message like this:

 ERROR: BBFILES_DYNAMIC entries must be of the form <collection name>:<filename pattern>, not:
     /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
     /work/my-layer/bbappends/openembedded-core/meta/*/*/*.bbappend

Based on a patch by Richard Purdie.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/cookerdata.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 722d860..aa96f54 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -346,6 +346,20 @@ class CookerDataBuilder(object):
             data.delVar('LAYERDIR_RE')
             data.delVar('LAYERDIR')
 
+            bbfiles_dynamic = (data.getVar('BBFILES_DYNAMIC') or "").split()
+            collections = (data.getVar('BBFILE_COLLECTIONS') or "").split()
+            invalid = []
+            for entry in bbfiles_dynamic:
+                parts = entry.split(":", 1)
+                if len(parts) != 2:
+                    invalid.append(entry)
+                    continue
+                l, f = parts
+                if l in collections:
+                    data.appendVar("BBFILES", " " + f)
+            if invalid:
+                bb.fatal("BBFILES_DYNAMIC entries must be of the form <collection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
+
         if not data.getVar("BBPATH"):
             msg = "The BBPATH variable is not set"
             if not layerconf:

base-commit: 705ab252e631903e6d2e46202b419a9e8adcd861
-- 
git-series 0.9.1

