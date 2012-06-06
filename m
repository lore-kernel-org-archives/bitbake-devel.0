Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1ScD4k-0002mA-LF
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 12:02:50 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q569qMic002833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 6 Jun 2012 02:52:22 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 6 Jun 2012 02:52:22 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Wed, 6 Jun 2012 17:52:24 +0800
Message-ID: <51b90e87ce488333de3cd279968aaf4807ab4df7.1338976258.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338976258.git.kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 2/6] ui/crumbs/hig.py: fix run time error
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 06 Jun 2012 10:02:51 -0000
Content-Type: text/plain

Commit 094742bed2fc01d55f572da946fcfa7a48521401 re-implement the
function popen_read(). If there is no USB device, it crashes with
"ExecutionError: Execution of 'ls /dev/disk/by-id/usb*' failed with exit
code 2:"

Replace popen_read() way with glob module to get the USB devices.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 7c9e73f..893fad4 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -20,6 +20,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import glob
 import gtk
 import gobject
 import hashlib
@@ -806,7 +807,7 @@ class DeployImageDialog (CrumbsDialog):
 
     def find_all_usb_devices(self):
         usb_devs = [ os.readlink(u)
-            for u in self.popen_read('ls /dev/disk/by-id/usb*').split()
+            for u in glob.glob('/dev/disk/by-id/usb*')
             if not re.search(r'part\d+', u) ]
         return [ '%s' % u[u.rfind('/')+1:] for u in usb_devs ]
 
-- 
1.7.5.4



