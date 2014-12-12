Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 672D57250C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:26 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id h11so2241172wiw.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=nN/xZ0Vc+2q1rugnvLVUzbafr41IneuPDAryiSzoBsI=;
	b=mIJj+ktDSjrLEuRx81ZxmWsut2JP6nBUELxV1xB68vhbcQJe6D2TYYJs3s9+px0h0J
	ciJ5BQpTS9cc3KZh38FMH6XJ7DdsFkn/Xx/i2JvbYH9SmXeEiiXLVrbL6svFo4ltBknJ
	KXYc/QEV1RDPjaJvt+MZoyhYxcGkDhDkXxnSEts//Bg1r5Kqy5IDrNA+voQ1hTZvFUCA
	qcIwv+gAqi6B8NVVz185ybksPacX4ixRbuS/4vZGQRP55khZGCCdorhil33q3MEm1pcW
	5uNqZTGAF3Rpf5ifZsajdV48BNkO37gbAZA5gKB61siLtj+/OF66+3edNxYh35w/MK3m
	JWxQ==
X-Gm-Message-State: ALoCoQlxR1bzfq2O7XcIKZhlHD5hWW37n9u5JzCof1KLVM++A+7mOrVfmgXXsyudIioOTfx3JIk7
X-Received: by 10.180.109.46 with SMTP id hp14mr7023233wib.54.1418384726733;
	Fri, 12 Dec 2014 03:45:26 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id h8sm1735108wiy.17.2014.12.12.03.45.23
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4F2D656625C; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:17 +0000
Message-Id: <3a5b78af4f3cab203824d933a73e82a41ab377e3.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 18/18] toaster: importlayer Tidy up the page initialisation
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:28 -0000

From: Michael Wood <michael.g.wood@intel.com>

Tidy up the page initialisation and change the error logging so that
it's consistent with other pages.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/importlayer.html | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index c92e552..a4d8ee1 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -12,19 +12,20 @@
                   <script src="{% static 'js/importlayer.js' %}"></script>
                   <script>
                     $(document).ready(function (){
-                      var ctx = {};
-                      ctx.xhrDataTypeaheadUrl = "{% url 'xhr_datatypeahead' %}";
-                      ctx.layerDetailsUrl = "{% url 'layerdetails' %}";
-                      ctx.xhrImportLayerUrl = "{% url 'xhr_importlayer' %}";
-                      ctx.xhrEditProjectUrl = "{% url 'xhr_projectedit' project.id %}";
-                      ctx.projectPageUrl = "{% url 'project' project.id %}";
-                      ctx.projectId = {{project.id}};
+                      var ctx = {
+                        xhrDataTypeaheadUrl : "{% url 'xhr_datatypeahead' %}",
+                        layerDetailsUrl : "{% url 'layerdetails' %}",
+                        xhrImportLayerUrl : "{% url 'xhr_importlayer' %}",
+                        xhrEditProjectUrl : "{% url 'xhr_projectedit' project.id %}",
+                        projectPageUrl : "{% url 'project' project.id %}",
+                        projectId : {{project.id}}
+                      };
 
                       try {
                         importLayerPageInit(ctx);
-                      } catch(e) {
-                        document.write(e.stack);
-                        console.log(e);
+                      } catch (e) {
+                        document.write("Sorry, An error has occurred loading this page");
+                        console.warn(e);
                       }
                     });
                   </script>
-- 
1.9.1


