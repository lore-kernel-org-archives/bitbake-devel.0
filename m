Return-Path: <raj.khem@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id E0A8B7F8E5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 04:10:00 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id q16so6809587plr.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Nov 2019 20:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LmPxm7urxhCbReLnEQmlap6MOqJrxQK3k7T4pGj/eb4=;
	b=uLsTOQoHrkBLF9nl1AVmqWn131b4Nuwx9Dkp9KERorNv1+9Nk41idP8xC/IdFkzTTK
	JkCGm7LGoBINZXl4HgCg+gWBT1x5Wjt/3dM2QmEBNVYLnvJnIkrB87jiWJi1IRArLUbr
	urAm4ZUtP31TXuyJqLqygjpEFuy4zoc9iLihInj/MmSixrVV/FdhwGM97osH+cxq3SES
	OcdfUBhdIkzoKP17tHFRtbII5T8V1Y6gZt7GZ2EGQ0Xt+Ze2htt3czjN3SJ8k07Ytg2f
	MIC5N8My9jnkbT0z6Pg2dtG4E8VKjrWFLHU5CkpjS2W2g6mg+VMtLjsIqx8hb49f48+L
	+8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LmPxm7urxhCbReLnEQmlap6MOqJrxQK3k7T4pGj/eb4=;
	b=TgVCLj/yzdYervLsVdJHu/Txerw7ov+aHGTetODA2pq/1d+ataHZ0MZK5bDnZiLmmu
	Y2urfDXiGBx68jP2ee4oV+Tfjsh94qNmm9GlS2e4DZq/7xRV8JLvsQ5K3g6mheGu8ZW6
	WCXwOo5haSSFMRdEG/3aDEaUal6+EFZluOD0P7fSv5WTTVzyB2y4oFcJJXC/NQHgrv2R
	Q11TDcU7vliad2dwYP0UTCOJ6dk+tprYYgk4CqRYIpKnUmpb0D5IcxXipAH8NxoYyyNy
	NKMgqKujNTx5c1kZoP3z8HpHBCsLiLtbBbcKyS3V5rMGRe43r0pItyVo26gphrAx/UCW
	0srw==
X-Gm-Message-State: APjAAAUpZCT98BCHRiKAqhpsI8Q9fHKwhCtdR8IKk6bmyf+dEt82V2RM
	OIphh+Z6aEhdWlTNXA7vEZfEDqAprx4=
X-Google-Smtp-Source: APXvYqykVHFV9NQ9J2JWSetsz+iKwO9qVqcAyYtM0IOzhn/fbrnyoLX5canCUNzindg/EzjINWmKHQ==
X-Received: by 2002:a17:90a:8990:: with SMTP id
	v16mr10566420pjn.114.1574914201223; 
	Wed, 27 Nov 2019 20:10:01 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:8500:1c20::e439])
	by smtp.gmail.com with ESMTPSA id
	x7sm18121703pfa.107.2019.11.27.20.10.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 27 Nov 2019 20:10:00 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Nov 2019 20:09:47 -0800
Message-Id: <20191128040947.3413821-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Subject: [PATCH] hg: Add python3-native to native paths
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
X-List-Received-Date: Thu, 28 Nov 2019 04:10:01 -0000
Content-Transfer-Encoding: 8bit

This helps fix an issue where python interpreter in hg script could
overflow the BINPRM_BUF_SIZE which is 128 on most of systems, because
interpreter is hardcoded and build paths can be deep.

This patch helps, because now the absolute python interp path in hg can
be replaced with '/usr/bin/env python3' and it will ensure that python3
from native install is used instead of the one on host.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/bb/fetch2/hg.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index e21115de..a640a80c 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -65,6 +65,7 @@ class Hg(FetchMethod):
         ud.pkgdir = os.path.join(hgdir, hgsrcname)
         ud.moddir = os.path.join(ud.pkgdir, ud.module)
         ud.localfile = ud.moddir
+        d.appendVar("EXTRANATIVEPATH", " python3-native ")
         ud.basecmd = d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
 
         ud.setup_revisions(d)
-- 
2.24.0


