Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S1Bio-00009i-Fa
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 08:07:10 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Feb 2012 22:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="70177515"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Feb 2012 22:58:45 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Andreas Oberritter <obi@opendreambox.org>
In-Reply-To: <4F48217F.6040406@opendreambox.org>
References: <4F48217F.6040406@opendreambox.org>
Date: Sat, 25 Feb 2012 14:56:46 +0800
Message-ID: <1330153006.1957.10.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: cache broken in master
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
X-List-Received-Date: Sat, 25 Feb 2012 07:07:10 -0000
X-Groupsio-MsgNum: 1045
Content-Type: multipart/mixed; boundary="=-5eNi4eqze4WOQbWVvuQM"

--=-5eNi4eqze4WOQbWVvuQM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
> Hi,
> 
> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
> dependency cache for me, i.e. it parses all recipes on every invocation
> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache didn't
> help. Reverting this commit restores the functionality.

Hi Andreas,

Sorry for the inconvenience that this commit brought to you.

Could you help to try the following and send me your "/tmp/1.log
and /tmp/2.log"?

1) apply the attached "cache_debug.patch"
2) remove tmp/cache
3) bitbake -p &> /tmp/1.log
4) bitbake -p &> /tmp/2.log

Besides, you can have a try of the attached cache_whitelist.patch to see
if it fixes your problem.

Thanks,
Dongxiao

> 
> Regards,
> Andreas


--=-5eNi4eqze4WOQbWVvuQM
Content-Disposition: attachment; filename="cache_debug.patch"
Content-Type: text/x-patch; name="cache_debug.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 24c7a8f..29af5e5 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -478,5 +478,6 @@ class DataSmart(MutableMapping):
             else:
                 value = self.getVar(key, False) or ""
             data = data + key + ': ' + str(value) + '\n'
+        print("The data for hash is: %s" % data)
 
         return hashlib.md5(data).hexdigest()

--=-5eNi4eqze4WOQbWVvuQM
Content-Disposition: attachment; filename="cache_whitelist.patch"
Content-Type: text/x-patch; name="cache_whitelist.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 24c7a8f..dbf2002 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -463,20 +463,12 @@ class DataSmart(MutableMapping):
 
     def get_hash(self):
         data = ""
-        keys = iter(self)
+        basewhitelist = set((self.getVar("BB_HASHBASE_WHITELIST", True) or "").split())
+        keys = set(key for key in iter(self) if not key.startswith("__"))
         for key in keys:
-            if key in ["TIME", "DATE"]:
+            if key in basewhitelist:
                 continue
-            if key == "__depends":
-                deps = list(self.getVar(key, False))
-                deps.sort()
-                value = [deps[i][0] for i in range(len(deps))]
-            elif key == "PATH":
-                path = list(set(self.getVar(key, False).split(':')))
-                path.sort()
-                value = " ".join(path)
-            else:
-                value = self.getVar(key, False) or ""
+            value = self.getVar(key, False) or ""
             data = data + key + ': ' + str(value) + '\n'
 
         return hashlib.md5(data).hexdigest()
diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index 90e5f7a..133a957 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -727,7 +727,7 @@ BB_CONSOLELOG = "${TMPDIR}/cooker.log.${DATETIME}"
 
 # Setup our default hash policy
 BB_SIGNATURE_HANDLER ?= "OEBasic"
-BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD BB_TASKHASH BBPATH DL_DIR SSTATE_DIR THISDIR FILESEXTRAPATHS FILE_DIRNAME HOME LOGNAME SHELL TERM USER FILESPATH STAGING_DIR_HOST STAGING_DIR_TARGET COREBASE PRSERV_HOST PRSERV_PORT PRSERV_DUMPDIR PRSERV_DUMPFILE PRSERV_LOCKDOWN"
+BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD BB_TASKHASH BBPATH DL_DIR SSTATE_DIR THISDIR FILESEXTRAPATHS FILE_DIRNAME HOME LOGNAME SHELL TERM USER FILESPATH STAGING_DIR_HOST STAGING_DIR_TARGET COREBASE PRSERV_HOST PRSERV_PORT PRSERV_DUMPDIR PRSERV_DUMPFILE PRSERV_LOCKDOWN DATE TIME"
 
 MLPREFIX ??= ""
 MULTILIB_VARIANTS ??= ""

--=-5eNi4eqze4WOQbWVvuQM--
