Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web12.12376.1607606026706593564
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Dec 2020 05:13:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E85A51FB
	for <bitbake-devel@lists.openembedded.org>; Thu, 10 Dec 2020 05:13:45 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F0CC3F718
	for <bitbake-devel@lists.openembedded.org>; Thu, 10 Dec 2020 05:13:45 -0800 (PST)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] msg: use safe YAML loader
Date: Thu, 10 Dec 2020 13:13:41 +0000
Message-Id: <20201210131341.1475578-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If using a YAML file in BB_LOGCONFIG, the unsafe loader is used and this
causes a runtime warning:

YAMLLoadWarning: calling yaml.load() without Loader=3D... is deprecated,
as the default Loader is unsafe. Please read https://msg.pyyaml.org/load
for full details.

As log configuration YAML is relatively simple we can just use
safe_load().

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/msg.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 6f17b6acc7..291b38ff7f 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -278,7 +278,7 @@ def setLoggingConfig(defaultconfig, userconfigfile=3D=
None):
         with open(os.path.normpath(userconfigfile), 'r') as f:
             if userconfigfile.endswith('.yml') or userconfigfile.endswit=
h('.yaml'):
                 import yaml
-                userconfig =3D yaml.load(f)
+                userconfig =3D yaml.safe_load(f)
             elif userconfigfile.endswith('.json') or userconfigfile.ends=
with('.cfg'):
                 import json
                 userconfig =3D json.load(f)
--=20
2.25.1

