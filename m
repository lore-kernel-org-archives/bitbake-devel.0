Received: from lilium.sigma-star.at (lilium.sigma-star.at [109.75.188.150])
 by mx.groups.io with SMTP id smtpd.web08.8237.1621940699717099026
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 May 2021 04:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: nod.at, ip: 109.75.188.150, mailfrom: richard@nod.at)
Received: from localhost (localhost [127.0.0.1])
	by lilium.sigma-star.at (Postfix) with ESMTP id 57D661817A0D7;
	Tue, 25 May 2021 13:04:58 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
	by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CEVGa9Q_p-BE; Tue, 25 May 2021 13:04:58 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
	by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E5QD5WCNrgvF; Tue, 25 May 2021 13:04:58 +0200 (CEST)
From: "Richard Weinberger" <richard@nod.at>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Richard Weinberger <richard@nod.at>
Subject: [yocto-docs][PATCH] Document erofs filesystem targets
Date: Tue, 25 May 2021 13:04:29 +0200
Message-Id: <20210525110429.738-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525110429.738-1-richard@nod.at>
References: <20210525110429.738-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 documentation/ref-manual/kickstart.rst | 2 ++
 documentation/ref-manual/variables.rst | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/documentation/ref-manual/kickstart.rst b/documentation/ref-m=
anual/kickstart.rst
index 8308ffff5b72..2c8b724ff9ac 100644
--- a/documentation/ref-manual/kickstart.rst
+++ b/documentation/ref-manual/kickstart.rst
@@ -116,6 +116,8 @@ the ``part`` and ``partition`` commands:
=20
    -  ``squashfs``
=20
+   -  ``erofs``
+
    -  ``swap``
=20
 -  ``--fsoptions``: Specifies a free-form string of options to be used
diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-m=
anual/variables.rst
index df6413b68ae9..d4ea4f399921 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -3293,6 +3293,9 @@ system and gives an overview of their function and =
contents.
       - jffs2
       - jffs2.sum
       - multiubi
+      - erofs
+      - erofs-lz4
+      - erofs-lz4hc
       - squashfs
       - squashfs-lz4
       - squashfs-lzo
--=20
2.26.2

