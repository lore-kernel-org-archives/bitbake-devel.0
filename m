Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 01F2177179;
	Tue,  2 Feb 2016 14:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12E82I2004430; Tue, 2 Feb 2016 14:08:02 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id u7ZSuU-Feiwy; Tue,  2 Feb 2016 14:08:02 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12E7wKP004426
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 2 Feb 2016 14:07:59 GMT
Message-ID: <1454422078.27087.76.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 14:07:58 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Subject: [PATCH] build/data: Don't expand python functions before execution [API change]
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
X-List-Received-Date: Tue, 02 Feb 2016 14:08:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Right now, if you have some python code like:

X = "a"

def somefunction(d):
    d.setVar("X", "b")
    d.setVar("Y", "${X}")

then any sane person would expect that Y = "b" at the end of the
function. This is not the case, Y = "a".

This is due to the python function being expanded before execution, the
executed code would read d.setVar("Y", "a"). This understandably
confuses people, it also makes it near impossible to write ${} in a
python function without unintended things happening.

I think there is general agreement we should fix this and standardise
on non-expansion of python functions. We already don't expand anonymous
python (mostly).

I've checked OE-Core with buildhistory before and after this change and
there were a small number of issues this exposed which I've sent
patches for.

I propose we default to not expanding python code and then deal with
any consequences from that if/as/where identified. This will improve
new user understanding and usability of the system, it also allows
several long standing weird expansion issues to be fixed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 52a4916..b7c49eb 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -239,7 +239,7 @@ def exec_func_python(func, d, runfile, cwd=None):
     """Execute a python BB 'function'"""
 
     bbfile = d.getVar('FILE', True)
-    code = _functionfmt.format(function=func, body=d.getVar(func, True))
+    code = _functionfmt.format(function=func, body=d.getVar(func, False))
     bb.utils.mkdirhier(os.path.dirname(runfile))
     with open(runfile, 'w') as script:
         bb.data.emit_func_python(func, script, d)
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 1f1f0d2..86ad4ed 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -308,7 +308,7 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
 
     write_func(func, o, True)
     pp = bb.codeparser.PythonParser(func, logger)
-    pp.parse_python(d.getVar(func, True))
+    pp.parse_python(d.getVar(func, False))
     newdeps = pp.execs
     newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
     seen = set()



