Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9B8E07F9C4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5B9419C0446;
	Fri, 17 Jan 2020 11:45:59 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id qHuJZxMVg_kr; Fri, 17 Jan 2020 11:45:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CEB0D9C042D;
	Fri, 17 Jan 2020 11:45:58 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id j7gg7rM2L04K; Fri, 17 Jan 2020 11:45:58 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id F254F9C042B;
	Fri, 17 Jan 2020 11:45:57 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:40 +0100
Message-Id: <20200117164548.28453-5-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 04/12] bitbake: fetch2: add more hash functions for checksum verification
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:09 -0000
Content-Transfer-Encoding: quoted-printable

This commit enables the "sha1", "sha384" and "sha512" hash functions in
the supported checksum list. This allows to use more SRC_URI checksums
functions for a url:

  SRC_URI[sha1sum] =3D "..."
  SRC_URI[sha384sum] =3D "..."
  SRC_URI[sha512sum] =3D "..."

The npm fetcher needs this to support subresource integrity:
  https://www.w3.org/TR/SRI/

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b4122aee..0fbc0c8d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -33,7 +33,7 @@ _checksum_cache =3D bb.checksum.FileChecksumCache()
=20
 logger =3D logging.getLogger("BitBake.Fetcher")
=20
-CHECKSUM_LIST =3D [ "md5", "sha256" ]
+CHECKSUM_LIST =3D [ "md5", "sha256", "sha1", "sha384", "sha512" ]
=20
 class BBFetchException(Exception):
     """Class all fetch exceptions inherit from"""
--=20
2.20.1


