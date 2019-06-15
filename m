Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
	[209.85.214.177])
	by mail.openembedded.org (Postfix) with ESMTP id AC2FC7EB1F
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:13 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id e5so2341559pls.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=8BNsSoMzNvlAQd/3CqrkyOBo2K/dCrOtvM8cxZDFdro=;
	b=uaBOoUBnEkVv1ClxdXy0mMPM2SoJUQVpaUliIA+YZtXjUUcfmxQISKfHb7G6v7+2/w
	dhUlZG63hvT17UbZU0ZIcHDsVQy3thTdktZlw0DZ0W2mLG/z8FKs6lsOpJWeTTbHdeMz
	zkjfmpgATWmZWtXJMO96tYMymfllbO56m8DJA0mr8OQ/x+zUhX7ZvVv+kuhMjivSjIza
	MGOfXMy5Aq7cNcP+jQP6pUc6cqoUz658TIJX0HiPlIFQZBthfT4ZLBvPI631dxrs8k1V
	DOsdUl9HoWmxwv6+WZumcGH8VsFRZWXQ3Ynzr4GZHnF4JTd8mUteZQxybRcRsKQ3MrN5
	K8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=8BNsSoMzNvlAQd/3CqrkyOBo2K/dCrOtvM8cxZDFdro=;
	b=SXaHUHOR0KbzjLT9m0CTSIU2CXY4apJ/x4JQWRYlGPTdG+nqicldIhu2O44xWNV2Yi
	2zl2dCPnMpcUn00WcMCzYSPlGb21PIz92TJpOFaTsCeuueeDL5SbxaWvpeIkDij/Ab5l
	sM2OTZWIE5pQLZFjHsh0Y7Yq6GJdavv9R1YaCq5wPiKTEb+jdSksl6UaFK1w+OA686dI
	q7hwy/Ikntx2I/5lho6dGCVIY6omM2TzCahQgeCrQRACLFl/d3b+28BZ1AgHSCqc2oYY
	X03zqyPNz/3PwBDNArrLskunMxYk567JzVUzVEAxAguJTc7SUHatLbcyhQ5I4IX7sqUu
	qVSw==
X-Gm-Message-State: APjAAAWIbIknhR/EFYVvM62jokFu8ZQpuIn7T7098TXRtQakducbESgr
	dakXGzxKJxk7uu5MinNKDp+GvaC6
X-Google-Smtp-Source: APXvYqwkct2af2UB/IcUBG3jOsNcoIPofHdHBV6YxeRrRt6wnN8XmQaDqPs19CjV9YkdOHAmlon1GA==
X-Received: by 2002:a17:902:b705:: with SMTP id
	d5mr62868828pls.274.1560621074655; 
	Sat, 15 Jun 2019 10:51:14 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:14 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:47 -0700
Message-Id: <5f4408b2df0e951a10a7b61df42d28098b544cbe.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 17/23] mariadb: Upgrade to 10.3.15
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:13 -0000

From: Mingli Yu <mingli.yu@windriver.com>

Fixes for the following security vulnerabilities:
 CVE-2019-2614
 CVE-2019-2627
 CVE-2019-2628

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../mysql/{mariadb-native_10.3.13.bb => mariadb-native_10.3.15.bb}    | 0
 meta-oe/recipes-dbs/mysql/mariadb.inc                                 | 4 ++--
 meta-oe/recipes-dbs/mysql/{mariadb_10.3.13.bb => mariadb_10.3.15.bb}  | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename meta-oe/recipes-dbs/mysql/{mariadb-native_10.3.13.bb => mariadb-native_10.3.15.bb} (100%)
 rename meta-oe/recipes-dbs/mysql/{mariadb_10.3.13.bb => mariadb_10.3.15.bb} (100%)

diff --git a/meta-oe/recipes-dbs/mysql/mariadb-native_10.3.13.bb b/meta-oe/recipes-dbs/mysql/mariadb-native_10.3.15.bb
similarity index 100%
rename from meta-oe/recipes-dbs/mysql/mariadb-native_10.3.13.bb
rename to meta-oe/recipes-dbs/mysql/mariadb-native_10.3.15.bb
diff --git a/meta-oe/recipes-dbs/mysql/mariadb.inc b/meta-oe/recipes-dbs/mysql/mariadb.inc
index fca74d4..eed23d2 100644
--- a/meta-oe/recipes-dbs/mysql/mariadb.inc
+++ b/meta-oe/recipes-dbs/mysql/mariadb.inc
@@ -19,8 +19,8 @@ SRC_URI = "https://downloads.mariadb.org/interstitial/${BPN}-${PV}/source/${BPN}
            file://clang_version_header_conflict.patch \
            file://fix-arm-atomic.patch \
           "
-SRC_URI[md5sum] = "603ce42e35b9a688f2cca05275acb5cb"
-SRC_URI[sha256sum] = "b2aa857ef5b84f85a7ea60a1eac7b34c0ca5151c71a0d44ce2d7fb028d71459a"
+SRC_URI[md5sum] = "08edd8b5060a181e6dd3c6aac23218cd"
+SRC_URI[sha256sum] = "27f391a54d544f93850d4edfb3ef1b4cf24f8e27e61e51727b0e7d31bb4d6968"
 
 UPSTREAM_CHECK_URI = "https://github.com/MariaDB/server/releases"
 
diff --git a/meta-oe/recipes-dbs/mysql/mariadb_10.3.13.bb b/meta-oe/recipes-dbs/mysql/mariadb_10.3.15.bb
similarity index 100%
rename from meta-oe/recipes-dbs/mysql/mariadb_10.3.13.bb
rename to meta-oe/recipes-dbs/mysql/mariadb_10.3.15.bb
-- 
2.7.4


