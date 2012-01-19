Received: from mymadcat.com ([213.251.163.154] helo=mail.mymadcat.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <madcat@mymadcat.com>) id 1RnvOD-00022O-LM
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 18:03:06 +0100
Received: by mail.mymadcat.com (Postfix, from userid 500)
	id 5BA773E8BA; Thu, 19 Jan 2012 17:49:07 +0100 (CET)
From: Adrien Bustany <adrien@bustany.org>
Date: Thu, 19 Jan 2012 17:49:47 +0200
MIME-Version: 1.0
Message-Id: <20120119164907.5BA773E8BA@mail.mymadcat.com>
X-Mailman-Approved-At: Thu, 19 Jan 2012 20:47:02 +0100
Subject: [PATCH] bitbake/lib/bb/fetch2: Fix stderr handling when running commands
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
X-List-Received-Date: Thu, 19 Jan 2012 17:03:06 -0000
X-Groupsio-MsgNum: 876
Content-Type: multipart/mixed; boundary="------------1.7.5.1"

--------------1.7.5.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: quoted-printable


stderr would previously be appended to stdout, corrupting the result
when something was outputed to stderr but exit code was still 0
(non-fatal warning messages). This commit makes the code parse only
stdout, but output stderr if an error happened.

Signed-off-by: Adrien Bustany <adrien.bustany@nokia.com>
---
 bitbake/lib/bb/fetch2/__init__.py |   35 ++++++++++++++++---------------=
----
 1 files changed, 16 insertions(+), 19 deletions(-)


--------------1.7.5.1
Content-Type: text/x-patch; name="0001-bitbake-lib-bb-fetch2-Fix-stderr-handling-when-runni.patch"
Content-Disposition: attachment; filename="0001-bitbake-lib-bb-fetch2-Fix-stderr-handling-when-runni.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index 374ac9b..c3b22d7 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -378,6 +378,9 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D []=
):
     Optionally remove the files/directories listed in cleanup upon failure
     """
=20
+    import bb.process
+    import subprocess
+
     # Need to export PATH as binary could be in metadata paths
     # rather than host provided
     # Also include some other variables.
@@ -394,33 +397,27 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D =
[]):
=20
     logger.debug(1, "Running %s", cmd)
=20
-    # redirect stderr to stdout
-    stdout_handle =3D os.popen(cmd + " 2>&1", "r")
-    output =3D ""
-
-    while True:
-        line =3D stdout_handle.readline()
-        if not line:
-            break
-        if not quiet:
-            print(line, end=3D' ')
-        output +=3D line
+    success =3D False
+    error_message =3D ""
=20
-    status =3D stdout_handle.close() or 0
-    signal =3D status >> 8
-    exitstatus =3D status & 0xff
+    try:
+        (output, errors) =3D bb.process.run(cmd, shell=3DTrue, stderr=3Dsu=
bprocess.PIPE)
+        success =3D True
+    except bb.process.NotFoundError as e:
+        error_message =3D "Fetch command %s" % (e.command)
+    except bb.process.CmdError as e:
+        error_message =3D "Fetch command %s could not be run:\n%s" % (e.co=
mmand, e.msg)
+    except bb.process.ExecutionError as e:
+        error_message =3D "Fetch command %s failed with exit code %s, outp=
ut:\n%s" % (e.command, e.exitcode, e.stderr)
=20
-    if (signal or status !=3D 0):
+    if not success:
         for f in cleanup:
             try:
                 bb.utils.remove(f, True)
             except OSError:
                 pass
=20
-        if signal:
-            raise FetchError("Fetch command %s failed with signal %s, outp=
ut:\n%s" % (cmd, signal, output))
-        elif status !=3D 0:
-            raise FetchError("Fetch command %s failed with exit code %s, o=
utput:\n%s" % (cmd, status, output))
+        raise FetchError(error_message)
=20
     return output
=20

--------------1.7.5.1--
