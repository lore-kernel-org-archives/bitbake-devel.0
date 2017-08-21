Return-Path: <kergoth@gmail.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail.openembedded.org (Postfix) with ESMTP id 5072078202
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 16:37:50 +0000 (UTC)
Received: by mail-wr0-f194.google.com with SMTP id p8so15887371wrf.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7oAFyj99KlEZVUs8XcuHdx9+Au6XdNrUqZZfzIi5Ss0=;
	b=jhxCm3XIH2gSe2Cl5arrKHP/1Hqvz98WP8783hAO2K3hCt5K9uKdxG0Lxfhfabtt9k
	NH1wYBEUdP+4P0vdnfLBBgKbYS2dDIAeGq595h8Pm3uVOodUfx9gOsbhSMKqWTuRYz4U
	qJwB8KawBGgeXX3O1NsCiAvgw5xVlbcGrCsiKkKb2exrB7Qf++QcPO4VVfgD9SSXU7xX
	lUKo+7K62TVc83jmDxwZxkIrwQOjjcKNj79hIfh22yGNv/733LuHx+j9VCaS62R79XVY
	wTXLPhlIGqepqLB2UPhK48+Y91eIF403r+B1BOKDq963aQh9hNBuNt0qopU8xP2V4mtW
	3Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7oAFyj99KlEZVUs8XcuHdx9+Au6XdNrUqZZfzIi5Ss0=;
	b=TBU7qVGyuvR9anQV+IQLaaySEow+od+AQ1E9uWt+4Rf8qdQ2kPD5qQGxRGA1Vqb3Zh
	fVEOrQd71n2mm/Zl2PGdOuUVPScho6TSZC5ZSkcn/z2M3chOCUvd4+567MiWL3DH/mjl
	cEsmp/6YnX5Tls4BAimaievv2T1ZkREc1dTM76zFL5/IMWniz+9gD7Qef1SAjQ3wbAGn
	xYFB6ibCV8RIDnMU+K+e7HsX5FcnNgSTZGRNT0Od4DLqqk9CYf0ewxLGbbU0wdopf67B
	jDIILAwB+VRw+2zOGnoYH0f7K6oaqvasiam6f9q9am+oRar4QM4X3ppaok78W2qdNc21
	ADQA==
X-Gm-Message-State: AHYfb5gLMJ/31dnW7wA4wZDjvoIhyswMchlI3NHN9bpM6Tu1pAjNCOy/
	speMHNDAv4UoKELr78g=
X-Received: by 10.28.138.83 with SMTP id m80mr270915wmd.47.1503333471823;
	Mon, 21 Aug 2017 09:37:51 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id 62sm9933965wrb.12.2017.08.21.09.37.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Aug 2017 09:37:50 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Aug 2017 21:37:41 +0500
Message-Id: <20170821163741.28301-2-kergoth@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170821163741.28301-1-kergoth@gmail.com>
References: <20170821163741.28301-1-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] Revert "fetch2/gitsm: Fix when repository change submodules"
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
X-List-Received-Date: Mon, 21 Aug 2017 16:37:51 -0000

From: Christopher Larson <chris_larson@mentor.com>

This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.

This commit caused the gitsm fetcher to download submodules from upstream in
do_unpack, rather than using the previously fetched submodules from DL_DIR.

[YOCTO #11830]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/gitsm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..167b77a1 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -131,5 +131,6 @@ class GitSM(Git):
         Git.unpack(self, ud, destdir, d)
 
         if self.uses_submodules(ud, d, ud.destdir):
+            runfetchcmd('cp -fpPRH "%s/modules" "%s/"' % (ud.clonedir, os.path.join(ud.destdir, '.git')), d)
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
             runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
-- 
2.11.1


