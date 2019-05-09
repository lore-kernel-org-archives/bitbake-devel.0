Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3BD097DFB8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 May 2019 08:03:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x4983aAl003353
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 May 2019 01:03:46 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 9 May 2019 01:03:25 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 May 2019 16:03:03 +0800
Message-ID: <ac4edd962cb6b4831cb85cd731d2d2a810c62503.1557388944.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557388944.git.liezhi.yang@windriver.com>
References: <cover.1557388944.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: cookerdata: Avoid double exceptions for bb.fatal()
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
X-List-Received-Date: Thu, 09 May 2019 08:03:56 -0000
Content-Type: text/plain

The bb.fatal() raises BBHandledException() which causes double exceptions,
e.g.:

Add 'HOSTTOOLS += "hello"' to conf/local.conf:
$ bitbake -p
[snip]
During handling of the above exception, another exception occurred:
[snip]
ERROR: The following required tools (as specified by HOSTTOOLS) appear to be unavailable in PATH, please install them in order to proceed:
  hello

Use "raise" rather than "raise bb.BBHandledException" to fix the double
exceptions.

[YOCTO #13267]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cookerdata.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index f8ae410..585edc5 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -301,7 +301,9 @@ class CookerDataBuilder(object):
             if multiconfig:
                 bb.event.fire(bb.event.MultiConfigParsed(self.mcdata), self.data)
 
-        except (SyntaxError, bb.BBHandledException):
+        except bb.BBHandledException:
+            raise
+        except SyntaxError:
             raise bb.BBHandledException
         except bb.data_smart.ExpansionError as e:
             logger.error(str(e))
-- 
2.7.4


