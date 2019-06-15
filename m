Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
	[209.85.214.170])
	by mail.openembedded.org (Postfix) with ESMTP id F29A77EAB5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:16 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id bh12so2359213plb.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=9o71N3tCdYUUnbPfLuHfYBBTgAnxvFQXb8UDXuPx5WE=;
	b=gmJajQSkE/TR5p89XUmTYcWnAwjHDz3helj/aVgwJTMSk4vu60EM/Xmm48+gK+Ia1Z
	eVHKwdBC8zQaUrVxgEDQ9c/WIdtcVmP/wquqgyGfgkqmT3nZ8mtc80MQAEkrO3JXngk6
	sb7K6a4FC9iXiYSLRhn515oYiyEA2ngi9tfinsdltYKeMaqTTfRFKAH91X3sGwrYt+AS
	sFZrh9vvPwu5U/chk3EUBbPgrfswk6t/nXNT8TbKtmp0gH2O7FguTkktvESkMHt5z3vF
	4Zu5rpr3no3j12+ARjcwyDAmPI85blmGpOY5uneJbh6QU1YNaThFhgnwkhZcr89R0zLF
	LqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=9o71N3tCdYUUnbPfLuHfYBBTgAnxvFQXb8UDXuPx5WE=;
	b=kcM9B6cP5MOrQ8/MFpqGUIZ8ScGJenk8J5DXAx+CS3/KKgpomW1ZKy3do3Fbz/digi
	IO8FYSPDlxKU191xcEpV494N2rwwXpX2VFvoHHyfrIe0uSaTx4dYbuZX8G1z20lYeq0w
	nGQOKvIATCnQBOBm+Bv0jaaNnqAJyqOZkAQ4qbpYDBYM9KLtGq5h+1QcdhPO+v3z/Ej3
	DtUdBUWX/j6XUjCw/dsejZhsVBld4E/3arJvAxFz2Mjb0eS58+OZv9DRwDA6slS8WNxT
	q0+LUudc3qlh53QxNDZ7bQQaZ5mADg07i5kFD12+AacaJkniY8FdWLrD9LjHeTBQSrpx
	PrCQ==
X-Gm-Message-State: APjAAAXUN2MZX3ei3QxxTHpQH4ak836lWymUKN2YCawFfp8jZge2tqll
	YXhwAPOrAZBdgEVG9km8hKOzug1S
X-Google-Smtp-Source: APXvYqyrE/QH6sILoBXYK5ZcP9zSVERZ8gwY9d3u/RLJWQ5qz/AtSXH2R/KKMHjydccgyn/0s6vQJA==
X-Received: by 2002:a17:902:6b07:: with SMTP id
	o7mr77320985plk.180.1560621078144; 
	Sat, 15 Jun 2019 10:51:18 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:17 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:52 -0700
Message-Id: <9814a993ba65cfd84a8707a22dc02a85082de513.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 22/23] netkit-telnet: add rconflicts
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:17 -0000

From: Changqing Li <changqing.li@windriver.com>

fix below error:

file /etc/xinetd.d/telnet conflicts between attempted installs of netkit-telnet-0.17-r0.i586 and inetutils-telnetd-1.9.4-r0.i586
file /usr/sbin/in.telnetd conflicts between attempted installs of netkit-telnet-0.17-r0.i586 and inetutils-telnetd-1.9.4-r0.i586

Signed-off-by: Changqing Li <changqing.li@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb b/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb
index db4b1c9..4b035af 100644
--- a/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb
+++ b/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb
@@ -63,3 +63,4 @@ FILES_${PN} += "${sbindir}/in.* ${libdir}/* ${sysconfdir}/xinetd.d/*"
 
 # http://errors.yoctoproject.org/Errors/Details/186954/
 EXCLUDE_FROM_WORLD_libc-musl = "1"
+RCONFLICTS_${PN} = "inetutils-telnetd"
-- 
2.7.4


