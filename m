Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D046C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 01:53:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.10263.1702000409596032914
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 17:53:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=RZ8pLAhL;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EA1499C3496
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 Dec 2023 20:53:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id yYrOcbVnelS0; Thu,  7 Dec 2023 20:53:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 15E449C33E2;
	Thu,  7 Dec 2023 20:53:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 15E449C33E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702000408; bh=pp6zLWIo90Ps7WkBEqk9c38PxAJKi0ezvosNJG3A7dM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=RZ8pLAhLnnuK/quBurGIKlkBrrhrtON6+pXQcJ5zaYQyR8+EsAvDDbge583uTHSkc
	 N6RKOGCDkg1GuMX2W3QaYra4zvZKfpdw4Syov7O7zCvObQF7bTG5J3rgjwwIVx3zwF
	 KFu/+JokIpNYdk9n+vRPR1lFcDNWDP5ueE/hJ9rPZt+Jmf869UZq7uddEPrMt6PSBD
	 z6BYMnkW/ASsdeenG+xsZB4UjezqIsZgpzsKoGq8VyyuKB2vxGios8wu06pgm9zZaq
	 IBKwLo9sQw71MsYarKOuWdo7nK2XAeiLDp2izOLZLnaiUjOVnLSmbu1kNdKOP7FbC5
	 T+ptFpXBy2elw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id bWlwG8V0yVmT; Thu,  7 Dec 2023 20:53:27 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3EEE89C3188;
	Thu,  7 Dec 2023 20:53:27 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/4] toaster/test: Added functional/utils, contains useful methods using by functional tests
Date: Fri,  8 Dec 2023 02:53:17 +0100
Message-Id: <20231208015319.677993-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
References: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 01:53:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15635

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/utils.py | 89 +++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 lib/toaster/tests/functional/utils.py

diff --git a/lib/toaster/tests/functional/utils.py b/lib/toaster/tests/fu=
nctional/utils.py
new file mode 100644
index 00000000..bde1146e
--- /dev/null
+++ b/lib/toaster/tests/functional/utils.py
@@ -0,0 +1,89 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux Inc
+#
+# SPDX-License-Identifier: GPL-2.0-only
+
+
+from time import sleep
+from selenium.common.exceptions import NoSuchElementException, StaleElem=
entReferenceException, TimeoutException
+from selenium.webdriver.common.by import By
+
+from orm.models import Build
+
+
+def wait_until_build(test_instance, state):
+    timeout =3D 60
+    start_time =3D 0
+    build_state =3D ''
+    while True:
+        try:
+            if start_time > timeout:
+                raise TimeoutException(
+                    f'Build did not reach {state} state within {timeout}=
 seconds'
+                )
+            last_build_state =3D test_instance.driver.find_element(
+                By.XPATH,
+                '//*[@id=3D"latest-builds"]/div[1]//div[@class=3D"build-=
state"]',
+            )
+            build_state =3D last_build_state.get_attribute(
+                'data-build-state')
+            state_text =3D state.lower().split()
+            if any(x in str(build_state).lower() for x in state_text):
+                return str(build_state).lower()
+            if 'failed' in str(build_state).lower():
+                break
+        except NoSuchElementException:
+            continue
+        except TimeoutException:
+            break
+        start_time +=3D 1
+        sleep(1) # take a breath and try again
+
+def wait_until_build_cancelled(test_instance):
+    """ Cancel build take a while sometime, the method is to wait driver=
 action
+        until build being cancelled
+    """
+    timeout =3D 30
+    start_time =3D 0
+    build =3D None
+    while True:
+        try:
+            if start_time > timeout:
+                raise TimeoutException(
+                    f'Build did not reach cancelled state within {timeou=
t} seconds'
+                )
+            last_build_state =3D test_instance.driver.find_element(
+                By.XPATH,
+                '//*[@id=3D"latest-builds"]/div[1]//div[@class=3D"build-=
state"]',
+            )
+            build_state =3D last_build_state.get_attribute(
+                'data-build-state')
+            if 'failed' in str(build_state).lower():
+                break
+            if 'cancelling' in str(build_state).lower():
+                # Change build state to cancelled
+                if not build:  # get build object only once
+                    build =3D Build.objects.last()
+                    build.outcome =3D Build.CANCELLED
+                    build.save()
+            if 'cancelled' in str(build_state).lower():
+                break
+        except NoSuchElementException:
+            continue
+        except StaleElementReferenceException:
+            continue
+        except TimeoutException:
+            break
+        start_time +=3D 1
+        sleep(1) # take a breath and try again
+
+def get_projectId_from_url(url):
+    # url =3D 'http://domainename.com/toastergui/project/1656/whatever
+    # or url =3D 'http://domainename.com/toastergui/project/1/
+    # or url =3D 'http://domainename.com/toastergui/project/186
+    assert '/toastergui/project/' in url, "URL is not valid"
+    url_to_list =3D url.split('/toastergui/project/')
+    return  int(url_to_list[1].split('/')[0])  # project_id
--=20
2.34.1


