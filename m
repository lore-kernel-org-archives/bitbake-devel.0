Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>)
	id 1TgvMb-0002aN-HO; Fri, 07 Dec 2012 11:41:02 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id qB7AQXXR002302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Dec 2012 11:26:34 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1Tgv8a-0002xB-VI; Fri, 07 Dec 2012 11:26:33 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Fri, 07 Dec 2012 11:26:32 +0100
Message-ID: <lyfw3ii2ef.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.85
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,RP_MATCHES_RCVD,SPF_NEUTRAL,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Subject: Complete rebuilds due to random hashes
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
X-List-Received-Date: Fri, 07 Dec 2012 10:41:02 -0000
Content-Type: text/plain

Hello,

I have encountered the problem the whole distribution gets rebuilt when
I change a single, completely unrelated variable (e.g. BB_DISKMON_DIRS).

Dumping data in _build_data() (siggen.py) revealed that sometimes a
gitpkgv_do_configure() (or _do_compile/install...) function is in the
deps, sometimes not.  The recipes where this happens (e.g. m4) do not
inherit gitpkgv and it is not included globally either.

Further debugging[1] shows

| ERROR: calledvar=autotools_do_configure, vars=[['gitpkgv_do_configure', 'autotools_do_configure'], ['do_configure', 'gitpkgv_do_configure']], allvars=['do_configure', 'autotools_do_configure', 'gitpkgv_do_configure'], classes=[None, 'gitpkgv', 'autotools']

for such a recipe (note the 'gitpkgv_do_configure')


For me, it seems that this depends on the (random) order in which recipes
are read.  E.g. when a recipe using 'gitpkgv' is read first, the global
'classes' array will contain 'gitpkgv' and ExportFuncsNode() is constructed
with it.

But when m4 is read before the first recipe using 'gitpkgv', it won't be
contained in 'classes' and the corresponding ExportFuncsNode() will not
create this variable.


Does somebody know how to fix this?


Enrico

Footnotes: 
[1]  
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -207,6 +207,8 @@ class ExportFuncsNode(AstNode):
 
                 for flag in [ "func", "python" ]:
                     if data.getVarFlag(calledvar, flag):
+                        if var == 'gitpkgv_do_configure':
+                            bb.error("calledvar=%s, vars=%s, allvars=%s, classes=%s" % (calledvar,vars,allvars,self.classes))
                         data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag))
                 for flag in [ "dirs" ]:
                     if data.getVarFlag(var, flag):


