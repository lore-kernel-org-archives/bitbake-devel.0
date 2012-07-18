Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SrRKd-0007el-Tt; Wed, 18 Jul 2012 12:18:12 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6IA6pBD023642;
	Wed, 18 Jul 2012 11:06:51 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21945-08; Wed, 18 Jul 2012 11:06:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6IA6fpi023635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 11:06:42 +0100
Message-ID: <1342606005.30680.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-core <openembedded-core@lists.openembedded.org>
Date: Wed, 18 Jul 2012 11:06:45 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: PLEASE READ: Major change landing shortly (python whitespace)
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
X-List-Received-Date: Wed, 18 Jul 2012 10:18:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

It's become clear we have a horrible mixture of whitespace (tabs and
space) in python functions. At first glance this sounds trivial but
there is a serious problem if pieces of code get mixed together with
different whitespace since they may or may not work as intended.

The documented standard for python functions is four space indentation
although we have a mixture. Fixing this sounds simple at first, we just
go through and change tabs to spaces. The problem comes with _append and
_prepend to python functions since both need their whitespace changed at
the same time. populate_packages() is the real problem child in that
regard but its the less common examples I worry about.

I did some research and we have inconsistencies, even in existing
functions since people are editing files and getting confused
(understandably).

So the question becomes, how do we get ourselves out of this mess?

I put a proposal to the TSC, that we have bitbake warn/error whenever it
finds tab characters in any python function. The advantage of this is
that we give the user a clear definitive error. The downside is that
we'll have to go through all the metadata and scrub it for the problem.

The TSC agrees we should do something about this rather than perpetuate
the problem and that this is as good a solution as any of us can come up
with. We also agreed that we should do it sooner than later before it
gets any later in this release cycle. Putting it off until the next
release cycle didn't seem to offer any advantage, we might as well get
on with it.

So I am going to:

a) Try and flush through as many pending patches as I can.
b) Check in a warning into bitbake master and increase its version
c) Require that version in OE-Core
d) Commit a significant set of whitespace changes to OE-Core, resolving
all the warnings for OE-Core.

I plan to do this, tomorrow, Thursday.

The reason for getting on with it is that the patches are horrible to
carry around and that any other patches made against OE-Core will likely
need to be remade to apply after these changes. I therefore don't want a
week of waiting around discussing it, this is something I believe we
need to do now and be done with it. I'm also not going to post the
whitespace patches for review, I'll write+merge them and then be
responsive for accepting fixes for anything that gets broken. They will
only be whitespace changes.

I appreciate this is going to cause some disruption but I think there is
a problem worth solving here and this is the best way to do it. If
anyone has any strong objections I'm open to alternative ideas.

The bitbake patch to error on tab whitespace is included below. I'll try
and post a branch with the whitespace fixes on later today.

Cheers,

Richard




diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index e3ffefe..4b653a5 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -291,6 +291,8 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
             if d.getVarFlag(key, "python"):
                 parsedvar = d.expandWithRefs(value, key)
                 parser = bb.codeparser.PythonParser(key, logger)
+                if parsedvar.value and "\t" in parsedvar.value:
+                    bb.warn("Variable %s contains tabs, please remove these" % key)
                 parser.parse_python(parsedvar.value)
                 deps = deps | parser.references
             else:
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index eae840f..86f9463 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -212,9 +212,9 @@ class ExportFuncsNode(AstNode):
                         data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag))
 
                 if data.getVarFlag(calledvar, "python"):
-                    data.setVar(var, "\tbb.build.exec_func('" + calledvar + "', d)\n")
+                    data.setVar(var, "    bb.build.exec_func('" + calledvar + "', d)\n")
                 else:
-                    data.setVar(var, "\t" + calledvar + "\n")
+                    data.setVar(var, "    " + calledvar + "\n")
                 data.setVarFlag(var, 'export_func', '1')
 
 class AddTaskNode(AstNode):




