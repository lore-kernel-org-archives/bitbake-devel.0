Return-Path: <prvs=973ddaea1=Stefan.Klug@baslerweb.com>
X-Greylist: delayed 593 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 18 Mar 2019 14:08:26 UTC
Received: from mail01.baslerweb.com (mail01.baslerweb.com [80.156.24.166])
	by mail.openembedded.org (Postfix) with ESMTP id 3A3C47C6B5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 14:08:25 +0000 (UTC)
Received: from unknown (HELO ahr206s.basler.corp) ([172.16.20.206])
	by mail01-out.baslerweb.com with ESMTP; 18 Mar 2019 14:58:35 +0100
From: Stefan Klug <stefan.klug@baslerweb.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Mar 2019 14:58:18 +0100
Message-ID: <20190318135820.7344-2-stefan.klug@baslerweb.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318135820.7344-1-stefan.klug@baslerweb.com>
References: <20190318135820.7344-1-stefan.klug@baslerweb.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.85.155]
X-ClientProxiedBy: ahr206s.basler.corp (172.16.20.206) To ahr206s.basler.corp
	(172.16.20.206)
X-C2ProcessedOrg: edc209ba-7b98-423a-8e4d-b8fa22bc0743
Subject: [PATCH 1/3] fetch2: Fix fetching of git repositories with kerberos authentication
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
X-List-Received-Date: Mon, 18 Mar 2019 14:08:26 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

When using pam_krb to login to a system KRB5CCNAME is set to the
corresponding kerberos auth cache file. The bitbake fetcher removes
this variable from the environment leading to a git authentication failure.
Also the fetcher ignores the normally used BB_ENV_[EXTRA_]WHITE
variables and relies on a hardcoded list.
Therefore it is impossible to fix this issue outside of bitbake.

Signed-off-by: Stefan Klug <stefan.klug@baslerweb.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f112067d..df8e83e7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -830,6 +830,7 @@ def runfetchcmd(cmd, d, quiet=3DFalse, cleanup=3DNone, =
log=3DNone, workdir=3DNone):
                   'GIT_SSH',
                   'GIT_SSL_CAINFO',
                   'GIT_SMART_HTTP',
+                  'KRB5CCNAME',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD',
                   'DBUS_SESSION_BUS_ADDRESS',
--=20



