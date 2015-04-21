Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C042D73D6D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Apr 2015 09:07:32 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3L97XpX015959
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Apr 2015 02:07:34 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Tue, 21 Apr 2015 02:07:33 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Apr 2015 02:07:33 -0700
Message-ID: <a76c78db62cc1254387c8d4a556f0d8c54df704f.1429607216.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1429607216.git.liezhi.yang@windriver.com>
References: <cover.1429607216.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker.py: change working dir before use pyinotify
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
X-List-Received-Date: Tue, 21 Apr 2015 09:07:32 -0000
Content-Type: text/plain

Fixed:
$ cd tmp/work/core2-64-poky-linux/bash/4.3-r1
$ bitbake bash -cclean

ERROR: Running idle function
Traceback (most recent call last):
  File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 1317, in Notifier.process_events():
                     continue
    >            revent = self._sys_proc_fun(raw_event)  # system processings
                 if watch_ and watch_.proc_fun:
  File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 686, in _SysProcessEvent.__call__(event=<_RawEvent cookie=0 mask=0x40000200 name=build wd=5 >):
             # 3- default call method process_default
    >        return self.process_default(event)

  File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 897, in _SysProcessEvent.process_default(raw_event=<_RawEvent cookie=0 mask=0x40000200 name=build wd=5 >, to_append=None):
                 dict_.update(to_append)
    >        return Event(dict_)

  File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 628, in Event.__init__(raw={'path': '.', 'wd': 5, 'mask': 1073742336, 'name': 'build', 'dir': True}):
                     self.pathname = os.path.abspath(os.path.join(self.path,
    >                                                             self.name))
                 else:
  File "/usr/lib/python2.7/posixpath.py", line 347, in abspath(path='./build'):
             else:
    >            cwd = os.getcwd()
             path = join(cwd, path)
OSError: [Errno 2] No such file or directory

And we can't run bitbake again:
ERROR: Only one copy of bitbake should be run against a build directory

Chaneg working dir to TOPDIR rather than the dir which runs the command
will fix the problem. Move self.initConfigurationData ahead, otherwise,
there is no self.data.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c101f2..678a2f7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -121,6 +121,9 @@ class BBCooker:
 
         self.configuration = configuration
 
+        self.initConfigurationData()
+        os.chdir(self.data.expand('${TOPDIR}'))
+
         self.configwatcher = pyinotify.WatchManager()
         self.configwatcher.bbseen = []
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
@@ -131,9 +134,6 @@ class BBCooker:
         self.watcher.bbseen = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
-
-        self.initConfigurationData()
-
         self.inotify_modified_files = []
 
         def _process_inotify_updates(server, notifier_list, abort):
-- 
1.7.9.5


