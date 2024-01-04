Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E784AC47074
	for <webhook@archiver.kernel.org>; Thu,  4 Jan 2024 15:18:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.56265.1704381521489847661
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jan 2024 07:18:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=c0QPnk7k;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D6E1E9C15B5
	for <bitbake-devel@lists.openembedded.org>; Thu,  4 Jan 2024 10:18:40 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Mbl3QRKVBupM; Thu,  4 Jan 2024 10:18:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8C3DD9C32E2;
	Thu,  4 Jan 2024 10:18:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8C3DD9C32E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704381520; bh=mBxSutm6wDEy840sgvQFFKQeV/wFP3BC9HwNNx2ixaI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=c0QPnk7kornZEcCEyA3yIJ2UpZ5r/HCvf/LlecgPOSvwS/N8bCjN9lV7welwKgmXr
	 pVcBLsWm1kgFj0qECEbEYsngAQevUM9b+UFSYL4pqb6LS55VE6BWh1EQ0uurZy3fS0
	 dZ/pf9IXu+iGsCFsg4SxVtqOikGpY8VPGkZ2oMuoP3GmQIxcGbR98Q0wsXObI6pEPK
	 kmlDnDzF7b1w+k30kpFfrHQqRkqxsrJg6uxiqW4SjzZI43fQ3Aw2P6h71XG2KM25JK
	 dtyM2TvFss+9ljKNAiQknMcyhIFY5HYYet0IPpKQ64iRuQk4jShsF3gHoCPQQNDZG2
	 ectD5uf3nKVJg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jxu7xZULhnVO; Thu,  4 Jan 2024 10:18:40 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D561A9C15B5;
	Thu,  4 Jan 2024 10:18:39 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] toaster/toastergui: Bug-fix verify given layer path only if import/add local layer
Date: Thu,  4 Jan 2024 16:18:35 +0100
Message-Id: <20240104151835.135968-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jan 2024 15:18:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15740

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/toastergui/api.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.p=
y
index a06ffc00..e367bd91 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -227,7 +227,7 @@ class XhrSetDefaultImageUrl(View):
 #    same logical name
 #  * Each project that uses a layer will have its own
 #    LayerVersion and Project Layer for it
-#  * During the Paroject delete process, when the last
+#  * During the Project delete process, when the last
 #    LayerVersion for a 'local_source_dir' layer is deleted
 #    then the Layer record is deleted to remove orphans
 #
@@ -457,15 +457,18 @@ class XhrLayer(View):
                              'layerdetailurl':
                              layer_dep.get_detailspage_url(project.pk)})
=20
-            # Scan the layer's content and update components
-            scan_layer_content(layer,layer_version)
+            # Only scan_layer_content if layer is local
+            if layer_data.get('local_source_dir', None):
+                # Scan the layer's content and update components
+                scan_layer_content(layer,layer_version)
=20
         except Layer_Version.DoesNotExist:
             return error_response("layer-dep-not-found")
         except Project.DoesNotExist:
             return error_response("project-not-found")
-        except KeyError:
-            return error_response("incorrect-parameters")
+        except KeyError as e:
+            _log("KeyError: %s" % e)
+            return error_response(f"incorrect-parameters")
=20
         return JsonResponse({'error': "ok",
                              'imported_layer': {
--=20
2.34.1


