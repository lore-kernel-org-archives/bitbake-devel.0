Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 8370F760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:45 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id cm16so14822649pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=uQMMvmMcLDp2lQMsZn1aMY4FlH5ewur1pBM9vZY8ny0=;
	b=lknK4rBgOQO85Om+LgBdzcVFcamU+GKckzafvtvZU8P2O6JspnszwH4lUYZIc7b1FY
	cOBC2PgBINGFMyV2hE7Ypu9ukjplSpn4EQXpJBycwPy1IWiDfVI5E+RCEwVKGw1h0K7G
	ww+Tc6I1y2Hv54MmaYxg40CESebDYuiwMgmGmf/V0VlV/RGvkbuQzNLnCnHTPIjsqx6B
	TkqiCzgS7U7nuofQ4yyvw6kuSbIredk7P2YSOvavphLVKHa90CqQRK+vQ6FYcQgl8Skx
	hLkPa0DQRCFDIqsQEitTwH9aG+2TFAoCDF3pLuixIIYtLP5CBvzPjNirT6rKo5WIpB+B
	PBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=uQMMvmMcLDp2lQMsZn1aMY4FlH5ewur1pBM9vZY8ny0=;
	b=AcqNKZ0NxvTe9ebXfUzxkOs1eTvMGM/hr49wzZvUX9k9YfH3js3n2Wo+s4bLUsKmqy
	R05d1qakdTOdthBVVKvJs89dLBgosaO3QI6kZBlzFe9nyJxT0MSoWLTRtjVlxgcC4Yd0
	fcdblnxdlvHbKSxMgjoJTgEzd/oFntzx+5a1dSOTi6bDiw+vfoI3GLh5LYqv7RAn5Ydk
	oAOVZA/oB5A5Xq6VE9Wv8wgbGCI1BICMX2zgrm9SVJjD+58WxN8tutovZEC0/WkWjhdP
	L42g0IXS+jyjaRrzGc3paAZ2QVJNfGTfKkWs3vcl078Vh6z4YIvAny3Pqi4aKnDCiizE
	i4bA==
X-Gm-Message-State: AE9vXwP/IPc/lO+6+SS+8ZvPgdC11E9WOdmnRNmnuWtOUmPuTPPC4M3jsVDILl1RD96R+iec
X-Received: by 10.66.144.164 with SMTP id sn4mr61896040pab.0.1473085786010;
	Mon, 05 Sep 2016 07:29:46 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:45 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:24 +0100
Message-Id: <1473085772-17878-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 03/11] toaster: layer details Layout fixes
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:45 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

The layout of the layer details page was looking a bit awkward. This
commit tidies things up.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css      | 8 +++++++-
 lib/toaster/toastergui/templates/layerdetails.html | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index a56bb8c..22510e8 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -161,7 +161,13 @@ dd .glyphicon-edit { margin-left: 5px; }
 
 /* Style the forms and definition lists in the layer details pages */
 #change-repo-form .form-control { width: 17em; }
+#information { margin-bottom: 5em; }
 #information dd > form { margin-bottom: 5px; margin-top: 5px; }
+#edit-layer-source-form fieldset { margin-top: 20px; }
+#directory-info,
+#git-repo-info { margin-top: 20px; }
+#layer-dir-path-in-details { width: 55%; }
+.add-deps .form-control { width: 15em; }
 
 /* Style the forms and definition lists in the BitBake variables page */
 .variable-list { margin-bottom: 20px; }
@@ -196,7 +202,7 @@ h2 { margin-bottom: 25px; }
 .tt-suggestion:active { background-color: #f5f5f5; cursor: pointer; }
 
 /* Style the import layer form controls*/
-legend { border: none; margin-top: 20px; }
+legend { border: none; }
 .radioLegend { margin-bottom: 0; }
 #layer-name-ctrl { margin-top: 20px; }
 #import-layer-name,
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 08e41ce..7dd0c47 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -258,7 +258,7 @@
              <span class="glyphicon glyphicon-question-sign get-help" title="Other layers this layer depends upon"></span>
            </h3>
 
-           <ul class="list-unstyled current-value" id="layer-deps-list">
+           <ul class="list-unstyled current-value lead" id="layer-deps-list">
              {% for ld in layerversion.dependencies.all %}
              <li data-layer-id="{{ld.depends_on.id}}">
              <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' project.id ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
-- 
2.7.4


