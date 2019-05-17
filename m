Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2C6A77DEB1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 15:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3DF899C0323
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:18 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id yJ6zihJveMCZ for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B10169C031E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id iOjFALKiItAc for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 57B139C01E9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 17:14:07 +0200
Message-Id: <20190517151410.8487-2-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Subject: [PATCH 1/4] bitbake: fetch2/npm: fix npw view parsing
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
X-List-Received-Date: Fri, 17 May 2019 15:19:56 -0000
Content-Transfer-Encoding: quoted-printable

Fixes [YOCTO #13344]

When parsing manually the 'npm view --json' ouput, an extra closing
brackets in a JSON string can leads the fetcher to fail with a
JSONDecodeError exception.

This commit use the JSON parser to extract:
 - The last object in the returned array if there are multiple results.
 - The returned object if there is only one result.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 bitbake/lib/bb/fetch2/npm.py | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index f08bdee739..4427b1bb87 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -151,20 +151,11 @@ class Npm(FetchMethod):
         Parse the output of npm view --json; the last JSON result
         is assumed to be the one that we're interested in.
         '''
-        pdata =3D None
-        outdeps =3D {}
-        datalines =3D []
-        bracelevel =3D 0
-        for line in output.splitlines():
-            if bracelevel:
-                datalines.append(line)
-            elif '{' in line:
-                datalines =3D []
-                datalines.append(line)
-            bracelevel =3D bracelevel + line.count('{') - line.count('}'=
)
-        if datalines:
-            pdata =3D json.loads('\n'.join(datalines))
-        return pdata
+        pdata =3D json.loads(output);
+        try:
+            return pdata[-1]
+        except:
+            return pdata
=20
     def _getdependencies(self, pkg, data, version, d, ud, optional=3DFal=
se, fetchedlist=3DNone):
         if fetchedlist is None:
--=20
2.20.1


