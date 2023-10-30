Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED173C00142
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:24 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.159178.1698695476169487000
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=DFyOg25j;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8C5A29C2848
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id uzGb42f-6hNv; Mon, 30 Oct 2023 15:51:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EBF0E9C332F;
	Mon, 30 Oct 2023 15:51:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EBF0E9C332F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695474; bh=+5uZZBBn17ErJhYtUSTuu9jVZ2vwwTzGT4O4Jw8pWWc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=DFyOg25jv7b4gnRiRIYrpc0mRZL3bok7xXe+1t31MPxWnoM66J6+YcWy0nyJ+AD5Y
	 5dX+FlQuW3Xl9SKj7rqch4uoPS1uvxsQ0jU6vBn+xigRrIns9gCPufmiyy7E1J2HT2
	 jXVuv2qcPiv07ORlpoDHi/tf45KFd2WPORf7ECykWuw0ITfVEPDjnBQUE/uKwD7SAP
	 BmARt7gq/+W/S0wXLNQiHI+iGP1RhdySY+G8vmXRE4po8nHqw/6iU4jH/mVqI6aeDB
	 MCRKwEWTNt54CqdqZGt9m9kQNvS2PUG1Vp0MLMSR7QuAODZfPuqF1gU7RIU/+qGgsr
	 1th/juskZbkZw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BDTsOepzIn-N; Mon, 30 Oct 2023 15:51:14 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 44A719C284C;
	Mon, 30 Oct 2023 15:51:13 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 7/8] Toaster: fixed: Tests fail when executed one after the other out of sequence
Date: Mon, 30 Oct 2023 20:50:36 +0100
Message-Id: <20231030195037.232912-7-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15331

As mentionned in earlier commit, pytest-django takes a conservative appro=
ach
to enabling database access. By default our tests will fail if they try t=
o access
the database, Only if we explicitly request database access will this be =
allowed,
using pytest marks to tell pytest-django our test needs database access.

A side effect of pytest mark, is test_case method marked is execute out o=
f
scope of its module class, which create an inconsistance sequence and mak=
e fails
followings tests.

The scope of the ordering is global per default, e.g. tests with lower or=
dinal
numbers are always executed before tests with higher numbers in the same =
test session,
regardless of the module and class they reside in. This can be changed by=
 using
the --order-scope option from module pytest-order.

To fix that i added execution order to tests suite using pytest-order.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_functional_basic.py | 4 +++-
 lib/toaster/tests/toaster-tests-requirements.txt      | 1 +
 lib/toaster/tests/views/test_views.py                 | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index 7e9be91c..f558cce8 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -8,12 +8,14 @@
 #
=20
 import re, time
-import pytest
 from django.urls import reverse
+import pytest
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Project
 from selenium.webdriver.common.by import By
=20
+
+@pytest.mark.order("last")
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
 #   testcase (1514)
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toast=
er/tests/toaster-tests-requirements.txt
index 7109c625..71cc0834 100644
--- a/lib/toaster/tests/toaster-tests-requirements.txt
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -4,3 +4,4 @@ pytest-django=3D=3D4.5.2
 pytest-env=3D=3D1.1.0
 pytest-html=3D=3D4.0.2
 pytest-metadata=3D=3D3.0.0
+pytest-order=3D=3D1.1.0
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index 06bf6c20..349881eb 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -9,6 +9,7 @@
=20
 """Test cases for Toaster GUI and ReST."""
=20
+import pytest
 from django.test import TestCase
 from django.test.client import RequestFactory
 from django.urls import reverse
@@ -33,6 +34,7 @@ PROJECT_NAME2 =3D "test project 2"
 CLI_BUILDS_PROJECT_NAME =3D 'Command line builds'
=20
=20
+@pytest.mark.order(1)
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
=20
--=20
2.34.1


