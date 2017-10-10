Return-Path: <jpuhlman@mvista.com>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 23A65606A8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Oct 2017 21:47:25 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id n14so16726993pfh.8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Oct 2017 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=U449/C27lKe30ztvIn5tA9v2Wr+Nx/DDw3nNgCqgylY=;
	b=vlz6uxxIT8j/F2U3DegZI+SZvI+og3+9ORK3Xi4AchclNCoVDI21wbXJkFp3ZItj6i
	IbZbHcuMmb5CMwgN0mZWRQ/8Xk7BzVDvlIkkDOjuwHvQtaaNlVlsk9AE2WsrQhyObRD/
	qNXRu7s0BwtHaowPTJPCj2IEZSTJ9nR+wupZNXe3B2l5/4q4Jb8IVBF6ylItkb9MsXlB
	UODK/D9yKNktM6jaB+KOA7M5eMxmo9kboiLyz+nbQndjbcMDUjKhiuS2hWYgrheHo79F
	ZO314bgb29pNIQMv/IAqmohIPMdV2NmXi/kyUiB/Zfs/lV4hf74hCLeWHbm6YR105I9s
	1WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=U449/C27lKe30ztvIn5tA9v2Wr+Nx/DDw3nNgCqgylY=;
	b=NvxBj58lQ96SVI3AiSxNzS28VvFXqA+eUAM79nEB9YD9+vTUbJzlbf8fX+iCHDc3Sw
	IDjAInNSjGVf2wee7KVB16FPzPTMnsV75T5MOSZzpHkm7yMrsW5U9KHSh4betqojEDNp
	7LjtCnVEw3eUGVaTllUjad9Vs2ferzyklERLlLo1ER1ADbu5dhk1OcahWyJ+XLxUJo+i
	JkCm+xVeJKRSeYHBXQPh+r57tpygYUrHXgmbvbKy0PcrNL/sUbhweT++NF/NAfZ0QKbm
	QOSDk55PQ0CmKva21MvLTMEd2LE2r45Yifb4W3VJ44yLvlJ6HJw1yELetVqqNa64biq4
	3KzA==
X-Gm-Message-State: AMCzsaWDDqABxGi/O1K7rMO9bmcw36ewj4UeEQspTeJlLmyUQzBEx3iI
	ZbR9GI41BjnaPrSTQOilcu03RBP/
X-Google-Smtp-Source: AOwi7QDQlhnuunyqFTQkoxWUzGyVj+3emXF25MmXJiYlusIV8L2mAqZHZx8nn2tAhpAvVe7+weg2hg==
X-Received: by 10.84.248.10 with SMTP id p10mr7246943pll.447.1507672047032;
	Tue, 10 Oct 2017 14:47:27 -0700 (PDT)
Received: from workhorse.mvista.com
	(99-0-9-164.lightspeed.frokca.sbcglobal.net. [99.0.9.164])
	by smtp.gmail.com with ESMTPSA id
	q69sm11080493pfg.127.2017.10.10.14.47.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 10 Oct 2017 14:47:26 -0700 (PDT)
From: Jeremy Puhlman <jpuhlman@mvista.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Oct 2017 14:47:17 -0700
Message-Id: <1507672037-29948-1-git-send-email-jpuhlman@mvista.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] Allow layers to be added relative to topdir.
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
X-List-Received-Date: Tue, 10 Oct 2017 21:47:26 -0000

From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>

Use case:
Some users place their projects and their layers under source control.
If absolute paths are used for the layers, the bblayers file is invalid
when checked out on another system. If the layers are checked in
relative to the project, then the project can be used anywhere.

If LAYERS_RELATIVE is set in the bblayers.conf file, each layer is added
relative to TOPDIR.

Signed-off-by: Jeremy Puhlman <jpuhlman@mvista.com>
---
 lib/bblayers/action.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index b1326e5..4dc6622 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -38,7 +38,9 @@ class ActionPlugin(LayerPlugin):
         tempdir = tempfile.mkdtemp()
         backup = tempdir + "/bblayers.conf.bak"
         shutil.copy2(bblayers_conf, backup)
-
+        if self.tinfoil.config_data.getVar('LAYERS_RELATIVE'):
+            topdir = self.tinfoil.config_data.getVar('TOPDIR')
+            layerdir = os.path.join("${TOPDIR}", os.path.relpath(layerdir,topdir))
         try:
             notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
             if not (args.force or notadded):
-- 
2.6.2


