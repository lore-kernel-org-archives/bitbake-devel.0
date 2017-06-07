Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
	[209.85.214.44])
	by mail.openembedded.org (Postfix) with ESMTP id A13847810C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 13:56:37 +0000 (UTC)
Received: by mail-it0-f44.google.com with SMTP id x129so14439935ite.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Jun 2017 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s2YsRVmJkeiuRr2Qrv0YOfiWhQ9r0hJJoIJ8aAPOs6w=;
	b=FRfLddNNQEMcUXfs/9zHwd8Qhb48g7navCfe5yEVZ2wZuFGWxpb928ObisfNKigiv/
	uNxO8o8H7wkDjyFyUD9g21FBWJnZwOrzx+FFx7LCVm1+gZYoxWE4YV7hghWotF96TQEX
	BOoVucoycvfzMTbUhMdW1cmQPUgR/M8GEjfWLLguE3bp0ePwxDp2rj2Uhnb+aIEY2OzE
	BSHI7rPD1Znw24wVSyVjHXiIEWkxArEkvHXKqKHgPDWw5qrsD/O/Og0dIRkOrhzlDSdr
	FeJ4OamAl0BYelMkL7CCQS6hJW0sus1R3XEn20fNWdPRrb9zqHH+E/tbqzHMcziGsbEL
	rkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s2YsRVmJkeiuRr2Qrv0YOfiWhQ9r0hJJoIJ8aAPOs6w=;
	b=Ni91DZAV2AS5NDoQZTAoi/mi6OVyMZkmMqJGCkQL7aK1tijLEiXkiiH9Pp516BBoZw
	6a5IiQ3b7b7EhWcAnEtAUwgBIJsQMqb+xSumo1SFfkF4fk1VTIAS9f1J7XOQsZzGOXfN
	0a6z27Iql6qb/mm7j0hgSBRF613FYeasZqF7d4xyR0GI2YgqODmwg3hFWSaVfP3SKuvr
	a0Y/TAxqPErwEKTB5NBTDN6U5wFKVIKpEEBE5Lu35rmBWIfgBkhye8MXkaIwNItk5Wy5
	Ynj03lsOUC1szChtkq55GjjCfVkW+dpqR5z5nTdwobxk3WT2sRYdcvHJ8rfw+wLxvpXD
	R7qg==
X-Gm-Message-State: AODbwcCSjVw7aBO1nJPs07D1ABohymGq3bTv1sL6qidNh9+jnocjaTRh
	NyjIZAYTWk3kCXKEjoA=
X-Received: by 10.36.211.69 with SMTP id n66mr2888101itg.36.1496843798200;
	Wed, 07 Jun 2017 06:56:38 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8FFF1.dip0.t-ipconnect.de.
	[93.232.255.241]) by smtp.gmail.com with ESMTPSA id
	e32sm1065133itd.18.2017.06.07.06.56.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 07 Jun 2017 06:56:37 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 15:56:25 +0200
Message-Id: <bde65477ce3b1070afeb82ee70eee2e8b006614d.1496843701.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
References: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
Subject: [PATCH 2/2] ConfHandler.py: allow inherit or include with multiple parameters
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
X-List-Received-Date: Wed, 07 Jun 2017 13:56:37 -0000

"inherit" already allows inheriting more than one class in a single
statement. The same also makes sense for "include" and "require",
because then one can generate a list of files to be included
dynamically also for the case that more than one file needs to be
included.

For example, with a new utility method, include files could be
included depending on the current distro features like this:

   require ${@ oe.utils.optional_includes(d, \
               "foo,bar:foo-or-bar.inc xyz:x.inc,y.inc,z.inc", \
               "DISTRO_FEATURES")}

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index b006d06..97aa130 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -69,21 +69,25 @@ def init(data):
 def supports(fn, d):
     return fn[-5:] == ".conf"
 
-def include(parentfn, fn, lineno, data, error_out):
+def include(parentfn, fns, lineno, data, error_out):
     """
     error_out: A string indicating the verb (e.g. "include", "inherit") to be
     used in a ParseError that will be raised if the file to be included could
     not be included. Specify False to avoid raising an error in this case.
     """
-    if parentfn == fn: # prevent infinite recursion
-        return None
-
-    fn = data.expand(fn)
+    fns = data.expand(fns)
     parentfn = data.expand(parentfn)
 
-    if not fn:
-        # "include" or "require" without parameter is fine, just return.
-        return
+    # "include" or "require" accept zero to n space-separated file names to include.
+    for fn in fns.split():
+        include_single_file(parentfn, fn, lineno, data, error_out)
+
+def include_single_file(parentfn, fn, lineno, data, error_out):
+    """
+    Helper function for include() which does not expand or split its parameters.
+    """
+    if parentfn == fn: # prevent infinite recursion
+        return None
 
     if not os.path.isabs(fn):
         dname = os.path.dirname(parentfn)
-- 
git-series 0.9.1

