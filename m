Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 7714671B86
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:07 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id g23so32316636wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=c6znESbp7LzMQAcjN4NXlshoyM5WV5pWi5PbZr4ivTk=;
	b=gx4khMxS4QXx6V/NRoc9gMhUwheBil4+3MXAE4HIzaBt/4WT3mNISBlxlIwt6mYh99
	01PdTkLr905KBvbu+pKfCJ6ih4wj1mVnWTNroswFSHdlSqdz8T+BomSMM5bY9w0CuFoz
	R0AG+NHW8QlgOE+HsEt7PuRb2D/SXMzHBx8kMAs9YGHF9SMq4MPS9vqJ+wvE/HtKr6JX
	d0Rg5lq0n/RPoKUS0zai/fC49CmPjsyuKSDPWOA3sSPtHkuAw0GSWC7m3kZkX+plK11L
	Hysu0WnOCfC8VoU+htXPWAifow5FUhO53yBPsJDtN1u2OAB2NgU+iDVB77fESGjjupzA
	QfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=c6znESbp7LzMQAcjN4NXlshoyM5WV5pWi5PbZr4ivTk=;
	b=G8OXt+y40hvuJhTxMZnrXjjVf64Q8W9sThCDJoPDyUt+wQY3mEUsSwpljemntWJoSp
	8weXgrbZ54r3zJfOd5P0/HJekKz3OLd+JmQwGT9Zs2oQY6nI2vwV/WUS1bJqolG+x591
	RT+6+jYJe3UH0TqhS25hIBUmt+RBWVh4+vAIRumankS69r5SgMEWd5N20V19DFqwy0dR
	Jc6WSlRSPR7FfVB5LOFRxha7i6bA7CQ5/vbSU0YdZWOAh1MtOSpRXXdHQrBUDt5/e57y
	rxVuIg6c3qPg830FpabsnsEAt+Q8aGsYjqxOr07VdmsKVxfBEX11m44/OezL+6yzC1VL
	OaWQ==
X-Gm-Message-State: AKaTC01aAx3vY91jrtEgVIzfInfpz2KjUn4QWf7CEGIfTODQGLQXQ6EOL7LffujqD1GeQZ7M
X-Received: by 10.28.148.81 with SMTP id w78mr7272978wmd.42.1481302388026;
	Fri, 09 Dec 2016 08:53:08 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:07 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:46 +0000
Message-Id: <1481302375-7985-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 05/14] toaster: importlayer Use new layer add API
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:07 -0000

Switch the importlayer.js to use the new REST API for importing a new layer.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 30dc282..4784c65 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -158,6 +158,7 @@ function importLayerPageInit (ctx) {
         project_id: libtoaster.ctx.projectId,
         layer_deps: layerDepsCsv,
         local_source_dir: $('#local-dir-path').val(),
+        add_to_project: true,
       };
 
       if ($('input[name=repo]:checked').val() == "git") {
@@ -168,9 +169,9 @@ function importLayerPageInit (ctx) {
       }
 
       $.ajax({
-          type: "POST",
-          url: ctx.xhrImportLayerUrl,
-          data: layerData,
+          type: "PUT",
+          url: ctx.xhrLayerUrl,
+          data: JSON.stringify(layerData),
           headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
           success: function (data) {
             if (data.error != "ok") {
-- 
2.7.4


