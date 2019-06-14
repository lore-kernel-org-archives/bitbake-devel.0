Return-Path: <open.source@oleksandr-kravchuk.com>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail.openembedded.org (Postfix) with ESMTP id EBD247E7D6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2019 00:09:28 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id 131so507466ljf.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Jun 2019 17:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oleksandr-kravchuk-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=BhJyQonawHCsAbogjVgs5ohfgoUkEBvYpiU1oNJJY3I=;
	b=wu95YanJvUDzZCXREIzEGibT7UDjn3YNhPAWozjOe/YhJbLhytrax9pXnSKdFFu6/n
	cYwa0FCgrhfnOs5QNMDXy8lJy8wUCutSVcPbXlVNO/FTNr75pZRxo2gKp98AGPJn1d1S
	6nu7PWxTv8ms1QTScnb9xXnF7V1XFNXAu2XygmpzO9TvJs+F9eh5/LaVZ52leLo7yduU
	YVf1ozlc4M2Fzt2mTIWIztYHwym0zXxI4pRY076lq2pqj/oVhAQ9kzJt6eJVXaKBc+QK
	FIV/U1jDQ4ZQy3oin2Us0BfOx3XEiFF/M0lF66/1/pgQhGTMxCqN+FwVGACHooCQLdnc
	0kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=BhJyQonawHCsAbogjVgs5ohfgoUkEBvYpiU1oNJJY3I=;
	b=bS8t+INQAoVKEHzf+TAVBxVKriDHtgvzLmrDhTdBFa/JcsdqUWUG0xeFM9EhaYxoSn
	weCyjeBZx9TAbNCX40YtJ3uZZPE/4RV6XqZyPWtRs3vSrztaCAWwpFxje6qd3/SxTb0D
	HAKFHUIApvg9wC6QClb+jWziIK6804b0LEVt9eshjuSdJ3vEJ4d/JzFprVGmSuwBrIxR
	0wwMU0Gog79ONyb0Va/mttrQlF6b6M9wXTTJBwOnHsKDlmRnsW6KTl60yfxYVJE3ySgo
	WWltbIFpPyJI1Lz0bkxXuuMUWOG3KFKX9xf+8O314L3RQVP2bRCrSb0xpzYMzSv8+ryF
	uTVg==
X-Gm-Message-State: APjAAAX5kHdiqqtPhMo7NlYKDlG6yoPpE0svic4A+womyaFxwsZLEXQE
	Va4MQkRHGO3fwDExyb8SvIaGVSUqfl0=
X-Google-Smtp-Source: APXvYqxw9V6FBZuC7H8TIsJpIWdj+IUev5kxUzmZ897wLNz8OHimYTR0oYp4HO+Hf5oKalSnqBHvbw==
X-Received: by 2002:a2e:551d:: with SMTP id j29mr38922852ljb.213.1560470968919;
	Thu, 13 Jun 2019 17:09:28 -0700 (PDT)
Received: from localhost.localdomain (c83-252-117-108.bredband.comhem.se.
	[83.252.117.108])
	by smtp.gmail.com with ESMTPSA id 25sm250376ljv.40.2019.06.13.17.09.28
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 13 Jun 2019 17:09:28 -0700 (PDT)
From: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Jun 2019 02:09:25 +0200
Message-Id: <20190614000925.12048-1-open.source@oleksandr-kravchuk.com>
X-Mailer: git-send-email 2.17.1
Cc: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>
Subject: [PATCH] bitbake: cooker: list all nonexistent bblayer directories
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
X-List-Received-Date: Fri, 14 Jun 2019 00:09:29 -0000

Check existence of all the bblayer direcotories at once and print them
all, so if there are multiple nonexistent directories, user does not
have to correct bblayers.conf and restart bitbake multiple times.

[YOCTO #11647]

Signed-off-by: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>
---
 bitbake/lib/bb/cookerdata.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index f8ae41093b..842275d530 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -342,14 +342,24 @@ class CookerDataBuilder(object):
             data = parse_config_file(layerconf, data)
 
             layers = (data.getVar('BBLAYERS') or "").split()
+            broken_layers = []
 
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
+
+            # Check whether present layer directories exist
             for layer in layers:
                 if not os.path.isdir(layer):
-                    parselog.critical("Layer directory '%s' does not exist! "
-                                      "Please check BBLAYERS in %s" % (layer, layerconf))
-                    sys.exit(1)
+                    broken_layers.append(layer)
+
+            if broken_layers:
+                parselog.critical("The following layer directories do not exist:")
+                for layer in broken_layers:
+                    parselog.critical("   %s", layer)
+                parselog.critical("Please check BBLAYERS in %s" % (layerconf))
+                sys.exit(1)
+
+            for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
                 if 'HOME' in approved and '~' in layer:
                     layer = os.path.expanduser(layer)
-- 
2.17.1


