Return-Path: <matthias.schiffer@ew.tq-group.com>
X-Greylist: delayed 590 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 22 May 2019 09:23:14 UTC
Received: from mx1.tq-group.com (mx1.tq-group.com [62.157.118.193])
	by mail.openembedded.org (Postfix) with ESMTP id A2BD87E39C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2019 09:23:14 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.60,498,1549926000"; 
   d="scan'208";a="7525096"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
	by mx1-pgp.tq-group.com with ESMTP; 22 May 2019 11:13:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
	by tq-pgp-pr1.tq-net.de (PGP Universal service);
	Wed, 22 May 2019 11:13:24 +0200
X-PGP-Universal: processed;
	by tq-pgp-pr1.tq-net.de on Wed, 22 May 2019 11:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
	t=1558516404; x=1590052404;
	h=from:to:cc:subject:date:message-id;
	bh=wvCPn3Ca9ZNkAro+EwdBlyOpDhDsBczrlFe41WaUiYc=;
	b=Bbm5mEQRfxHvX+/LV840K0y1oVRpTDY60WHxBKsHZYd+Oc9lJdyxxoYA
	TGaEyimLHKiXTFUHWk6OQSIC+GvzDL012wbp2PRYoAqNOLr66sQVUGNEO
	S48Yk9psNMP5ukLgPZgECaBt8A3W5/IQsALZz/Ywi6sro8CdMYtEl65z+
	OxSKIOrzWylkXtWxvZ1OqplVy+lS3dubXlYZ6ywcqUHKBWUudN7tajP+V
	p7YkQDShpdhPHWoFrNWB8iLdMzdvJw4qsj1/c/ZDyIHRkCw+2fcBicblu
	AwRYDY+ACZAAHN4LUu9QfJ8pV2hs0M0rgLMvvHmPxtaoJYD00HK69Ve5L Q==;
X-IronPort-AV: E=Sophos;i="5.60,498,1549926000"; 
   d="scan'208";a="7525095"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
	by mx1.tq-group.com with ESMTP; 22 May 2019 11:13:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de
	[10.117.49.26])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 37875280074;
	Wed, 22 May 2019 11:13:23 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2019 11:13:10 +0200
Message-Id: <20190522091310.14470-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH master 1.42] fetch2: runfetchcmd(): unset _PYTHON_SYSCONFIGDATA_NAME
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
X-List-Received-Date: Wed, 22 May 2019 09:23:15 -0000

Since warrior, python3native.bbclass sets _PYTHON_SYSCONFIGDATA_NAME;
unfortunately, this also affects Python scripts run as fetch commands like
git-make-shallow, breaking it with a message like

    Failed to import the site module
    Traceback (most recent call last):
      File "/usr/lib/python3.6/site.py", line 570, in <module>
        main()
      File "/usr/lib/python3.6/site.py", line 556, in main
        known_paths = addusersitepackages(known_paths)
      File "/usr/lib/python3.6/site.py", line 288, in addusersitepackages
        user_site = getusersitepackages()
      File "/usr/lib/python3.6/site.py", line 264, in getusersitepackages
        user_base = getuserbase() # this will also set USER_BASE
      File "/usr/lib/python3.6/site.py", line 254, in getuserbase
        USER_BASE = get_config_var('userbase')
      File "/usr/lib/python3.6/sysconfig.py", line 607, in get_config_var
        return get_config_vars().get(name)
      File "/usr/lib/python3.6/sysconfig.py", line 550, in get_config_vars
        _init_posix(_CONFIG_VARS)
      File "/usr/lib/python3.6/sysconfig.py", line 421, in _init_posix
        _temp = __import__(name, globals(), locals(), ['build_time_vars'], 0)
    ModuleNotFoundError: No module named '_sysconfigdata'

on an Ubuntu 18.04 system (and likely others) when building with
BB_GIT_SHALLOW and BB_GENERATE_SHALLOW_TARBALLS.

Unset _PYTHON_SYSCONFIGDATA_NAME in runfetchcmd() to work around this.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

I think this (or a different fix for this issue) should be added to both
master and 1.42, as Yocto warrior is affected.

Note that this fix assumes that the host Python does not need a
_PYTHON_SYSCONFIGDATA_NAME, which should be true on most systems. A more
complete fix would be to reset _PYTHON_SYSCONFIGDATA_NAME to its original
value, but I don't know the Bitbake code well enough to do that.

 lib/bb/fetch2/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0126e0d7..f6b5529b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -843,6 +843,11 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
+    # Ensure that a _PYTHON_SYSCONFIGDATA_NAME value set by a recipe
+    # (for example via python3native.bbclass since warrior) is not set for
+    # host Python (otherwise tools like git-make-shallow will fail)
+    cmd = 'unset _PYTHON_SYSCONFIGDATA_NAME; ' + cmd
+
     # Disable pseudo as it may affect ssh, potentially causing it to hang.
     cmd = 'export PSEUDO_DISABLED=1; ' + cmd
 
-- 
2.17.1


