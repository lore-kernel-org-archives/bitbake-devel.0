Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 434FA60667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:44 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47007647pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=/cAEj264AFDu1SeQAVB8lzeoVDXk1iDZ4lQvl/jmnGo=;
	b=V551wKSeuS9CVzcSdAikXAtcxBBiyhx2Nk/HVIRmxhrGsjj8P9KyrQA8pInLVYM/Ry
	0CNBi71wycf3lZo5K1At9mZJfBW6Ilhf1zQ2p+GtGc9Kv98oBcfENx9hxazvW1p/2/Hd
	uhnMwcSyfHN9n2GXSeVTOsCX8Qy3l3eTG9NjWRFjlCKT+R03BW3CusjrVQ5z2TYWk4PK
	PWFvuUdmSg8KUFeBwBEzp0CcYd7qeq1lVEsriInXgBYzCIVo3SeEx8kixudIH1THZVTG
	vMZ3LZZYLltRFfEq9VyV8mrQhM5tNSRf9CTv0ypiHnlalr9dlY+PT7JhpTJCkW9yN/Iu
	AOyA==
X-Received: by 10.98.2.213 with SMTP id 204mr6544495pfc.9.1449079185789;
	Wed, 02 Dec 2015 09:59:45 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:44 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:45 -0800
Message-Id: <0991663c5262edfc894d8f55a6a5db4e7f448c2a.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 13/30] toaster: implement 'toaster restart-bitbake'
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:45 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This implementation allows to have functionality of restarting
bitbake in toaster script. It can be used by toaster script and
build controllers.

[YOCTO #8279]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/toaster b/bin/toaster
index 34a4e8f..c89e015 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -268,6 +268,15 @@ if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
     exit 1
 fi
 
+if [ "$1" = 'restart-bitbake' ] ; then
+    stop_bitbake
+    sleep 1
+    start_bitbake
+    rc=$?
+    sleep 1
+    return $rc
+fi
+
 if ! verify_prereq; then
     echo "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
     return 1
-- 
1.9.1


