Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by mail.openembedded.org (Postfix) with ESMTP id BF6A47F385
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 13:43:54 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id d5so16492609lja.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2019 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=NzQpDtg3BPAFCCfvMsw5D/MnTDZ5o65jpJnPksQRBRA=;
	b=hHr9DvNrPfAVFyjhNDv4Y/XqsX9vIYHHZ5kTuFPXmyTsU6BfiAr3PlALjX4FTJ9r8R
	v99yXXsel4WXYXk7TIWUUjlcKxhZysWeNPdyGPUnB1ajdt6Zk8GIVjyOSb5vQvZvv00R
	MI+RT9ahTDwYr7q/3mALN313BM+qPPnDmtbc3738xmeDZJwFoHqM0PkITdO9LZri7vX4
	/U/0k5B2fx+4RQVjoBnV/GzF65sxHWtjh4EzrArdWem/m63m6VMIrDZA2ZTf7PC1UHKv
	BdP0nxh8Vh0QO+IAIcO0h2Au6rO5vxR42HTRTcv93oOS0GQWCUkHta+vnMvtwPnns7C9
	0hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NzQpDtg3BPAFCCfvMsw5D/MnTDZ5o65jpJnPksQRBRA=;
	b=lHQz8IzRMrjAMKOX2+0qk/tm/tbJxfEWUuN6wr5ETBO8EUN2e6cxOEOULDT9M0E6oR
	/4ixUxCCTw7Y39CfYEXgXqqN+rmJkp4Kzmx+fBvJFCVNcooUTiEbf1DWNxrdQzYZalTc
	tSxXJCxszi47l12DkjV79XzCdeLXWduNuZ0JTx6hrMsgkdWemReEGPLGw5C8U9RHGwPc
	j4KXlu2pLIqF5EA7na4nEtGi8IovckGz4L9OIbCV2LGAmekT4z5lXeTGZVlPQSBDTuY8
	vUsCKrLNQ01RfBU0HXZzuVUphSswBB6LB0kW7MODWb+a5rbMbcG1AMUOeDq+uEayO6jc
	z+nA==
X-Gm-Message-State: APjAAAW5wz808qoW5FVZhTZQi6lqDN8Rvc786lsG/NfpFqNgw7fd9BV4
	QYajd3gRTGIAThtKUulbzufgK7mWvYU=
X-Google-Smtp-Source: APXvYqyk6EUZq0IMi1yMaazovIjQu/2C9y5RffKyiQynmYfUThEJ6BHgnvGWDbQpp4YUM6si0pT3vQ==
X-Received: by 2002:a2e:8704:: with SMTP id m4mr19890475lji.65.1568123034868; 
	Tue, 10 Sep 2019 06:43:54 -0700 (PDT)
Received: from manatarms-greyskull.lan.mikrodidakt.se ([213.185.29.22])
	by smtp.gmail.com with ESMTPSA id
	k21sm4169304lfm.68.2019.09.10.06.43.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 10 Sep 2019 06:43:54 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Sep 2019 15:43:28 +0200
Message-Id: <20190910134328.27305-2-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910134328.27305-1-jacob.kroon@gmail.com>
References: <20190910134328.27305-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake-user-manual: key-expansion: Don't refer to overrides
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
X-List-Received-Date: Tue, 10 Sep 2019 13:43:55 -0000
Content-Transfer-Encoding: 8bit

Nowadays bitbake applies overrides dynamically, not at a single
specific point in time during parsing.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 6b49d7fa..421364c2 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -799,17 +799,15 @@
             <title>Key Expansion</title>
 
             <para>
-                Key expansion happens when the BitBake datastore is finalized
-                just before BitBake expands overrides.
+                Key expansion happens when the BitBake datastore is finalized.
                 To better understand this, consider the following example:
                 <literallayout class='monospaced'>
      A${B} = "X"
      B = "2"
      A2 = "Y"
                 </literallayout>
-                In this case, after all the parsing is complete, and
-                before any overrides are handled, BitBake expands
-                <filename>${B}</filename> into "2".
+                In this case, after all the parsing is complete,
+                BitBake expands <filename>${B}</filename> into "2".
                 This expansion causes <filename>A2</filename>, which was
                 set to "Y" before the expansion, to become "X".
             </para>
-- 
2.21.0


