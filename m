Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
 by mx.groups.io with SMTP id smtpd.web11.5180.1630679345806323491
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Sep 2021 07:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=XEkCNJQk;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.13, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1630679342; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Owv7Cuo7wa68I4UVjV8aCnSf9CJTn+vdQ4CK2drDSH+mp+3b7H0ZlWBX0AEiRxT1isY/xHgNCHv5zdzRzLJFXAls3nUvRd10dymcXi0iRC7tUYIjQjxQKMXapo3WXMFkWKUpDkQ8KyvxwV8Q+FJn1M/nRfNrGzClpodfLQr90u8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1630679342; h=Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=3lNhUZjFd2jmJNoDM6a4EcphIlWBSGvuzTHDge/y2oE=; 
	b=SqDXslKW39KAgXQHNMAgyb7vAFomwsU44juYOBm6KuwmlqdMqDRLQlE3LrI4lajbT7B4HQIU8A/JTMrx+u5f6+ZuGCKa01aHUa3TL8RpK9X4DO0YpbxyoUWp9TEG9Vz3mlrhOyUTmfY8y9RvDW1JnHEpVy/BdMcgQThbLKt1PsY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1630679342;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=3lNhUZjFd2jmJNoDM6a4EcphIlWBSGvuzTHDge/y2oE=;
	b=XEkCNJQk7mQHbMkvsK10L2RqyMuMH0wf4yTH/GJns/dAEZVqXKhsDdMVzC2gkoyP
	NNWOoh6OwCdIgp8Yi3A98DMa5tolDJcBNA/bj0az85mpcYrgb7hr+rIDrl/ChkbOsIu
	Pzq/wb8XJYV1rRhbFcUTNwitIBEcyNdgbIOK1v2k=
Received: from dell.wrobel.ignorelist.com (178.217.216.129 [178.217.216.129]) by mx.zohomail.com
	with SMTPS id 1630679337573190.70988724683934; Fri, 3 Sep 2021 07:28:57 -0700 (PDT)
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Only warn on potentially incompatible layer
Date: Fri,  3 Sep 2021 16:28:40 +0200
Message-Id: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-ZohoMailClient: External
Content-Transfer-Encoding: 8bit

It frequently happens that the 3rd party layer is, in practise,
fully compatible with the older version of yocto. So, instead of
false positively reporting an error, it seems to be more
appropriately to just emit the warning.

Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1c1e008c..ed678616 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -397,7 +397,7 @@ class CookerDataBuilder(object):
                     bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
                 compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
                 if compat and not (compat & layerseries):
-                    bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
+                    bb.warn("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
                               % (c, " ".join(layerseries), " ".join(compat)))
                 elif not compat and not data.getVar("BB_WORKERCONTEXT"):
                     bb.warn("Layer %s should set LAYERSERIES_COMPAT_%s in its conf/layer.conf file to list the core layer names it is compatible with." % (c, c))
-- 
2.31.1

