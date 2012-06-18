Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1SgaIa-0007qj-Kk
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 13:39:12 +0200
Received: by bkcjm2 with SMTP id jm2so3734509bkc.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jun 2012 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=IMrpfQgLVDPRr8Iz5oz8Ilt1cEpzD3kPz0i8qIFEPWE=;
	b=oQ/ePOFH7aY2oKlnXoRoVrhXjyAgDaMhrJGav7tYeyl/Du0MoZ6GHsExyZXtKkr4P+
	6dAL8sbRQts6S7EM+6rEo1f29GXVZbPLlCvIm1HWRffzQlCHTEiYPZf3DVnxf8GzxO9p
	RDCwnkWQXz4HaKwbO4SrStG6M7ROLJXP6ZsOYERQCUvybm9sodRlGnG7dnrM4svTa2wq
	469dtRZOxq19Owbbv/fcHuefJ8wMocQOvMD9hFvRGsEx93vKhRFiSWI/LqqbfJjyUN7q
	P7rgqh8WbxdhD+oZcc/VRgJsCOeGO06gyYM9q5SKsSRZ8Ov8f22BOeiqw2bKubsD+srC
	1D4g==
Received: by 10.204.148.74 with SMTP id o10mr6309616bkv.111.1340018910707;
	Mon, 18 Jun 2012 04:28:30 -0700 (PDT)
Received: from s42.loc ([91.119.132.55])
	by mx.google.com with ESMTPS id e20sm18249164bkv.10.2012.06.18.04.28.29
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 18 Jun 2012 04:28:30 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.77)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1Sga8C-0002Ii-VO; Mon, 18 Jun 2012 13:28:29 +0200
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jun 2012 13:28:27 +0200
Message-Id: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
X-Mailer: git-send-email 1.7.10
Subject: [PATCH] fetch2: do not try to checksum a socket
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
X-List-Received-Date: Mon, 18 Jun 2012 11:39:13 -0000

computing the md5 of a socket does not work too well.

Traceback (most recent call last):
  File "/scratch/src/oe/bitbake/build/lib/bb/siggen.py", line 172, in SignatureGeneratorOEBasic.get_taskhash(fn='/scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb', task='do_fetch', deps=[], dataCache=<bb.cache.CacheData object at 0xd95890>):
             if task in dataCache.file_checksums[fn]:
    >            checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
                 for (f,cs) in checksums:
  File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line 627, in get_file_checksums(filelist='/scratch/src/uClibc/ /scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.machine /scratch/src/oe/openembedded-core/meta/recipes-core/uclibc/uclibc-git/uClibc.distro', pn='uclibc'):
                         fullpth = os.path.join(root, name)
    >                    checksum = checksum_file(fullpth)
                         if checksum:
  File "/scratch/src/oe/bitbake/build/lib/bb/fetch2/__init__.py", line 605, in checksum_file(f='/scratch/src/uClibc/test/inet/socktest'):
             try:
    >            checksum = _checksum_cache.get_checksum(f)
             except OSError as e:
  File "/scratch/src/oe/bitbake/build/lib/bb/checksum.py", line 78, in FileChecksumCache.get_checksum(f='/scratch/src/uClibc/test/inet/socktest'):

    >        hashval = bb.utils.md5_file(f)
             self.cachedata_extras[0][f] = (cmtime, hashval)
  File "/scratch/src/oe/bitbake/build/lib/bb/utils.py", line 362, in md5_file(filename='/scratch/src/uClibc/test/inet/socktest'):

    >    for line in open(filename):
             m.update(line)
IOError: [Errno 6] No such device or address: '/scratch/src/uClibc/test/inet/socktest'

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
---
 lib/bb/fetch2/__init__.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 324eef2..0c0d60d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -601,6 +601,7 @@ def get_file_checksums(filelist, pn):
     """
 
     def checksum_file(f):
+        if not os.path.isfile(f): return None
         try:
             checksum = _checksum_cache.get_checksum(f)
         except OSError as e:
-- 
1.7.10



