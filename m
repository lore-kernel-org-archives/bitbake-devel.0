Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C22497DB52
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 11:12:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id x8RBCGuK007594
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 04:12:17 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Fri, 27 Sep 2019 04:12:16 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Sep 2019 19:12:17 +0800
Message-ID: <8121dd1383d22906019e908a4f6ffd9578a53dcc.1569582663.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1569582663.git.liezhi.yang@windriver.com>
References: <cover.1569582663.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] corosync: Fix PACKAGECONFIG flag for rdma
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
X-List-Received-Date: Fri, 27 Sep 2019 11:12:15 -0000
Content-Type: text/plain

Fixed:
PACKAGECONFIG_append_pn-corosync = ' rdma'

$ bitbake corosync
| configure: error: Package requirements (rdmacm) were not met:
|
| No package 'rdmacm' found

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 meta-networking/recipes-extended/corosync/corosync_2.4.4.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-networking/recipes-extended/corosync/corosync_2.4.4.bb b/meta-networking/recipes-extended/corosync/corosync_2.4.4.bb
index 23a3d14..e2ab25b 100644
--- a/meta-networking/recipes-extended/corosync/corosync_2.4.4.bb
+++ b/meta-networking/recipes-extended/corosync/corosync_2.4.4.bb
@@ -36,7 +36,7 @@ PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} \
 PACKAGECONFIG[dbus] = "--enable-dbus,--disable-dbus,dbus"
 PACKAGECONFIG[qdevice] = "--enable-qdevices,--disable-qdevices"
 PACKAGECONFIG[qnetd] = "--enable-qnetd,--disable-qnetd"
-PACKAGECONFIG[rdma] = "--enable-rdma,--disable-rdma"
+PACKAGECONFIG[rdma] = "--enable-rdma,--disable-rdma,librdmacm"
 PACKAGECONFIG[snmp] = "--enable-snmp,--disable-snmp,net-snmp"
 PACKAGECONFIG[systemd] = "--enable-systemd --with-systemddir=${systemd_system_unitdir},--disable-systemd --without-systemddir,systemd"
 
-- 
2.7.4


