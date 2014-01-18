Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 473A560D98
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 Jan 2014 23:31:32 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0INVRNd028448 for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 Jan 2014 23:31:27 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id u1AhWntToiEN for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 Jan 2014 23:31:27 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0INUXeg028439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 Jan 2014 23:30:35 GMT
Message-ID: <1390087827.14987.159.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 18 Jan 2014 23:30:27 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Remove fsync that is causing performance issues
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
X-List-Received-Date: Sat, 18 Jan 2014 23:31:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This fsync was added for belt and braces protection for things like sstate
on NFS. To be honest, it probably doesn't buy much, if the rename isn't
atomic, all bets are off anyway and there are bigger issues to worry about.

The issue is that at the end of every task, the dump_sig() code is triggered
to save out information about the task and this was triggering an fsync(fd).

Whilst it may select the file descriptor, on file systems like ext4, it will
require large parts of the journal to be written out so it can have
significant impact. latencytop showed an average fsync() call overhead of about
2s and if that happens for 5000 tasks, the time mounts up. This blocks the next
task execution by that time.

We therefore drop the fsync since in reality its causing problems and is unlikely
to buy much.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index bc96fd3..bb8203d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -238,7 +238,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
             with os.fdopen(fd, "wb") as stream:
                 p = pickle.dump(data, stream, -1)
                 stream.flush()
-                os.fsync(fd)
             os.chmod(tmpfile, 0664)
             os.rename(tmpfile, sigfile)
         except (OSError, IOError) as err:



