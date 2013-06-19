Return-Path: <Jate.Sujjavanich@myfuelmaster.com>
Received: from stspspam.syntech.org (exchsrvr.syntech-fuelmaster.com
	[199.44.250.2])
	by mail.openembedded.org (Postfix) with ESMTP id 110E7608A7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 20:24:36 +0000 (UTC)
Received: from pps.filterd (stspspam [127.0.0.1])
	by stspspam.syntech.org (8.14.5/8.14.5) with SMTP id r5JKIRNZ007010
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 16:24:38 -0400
Received: from courier.syntech-fuelmaster.com (courier.syntech.org
	[172.16.10.30]) by stspspam.syntech.org with ESMTP id 1cykfftm5a-1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 16:24:37 -0400
Received: from Courier.syntech.org ([::1]) by Courier.syntech.org ([::1]) with
	mapi; Wed, 19 Jun 2013 16:24:37 -0400
From: Jate Sujjavanich <Jate.Sujjavanich@myfuelmaster.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 19 Jun 2013 16:20:59 -0400
Thread-Topic: [PATCH] Checksums for local files now stored using partial
	recipe path
Thread-Index: Ac5s/Ugl+vXwzcvbRqeXjlcFBBvaTAALTsDI
Message-ID: <6C2434209962DC46B88345CA85C334A201C9F4A6EBEA@Courier.syntech.org>
References: <1371653832-2178-1-git-send-email-jate.sujjavanich@myfuelmaster.com>
In-Reply-To: <1371653832-2178-1-git-send-email-jate.sujjavanich@myfuelmaster.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.10.8794, 1.0.431,
	0.0.0000
	definitions=2013-06-19_07:2013-06-19, 2013-06-19,
	1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
	suspectscore=0 phishscore=0
	adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1
	engine=7.0.1-1305240000 definitions=main-1306190192
Subject: FW: [PATCH] Checksums for local files now stored using partial recipe path
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Jun 2013 20:24:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


This allows sstate-cache to be shared between builds in different
directories.

Differences in the full path were triggering a false positive when
there were actually no changes.

Signed-off-by: Jate Sujjavanich <jate.sujjavanich@myfuelmaster.com>
---
Additional comments (cross post from oe-core mailing list)
On the same machine, I had two identical poky directories. One, I built fir=
st to use as the cache source. I then configured the second one to use a SS=
TATE_MIRRORS pointing to the first.

The build of the second would just detect changes and force a rebuild. Runn=
ing the bitbake-diffsigs tool on the do_fetch...sigdata showed something li=
ke the following on all of the local files:

Removed("/home/user/poky1/meta/recipes...file1", chksum1)
Added("/home/user/poky2/meta/recipes...file1", chksum1)

Upon applying my patch, the components of core-minimal-image were pulled fr=
om the sstate-cache.

I will have to see about the other local file cases that I don't know.
---
 bitbake/lib/bb/fetch2/__init__.py |   14 +++++++++-----
 bitbake/lib/bb/siggen.py          |    3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index dd1cc93..7ab44d7 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -900,8 +900,7 @@ def get_checksum_file_list(d):

     return " ".join(filelist)

-
-def get_file_checksums(filelist, pn):
+def get_file_checksums(filelist, pn, topdir):
     """Get a list of the checksums for a list of local files

     Returns the checksums for a list of local files, caching the results a=
s
@@ -917,7 +916,12 @@ def get_file_checksums(filelist, pn):
             bb.warn("Unable to get checksum for %s SRC_URI entry %s: %s" %=
 (pn, os.path.basename(f), e))
             return None
         return checksum
+
+    (recipe_root, _) =3D os.path.split(topdir)

+    def remove_recipe_parent(data):
+        return data.replace(recipe_root, '').strip('/')
+
     checksums =3D []
     for pth in filelist.split():
         checksum =3D None
@@ -927,7 +931,7 @@ def get_file_checksums(filelist, pn):
             for f in glob.glob(pth):
                 checksum =3D checksum_file(f)
                 if checksum:
-                    checksums.append((f, checksum))
+                    checksums.append((remove_recipe_parent(f), checksum))
         elif os.path.isdir(pth):
             # Handle directories
             for root, dirs, files in os.walk(pth):
@@ -935,12 +939,12 @@ def get_file_checksums(filelist, pn):
                     fullpth =3D os.path.join(root, name)
                     checksum =3D checksum_file(fullpth)
                     if checksum:
-                        checksums.append((fullpth, checksum))
+                        checksums.append((remove_recipe_parent(fullpth), c=
hecksum))
         else:
             checksum =3D checksum_file(pth)

         if checksum:
-            checksums.append((pth, checksum))
+            checksums.append((remove_recipe_parent(pth), checksum))

     checksums.sort(key=3Doperator.itemgetter(1))
     return checksums
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 8861337..c64acfe 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -74,6 +74,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.pkgnameextract =3D re.compile("(?P<fn>.*)\..*")
         self.basewhitelist =3D set((data.getVar("BB_HASHBASE_WHITELIST", T=
rue) or "").split())
         self.taskwhitelist =3D None
+        self.topdir =3D data.getVar("TOPDIR", True)
         self.init_rundepcheck(data)

     def init_rundepcheck(self, data):
@@ -187,7 +188,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.runtaskdeps[k].append(dep)

         if task in dataCache.file_checksums[fn]:
-            checksums =3D bb.fetch2.get_file_checksums(dataCache.file_chec=
ksums[fn][task], recipename)
+            checksums =3D bb.fetch2.get_file_checksums(dataCache.file_chec=
ksums[fn][task], recipename, self.topdir)
             for (f,cs) in checksums:
                 self.file_checksum_values[k][f] =3D cs
                 data =3D data + cs
--
1.7.0.4

