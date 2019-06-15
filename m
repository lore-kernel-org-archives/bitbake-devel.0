Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
	[209.85.214.179])
	by mail.openembedded.org (Postfix) with ESMTP id EB2B17E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:14 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id k8so1385695plt.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ep70kDE/UoXv3QVa1F/spHpWvzD7bihV75XXb/U4usI=;
	b=rQbevMX3HSjfUQtEcVYDQV7Yy/EuiWidOoJz8ySa1fDZmU+xNN2GVEQ47tmt3cI/+S
	0tfof/ygddYSp3ZwpEBYuuMLmEF0euDlUrRZUIoRE8qxxUxCrNV+Dk0MytbXvd+qL5z8
	9SKW2WN8Vi1lBFbyy996HK+q5dEBDBsGjI4l3a0tBu9jQIivK2Q88HSgTlgMhtGZDbLo
	Ns7tzpHkxu2aXe+ChocVrIbShUjx8LtHuPdFPgVeg2KS6m0rJ5uzOlI1ZXKm4GH5M6lk
	TZdU/A1AVe1qO/kMUUW6+hlkFeNv+9Zc9mvNsyE+WMzkc+IX8PVKCzOgyqmZvylQsm6O
	SGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ep70kDE/UoXv3QVa1F/spHpWvzD7bihV75XXb/U4usI=;
	b=Bd/rvNI8SIDEILgnZNm8QCYlkxXmeNMcWRSTLAF/kfQi5ryoRRYvlPAcjTUSaSq+dA
	bwCSdz+5lTAM847VvYd/GRicsm0Jtsfj63hYNdrw+QA/5a0oFi42TtGyEQeeZYtC+8I8
	4bwPp2e9PAtsKYR1fnC1Xmo8cP7Jj/QaSO36Rmbgd6AaggPZKTFStMC6+TXbXg+UBmtf
	RjtQStgn8m9ddT3jwMnp/r/m+rnp3NN5v+Ug7gN9BPqsTfQcCj+otNKsVM4Mkq1FkyZT
	ZMBQEBaMNXIyvJQ+KcGVIbSDXFFrG0xVW8HUJ2SdKF4+TqRD0XOQaMjLy6bbk+4CpRzX
	bMjA==
X-Gm-Message-State: APjAAAV1qcJEuFOuES4Ru8bucnXullCX3oYbWLqf+NMWmCDRhzStACUH
	L0POcLab/orGZhIeuZH12mCZfPDQ
X-Google-Smtp-Source: APXvYqxWqXja73VdLTp2h77guRUfyHUEAQufY9XHF5skto0dc0+ypQhNqbN0U7Mi43RcOhPIsP+veA==
X-Received: by 2002:a17:902:934b:: with SMTP id
	g11mr87373187plp.245.1560621076134; 
	Sat, 15 Jun 2019 10:51:16 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:15 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:49 -0700
Message-Id: <f2a4c4eab38fd07983bd08f6f3f415d69f831251.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 19/23] leptonica: fix SRC_URI
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:15 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* leptonica.com now only redirects to www.leptonica.org, so it only downloads
  the HTML home page instead of the source tarball

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-graphics/leptonica/leptonica_1.74.4.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-oe/recipes-graphics/leptonica/leptonica_1.74.4.bb b/meta-oe/recipes-graphics/leptonica/leptonica_1.74.4.bb
index 91fa00c..249e96f 100644
--- a/meta-oe/recipes-graphics/leptonica/leptonica_1.74.4.bb
+++ b/meta-oe/recipes-graphics/leptonica/leptonica_1.74.4.bb
@@ -3,7 +3,7 @@ DEPENDS = "jpeg tiff libpng zlib"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://leptonica-license.txt;md5=34aa579294e8284b7b848c8d5d361e8f"
 
-SRC_URI = "http://leptonica.com/source/leptonica-${PV}.tar.gz"
+SRC_URI = "http://www.leptonica.org/source/leptonica-${PV}.tar.gz"
 SRC_URI[md5sum] = "4f32be9bd2e2c142ba018037ab5d746f"
 SRC_URI[sha256sum] = "29c35426a416bf454413c6fec24c24a0b633e26144a17e98351b6dffaa4a833b"
 
-- 
2.7.4


