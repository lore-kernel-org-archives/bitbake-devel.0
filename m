Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1875BC021A0
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 15:06:02 +0000 (UTC)
Received: from 4.mo576.mail-out.ovh.net (4.mo576.mail-out.ovh.net [46.105.42.102])
 by mx.groups.io with SMTP id smtpd.web10.13151.1739459153208923736
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 07:05:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=A9q+HOWm;
 spf=softfail (domain: syslinbit.com, ip: 46.105.42.102, mailfrom: louis.rannou@syslinbit.com)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.176.51])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4Ytz5W2ypFz23sQ
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 15:05:51 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-tfz7l (unknown [10.110.178.109])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D42731FEC4;
	Thu, 13 Feb 2025 15:05:50 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-tfz7l with ESMTPSA
	id MQGMAE4Krmfl8AAAvMEkeg:T2
	(envelope-from <louis.rannou@syslinbit.com>); Thu, 13 Feb 2025 15:05:50 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-104R00531e33edd-221a-418f-921a-4ad4da9ca463,
                    A3E930DA2C8C0F3093FF869A1907ED10BC64B092) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: Louis Rannou <louis.rannou@syslinbit.com>
Date: Thu, 13 Feb 2025 16:05:42 +0100
Subject: [PATCH v2 1/2] bitbake: data_smart: fix ??= operator for variable
 flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-varflags-v2-1-884794e84e55@syslinbit.com>
References: <20250213-varflags-v2-0-884794e84e55@syslinbit.com>
In-Reply-To: <20250213-varflags-v2-0-884794e84e55@syslinbit.com>
To: bitbake-devel@lists.openembedded.org
Cc: Louis Rannou <louis.rannou@syslinbit.com>, pascal.eberhard@se.com, 
 yoann.congal@smile.fr, Louis Rannou <louis.rannou@non.se.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739459150; l=1994;
 i=louis.rannou@syslinbit.com; s=20230614; h=from:subject:message-id;
 bh=Dx2HhWOMizV+rj9TUGqbRx+WNn79g7h8yBD/16ymevQ=;
 b=1+Dhol4psTFljGLo8pnBhP54rDJttWl6o5QuN7NycRFjyQwKVkCdnM/fQZUq2vbVXXotgly1J
 7QAaeOtuMUzDz6isoQ0R4F1nVkAXdIBRVUyVwaj7nUSyg7vSIfGRAg6
X-Developer-Key: i=louis.rannou@syslinbit.com; a=ed25519;
 pk=QLSK64UNeqThVe2CiH917a68zTpexYuA7iXw6WQ0bbI=
X-Ovh-Tracer-Id: 742812466083192197
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepudfhueeutdehffdvhfejleffudekieduffffteefiedutdeuhfehkeffueehfeevnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehjeeimgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=cet+7bEbBarI2/jVtleNHDLE02Dlyw7f8Ban2Jc9KCk=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739459151; v=1;
 b=A9q+HOWm86bXJbYLXAUMvQHQ3kw2TGXFow+w7pGqL9Rg+uzSC4wjXkHALOrqkc8HKalL4i6m
 82/GReYrQisEjyjjlyo9yDz5rNqmRy5Bvg9aGt1AokdpgHbiBOdwS7w8+Erev1bdR7NfxSN3eX8
 3RDZzH2GGm8MdAiTEWD42WiB3op5RxByXA0DU+c8XUNq3Qcjvlq1GHdqkrZaU86vuGTXksYv5yZ
 8fP9aII8T5B2Mk27Ewf8EdHzm/fxtbrxIGUEop/nVpLG5yB3VDyuUKQ4yIRmf5llSmTfLurqCZb
 tqzMXpVkjYIliaWOgF3TyPEkJ/H4IepZA5NkVr0WAigYA==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 15:06:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17214

From: Louis Rannou <louis.rannou@non.se.com>

Variable flags have been fixed in commit
0329a7e3ac694737f2d2c1861f65492551360663 which introduces the
"_defaultval_flag_" prefix for default values.

This must not be ignored in delVarFlags and getVarFlags.

Fixes [YOCTO #15685]

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 lib/bb/data_smart.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 897ceeb32c7ce0acb8ed44c25e1bf2f2f28aa9dc..54125965666a46848d10051dba80a9f8cbaee439 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -920,6 +920,8 @@ class DataSmart(MutableMapping):
             self.varhistory.record(**loginfo)
 
             del self.dict[var][flag]
+            if ("_defaultval_flag_" + flag) in self.dict[var]:
+                del self.dict[var]["_defaultval_flag_" + flag]
 
     def appendVarFlag(self, var, flag, value, **loginfo):
         loginfo['op'] = 'append'
@@ -954,17 +956,22 @@ class DataSmart(MutableMapping):
         flags = {}
 
         if local_var:
-            for i in local_var:
-                if i.startswith(("_", ":")) and not internalflags:
+            for i, val in local_var.items():
+                if i.startswith("_defaultval_flag_") and not internalflags:
+                    i = i[len("_defaultval_flag_"):]
+                    if i not in local_var:
+                        flags[i] = val
+                elif i.startswith(("_", ":")) and not internalflags:
                     continue
-                flags[i] = local_var[i]
+                else:
+                    flags[i] = val
+
                 if expand and i in expand:
                     flags[i] = self.expand(flags[i], var + "[" + i + "]")
         if len(flags) == 0:
             return None
         return flags
 
-
     def delVarFlags(self, var, **loginfo):
         self.expand_cache = {}
         if not var in self.dict:

-- 
2.48.1


