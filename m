Return-Path: <sujith.h@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail.openembedded.org (Postfix) with ESMTP id 8569070016
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Dec 2016 07:17:37 +0000 (UTC)
Received: by mail-pg0-f68.google.com with SMTP id p66so18987681pga.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Dec 2016 23:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=UueQ+SxnWSpv6iTZhXryMzWjIeUMJusXmUKLZE5au5k=;
	b=zhUOErpSzDqWS034arMXvw7FSVGCI96co4Lvz+37SX80ypTKXw7XBWk5VQsB6T+KNI
	Cvvsj0IDfqXfWNfRbtedtbTzFuo9l2ueAVKXr0UgJ3q+GqbjDhpp5qdSXsgSUOjyqKAZ
	bVsLkW46a5PrkoHWBSuvufsQl4Ur0/+jV43sMEEtENB//RrBMIn7F335syxUg8vILEZf
	eUvTdr/HwjD+xtRUmJMRL/KQ9X529vIDiOVIAp7OSWlDX3h8Bk93jLCjdA5iA0L0Eyfr
	dO8h1WNjxRncpKmDdpm972XQ8Mac/+1eGtIFsNNi2z5vpkhmiitMI0O09BA9OSsqLXLo
	nmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=UueQ+SxnWSpv6iTZhXryMzWjIeUMJusXmUKLZE5au5k=;
	b=fm/7BD6Hqk/N6IpwILbsHUtYv6rcafQMk9IVKG1ncxfzMrE8p1Z4nKPi34F7ccAGKc
	DxOb7t5o03GU741drDdoj2uosqYIvFiWGPZRo1FuPiCzU2WXdHFYfaXZrKZX4iCjJaDi
	PwRVpgK3AGOuoI4WsIPoFDe2+G9+R7Qx1QRn20DPdhCRm9emzbs5QTrdPJdPiBIpJrrl
	zZVwi9XW20MEnPN+6RLnwoKuvAOApHy0IvmipZ8HMYbwuotCOrxEAcI2FKFfXXluqq+W
	WmQmiuBAWO2oLT7e8Ahh+wMOq2F2DmOrj7gGWvWlaWLsOVr9OnN37JUy4+Iu+j9P1tOt
	eMng==
X-Gm-Message-State: AKaTC03NCc3lxKZVupiVyw4i441HqZ+eRxviTjE+O1Myl6ej93devEekDW+ff0KzB5V62g==
X-Received: by 10.84.205.69 with SMTP id o5mr130955297plh.70.1481008658970;
	Mon, 05 Dec 2016 23:17:38 -0800 (PST)
Received: from kdekidd0.inp-wifi.mentorg.com ([139.181.35.34])
	by smtp.gmail.com with ESMTPSA id
	89sm32045041pfi.70.2016.12.05.23.17.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Dec 2016 23:17:38 -0800 (PST)
From: Sujith H <sujith.h@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Dec 2016 12:47:29 +0530
Message-Id: <1481008649-23173-1-git-send-email-sujith.h@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH v3] bitbake: cooker: convert type which needs to be marshalled
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
X-List-Received-Date: Tue, 06 Dec 2016 07:17:37 -0000

We assume that the value taken by variable v can be string,
integer or any type which can be marshalled by xmlrpc. This
change would help us to convert the non marshallable types
to string. So that we don't get exception from xmlrpc.

[YOCTO #10740]

Signed-off-by: Sujith H <sujith.h@gmail.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c08af45..d59cd7b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1488,7 +1488,7 @@ class BBCooker:
                 v = self.data.getVar(k, expand)
                 if not k.startswith("__") and not isinstance(v, bb.data_smart.DataSmart):
                     dump[k] = {
-    'v' : v ,
+    'v' : str(v) ,
     'history' : self.data.varhistory.variable(k),
                     }
                     for d in flaglist:
-- 
1.9.1


